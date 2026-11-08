use anyhow::{bail, Result};
use std::path::PathBuf;
use std::process::Command;

fn main() -> Result<()> {
    if cfg!(windows) {
        panic!("this doesn't work on windows yet");
    }

    build_binaryen_wasm_opt()?;
    build_rust_wasm_opt()?;

    #[cfg(feature = "llvm")]
    llvm::maybe_link_llvm()?;

    Ok(())
}

struct Dirs {
    workspace: PathBuf,
    binaryen_src: PathBuf,
    binaryen_build: PathBuf,
}

fn get_dirs() -> Result<Dirs> {
    let manifest_dir = std::env::var("CARGO_MANIFEST_DIR")?;
    let manifest_dir = PathBuf::from(manifest_dir);
    let workspace = manifest_dir.join("../..");
    let binaryen_src = workspace.join("binaryen");
    let out_dir = std::env::var("OUT_DIR")?;
    let out_dir = PathBuf::from(out_dir);
    let binaryen_build = out_dir.join("binaryen-test-build");

    Ok(Dirs {
        workspace,
        binaryen_src,
        binaryen_build,
    })
}

fn build_binaryen_wasm_opt() -> Result<()> {
    let dirs = get_dirs()?;

    std::fs::create_dir_all(&dirs.binaryen_build)?;

    let cmake_status = Command::new("cmake")
        .current_dir(&dirs.binaryen_build)
        .arg(&dirs.binaryen_src)
        .arg("-DBUILD_TESTS=OFF")
        .arg("-G")
        .arg("Ninja")
        .status()?;

    if !cmake_status.success() {
        bail!("cmake failed");
    }

    let make_status = Command::new("cmake")
        .arg("--build")
        .arg(".")
        .current_dir(&dirs.binaryen_build)
        .status()?;

    if !make_status.success() {
        bail!("cmake --build failed");
    }

    Ok(())
}

fn build_rust_wasm_opt() -> Result<()> {
    let dirs = get_dirs()?;

    let mut cmd = Command::new("cargo");
    cmd.current_dir(dirs.workspace)
        .args(["build", "-p", "wasm-opt", "--release"]);

    let cargo_status = cmd.status()?;

    if !cargo_status.success() {
        bail!("cargo failed");
    }

    Ok(())
}

#[cfg(feature = "llvm")]
mod llvm {
    use anyhow::{bail, Context as _, Result};
    use reqwest::blocking::Client;
    use std::{
        env,
        fs::{self, File},
        path::{Path, PathBuf},
        process::Command,
    };

    pub fn maybe_link_llvm() -> anyhow::Result<()> {
        let target_os = env::var("CARGO_CFG_TARGET_OS").unwrap_or_default();
        let target_env = env::var("CARGO_CFG_TARGET_ENV").unwrap_or_default();
        if target_os == "linux" && target_env == "gnu" {
            link_llvm()?;
        }
        Ok(())
    }

    fn link_llvm() -> Result<()> {
        let tag = resolve_llvm_tag();
        let tag_dir = PathBuf::from(env::var("OUT_DIR")?)
            .join("llvm-cache")
            .join(&tag);
        fs::create_dir_all(&tag_dir)?;

        let root = tag_dir.join("root");
        if !root.join(".complete").is_file() {
            let archive = tag_dir.join("llvm.tar.zst");
            if !archive.is_file() {
                download_llvm_release(&tag_dir, &tag, &archive)?;
            }
            extract_llvm_archive(&archive, &root)?;
        }

        emit_llvm_link_flags(&root)
    }

    /// The LLVM release linked by default.
    ///
    /// Pinned so that a new LLVM release cannot change the build. Override
    /// with the `CONFORMANCE_LLVM_VERSION` environment variable.
    const DEFAULT_LLVM_VERSION: &str = "23.1.4";

    fn resolve_llvm_tag() -> String {
        const VERSION_ENV: &str = "CONFORMANCE_LLVM_VERSION";
        println!("cargo:rerun-if-env-changed={}", VERSION_ENV);

        let version = env::var(VERSION_ENV).unwrap_or_default();
        let version = match version.trim() {
            "" => DEFAULT_LLVM_VERSION,
            version => version,
        };

        if version.starts_with("llvmorg-") {
            version.to_string()
        } else {
            format!("llvmorg-{}", version)
        }
    }

    fn download_llvm_release(tag_dir: &Path, tag: &str, archive: &Path) -> Result<()> {
        let arch = match env::var("CARGO_CFG_TARGET_ARCH").ok().as_deref() {
            Some("x86_64") => "X64",
            Some("aarch64") => "ARM64",
            other => bail!(
                "there are no official LLVM release binaries for Linux architecture `{:?}`",
                other
            ),
        };
        let version = tag.strip_prefix("llvmorg-").unwrap_or(tag);
        let url = format!(
            "https://github.com/llvm/llvm-project/releases/download/{}/LLVM-{}-Linux-{}.tar.zst",
            tag, version, arch
        );
        println!("cargo:warning=downloading LLVM {} from {}", tag, url);

        let mut response = Client::new()
            .get(&url)
            .send()
            .with_context(|| format!("failed to download `{}`", url))?;
        if !response.status().is_success() {
            bail!("HTTP {} while downloading `{}`", response.status(), url);
        }

        let partial = tag_dir.join("llvm.tar.zst.partial");
        let _ = fs::remove_file(&partial);
        let mut file = File::create(&partial)?;
        std::io::copy(&mut response, &mut file)?;
        fs::rename(&partial, archive)?;

        Ok(())
    }

    fn extract_llvm_archive(archive: &Path, root: &Path) -> Result<()> {
        let _ = fs::remove_dir_all(root);
        fs::create_dir_all(root)?;

        let status = Command::new("tar")
            .arg("-I")
            .arg("zstd -d --memory=1024MB")
            .arg("-xf")
            .arg(archive)
            .arg("-C")
            .arg(root)
            .arg("--strip-components=1")
            .status()
            .with_context(|| format!("failed to run tar for `{}`", archive.display()))?;
        if !status.success() {
            let _ = fs::remove_dir_all(root);
            bail!("tar exited with {}", status);
        }

        fs::write(root.join(".complete"), b"")?;

        Ok(())
    }

    fn emit_llvm_link_flags(llvm_root: &Path) -> Result<()> {
        let lib_dir = llvm_root.join("lib");
        let llvm_config = llvm_root.join("bin/llvm-config");
        let libs = run_llvm_config(&llvm_config, &["--link-static", "--libs"])?;

        println!("cargo:rustc-link-search=native={}", lib_dir.display());

        println!("cargo:rustc-link-arg=-Wl,--whole-archive");
        for lib in libs
            .split_whitespace()
            .filter_map(|flag| flag.strip_prefix("-l"))
        {
            let archive = lib_dir.join(format!("lib{}.a", lib));
            if !archive.is_file() {
                bail!("missing LLVM static library `{}`", archive.display());
            }
            println!("cargo:rustc-link-arg={}", archive.display());
        }
        println!("cargo:rustc-link-arg=-Wl,--no-whole-archive");

        let system_libs = run_llvm_config(&llvm_config, &["--link-static", "--system-libs"])?;
        for lib in system_libs.split_whitespace().chain(["-lstdc++"]) {
            println!("cargo:rustc-link-arg={}", lib);
        }

        Ok(())
    }

    fn run_llvm_config(llvm_config: &Path, args: &[&str]) -> Result<String> {
        let output = Command::new(llvm_config)
            .args(args)
            .output()
            .with_context(|| format!("failed to run `{}`", llvm_config.display()))?;

        if !output.status.success() {
            bail!(
                "`{}` {:?} failed with {}: {}",
                llvm_config.display(),
                args,
                output.status,
                String::from_utf8_lossy(&output.stderr).trim()
            );
        }

        Ok(String::from_utf8_lossy(&output.stdout).trim().to_string())
    }
}

use anyhow::{bail, Result};
use std::path::PathBuf;
use std::process::Command;

fn main() -> Result<()> {
    if cfg!(windows) {
        panic!("this doesn't work on windows yet");
    }

    build_binaryen_wasm_opt()?;
    build_rust_wasm_opt()?;

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
        .status()?;

    if !cmake_status.success() {
        bail!("cmake failed");
    }

    let make_status = Command::new("make")
        .current_dir(&dirs.binaryen_build)
        .status()?;

    if !make_status.success() {
        bail!("make failed");
    }

    Ok(())
}

fn build_rust_wasm_opt() -> Result<()> {
    let dirs = get_dirs()?;

    let mut cmd = Command::new("cargo");
    cmd
        .current_dir(dirs.workspace)
        .args(["build", "-p", "wasm-opt", "--release"]);

    #[cfg(feature = "dwarf")]
    cmd.args(["--features", "dwarf"]);

    let cargo_status = cmd.status()?;

    if !cargo_status.success() {
        bail!("cargo failed");
    }

    Ok(())
}

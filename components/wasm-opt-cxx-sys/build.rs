use std::path::{Path, PathBuf};

fn main() -> anyhow::Result<()> {
    let mut builder = cxx_build::bridge("src/lib.rs");

    {
        let target_env = std::env::var("CARGO_CFG_TARGET_ENV")?;

        let flags: &[_] = if target_env != "msvc" {
            &["-std=c++17", "-Wno-unused-parameter"]
        } else {
            &["/std:c++17"]
        };

        for flag in flags {
            builder.flag(flag);
        }
    }

    let binaryen_dir = get_binaryen_dir()?;

    builder
        .include("src")
        .include(binaryen_dir.join("src"))
        .compile("wasm-opt-cxx");

    Ok(())
}

/// Finds the binaryen source directory.
///
/// Duplicated in `wasm-opt-sys`. See there for docs.
fn get_binaryen_dir() -> anyhow::Result<PathBuf> {
    let manifest_dir = std::env::var("CARGO_MANIFEST_DIR")?;
    let manifest_dir = Path::new(&manifest_dir);
    let binaryen_packaged_dir = manifest_dir.join("binaryen");
    let binaryen_submodule_dir = manifest_dir.join("../../binaryen");

    match (
        binaryen_packaged_dir.is_dir(),
        binaryen_submodule_dir.is_dir(),
    ) {
        (true, _) => Ok(binaryen_packaged_dir),
        (_, true) => Ok(binaryen_submodule_dir),
        (false, false) => anyhow::bail!(
            "binaryen source directory doesn't exist (maybe `git submodule update --init`?)"
        ),
    }
}

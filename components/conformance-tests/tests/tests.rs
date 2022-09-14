use anyhow::Result;
use std::path::{Path, PathBuf};

struct Paths {
    binaryen_wasm_opt: PathBuf,
    rust_wasm_opt: PathBuf,
}

fn get_paths() -> Result<Paths> {
    let out_dir = std::env::var("OUT_DIR")?;
    let out_dir = PathBuf::from(out_dir);
    let binaryen_build = out_dir.join("binaryen-test-build");
    let binaryen_wasm_opt = binaryen_build.join("bin/wasm-opt");

    let manifest_dir = std::env::var("CARGO_MANIFEST_DIR")?;
    let manifest_dir = PathBuf::from(manifest_dir);
    let workspace = manifest_dir.join("../..");
    let rust_wasm_opt = workspace.join("target/release/wasm-opt");

    Ok(Paths {
        binaryen_wasm_opt, rust_wasm_opt,
    })
}

struct TestArgs {
    /// Relative to 'test-modules' directory.
    infile: PathBuf,
    /// Relative to 'test-modules' directory.
    infile_sourcemap: Option<PathBuf>,
    /// Relative to temp directory.
    outfile: PathBuf,
    outfile_sourcemap: Option<PathBuf>,
    args: Vec<&'static str>,
}

/// Result of running wasm-opt once.
struct TestOut {
    outfile: PathBuf,
    outfile_sourcemap: Option<PathBuf>,
}

fn run_test(args: TestArgs) -> Result<()> {
    let tempdir = tempfile::tempdir()?;
    let binaryen_tempdir = tempdir.path().join("binaryen");
    let rust_tempdir = tempdir.path().join("rust");
    let api_tempdir = tempdir.path().join("api");

    let binaryen_out = run_test_binaryen(&args, &binaryen_tempdir)?;
    let rust_out = run_test_rust(&args, &rust_tempdir)?;
    let api_out = run_test_api(&args, &rust_tempdir)?;

    todo!()
}

fn run_test_binaryen(args: &TestArgs, tempdir: &Path) -> Result<()> {
    // create tempdir

    // find paths

    // run wasm-opt

    // return paths
    todo!()
}

fn run_test_rust(args: &TestArgs, tempdir: &Path) -> Result<()> {
    todo!()
}

fn run_test_api(args: &TestArgs, tempdir: &Path) -> Result<()> {
    todo!()
}

#[test]
fn smoke_test() -> Result<()> {
    run_test(TestArgs {
    })
}




use anyhow::Result;
use std::path::{Path, PathBuf};
use wasm_opt::integration;
use std::process::Command;
use std::fs;

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

    fs::create_dir_all(&binaryen_tempdir)?;
    fs::create_dir_all(&rust_tempdir)?;
    fs::create_dir_all(&api_tempdir)?;
    
    let binaryen_out = run_test_binaryen(&args, &binaryen_tempdir)?;
    let rust_out = run_test_rust(&args, &rust_tempdir)?;
    let api_out = run_test_api(&args, &rust_tempdir)?;

    let binaryen_out_file = fs::read(binaryen_out.outfile)?;
    let rust_out_file = fs::read(rust_out.outfile)?;
    assert_eq!(binaryen_out_file, rust_out_file);

    let api_out_file = fs::read(api_out.outfile)?;
    assert_eq!(api_out_file, rust_out_file);

    if binaryen_out.outfile_sourcemap.is_none()
        && rust_out.outfile_sourcemap.is_none()
        && api_out.outfile_sourcemap.is_none() {

        } else if binaryen_out.outfile_sourcemap.is_some()
        && rust_out.outfile_sourcemap.is_some()
        && api_out.outfile_sourcemap.is_some() {        

            let binaryen_out_sourcemap = fs::read(binaryen_out.outfile_sourcemap.expect("sourcemap"))?;
            let rust_out_sourcemap = fs::read(rust_out.outfile_sourcemap.expect("sourcemap"))?;
            assert_eq!(binaryen_out_sourcemap, rust_out_sourcemap);

            let api_out_sourcemap = fs::read(api_out.outfile_sourcemap.expect("sourcemap"))?;
            assert_eq!(api_out_sourcemap, rust_out_sourcemap);

        } else {
            anyhow::bail!("output_sourcemap test failed");
        }
    
    drop(binaryen_tempdir);
    drop(rust_tempdir);
    drop(api_tempdir);
    
    tempdir.close()?;

    Ok(())
}

fn run_test_binaryen(args: &TestArgs, tempdir: &Path) -> Result<TestOut> {
    let paths = get_paths()?;

    let mut cmd = Command::new(paths.binaryen_wasm_opt);
    cmd.arg(&args.infile);

    let outfile = tempdir.join(args.outfile.as_path());
    cmd.args(["--output", outfile.to_str().expect("PathBuf")]);

    if let Some(infile_sourcemap) = &args.infile_sourcemap {
        cmd.args(["--input-source-map", infile_sourcemap.to_str().expect("PathBuf")]);
    }

    if let Some(outfile_sourcemap) = &args.outfile_sourcemap {
        cmd.args(["--output-source-map", outfile_sourcemap.to_str().expect("PathBuf")]);
    }
    
    args.args.iter().for_each(|arg| {
        cmd.arg(arg);
    });
    
    if !cmd.status()?.success() {
        anyhow::bail!("run binaryen failed");
    }  

    Ok(TestOut {
        outfile,
        outfile_sourcemap: args.outfile_sourcemap.as_ref().map(|s| s.to_path_buf()),
    })
}

fn run_test_rust(args: &TestArgs, tempdir: &Path) -> Result<TestOut> {
    let paths = get_paths()?;
    
    let mut cmd = Command::new(paths.rust_wasm_opt);
    cmd.arg(&args.infile);

    let outfile = tempdir.join(args.outfile.as_path());
    cmd.args(["--output", outfile.to_str().expect("PathBuf")]);

    if let Some(infile_sourcemap) = &args.infile_sourcemap {
        cmd.args(["--input-source-map", infile_sourcemap.to_str().expect("PathBuf")]);
    }

    if let Some(outfile_sourcemap) = &args.outfile_sourcemap {
        cmd.args(["--output-source-map", outfile_sourcemap.to_str().expect("PathBuf")]);
    }

    args.args.iter().for_each(|arg| {
        cmd.arg(arg);
    });

    if !cmd.status()?.success() {
        anyhow::bail!("run rust wasm-opt failed");
    }  

    Ok(TestOut {
        outfile,
        outfile_sourcemap: args.outfile_sourcemap.as_ref().map(|s| s.to_path_buf()),
    })
}

fn run_test_api(args: &TestArgs, tempdir: &Path) -> Result<TestOut> {
    use wasm_opt::integration::Command;

    let paths = get_paths()?;

    let mut cmd = Command::new(paths.rust_wasm_opt);
    cmd.arg(&args.infile);

    let outfile = tempdir.join(args.outfile.as_path());
    cmd.args(["--output", outfile.to_str().expect("PathBuf")]);

    if let Some(infile_sourcemap) = &args.infile_sourcemap {
        cmd.args(["--input-source-map", infile_sourcemap.to_str().expect("PathBuf")]);
    }

    if let Some(outfile_sourcemap) = &args.outfile_sourcemap {
        cmd.args(["--output-source-map", outfile_sourcemap.to_str().expect("PathBuf")]);
    }

    args.args.iter().for_each(|arg| {
        cmd.arg(arg);
    });

    integration::run_from_command_args(cmd)?;

    Ok(TestOut {
        outfile,
        outfile_sourcemap: args.outfile_sourcemap.as_ref().map(|s| s.to_path_buf()),
    })
}

#[test]
fn smoke_test() -> Result<()> {
    let manifest_dir = std::env::var("CARGO_MANIFEST_DIR")?;
    let manifest_dir = PathBuf::from(manifest_dir);
    let workspace = manifest_dir.join("../..");
    let infile = workspace.join("components/wasm-opt/tests/ink_example_multisig.wasm");

    let outfile = PathBuf::from("outfile");
    
    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let mut args = Vec::new();
    args.push("-O");
//    args.push("--intrinsic-lowering");
//    args.push("-O");
    
    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

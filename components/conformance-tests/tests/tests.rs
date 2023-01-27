use anyhow::{Context, Result};
use std::fs;
use std::path::{Path, PathBuf};
use std::process::Command;
use wasm_opt::integration;

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
        binaryen_wasm_opt,
        rust_wasm_opt,
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
    /// Indicates the run succeeded.
    success: bool,
    /// For the binaries, they include the typical command output.
    proc_output: Option<std::process::Output>,
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
    let api_out = run_test_api(&args, &api_tempdir)?;

    assert_eq!(binaryen_out.success, rust_out.success);
    assert_eq!(binaryen_out.success, api_out.success);

    assert_eq!(binaryen_out.proc_output, rust_out.proc_output);

    let has_output = binaryen_out.outfile.exists();
    if has_output {
        let binaryen_out_file = fs::read(binaryen_out.outfile)?;
        let rust_out_file = fs::read(rust_out.outfile)?;

        assert_eq!(binaryen_out_file, rust_out_file);

        let api_out_file = fs::read(api_out.outfile)?;

        assert_eq!(api_out_file, rust_out_file);
    } else {
        assert!(!rust_out.outfile.exists());
        assert!(!api_out.outfile.exists());
    }

    match (
        binaryen_out.outfile_sourcemap,
        rust_out.outfile_sourcemap,
        api_out.outfile_sourcemap,
    ) {
        (None, None, None) => {}
        (Some(binaryen_out), Some(rust_out), Some(api_out)) => {
            let has_sourcemap_output = binaryen_out.exists();
            if has_sourcemap_output {
                let binaryen_out_sourcemap = fs::read(binaryen_out)?;
                let rust_out_sourcemap = fs::read(rust_out)?;
                assert_eq!(binaryen_out_sourcemap, rust_out_sourcemap);

                let api_out_sourcemap = fs::read(api_out)?;
                assert_eq!(api_out_sourcemap, rust_out_sourcemap);
            } else {
                assert!(!rust_out.exists());
                assert!(!api_out.exists());
            }
        }
        _ => anyhow::bail!("output_sourcemap test failed"),
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
        cmd.args([
            "--input-source-map",
            infile_sourcemap.to_str().expect("PathBuf"),
        ]);
    }

    let outfile_sourcemap = args.outfile_sourcemap.as_ref().map(|s| tempdir.join(s));

    if let Some(ref outfile_sourcemap) = outfile_sourcemap {
        cmd.args([
            "--output-source-map",
            outfile_sourcemap.to_str().expect("PathBuf"),
        ]);
    }

    if !args.args.is_empty() {
        args.args.iter().for_each(|arg| {
            cmd.arg(arg);
        });
    }

    let proc_output = cmd.output().context("run binaryen failed")?;
    let success = proc_output.status.success();
    let proc_output = Some(proc_output);

    Ok(TestOut {
        outfile,
        outfile_sourcemap,
        success,
        proc_output,
    })
}

fn run_test_rust(args: &TestArgs, tempdir: &Path) -> Result<TestOut> {
    let paths = get_paths()?;

    let mut cmd = Command::new(paths.rust_wasm_opt);
    cmd.arg(&args.infile);

    let outfile = tempdir.join(args.outfile.as_path());
    cmd.args(["--output", outfile.to_str().expect("PathBuf")]);

    if let Some(infile_sourcemap) = &args.infile_sourcemap {
        cmd.args([
            "--input-source-map",
            infile_sourcemap.to_str().expect("PathBuf"),
        ]);
    }

    let outfile_sourcemap = args.outfile_sourcemap.as_ref().map(|s| tempdir.join(s));

    if let Some(ref outfile_sourcemap) = outfile_sourcemap {
        cmd.args([
            "--output-source-map",
            outfile_sourcemap.to_str().expect("PathBuf"),
        ]);
    }

    if !args.args.is_empty() {
        args.args.iter().for_each(|arg| {
            cmd.arg(arg);
        });
    }

    let proc_output = cmd.output().context("run rust wasm-opt failed")?;
    let success = proc_output.status.success();
    let proc_output = Some(proc_output);

    Ok(TestOut {
        outfile,
        outfile_sourcemap,
        success,
        proc_output,
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
        cmd.args([
            "--input-source-map",
            infile_sourcemap.to_str().expect("PathBuf"),
        ]);
    }

    let outfile_sourcemap = args.outfile_sourcemap.as_ref().map(|s| tempdir.join(s));

    if let Some(ref outfile_sourcemap) = outfile_sourcemap {
        cmd.args([
            "--output-source-map",
            outfile_sourcemap.to_str().expect("PathBuf"),
        ]);
    }

    if !args.args.is_empty() {
        args.args.iter().for_each(|arg| {
            cmd.arg(arg);
        });
    }

    let success = integration::run_from_command_args(cmd).is_ok();

    Ok(TestOut {
        outfile,
        outfile_sourcemap,
        success,
        proc_output: None,
    })
}

fn get_test_infile_wasm() -> Result<PathBuf> {
    let manifest_dir = std::env::var("CARGO_MANIFEST_DIR")?;
    let manifest_dir = PathBuf::from(manifest_dir);
    let workspace = manifest_dir.join("../..");
    let infile = workspace.join("components/wasm-opt/tests/ink_example_multisig.wasm");

    Ok(infile)
}

fn get_test_infile_wat() -> Result<PathBuf> {
    let manifest_dir = std::env::var("CARGO_MANIFEST_DIR")?;
    let manifest_dir = PathBuf::from(manifest_dir);
    let workspace = manifest_dir.join("../..");
    let infile = workspace.join("components/wasm-opt/tests/hello_world.wat");

    Ok(infile)
}

fn get_test_sourcemap() -> Result<PathBuf> {
    let manifest_dir = std::env::var("CARGO_MANIFEST_DIR")?;
    let manifest_dir = PathBuf::from(manifest_dir);
    let workspace = manifest_dir.join("../..");
    let infile = workspace.join("components/wasm-opt/tests/hello_world.map");

    Ok(infile)
}

#[test]
fn wasm_to_wasm_no_optimization_args() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = Vec::new();

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_o() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-O"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_o0() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-O0"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_os() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-Os"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_oz() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-Oz"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_o1() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-O1"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_o2() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-O2"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_o3() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-O3"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_o4() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-O4"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wat_o() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wat");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-O", "--emit-text"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wat_no_optimization_args() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wat");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["--emit-text"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wat_to_wasm_o() -> Result<()> {
    let infile = get_test_infile_wat()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-O"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wat_to_wasm_no_optimization_args() -> Result<()> {
    let infile = get_test_infile_wat()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = Vec::new();

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wat_to_wasm_os() -> Result<()> {
    let infile = get_test_infile_wat()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-Os"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wat_os() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wat");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-Os", "--emit-text"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_with_sourcemap_to_wasm_without_sourcemap_os() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = get_test_sourcemap()?;
    let infile_sourcemap = Some(infile_sourcemap);
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-Os"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_with_sourcemap_to_wasm_with_sourcemap_os() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = get_test_sourcemap()?;
    let infile_sourcemap = Some(infile_sourcemap);

    let outfile_sourcemap = PathBuf::from("outfile_sourcemap.map");
    let outfile_sourcemap = Some(outfile_sourcemap);

    let args = vec!["-Os"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_o0_inlining_opt() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec![
        "-O0",
        "--always-inline-max-function-size",
        "2",
        "--flexible-inline-max-function-size",
        "20",
        "--one-caller-inline-max-function-size",
        "5",
        "--inline-functions-with-loops",
        "--partial-inlining-ifs",
        "0",
    ];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_debuginfo() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-Os", "-g"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_zero_filled_memory() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-Os", "--zero-filled-memory"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_source_map_url() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-Os", "--output-source-map-url", "https://example.com"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_mvp_features() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-Os", "--mvp-features"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_all_features() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-Os", "--all-features"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_enable_custom_features() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec![
        "-Os",
        "--enable-threads",
        "--enable-mutable-globals",
        "--enable-nontrapping-float-to-int",
        "--enable-simd",
        "--enable-bulk-memory",
        "--enable-sign-ext",
        "--enable-exception-handling",
        "--enable-tail-call",
        "--enable-reference-types",
        "--enable-multivalue",
        "--enable-gc",
        "--enable-memory64",
        "--enable-gc-nn-locals",
        "--enable-relaxed-simd",
        "--enable-extended-const",
        "--enable-strings",
        "--enable-multi-memories",
    ];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_disable_custom_features() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec![
        "-Os",
        "--disable-threads",
        "--disable-mutable-globals",
        "--disable-nontrapping-float-to-int",
        "--disable-simd",
        "--disable-bulk-memory",
        "--disable-sign-ext",
        "--disable-exception-handling",
        "--disable-tail-call",
        "--disable-reference-types",
        "--disable-multivalue",
        "--disable-gc",
        "--disable-memory64",
        "--disable-gc-nn-locals",
        "--disable-relaxed-simd",
        "--disable-extended-const",
        "--disable-strings",
        "--disable-multi-memories",
    ];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_pass_arg() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec![
        "--extract-function",
        "--pass-arg",
        "extract-function@rust_begin_unwind",
    ];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn wasm_to_wasm_converge() -> Result<()> {
    let infile = get_test_infile_wasm()?;
    let outfile = PathBuf::from("outfile.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec!["-Os", "--converge"];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn input_file_does_not_exist() -> Result<()> {
    let infile = PathBuf::from("bogus.wasm");
    let outfile = PathBuf::from("bogus-out.wasm");

    let infile_sourcemap = None::<PathBuf>;
    let outfile_sourcemap = None::<PathBuf>;

    let args = vec![];

    run_test(TestArgs {
        infile,
        infile_sourcemap,
        outfile,
        outfile_sourcemap,
        args,
    })
}

#[test]
fn check_versions() -> Result<()> {
    let paths = get_paths()?;

    let output = Command::new(paths.binaryen_wasm_opt)
        .arg("--version")
        .output()?;

    let version_binaryen = String::from_utf8(output.stdout)?.trim().to_string();

    let output = Command::new(paths.rust_wasm_opt)
        .arg("--version")
        .output()?;

    let version_rust = String::from_utf8(output.stdout)?.trim().to_string();

    assert_eq!(version_binaryen, version_rust);

    Ok(())
}

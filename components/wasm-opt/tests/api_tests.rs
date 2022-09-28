use std::collections::HashSet;
use strum::IntoEnumIterator;
use wasm_opt::base::pass_registry;
use wasm_opt::base::InliningOptions as BaseInliningOptions;
use wasm_opt::base::PassOptions as BasePassOptions;
use wasm_opt::base::{
    check_inlining_options_defaults, check_pass_options_defaults, pass_registry::is_pass_hidden,
};
use wasm_opt::*;

use std::error::Error;
use std::ffi::OsString;
use std::fs::File;
use std::io::BufWriter;
use std::io::Write;
use std::path::PathBuf;
use tempfile::Builder;

static WASM_FILE: &[u8] = include_bytes!("hello_world.wasm");
static GARBAGE_FILE: &[u8] = include_bytes!("garbage_file.wat");

#[test]
fn all_passes_correct() -> anyhow::Result<()> {
    let mut passes_via_base_rs = HashSet::<String>::new();
    pass_registry::get_registered_names()
        .iter()
        .for_each(|name| {
            if !is_pass_hidden(name) {
                passes_via_base_rs.insert(name.to_string());
            }
        });

    let mut passes_via_enum = HashSet::<String>::new();

    Pass::iter().for_each(|item| {
        passes_via_enum.insert(item.name().to_string());
    });

    let diff: Vec<_> = passes_via_base_rs.difference(&passes_via_enum).collect();

    println!("diff: {:?}", diff);

    assert_eq!(passes_via_base_rs, passes_via_enum);

    Ok(())
}

#[test]
fn test_inlining_options_defaults() -> anyhow::Result<()> {
    let inlining_defaults = InliningOptions::default();
    let mut inlining = BaseInliningOptions::new();
    inlining.set_always_inline_max_size(inlining_defaults.always_inline_max_size);
    inlining.set_one_caller_inline_max_size(inlining_defaults.one_caller_inline_max_size);
    inlining.set_flexible_inline_max_size(inlining_defaults.flexible_inline_max_size);
    inlining.set_allow_functions_with_loops(inlining_defaults.allow_functions_with_loops);
    inlining.set_partial_inlining_ifs(inlining_defaults.partial_inlining_ifs);

    assert_eq!(check_inlining_options_defaults(inlining), true);

    Ok(())
}

#[test]
fn test_pass_options_defaults() -> anyhow::Result<()> {
    let pass_options_defaults = PassOptions::default();
    let mut pass_options = BasePassOptions::new();
    pass_options.set_validate(pass_options_defaults.validate);
    pass_options.set_validate_globally(pass_options_defaults.validate_globally);
    pass_options.set_optimize_level(pass_options_defaults.optimize_level as i32);
    pass_options.set_shrink_level(pass_options_defaults.shrink_level as i32);
    pass_options.set_traps_never_happen(pass_options_defaults.traps_never_happen);
    pass_options.set_low_memory_unused(pass_options_defaults.low_memory_unused);
    pass_options.set_fast_math(pass_options_defaults.fast_math);
    pass_options.set_zero_filled_memory(pass_options_defaults.zero_filled_memory);
    pass_options.set_debug_info(pass_options_defaults.debug_info);

    assert_eq!(check_pass_options_defaults(pass_options), true);

    Ok(())
}

#[test]
fn test_optimization_options_os() -> anyhow::Result<()> {
    let opts = OptimizationOptions::new_optimize_for_size();

    let mut pass_options = BasePassOptions::new();
    pass_options.set_validate(opts.passopts.validate);
    pass_options.set_validate_globally(opts.passopts.validate_globally);
    pass_options.set_optimize_level(opts.passopts.optimize_level as i32);
    pass_options.set_shrink_level(opts.passopts.shrink_level as i32);
    pass_options.set_traps_never_happen(opts.passopts.traps_never_happen);
    pass_options.set_low_memory_unused(opts.passopts.low_memory_unused);
    pass_options.set_fast_math(opts.passopts.fast_math);
    pass_options.set_zero_filled_memory(opts.passopts.zero_filled_memory);
    pass_options.set_debug_info(opts.passopts.debug_info);

    assert_eq!(check_pass_options_defaults(pass_options), true);

    Ok(())
}

#[test]
fn optimization_read_module_error_works() -> anyhow::Result<()> {
    let temp_dir = Builder::new().prefix("wasm_opt_tests").tempdir()?;
    let inpath = temp_dir.path().join("infile.wasm");

    let file = File::create(&inpath)?;

    let mut buf_writer = BufWriter::new(&file);
    buf_writer.write_all(GARBAGE_FILE)?;

    let outpath = temp_dir.path().join("outfile.wasm");

    let opts = OptimizationOptions::new_optimize_for_size();
    let res = opts.run(inpath, outpath);

    assert!(res.err().unwrap().source().is_some());

    Ok(())
}

#[test]
fn pass_arg_unsupported_works() -> anyhow::Result<()> {
    use wasm_opt::integration::Command;

    let temp_dir = Builder::new().prefix("wasm_opt_tests").tempdir()?;
    let inpath = temp_dir.path().join("infile.wasm");

    let infile = File::create(&inpath)?;

    let mut buf_writer = BufWriter::new(&infile);
    buf_writer.write_all(WASM_FILE)?;

    let outfile = temp_dir.path().join("outfile.wasm");

    let manifest_dir = std::env::var("CARGO_MANIFEST_DIR")?;
    let manifest_dir = PathBuf::from(manifest_dir);
    let workspace = manifest_dir.join("../..");
    let rust_wasm_opt_dir = workspace.join("target/release/wasm-opt");

    let mut cmd = Command::new(rust_wasm_opt_dir);
    cmd.arg(&inpath);
    cmd.args(["--output", outfile.to_str().expect("PathBuf")]);

    cmd.arg("-p");
    cmd.arg("--whatever");
    cmd.arg("--no-validation");

    let res = integration::run_from_command_args(cmd);

    assert!(res.is_err());

    if let Some(err) = res.err() {
        match err {
            integration::Error::Unsupported { args } => {
                if args.contains(&OsString::from("--no-validation")) {
                    panic!();
                }

                if !(args.contains(&OsString::from("-p"))
                    && args.contains(&OsString::from("--whatever")))
                {
                    panic!();
                }
            }
            _ => panic!(),
        }
    }

    Ok(())
}

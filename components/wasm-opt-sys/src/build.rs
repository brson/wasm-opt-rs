#![allow(unused)]

use std::path::Path;

fn main() -> anyhow::Result<()> {
    Ok(())
}

fn main_() -> anyhow::Result<()> {
    let manifest_dir = std::env::var("CARGO_MANIFEST_DIR")?;
    let manifest_dir = Path::new(&manifest_dir);
    let binaryen_dir = manifest_dir.join("binaryen");

    let src_dir = binaryen_dir.join("src");
    let tools_dir = src_dir.join("tools");
    let wasm_opt_cpp = tools_dir.join("wasm-opt.cpp");

    let src_files = [
        wasm_opt_cpp,
    ];

    let flags = [
        "-Wno-unused-parameter",
        "-std=c++17",
    ];

    let mut builder = cc::Build::new();
    for flag in flags {
        builder.flag(flag);
    }
    builder
        .cpp(true)
        .include(src_dir)
        .files(src_files)
        .compile("wasm-opt-cc");

    Ok(())
}

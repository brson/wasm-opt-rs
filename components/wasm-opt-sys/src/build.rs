#![allow(unused)]

use std::path::{Path, PathBuf};

fn main() -> anyhow::Result<()> {
    let manifest_dir = std::env::var("CARGO_MANIFEST_DIR")?;
    let manifest_dir = Path::new(&manifest_dir);
    let binaryen_dir = manifest_dir.join("binaryen");

    let src_dir = binaryen_dir.join("src");

    let src_files = get_src_files(&src_dir);

    let tools_dir = src_dir.join("tools");
    let wasm_opt_src = tools_dir.join("wasm-opt.cpp");

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
        .file(wasm_opt_src)
        .compile("wasm-opt-cc");

    Ok(())
}

fn get_src_files(src_dir: &Path) -> Vec<PathBuf> {
    let wasm_dir = src_dir.join("wasm");
    let wasm_files = [
        "literal.cpp",
        "wasm-binary.cpp",
        "wasm-interpreter.cpp",
        "wasm-io.cpp",
        "wasm-s-parser.cpp",
        "wasm-stack.cpp",
        "wasm-type.cpp",
        "wasm-validator.cpp",
        "wasm.cpp",
    ];
    let wasm_files = wasm_files.iter().map(|f| {
        wasm_dir.join(f)
    });

    let support_dir = src_dir.join("support");
    let support_files = [
        "bits.cpp",
    ];
    let support_files = support_files.iter().map(|f| {
        support_dir.join(f)
    });

    let src_files: Vec<_> = None.into_iter()
        .chain(wasm_files)
        .chain(support_files)
        .collect();

    src_files
}

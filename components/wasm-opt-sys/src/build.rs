#![allow(unused)]

use std::fs::{self, File};
use std::io::{BufRead, BufReader, BufWriter, Write};
use std::path::{Path, PathBuf};

fn main() -> anyhow::Result<()> {
    let manifest_dir = std::env::var("CARGO_MANIFEST_DIR")?;
    let manifest_dir = Path::new(&manifest_dir);
    let binaryen_dir = manifest_dir.join("binaryen");

    let src_dir = binaryen_dir.join("src");

    let src_files = get_src_files(&src_dir)?;

    let tools_dir = src_dir.join("tools");
    let wasm_opt_src = tools_dir.join("wasm-opt.cpp");
    let wasm_opt_src = get_converted_wasm_opt_cpp(&wasm_opt_src)?;

    let flags = ["-Wno-unused-parameter", "-std=c++17"];

    let mut builder = cc::Build::new();
    for flag in flags {
        builder.flag(flag);
    }
    builder
        .cpp(true)
        .include(src_dir)
        .include(tools_dir)
        .files(src_files)
        .file(wasm_opt_src)
        .compile("wasm-opt-cc");

    Ok(())
}

fn get_converted_wasm_opt_cpp(src_dir: &Path) -> anyhow::Result<PathBuf> {
    let wasm_opt_file = File::open(src_dir)?;
    let reader = BufReader::new(wasm_opt_file);

    let output_dir = std::env::var("OUT_DIR")?;
    let output_dir = Path::new(&output_dir);

    let temp_file_dir = output_dir.join("wasm_opt.cpp.temp");
    let mut temp_file = File::create(&temp_file_dir)?;

    let mut writer = BufWriter::new(temp_file);
    for line in reader.lines() {
        let mut line = line?;

        if line.contains("int main") {
            line = line.replace("int main", "extern \"C\" int wasm_opt_main");
        }

        writer.write_all(line.as_bytes())?;
        writer.write_all(b"\n")?;
    }

    let output_wasm_opt_file = output_dir.join("wasm-opt.cpp");
    fs::rename(&temp_file_dir, &output_wasm_opt_file)?;

    Ok(output_wasm_opt_file)
}

fn get_src_files(src_dir: &Path) -> anyhow::Result<Vec<PathBuf>> {
    let wasm_dir = src_dir.join("wasm");
    let wasm_files = [
        "wasm-debug.cpp",
        "literal.cpp",
        "parsing.cpp",
        "wasm-binary.cpp",
        "wasm-interpreter.cpp",
        "wasm-io.cpp",
        "wasm-s-parser.cpp",
        "wasm-stack.cpp",
        "wasm-type.cpp",
        "wasm-validator.cpp",
        "wasm.cpp",
    ];
    let wasm_files = wasm_files.iter().map(|f| wasm_dir.join(f));

    let support_dir = src_dir.join("support");
    let support_files = [
        "bits.cpp",
        "colors.cpp",
        //        "command-line.cpp",
        "file.cpp",
        "safe_integer.cpp",
        "threads.cpp",
    ];
    let support_files = support_files.iter().map(|f| support_dir.join(f));

    let ir_dir = src_dir.join("ir");
    let ir_files = [
        "eh-utils.cpp",
        "intrinsics.cpp",
        "module-utils.cpp",
        "ReFinalize.cpp",
        "stack-utils.cpp",
        "table-utils.cpp",
        "type-updating.cpp",
    ];
    let ir_files = ir_files.iter().map(|f| ir_dir.join(f));

    let passes_dir = src_dir.join("passes");
    let passes_files = get_files_from_dir(&passes_dir)?;

    let fuzzing_dir = src_dir.join("tools/fuzzing");
    let fuzzing_files = ["fuzzing.cpp", "random.cpp"];
    let fuzzing_files = fuzzing_files.iter().map(|f| fuzzing_dir.join(f));

    let src_files: Vec<_> = None
        .into_iter()
        .chain(wasm_files)
        .chain(support_files)
        .chain(ir_files)
        .chain(passes_files)
        .chain(fuzzing_files)
        .collect();

    Ok(src_files)
}

fn get_files_from_dir(src_dir: &Path) -> anyhow::Result<impl Iterator<Item = PathBuf> + '_> {
    let files = fs::read_dir(src_dir)?
        .map(|f| f.expect("error reading dir"))
        .filter(|f| f.file_name().into_string().expect("UTF8").ends_with(".cpp"))
        .map(|f| src_dir.join(f.path()));

    Ok(files)
}

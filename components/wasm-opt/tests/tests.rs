use wasm_opt::*;

use std::fs::File;
use std::io::BufWriter;
use std::io::Write;
use tempfile::Builder;

static WAT_FILE: &[u8] = include_bytes!("hello_world.wat");
static WASM_FILE: &[u8] = include_bytes!("hello_world.wasm");

#[test]
fn module_reader_binary_works() -> anyhow::Result<()> {
    let temp_dir = Builder::new().prefix("wasm_opt_tests").tempdir()?;
    let path = temp_dir.path().join("hello_world.wasm");

    let temp_file = File::create(&path)?;
    let mut writer = BufWriter::new(&temp_file);
    writer.write_all(WASM_FILE)?;

    let mut m = Module::new();
    let mut reader = ModuleReader::new();
    reader.read_binary(&path, &mut m, None)?;

    // todo

    Ok(())
}

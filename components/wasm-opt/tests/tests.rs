use wasm_opt::*;

use std::fs::{self, File};
use std::io::BufWriter;
use std::io::Write;
use tempfile::Builder;

static WAT_FILE: &[u8] = include_bytes!("hello_world.wat");
static WASM_FILE: &[u8] = include_bytes!("hello_world.wasm");

#[test]
fn read_write_text_works() -> anyhow::Result<()> {
    let temp_dir = Builder::new().prefix("wasm_opt_tests").tempdir()?;
    let path = temp_dir.path().join("hello_world.wat");

    let temp_file = File::create(&path)?;
    let mut buf_writer = BufWriter::new(&temp_file);
    buf_writer.write_all(WAT_FILE)?;

    let mut m = Module::new();
    let mut reader = ModuleReader::new();
    reader.read_text(&path, &mut m)?;

    // todo

    Ok(())
}

#[test]
fn read_write_binary_works() -> anyhow::Result<()> {
    let temp_dir = Builder::new().prefix("wasm_opt_tests").tempdir()?;
    let path = temp_dir.path().join("hello_world.wasm");

    let temp_file = File::create(&path)?;
    let mut buf_writer = BufWriter::new(&temp_file);
    buf_writer.write_all(WASM_FILE)?;

    let mut m = Module::new();
    let mut reader = ModuleReader::new();
    reader.read_binary(&path, &mut m, None)?;

    let mut writer = ModuleWriter::new();
    let new_file = temp_dir.path().join("hellow_world_by_module_writer.wasm");
    writer.write_binary(&mut m, &new_file)?;

    let mut another_m = Module::new();
    let mut another_reader = ModuleReader::new();
    another_reader.read_binary(&new_file, &mut another_m, None)?;
    let mut another_writer = ModuleWriter::new();
    let another_new_file = temp_dir.path().join("hello_world_by_another_module_writer.wasm");
    another_writer.write_binary(&mut another_m, &another_new_file)?;

    let new_file_reader = fs::read(&new_file)?;
    let another_new_file_reader = fs::read(&another_new_file)?;
    
    assert_eq!(new_file_reader, another_new_file_reader);
    Ok(())
}

use wasm_opt::*;

use std::fs::File;
use std::io::Write;
use tempfile::Builder;
use std::io::BufWriter;

static WAT_FILE: &[u8] = include_bytes!("hello_world.wat");

#[test]
fn module_reader_works() -> anyhow::Result<()> {
    let temp_dir = Builder::new().prefix("wasm_opt_tests").tempdir()?;
    let path = temp_dir.path().join("hello_world.wat");
    
    let temp_file = File::create(&path)?;
    let mut writer = BufWriter::new(&temp_file);
    writer.write_all(WAT_FILE)?;
    
    let mut m = Module::new();
    let mut reader = ModuleReader::new();
    reader.read_text(&path, &mut m);

    // todo

    Ok(())
}

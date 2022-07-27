use wasm_opt_cxx_sys as wocxx;
use wocxx::cxx;
use wocxx::ffi;
use wocxx::cxx::let_cxx_string;

use std::path::Path;

pub struct Module(cxx::UniquePtr<ffi::Module>);

impl Module {
    pub fn new() -> Module {
        Module(ffi::newModule())
    }
}

pub struct ModuleReader(cxx::UniquePtr<ffi::ModuleReader>);

impl ModuleReader {
    pub fn new() -> ModuleReader {
        ModuleReader(ffi::newModuleReader())
    }

    // FIXME would rather take &self here but the C++ method is not const-correct
    // FIXME handle exceptions
    pub fn read_text(&mut self, path: &Path, wasm: &mut Module) {
        // FIXME need to support non-utf8 paths. Does this work on windows?
        let_cxx_string!(path = path.to_str().expect("utf8"));
        ffi::ModuleReader_readText(
            self.0.as_mut().expect("non-null"),
            &path,
            wasm.0.as_mut().expect("non-null"),
        );
    }
}

pub struct ModuleWriter(cxx::UniquePtr<ffi::ModuleWriter>);

impl ModuleWriter {
    pub fn new() -> ModuleWriter {
        ModuleWriter(ffi::newModuleWriter())
    }
}





/// Hack to establish linage to wasm-opt-sys.
///
/// See docs for wasm_opt_sys::init.
///
/// FIXME: reevaluate this later
#[doc(hidden)]
pub fn init() -> anyhow::Result<()> {
    wasm_opt_sys::init();

    Ok(())
}

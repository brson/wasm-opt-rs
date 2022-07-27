use wasm_opt_cxx_sys as wocxx;
use wocxx::cxx;

pub struct Module(cxx::UniquePtr<wocxx::ffi::Module>);

impl Module {
    pub fn new() -> Module {
        Module(wocxx::ffi::newModule())
    }
}

pub struct ModuleReader(cxx::UniquePtr<wocxx::ffi::ModuleReader>);

impl ModuleReader {
    pub fn new() -> ModuleReader {
        ModuleReader(wocxx::ffi::newModuleReader())
    }
}

pub struct ModuleWriter(cxx::UniquePtr<wocxx::ffi::ModuleWriter>);

impl ModuleWriter {
    pub fn new() -> ModuleWriter {
        ModuleWriter(wocxx::ffi::newModuleWriter())
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

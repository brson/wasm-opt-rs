use wasm_opt_cxx_sys as wocxx;
use wocxx::cxx;

pub struct ModuleReader(cxx::UniquePtr<wocxx::ffi::ModuleReader>);

impl ModuleReader {
    pub fn new() -> ModuleReader {
        ModuleReader(wocxx::ffi::newModuleReader())
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

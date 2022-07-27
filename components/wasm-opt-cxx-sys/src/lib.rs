pub use cxx;

#[cxx::bridge(namespace = "wasm")]
pub mod ffi {
    unsafe extern "C++" {
        include!("shims.h");

        type Module;

        fn newModule() -> UniquePtr<Module>;
    }

    unsafe extern "C++" {
        include!("shims.h");

        type ModuleReader;

        fn newModuleReader() -> UniquePtr<ModuleReader>;
    }

    unsafe extern "C++" {
        include!("shims.h");

        type ModuleWriter;

        fn newModuleWriter() -> UniquePtr<ModuleWriter>;
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

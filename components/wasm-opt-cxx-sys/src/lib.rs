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

        fn ModuleReader_readText(
            reader: Pin<&mut ModuleReader>,
            filename: &CxxString,
            wasm: Pin<&mut Module>,
        );

        fn ModuleReader_readBinary(
            reader: Pin<&mut ModuleReader>,
            filename: &CxxString,
            wasm: Pin<&mut Module>,
            sourceMapFilename: &CxxString,
        );

        fn ModuleReader_read(
            reader: Pin<&mut ModuleReader>,
            filename: &CxxString,
            wasm: Pin<&mut Module>,
            sourceMapFilename: &CxxString,
        );
    }

    unsafe extern "C++" {
        include!("shims.h");

        type ModuleWriter;

        fn newModuleWriter() -> UniquePtr<ModuleWriter>;

        fn ModuleWriter_writeText(
            writer: Pin<&mut ModuleWriter>,
            wasm: Pin<&mut Module>,
            filename: &CxxString,
        );

        fn ModuleWriter_writeBinary(
            writer: Pin<&mut ModuleWriter>,
            wasm: Pin<&mut Module>,
            filename: &CxxString,
        );
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

pub use cxx;

#[cxx::bridge(namespace = "Colors")]
pub mod ffi_colors {
    unsafe extern "C++" {
        include!("shims.h");

        fn setEnabled(enabled: bool);
    }
}

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
        ) -> Result<()>;

        fn ModuleReader_readBinary(
            reader: Pin<&mut ModuleReader>,
            filename: &CxxString,
            wasm: Pin<&mut Module>,
            sourceMapFilename: &CxxString,
        ) -> Result<()>;

        fn ModuleReader_read(
            reader: Pin<&mut ModuleReader>,
            filename: &CxxString,
            wasm: Pin<&mut Module>,
            sourceMapFilename: &CxxString,
        ) -> Result<()>;
    }

    unsafe extern "C++" {
        include!("shims.h");

        type ModuleWriter;

        fn newModuleWriter() -> UniquePtr<ModuleWriter>;

        fn ModuleWriter_writeText(
            writer: Pin<&mut ModuleWriter>,
            wasm: Pin<&mut Module>,
            filename: &CxxString,
        ) -> Result<()>;

        fn ModuleWriter_writeBinary(
            writer: Pin<&mut ModuleWriter>,
            wasm: Pin<&mut Module>,
            filename: &CxxString,
        ) -> Result<()>;
    }

    unsafe extern "C++" {
        include!("shims.h");

        type PassRunner<'wasm>;

        // todo: are these lifetimes enough to
        // keep `wasm` from being aliased later?
        fn newPassRunner<'wasm>(wasm: Pin<&'wasm mut Module>) -> UniquePtr<PassRunner<'wasm>>;

        fn addDefaultOptimizationPasses(self: Pin<&mut Self>);

        fn run(self: Pin<&mut Self>);
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

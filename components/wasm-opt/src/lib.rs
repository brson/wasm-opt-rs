use wasm_opt_cxx_sys as wocxx;
use wocxx::cxx;
use wocxx::cxx::let_cxx_string;
use wocxx::ffi;

use std::path::Path;

pub struct Module(cxx::UniquePtr<ffi::wasm::Module>);

impl Module {
    pub fn new() -> Module {
        Module(ffi::wasm::newModule())
    }
}

pub struct ModuleReader(cxx::UniquePtr<ffi::wasm::ModuleReader>);

impl ModuleReader {
    pub fn new() -> ModuleReader {
        ModuleReader(ffi::wasm::newModuleReader())
    }

    // FIXME would rather take &self here but the C++ method is not const-correct
    pub fn read_text(&mut self, path: &Path, wasm: &mut Module) -> Result<(), cxx::Exception> {
        // FIXME need to support non-utf8 paths. Does this work on windows?
        let_cxx_string!(path = path.to_str().expect("utf8"));
        ffi::wasm::ModuleReader_readText(
            self.0.as_mut().expect("non-null"),
            &path,
            wasm.0.as_mut().expect("non-null"),
        )
    }

    pub fn read_binary(
        &mut self,
        path: &Path,
        wasm: &mut Module,
        source_map_filename: Option<&Path>,
    ) -> Result<(), cxx::Exception> {
        let source_map_filename = source_map_filename
            .map(|p| p.to_str().expect("utf8"))
            .unwrap_or("");
        let_cxx_string!(path = path.to_str().expect("utf8"));
        let_cxx_string!(source_map_filename = source_map_filename);
        ffi::wasm::ModuleReader_readBinary(
            self.0.as_mut().expect("non-null"),
            &path,
            wasm.0.as_mut().expect("non-null"),
            &source_map_filename,
        )
    }

    pub fn read(
        &mut self,
        path: &Path,
        wasm: &mut Module,
        source_map_filename: Option<&Path>,
    ) -> Result<(), cxx::Exception> {
        let source_map_filename = source_map_filename
            .map(|p| p.to_str().expect("utf8"))
            .unwrap_or("");
        let_cxx_string!(path = path.to_str().expect("utf8"));
        let_cxx_string!(source_map_filename = source_map_filename);
        ffi::wasm::ModuleReader_read(
            self.0.as_mut().expect("non-null"),
            &path,
            wasm.0.as_mut().expect("non-null"),
            &source_map_filename,
        )
    }
}

pub struct ModuleWriter(cxx::UniquePtr<ffi::wasm::ModuleWriter>);

impl ModuleWriter {
    pub fn new() -> ModuleWriter {
        ModuleWriter(ffi::wasm::newModuleWriter())
    }

    pub fn write_text(&mut self, wasm: &mut Module, path: &Path) -> Result<(), cxx::Exception> {
        ffi::colors::setEnabled(false);

        let_cxx_string!(path = path.to_str().expect("utf8"));
        ffi::wasm::ModuleWriter_writeText(
            self.0.as_mut().expect("non-null"),
            wasm.0.as_mut().expect("non-null"),
            &path,
        )
    }

    pub fn write_binary(&mut self, wasm: &mut Module, path: &Path) -> Result<(), cxx::Exception> {
        let_cxx_string!(path = path.to_str().expect("utf8"));
        ffi::wasm::ModuleWriter_writeBinary(
            self.0.as_mut().expect("non-null"),
            wasm.0.as_mut().expect("non-null"),
            &path,
        )
    }
}

pub struct PassOptions(cxx::UniquePtr<ffi::wasm::PassOptions>);

impl PassOptions {
    pub fn new() -> PassOptions {
        PassOptions(ffi::wasm::newPassOptions())
    }

    pub fn set_optimize_level(&mut self, level: i32) {
        let this = self.0.as_mut().expect("non-null");
        this.setOptimizeLevel(level);
    }

    pub fn set_shrink_level(&mut self, level: i32) {
        let this = self.0.as_mut().expect("non-null");
        this.setShrinkLevel(level);
    }
}

pub struct PassRunner<'wasm>(cxx::UniquePtr<ffi::wasm::PassRunner<'wasm>>);

impl<'wasm> PassRunner<'wasm> {
    pub fn new(wasm: &'wasm mut Module) -> PassRunner<'wasm> {
        let wasm = wasm.0.as_mut().expect("non-null");
        PassRunner(ffi::wasm::newPassRunner(wasm))
    }

    pub fn new_with_options(wasm: &'wasm mut Module, options: PassOptions) -> PassRunner<'wasm> {
        let wasm = wasm.0.as_mut().expect("non-null");
        PassRunner(ffi::wasm::newPassRunnerWithOptions(wasm, options.0))
    }

    pub fn add_default_optimization_passes(&mut self) {
        let this = self.0.as_mut().expect("non-null");
        this.addDefaultOptimizationPasses();
    }

    pub fn run(&mut self) {
        let this = self.0.as_mut().expect("non-null");
        this.run();
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

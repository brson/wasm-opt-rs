//! The "base" API.
//!
//! This API hides the [`cxx`] types,
//! but otherwise sticks closely to the binaryen API.

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

    pub fn set_debug_info(&mut self, debug: bool) {
        ffi::wasm::ModuleReader_setDebugInfo(self.0.as_mut().expect("non-null"), debug)
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

    pub fn set_debug_info(&mut self, debug: bool) {
        ffi::wasm::ModuleWriter_setDebugInfo(self.0.as_mut().expect("non-null"), debug)
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

pub mod pass_registry {
    use wasm_opt_cxx_sys as wocxx;
    use wocxx::cxx::let_cxx_string;
    use wocxx::ffi;

    pub fn get_registered_names() -> Vec<String> {
        let names = ffi::wasm::getRegisteredNames();

        let name_vec: Vec<String> = names
            .iter()
            .map(|name| name.to_string_lossy().into_owned())
            .collect();

        name_vec
    }

    pub fn get_pass_description(name: &str) -> String {
        let_cxx_string!(name = name);

        let description = ffi::wasm::getPassDescription(&name);
        let description = description.as_ref().expect("non-null");

        description.to_str().expect("utf8").to_string()
    }

    pub fn is_pass_hidden(name: &str) -> bool {
        let_cxx_string!(name = name);

        ffi::wasm::isPassHidden(&name)
    }
}

pub struct InliningOptions(cxx::UniquePtr<ffi::wasm::InliningOptions>);

impl InliningOptions {
    pub fn new() -> InliningOptions {
        InliningOptions(ffi::wasm::newInliningOptions())
    }

    pub fn set_always_inline_max_size(&mut self, size: u32) {
        let this = self.0.as_mut().expect("non-null");
        this.setAlwaysInlineMaxSize(size);
    }

    pub fn set_one_caller_inline_max_size(&mut self, size: u32) {
        let this = self.0.as_mut().expect("non-null");
        this.setOneCallerInlineMaxSize(size);
    }

    pub fn set_flexible_inline_max_size(&mut self, size: u32) {
        let this = self.0.as_mut().expect("non-null");
        this.setFlexibleInlineMaxSize(size);
    }

    pub fn set_allow_functions_with_loops(&mut self, allow: bool) {
        let this = self.0.as_mut().expect("non-null");
        this.setAllowFunctionsWithLoops(allow);
    }

    pub fn set_partial_inlining_ifs(&mut self, number: u32) {
        let this = self.0.as_mut().expect("non-null");
        this.setPartialInliningIfs(number);
    }
}

pub struct PassOptions(cxx::UniquePtr<ffi::wasm::PassOptions>);

impl PassOptions {
    pub fn new() -> PassOptions {
        PassOptions(ffi::wasm::newPassOptions())
    }

    pub fn set_debug(&mut self, debug: bool) {
        let this = self.0.as_mut().expect("non-null");
        this.setDebug(debug);
    }

    pub fn set_validate(&mut self, validate: bool) {
        let this = self.0.as_mut().expect("non-null");
        this.setValidate(validate);
    }

    pub fn set_validate_globally(&mut self, validate: bool) {
        let this = self.0.as_mut().expect("non-null");
        this.setValidateGlobally(validate);
    }

    pub fn set_optimize_level(&mut self, level: i32) {
        let this = self.0.as_mut().expect("non-null");
        this.setOptimizeLevel(level);
    }

    pub fn set_shrink_level(&mut self, level: i32) {
        let this = self.0.as_mut().expect("non-null");
        this.setShrinkLevel(level);
    }

    pub fn set_inlining_options(&mut self, inlining: InliningOptions) {
        let this = self.0.as_mut().expect("non-null");
        this.setInliningOptions(inlining.0);
    }

    pub fn set_traps_never_happen(&mut self, ignore_traps: bool) {
        let this = self.0.as_mut().expect("non-null");
        this.setTrapsNeverHappen(ignore_traps);
    }

    pub fn set_low_memory_unused(&mut self, memory_unused: bool) {
        let this = self.0.as_mut().expect("non-null");
        this.setLowMemoryUnused(memory_unused);
    }

    pub fn set_fast_math(&mut self, fast_math: bool) {
        let this = self.0.as_mut().expect("non-null");
        this.setFastMath(fast_math);
    }

    pub fn set_zero_filled_memory(&mut self, zero_filled_memory: bool) {
        let this = self.0.as_mut().expect("non-null");
        this.setZeroFilledMemory(zero_filled_memory);
    }

    pub fn set_debug_info(&mut self, debug_info: bool) {
        let this = self.0.as_mut().expect("non-null");
        this.setDebugInfo(debug_info);
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

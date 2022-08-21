use wasm_opt_cxx_sys as wocxx;
use wocxx::cxx::let_cxx_string;
use wocxx::{colors, cxx, wasm};

use std::path::Path;

#[cfg(unix)]
use std::os::unix::ffi::OsStrExt;

pub struct Module(cxx::UniquePtr<wasm::Module>);

impl Module {
    pub fn new() -> Module {
        Module(wasm::newModule())
    }
}

pub struct ModuleReader(cxx::UniquePtr<wasm::ModuleReader>);

impl ModuleReader {
    pub fn new() -> ModuleReader {
        ModuleReader(wasm::newModuleReader())
    }

    pub fn set_debug_info(&mut self, debug: bool) {
        let this = self.0.pin_mut();
        this.setDebugInfo(debug);
    }

    pub fn set_dwarf(&mut self, dwarf: bool) {
        let this = self.0.pin_mut();
        this.setDwarf(dwarf);
    }

    // FIXME would rather take &self here but the C++ method is not const-correct
    pub fn read_text(&mut self, path: &Path, wasm: &mut Module) -> Result<(), cxx::Exception> {
        // FIXME need to support non-utf8 paths. Does this work on windows?
        let path = convert_path_to_u8(path)?;
        let_cxx_string!(path = path);

        let this = self.0.pin_mut();
        this.readText(&path, wasm.0.pin_mut())
    }

    pub fn read_binary(
        &mut self,
        path: &Path,
        wasm: &mut Module,
        source_map_filename: Option<&Path>,
    ) -> Result<(), cxx::Exception> {
        let path = convert_path_to_u8(path)?;
        let_cxx_string!(path = path);

        let source_map_filename = source_map_filename
            .map(|p| p.to_str().expect("utf8"))
            .unwrap_or("");
        let_cxx_string!(source_map_filename = source_map_filename);

        let this = self.0.pin_mut();
        this.readBinary(&path, wasm.0.pin_mut(), &source_map_filename)
    }

    pub fn read(
        &mut self,
        path: &Path,
        wasm: &mut Module,
        source_map_filename: Option<&Path>,
    ) -> Result<(), cxx::Exception> {
        let path = convert_path_to_u8(path)?;
        let_cxx_string!(path = path);

        let source_map_filename = source_map_filename
            .map(|p| p.to_str().expect("utf8"))
            .unwrap_or("");
        let_cxx_string!(source_map_filename = source_map_filename);

        let this = self.0.pin_mut();
        this.read(&path, wasm.0.pin_mut(), &source_map_filename)
    }
}

pub struct ModuleWriter(cxx::UniquePtr<wasm::ModuleWriter>);

impl ModuleWriter {
    pub fn new() -> ModuleWriter {
        ModuleWriter(wasm::newModuleWriter())
    }

    pub fn set_debug_info(&mut self, debug: bool) {
        let this = self.0.pin_mut();
        this.setDebugInfo(debug);
    }

    pub fn set_source_map_filename(&mut self, source_map_filename: &str) {
        let_cxx_string!(source_map_filename = source_map_filename);

        let this = self.0.pin_mut();
        this.setSourceMapFilename(&source_map_filename);
    }

    pub fn set_source_map_url(&mut self, source_map_url: &str) {
        let_cxx_string!(source_map_url = source_map_url);

        let this = self.0.pin_mut();
        this.setSourceMapFilename(&source_map_url);
    }

    pub fn write_text(&mut self, wasm: &mut Module, path: &Path) -> Result<(), cxx::Exception> {
        colors::setEnabled(false);

        let path = convert_path_to_u8(path)?;
        let_cxx_string!(path = path);

        let this = self.0.pin_mut();
        this.writeText(wasm.0.pin_mut(), &path)
    }

    pub fn write_binary(&mut self, wasm: &mut Module, path: &Path) -> Result<(), cxx::Exception> {
        let path = convert_path_to_u8(path)?;
        let_cxx_string!(path = path);

        let this = self.0.pin_mut();
        this.writeBinary(wasm.0.pin_mut(), &path)
    }
}

pub mod pass_registry {
    use wasm_opt_cxx_sys as wocxx;
    use wocxx::cxx::let_cxx_string;
    use wocxx::wasm;

    pub fn get_registered_names() -> Vec<String> {
        let names = wasm::getRegisteredNames();

        let name_vec: Vec<String> = names
            .iter()
            .map(|name| name.to_string_lossy().into_owned())
            .collect();

        name_vec
    }

    /// The `pass.cpp` method does assertion before searching:
    /// ```ignore
    /// assert(passInfos.find(name) != passInfos.end());
    /// ```
    /// The assertion will fail and the method call will be aborted if
    /// received invalid `name`
    pub fn get_pass_description(name: &str) -> String {
        let_cxx_string!(name = name);

        let description = wasm::getPassDescription(&name);
        let description = description.as_ref().expect("non-null");

        description.to_str().expect("utf8").to_string()
    }

    /// The `pass.cpp` method does assertion before searching:
    /// ```ignore
    /// assert(passInfos.find(name) != passInfos.end());
    /// ```
    /// The assertion will fail and the method call will be aborted if
    /// received invalid `name`
    pub fn is_pass_hidden(name: &str) -> bool {
        let_cxx_string!(name = name);

        wasm::isPassHidden(&name)
    }
}

pub struct InliningOptions(cxx::UniquePtr<wasm::InliningOptions>);

impl InliningOptions {
    pub fn new() -> InliningOptions {
        InliningOptions(wasm::newInliningOptions())
    }

    pub fn set_always_inline_max_size(&mut self, size: u32) {
        let this = self.0.pin_mut();
        this.setAlwaysInlineMaxSize(size);
    }

    pub fn set_one_caller_inline_max_size(&mut self, size: u32) {
        let this = self.0.pin_mut();
        this.setOneCallerInlineMaxSize(size);
    }

    pub fn set_flexible_inline_max_size(&mut self, size: u32) {
        let this = self.0.pin_mut();
        this.setFlexibleInlineMaxSize(size);
    }

    pub fn set_allow_functions_with_loops(&mut self, allow: bool) {
        let this = self.0.pin_mut();
        this.setAllowFunctionsWithLoops(allow);
    }

    pub fn set_partial_inlining_ifs(&mut self, number: u32) {
        let this = self.0.pin_mut();
        this.setPartialInliningIfs(number);
    }
}

pub struct PassOptions(cxx::UniquePtr<wasm::PassOptions>);

impl PassOptions {
    pub fn new() -> PassOptions {
        PassOptions(wasm::newPassOptions())
    }

    pub fn set_validate(&mut self, validate: bool) {
        let this = self.0.pin_mut();
        this.setValidate(validate);
    }

    pub fn set_validate_globally(&mut self, validate: bool) {
        let this = self.0.pin_mut();
        this.setValidateGlobally(validate);
    }

    pub fn set_optimize_level(&mut self, level: i32) {
        let this = self.0.pin_mut();
        this.setOptimizeLevel(level);
    }

    pub fn set_shrink_level(&mut self, level: i32) {
        let this = self.0.pin_mut();
        this.setShrinkLevel(level);
    }

    pub fn set_inlining_options(&mut self, inlining: InliningOptions) {
        let this = self.0.pin_mut();
        this.setInliningOptions(inlining.0);
    }

    pub fn set_traps_never_happen(&mut self, ignore_traps: bool) {
        let this = self.0.pin_mut();
        this.setTrapsNeverHappen(ignore_traps);
    }

    pub fn set_low_memory_unused(&mut self, memory_unused: bool) {
        let this = self.0.pin_mut();
        this.setLowMemoryUnused(memory_unused);
    }

    pub fn set_fast_math(&mut self, fast_math: bool) {
        let this = self.0.pin_mut();
        this.setFastMath(fast_math);
    }

    pub fn set_zero_filled_memory(&mut self, zero_filled_memory: bool) {
        let this = self.0.pin_mut();
        this.setZeroFilledMemory(zero_filled_memory);
    }

    pub fn set_debug_info(&mut self, debug_info: bool) {
        let this = self.0.pin_mut();
        this.setDebugInfo(debug_info);
    }
}

pub struct PassRunner<'wasm>(cxx::UniquePtr<wasm::PassRunner<'wasm>>);

impl<'wasm> PassRunner<'wasm> {
    pub fn new(wasm: &'wasm mut Module) -> PassRunner<'wasm> {
        let wasm = wasm.0.pin_mut();
        PassRunner(wasm::newPassRunner(wasm))
    }

    pub fn new_with_options(wasm: &'wasm mut Module, options: PassOptions) -> PassRunner<'wasm> {
        let wasm = wasm.0.pin_mut();
        PassRunner(wasm::newPassRunnerWithOptions(wasm, options.0))
    }

    pub fn add(&mut self, pass_name: &str) {
        let_cxx_string!(pass_name = pass_name);

        let this = self.0.pin_mut();
        this.add(&pass_name);
    }

    pub fn add_default_optimization_passes(&mut self) {
        let this = self.0.pin_mut();
        this.addDefaultOptimizationPasses();
    }

    pub fn run(&mut self) {
        let this = self.0.pin_mut();
        this.run();
    }

    pub fn pass_removes_debug_info(name: &str) -> bool {
        let_cxx_string!(name = name);

        wasm::passRemovesDebugInfo(&name)
    }
}

pub fn validate_wasm(wasm: &mut Module) -> bool {
    wasm::validateWasm(wasm.0.pin_mut())
}

fn convert_path_to_u8(path: &Path) -> Result<&[u8], cxx::Exception> {
    #[cfg(unix)]
    let path = path.as_os_str().as_bytes();

    #[cfg(windows)]
    let path = path.as_os_str().to_str().expect("utf8").as_bytes();

    Ok(path)
}

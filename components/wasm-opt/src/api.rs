#[derive(Clone, Debug, Default)]
pub struct OptimizationOptions {
    pub reader: ReaderOptions,
    pub writer: WriterOptions,
    pub inlining: InliningOptions,
    pub passopts: PassOptions,
    pub passes: Passes,
}

#[derive(Copy, Clone, Debug, Default)]
pub struct ReaderOptions {
    pub file_type: FileType,
}

#[derive(Copy, Clone, Debug, Default)]
pub struct WriterOptions {
    pub file_type: FileType,
}

#[derive(Copy, Clone, Debug)]
pub enum FileType {
    Wasm,
    Wat,
    Any,
}

#[derive(Copy, Clone, Debug)]
pub struct InliningOptions {
    pub always_inline_max_size: u32,
    pub one_caller_inline_max_size: u32,
    pub flexible_inline_max_size: u32,
    pub allow_functions_with_loops: bool,
    pub partial_inlining_ifs: u32,
}

#[derive(Copy, Clone, Debug)]
pub struct PassOptions {
    pub debug: bool,
    pub validate: bool,
    pub validate_globally: bool,
    pub optimize_level: OptimizeLevel,
    pub shrink_level: ShrinkLevel,
    pub traps_never_happen: bool,
    pub low_memory_unused: bool,
    pub fast_math: bool,
    pub zero_filled_memory: bool,
    pub debug_info: bool,
}

#[derive(Copy, Clone, Debug)]
pub enum OptimizeLevel {
    Level0 = 0,
    Level1 = 1,
    Level2 = 2,
    Level3 = 3,
    Level4 = 4,
}

#[derive(Copy, Clone, Debug)]
pub enum ShrinkLevel {
    Level0 = 0,
    Level1 = 1,
    Level2 = 2,
}

#[derive(Clone, Debug)]
pub struct Passes {
    pub add_default_passes: bool,
    pub more_passes: Vec<Pass>,
}

pub use crate::passes::Pass;

impl Default for FileType {
    fn default() -> FileType {
        FileType::Any
    }
}

impl Default for InliningOptions {
    fn default() -> InliningOptions {
        InliningOptions {
            always_inline_max_size: 2,
            one_caller_inline_max_size: u32::max_value(),
            flexible_inline_max_size: 20,
            allow_functions_with_loops: false,
            partial_inlining_ifs: 0,
        }
    }
}

impl Default for PassOptions {
    fn default() -> PassOptions {
        PassOptions {
            debug: false,
            validate: true,
            validate_globally: false,
            optimize_level: OptimizeLevel::default(),
            shrink_level: ShrinkLevel::default(),
            traps_never_happen: false,
            low_memory_unused: false,
            fast_math: false,
            zero_filled_memory: false,
            debug_info: false,
        }
    }
}

impl Default for OptimizeLevel {
    fn default() -> OptimizeLevel {
        OptimizeLevel::Level2
    }
}

impl Default for ShrinkLevel {
    fn default() -> ShrinkLevel {
        ShrinkLevel::Level1
    }
}

impl Default for Passes {
    fn default() -> Passes {
        Passes {
            add_default_passes: true,
            more_passes: vec![],
        }
    }
}

//! A builder API for `OptimizationOptions`.

use crate::api::*;

/// Builder methods.
impl OptimizationOptions {
    pub fn reader_file_type(&mut self, value: FileType) -> &mut Self {
        self.reader.file_type = value;
        self
    }

    pub fn writer_file_type(&mut self, value: FileType) -> &mut Self {
        self.writer.file_type = value;
        self
    }

    pub fn set_converge(&mut self) -> &mut Self {
        self.converge = true;
        self
    }

    pub fn always_inline_max_size(&mut self, value: u32) -> &mut Self {
        self.inlining.always_inline_max_size = value;
        self
    }

    pub fn one_caller_inline_max_size(&mut self, value: u32) -> &mut Self {
        self.inlining.one_caller_inline_max_size = value;
        self
    }

    pub fn flexible_inline_max_size(&mut self, value: u32) -> &mut Self {
        self.inlining.flexible_inline_max_size = value;
        self
    }

    pub fn allow_functions_with_loops(&mut self, value: bool) -> &mut Self {
        self.inlining.allow_functions_with_loops = value;
        self
    }

    pub fn partial_inlining_ifs(&mut self, value: u32) -> &mut Self {
        self.inlining.partial_inlining_ifs = value;
        self
    }

    pub fn validate(&mut self, value: bool) -> &mut Self {
        self.passopts.validate = value;
        self
    }

    pub fn validate_globally(&mut self, value: bool) -> &mut Self {
        self.passopts.validate_globally = value;
        self
    }

    pub fn optimize_level(&mut self, value: OptimizeLevel) -> &mut Self {
        self.passopts.optimize_level = value;
        self
    }

    pub fn shrink_level(&mut self, value: ShrinkLevel) -> &mut Self {
        self.passopts.shrink_level = value;
        self
    }

    pub fn traps_never_happen(&mut self, value: bool) -> &mut Self {
        self.passopts.traps_never_happen = value;
        self
    }

    pub fn low_memory_unused(&mut self, value: bool) -> &mut Self {
        self.passopts.low_memory_unused = value;
        self
    }

    pub fn fast_math(&mut self, value: bool) -> &mut Self {
        self.passopts.fast_math = value;
        self
    }

    pub fn zero_filled_memory(&mut self, value: bool) -> &mut Self {
        self.passopts.zero_filled_memory = value;
        self
    }

    pub fn debug_info(&mut self, value: bool) -> &mut Self {
        self.passopts.debug_info = value;
        self
    }

    pub fn set_pass_arg(&mut self, key: &str, value: &str) -> &mut Self {
        self.passopts
            .arguments
            .insert(key.to_string(), value.to_string());
        self
    }

    pub fn add_default_passes(&mut self, value: bool) -> &mut Self {
        self.passes.add_default_passes = value;
        self
    }

    pub fn add_pass(&mut self, value: Pass) -> &mut Self {
        self.passes.more_passes.push(value);
        self
    }

    pub fn mvp_features_only(&mut self) -> &mut Self {
        self.features = Features::MvpOnly;
        self
    }

    pub fn all_features(&mut self) -> &mut Self {
        self.features = Features::All;
        self
    }

    pub fn enable_feature(&mut self, feature: Feature) -> &mut Self {
        match &mut self.features {
            Features::Default | Features::MvpOnly | Features::All => {}
            Features::Custom {
                enabled: features,
                disabled: _,
            } => {
                features.insert(feature);
            }
        }

        self
    }

    pub fn disable_feature(&mut self, feature: Feature) -> &mut Self {
        match &mut self.features {
            Features::Default | Features::MvpOnly | Features::All => {}
            Features::Custom {
                enabled: _,
                disabled: features,
            } => {
                features.insert(feature);
            }
        }

        self
    }
}

use crate::api::*;
use crate::base::{
    validate_wasm, Feature as BaseFeature, FeatureSet as BaseFeatureSet,
    InliningOptions as BaseInliningOptions, Module, ModuleReader, ModuleWriter,
    PassOptions as BasePassOptions, PassRunner,
};
use std::path::Path;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum OptimizationError {
    #[error("Failed to validate wasm: error validating input")]
    ValidateWasmInput,
    #[error("Failed to validate wasm: error after opts")]
    ValidateWasmOutput,
    #[error("Failed to read module")]
    Read {
        #[source]
        source: Box<dyn std::error::Error + Send + Sync + 'static>,
    },
    #[error("Failed to write module")]
    Write {
        #[source]
        source: Box<dyn std::error::Error + Send + Sync + 'static>,
    },
    #[error("Refusing to read from stdin")]
    InvalideStdinPath,
}

/// Execution.
impl OptimizationOptions {
    /// Run the Binaryen wasm optimizer.
    ///
    /// This loads a module from a file,
    /// runs optimization passes,
    /// and writes the module back to a file.
    ///
    /// To supply sourcemaps for the input module,
    /// and preserve them for the output module,
    /// use [`OptimizationOptions::run_with_sourcemaps`].
    ///
    /// # Errors
    ///
    /// Returns error on I/O failure, or if the input fails to parse.
    /// If [`PassOptions::validate`] is true, it returns an error
    /// if the input module fails to validate, or if the optimized
    /// module fails to validate.
    ///
    /// The Rust API does not support reading a module on stdin, as the CLI
    /// does. If `infile` is empty or "-",
    /// [`OptimizationError::InvalidStdinPath`] is returned.
    pub fn run(
        &self,
        infile: impl AsRef<Path>,
        outfile: impl AsRef<Path>,
    ) -> Result<(), OptimizationError> {
        self.run_with_sourcemaps(infile, None::<&str>, outfile, None::<&str>)
    }

    /// Run the Binaryen wasm optimizer.
    ///
    /// This loads a module from a file,
    /// runs optimization passes,
    /// and writes the module back to a file.
    ///
    /// The sourcemap arguments are optional, and only have effect
    /// when reading or writing binary `wasm` files. When using
    /// text `wat` files the respective sourcemap argument is ignored.
    ///
    /// # Errors
    ///
    /// Returns error on I/O failure, or if the input fails to parse.
    /// If [`PassOptions::validate`] is true, it returns an error
    /// if the input module fails to validate, or if the optimized
    /// module fails to validate.
    ///
    /// The Rust API does not support reading a module on stdin, as the CLI
    /// does. If `infile` is empty or "-",
    /// [`OptimizationError::InvalidStdinPath`] is returned.
    pub fn run_with_sourcemaps(
        &self,
        infile: impl AsRef<Path>,
        infile_sourcemap: Option<impl AsRef<Path>>,
        outfile: impl AsRef<Path>,
        outfile_sourcemap: Option<impl AsRef<Path>>,
    ) -> Result<(), OptimizationError> {
        let infile: &Path = infile.as_ref();
        let infile_sourcemap: Option<&Path> = infile_sourcemap.as_ref().map(AsRef::as_ref);
        let outfile: &Path = outfile.as_ref();
        let outfile_sourcemap: Option<&Path> = outfile_sourcemap.as_ref().map(AsRef::as_ref);

        if infile.as_os_str().is_empty() || infile == Path::new("-") {
            return Err(OptimizationError::InvalideStdinPath);
        }

        let mut m = Module::new();

        self.apply_features(&mut m);

        let mut reader = ModuleReader::new();

        let set_dwarf =
            self.passopts.debug_info && !will_remove_debug_info(&self.passes.more_passes);
        reader.set_dwarf(set_dwarf);

        match self.reader.file_type {
            FileType::Wasm => reader.read_text(infile, &mut m),
            FileType::Wat => reader.read_binary(infile, &mut m, infile_sourcemap),
            FileType::Any => reader.read(infile, &mut m, infile_sourcemap),
        }.map_err(|e| OptimizationError::Read {
            source: Box::from(e),
        })?;

        if self.passopts.validate && !validate_wasm(&mut m) {
            return Err(OptimizationError::ValidateWasmInput);
        }

        let passopts = self.translate_pass_options();
        let mut pass_runner = PassRunner::new_with_options(&mut m, passopts);

        if self.passes.add_default_passes {
            pass_runner.add_default_optimization_passes();
        }

        self.passes
            .more_passes
            .iter()
            .for_each(|pass| pass_runner.add(pass.name()));

        pass_runner.run();
        drop(pass_runner);

        if self.passopts.validate && !validate_wasm(&mut m) {
            return Err(OptimizationError::ValidateWasmOutput);
        }

        let mut writer = ModuleWriter::new();
        writer.set_debug_info(self.passopts.debug_info);

        if let Some(filename) = outfile_sourcemap {
            writer
                .set_source_map_filename(filename).map_err(|e| {
                    OptimizationError::Write {
                        source: Box::from(e),
                    }
                })?;
        }

        if let Some(url) = &self.writer.source_map_url {
            writer.set_source_map_url(url);
        }

        match self.writer.file_type {
            FileType::Wasm => writer.write_binary(&mut m, outfile),
            FileType::Wat => writer.write_text(&mut m, outfile),
            FileType::Any => match self.reader.file_type {
                FileType::Any | FileType::Wasm => writer.write_binary(&mut m, outfile),
                FileType::Wat => writer.write_text(&mut m, outfile),
            },
        }.map_err(|e| {
            OptimizationError::Write {
                source: Box::from(e),
            }
        })?;

        Ok(())
    }

    fn apply_features(&self, m: &mut Module) {
        let mut feature_set_enabled = BaseFeatureSet::new();
        let mut feature_set_disabled = BaseFeatureSet::new();
        match &self.features {
            Features::Default => {}
            Features::MvpOnly => {
                feature_set_enabled.set_mvp();
                feature_set_disabled.set_all();
            }
            Features::All => {
                feature_set_enabled.set_all();
                feature_set_disabled.set_mvp();
            }
            Features::Custom { enabled, disabled } => {
                enabled.iter().for_each(|f| {
                    let feature = convert_feature(f);
                    feature_set_enabled.set(feature);
                });

                disabled.iter().for_each(|f| {
                    let feature = convert_feature(f);
                    feature_set_disabled.set(feature);
                });
            }
        }

        m.apply_features(feature_set_enabled, feature_set_disabled);
    }

    fn translate_pass_options(&self) -> BasePassOptions {
        let mut opts = BasePassOptions::new();

        opts.set_validate(self.passopts.validate);
        opts.set_validate_globally(self.passopts.validate_globally);
        opts.set_optimize_level(self.passopts.optimize_level as i32);
        opts.set_shrink_level(self.passopts.shrink_level as i32);
        opts.set_traps_never_happen(self.passopts.traps_never_happen);
        opts.set_low_memory_unused(self.passopts.low_memory_unused);
        opts.set_fast_math(self.passopts.fast_math);
        opts.set_zero_filled_memory(self.passopts.zero_filled_memory);
        opts.set_debug_info(self.passopts.debug_info);

        self.passopts
            .arguments
            .iter()
            .for_each(|(key, value)| opts.set_arguments(key, value));

        let mut inlining = BaseInliningOptions::new();
        inlining.set_always_inline_max_size(self.inlining.always_inline_max_size);
        inlining.set_one_caller_inline_max_size(self.inlining.one_caller_inline_max_size);
        inlining.set_flexible_inline_max_size(self.inlining.flexible_inline_max_size);
        inlining.set_allow_functions_with_loops(self.inlining.allow_functions_with_loops);
        inlining.set_partial_inlining_ifs(self.inlining.partial_inlining_ifs);

        opts.set_inlining_options(inlining);

        opts
    }
}

fn will_remove_debug_info(passes: &[Pass]) -> bool {
    passes
        .iter()
        .any(|pass| PassRunner::pass_removes_debug_info(pass.name()) == true)
}

fn convert_feature(feature: &Feature) -> BaseFeature {
    match feature {
        Feature::MVP => BaseFeature::MVP,
        Feature::Atomics => BaseFeature::Atomics,
        Feature::MutableGlobals => BaseFeature::MutableGlobals,
        Feature::TruncSat => BaseFeature::TruncSat,
        Feature::SIMD => BaseFeature::SIMD,
        Feature::BulkMemory => BaseFeature::BulkMemory,
        Feature::SignExt => BaseFeature::SignExt,
        Feature::ExceptionHandling => BaseFeature::ExceptionHandling,
        Feature::TailCall => BaseFeature::TailCall,
        Feature::ReferenceTypes => BaseFeature::ReferenceTypes,
        Feature::Multivalue => BaseFeature::Multivalue,
        Feature::GC => BaseFeature::GC,
        Feature::Memory64 => BaseFeature::Memory64,
        Feature::TypedFunctionReferences => BaseFeature::TypedFunctionReferences,
        Feature::GCNNLocals => BaseFeature::GCNNLocals,
        Feature::RelaxedSIMD => BaseFeature::RelaxedSIMD,
        Feature::ExtendedConst => BaseFeature::ExtendedConst,
        Feature::All => BaseFeature::All,
        Feature::AllPossible => BaseFeature::AllPossible,
    }
}

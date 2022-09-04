use crate::api::*;
use crate::base::{
    validate_wasm, InliningOptions as BaseInliningOptions, Module, ModuleReader, ModuleWriter,
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
    pub fn run(
        &self,
        infile: impl AsRef<Path>,
        outfile: impl AsRef<Path>,
    ) -> Result<(), OptimizationError> {
        self.run_with_sourcemap(infile, None::<&str>, outfile, None::<&str>)
    }

    pub fn run_with_sourcemap(
        &self,
        infile: impl AsRef<Path>,
        infile_sourcemap: Option<impl AsRef<Path>>,
        outfile: impl AsRef<Path>,
        outfile_sourcemap: Option<impl AsRef<Path>>,
    ) -> Result<(), OptimizationError> {
        let infile = infile.as_ref();
        if infile.as_os_str().is_empty() || infile.as_os_str().eq(std::ffi::OsStr::new("-")) {
            return Err(OptimizationError::InvalideStdinPath);
        }

        let mut m = Module::new();
        let mut reader = ModuleReader::new();

        let set_dwarf =
            self.passopts.debug_info && !will_remove_debug_info(&self.passes.more_passes);
        reader.set_dwarf(set_dwarf);

        let infile_sourcemap = infile_sourcemap.as_ref().map(AsRef::as_ref);

        match self.reader.file_type {
            FileType::Wasm => {
                reader
                    .read_text(infile, &mut m)
                    .map_err(|e| OptimizationError::Read {
                        source: Box::from(e),
                    })?
            }
            FileType::Wat => reader
                .read_binary(infile, &mut m, infile_sourcemap)
                .map_err(|e| OptimizationError::Read {
                    source: Box::from(e),
                })?,
            FileType::Any => reader.read(infile, &mut m, infile_sourcemap).map_err(|e| {
                OptimizationError::Read {
                    source: Box::from(e),
                }
            })?,
        };

        if self.passopts.validate && !validate_wasm(&mut m) {
            return Err(OptimizationError::ValidateWasmInput);
        }

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

        let mut inlining = BaseInliningOptions::new();
        inlining.set_always_inline_max_size(self.inlining.always_inline_max_size);
        inlining.set_one_caller_inline_max_size(self.inlining.one_caller_inline_max_size);
        inlining.set_flexible_inline_max_size(self.inlining.flexible_inline_max_size);
        inlining.set_allow_functions_with_loops(self.inlining.allow_functions_with_loops);
        inlining.set_partial_inlining_ifs(self.inlining.partial_inlining_ifs);
        opts.set_inlining_options(inlining);

        // todo:
        //        opts.apply_features(self.features);

        let mut pass_runner = PassRunner::new_with_options(&mut m, opts);

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
        reader.set_debug_info(false);

        if let Some(filename) = outfile_sourcemap {
            writer
                .set_source_map_filename(filename.as_ref().to_str().expect("source map filename"));
        }

        match self.writer.file_type {
            FileType::Wasm => writer.write_binary(&mut m, outfile.as_ref()).map_err(|e| {
                OptimizationError::Write {
                    source: Box::from(e),
                }
            })?,
            FileType::Wat => writer.write_text(&mut m, outfile.as_ref()).map_err(|e| {
                OptimizationError::Write {
                    source: Box::from(e),
                }
            })?,
            FileType::Any => match self.reader.file_type {
                FileType::Any | FileType::Wasm => writer
                    .write_binary(&mut m, outfile.as_ref())
                    .map_err(|e| OptimizationError::Write {
                        source: Box::from(e),
                    })?,
                FileType::Wat => writer.write_text(&mut m, outfile.as_ref()).map_err(|e| {
                    OptimizationError::Write {
                        source: Box::from(e),
                    }
                })?,
            },
        };
        Ok(())
    }
}

fn will_remove_debug_info(passes: &Vec<Pass>) -> bool {
    passes
        .iter()
        .any(|pass| PassRunner::pass_removes_debug_info(pass.name()) == true)
}

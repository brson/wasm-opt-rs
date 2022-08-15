#![allow(unused)]

use crate::api::*;
use crate::base::{
    InliningOptions as BaseInliningOptions, Module, ModuleReader, ModuleWriter,
    PassOptions as BasePassOptions, PassRunner,
};
use std::path::Path;

impl OptimizationOptions {
    pub fn run(
        &self,
        infile: &impl AsRef<Path>,
        infile_sourcemap: Option<impl AsRef<Path>>,
        outfile: &impl AsRef<Path>,
        outfile_sourcemap: Option<impl AsRef<Path>>,
    ) -> anyhow::Result<()> {
        let mut m = Module::new();
        let mut reader = ModuleReader::new();

        // todo reader.setDWARF()

        let infile_sourcemap = infile_sourcemap.as_ref().map(AsRef::as_ref);

        match self.reader.file_type {
            FileType::Wasm => reader.read_text(infile.as_ref(), &mut m)?,
            FileType::Wat => reader.read_binary(infile.as_ref(), &mut m, infile_sourcemap)?,
            FileType::Any => reader.read(infile.as_ref(), &mut m, infile_sourcemap)?,
        };

        let mut opts = BasePassOptions::new();
        opts.set_debug(self.passopts.debug);
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

        let mut pass_runner = PassRunner::new_with_options(&mut m, opts);

        pass_runner.add_default_optimization_passes();
        pass_runner.run();
        drop(pass_runner);

        let mut writer = ModuleWriter::new();
        reader.set_debug_info(false);

        if let Some(filename) = outfile_sourcemap {
            writer
                .set_source_map_filename(filename.as_ref().to_str().expect("source map filename"));
        }

        match self.writer.file_type {
            FileType::Wasm => writer.write_binary(&mut m, outfile.as_ref())?,
            FileType::Wat => writer.write_text(&mut m, outfile.as_ref())?,
            FileType::Any => match self.reader.file_type {
                FileType::Any | FileType::Wasm => writer.write_binary(&mut m, outfile.as_ref())?,
                FileType::Wat => writer.write_text(&mut m, outfile.as_ref())?,
            },
        };

        Ok(())
    }
}

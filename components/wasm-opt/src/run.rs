#![allow(unused)]

use std::path::Path;
use crate::api::OptimizationOptions;

impl OptimizationOptions {
    pub fn run(
        &self,
        infile: &impl AsRef<Path>,
        infile_sourcemap: Option<impl AsRef<Path>>,
        outfile: &impl AsRef<Path>,
        outfile_sourcemap: Option<impl AsRef<Path>>,
    ) -> anyhow::Result<()> {
        todo!()
    }
}

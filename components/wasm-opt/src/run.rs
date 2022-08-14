#![allow(unused)]

use crate::api::*;
use std::path::Path;

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

    pub fn new_s() -> Self {
        OptimizationOptions::default()
    }

    pub fn new_0() -> Self {
        let mut passopts = PassOptions::default();
        passopts.optimize_level = OptimizeLevel::Level0;
        passopts.shrink_level = ShrinkLevel::Level0;

        let mut opts = OptimizationOptions::default();
        opts.passopts = passopts;

        opts
    }

    pub fn new_1() -> Self {
        let mut passopts = PassOptions::default();
        passopts.optimize_level = OptimizeLevel::Level1;
        passopts.shrink_level = ShrinkLevel::Level0;

        let mut opts = OptimizationOptions::default();
        opts.passopts = passopts;

        opts
    }

    pub fn new_2() -> Self {
        let mut passopts = PassOptions::default();
        passopts.optimize_level = OptimizeLevel::Level2;
        passopts.shrink_level = ShrinkLevel::Level0;

        let mut opts = OptimizationOptions::default();
        opts.passopts = passopts;

        opts
    }

    pub fn new_3() -> Self {
        let mut passopts = PassOptions::default();
        passopts.optimize_level = OptimizeLevel::Level3;
        passopts.shrink_level = ShrinkLevel::Level0;

        let mut opts = OptimizationOptions::default();
        opts.passopts = passopts;

        opts
    }

    pub fn new_4() -> Self {
        let mut passopts = PassOptions::default();
        passopts.optimize_level = OptimizeLevel::Level4;
        passopts.shrink_level = ShrinkLevel::Level0;

        let mut opts = OptimizationOptions::default();
        opts.passopts = passopts;

        opts
    }

    pub fn new_z() -> Self {
        let mut passopts = PassOptions::default();
        passopts.optimize_level = OptimizeLevel::Level2;
        passopts.shrink_level = ShrinkLevel::Level2;

        let mut opts = OptimizationOptions::default();
        opts.passopts = passopts;

        opts
    }
}

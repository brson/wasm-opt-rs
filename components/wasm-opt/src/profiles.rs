use crate::api::{OptimizationOptions, OptimizeLevel, ShrinkLevel};

#[derive(Eq, PartialEq, Debug)]
pub struct Profile {
    optimize_level: OptimizeLevel,
    shrink_level: ShrinkLevel,
    add_default_passes: bool,
}

impl Profile {
    pub fn default() -> Profile {
        Profile::optimize_for_size()
    }

    pub fn optimize_for_size() -> Profile {
        Profile {
            optimize_level: OptimizeLevel::Level2,
            shrink_level: ShrinkLevel::Level1,
            add_default_passes: true,
        }
    }

    pub fn optimize_for_size_aggressively() -> Profile {
        Profile {
            optimize_level: OptimizeLevel::Level2,
            shrink_level: ShrinkLevel::Level2,
            add_default_passes: true,
        }
    }

    pub fn opt_level_0() -> Profile {
        Profile {
            optimize_level: OptimizeLevel::Level0,
            shrink_level: ShrinkLevel::Level0,
            add_default_passes: false,
        }
    }

    pub fn opt_level_1() -> Profile {
        Profile {
            optimize_level: OptimizeLevel::Level1,
            shrink_level: ShrinkLevel::Level0,
            add_default_passes: true,
        }
    }

    pub fn opt_level_2() -> Profile {
        Profile {
            optimize_level: OptimizeLevel::Level2,
            shrink_level: ShrinkLevel::Level0,
            add_default_passes: true,
        }
    }

    pub fn opt_level_3() -> Profile {
        Profile {
            optimize_level: OptimizeLevel::Level3,
            shrink_level: ShrinkLevel::Level0,
            add_default_passes: true,
        }
    }

    pub fn opt_level_4() -> Profile {
        Profile {
            optimize_level: OptimizeLevel::Level4,
            shrink_level: ShrinkLevel::Level0,
            add_default_passes: true,
        }
    }

    pub fn into_opts(self) -> OptimizationOptions {
        let mut opts = OptimizationOptions::default();
        self.apply_to_opts(&mut opts);
        opts
    }

    pub fn apply_to_opts(self, opts: &mut OptimizationOptions) {
        opts.passopts.optimize_level = self.optimize_level;
        opts.passopts.shrink_level = self.shrink_level;
        opts.passes.add_default_passes = self.add_default_passes;
    }
}

// The default implementation of OptimizationOptions doesn't use
// Profile since that would cause infinite recursion. This tests
// that it is open-coded correctly.
#[test]
fn default_optimization_options_are_for_size() {
    let opts1 = OptimizationOptions::default();
    let opts2 = Profile::optimize_for_size().into_opts();
    assert_eq!(opts1.passopts.optimize_level, opts2.passopts.optimize_level);
    assert_eq!(opts1.passopts.shrink_level, opts2.passopts.shrink_level);
    assert_eq!(
        opts1.passes.add_default_passes,
        opts2.passes.add_default_passes
    );
}

#[test]
fn default_is_os() {
    let opts1 = Profile::default();
    let opts2 = Profile::optimize_for_size();
    assert_eq!(opts1, opts2);
}

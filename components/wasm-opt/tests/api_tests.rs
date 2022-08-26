use std::collections::HashSet;
use strum::IntoEnumIterator;
use wasm_opt::api::*;
use wasm_opt::base::pass_registry;
use wasm_opt::base::InliningOptions as BaseInliningOptions;
use wasm_opt::base::PassOptions as BasePassOptions;
use wasm_opt::base::{check_inlining_options_defaults, check_pass_options_defaults};
use wasm_opt::Pass;

#[test]
fn all_passes_correct() -> anyhow::Result<()> {
    let mut passes_via_base_rs = HashSet::<String>::new();
    pass_registry::get_registered_names()
        .iter()
        .for_each(|name| {
            passes_via_base_rs.insert(name.to_string());
        });

    let mut passes_via_enum = HashSet::<String>::new();

    Pass::iter().for_each(|item| {
        passes_via_enum.insert(item.name().to_string());
    });

    assert_eq!(passes_via_base_rs, passes_via_enum);

    Ok(())
}

#[test]
fn check_inlining_options_defaults() -> anyhow::Result<()> {
    let inlining_defaults = InliningOptions::default();
    let mut inlining = BaseInliningOptions::new();
    inlining.set_always_inline_max_size(inlining_defaults.always_inline_max_size);
    inlining.set_one_caller_inline_max_size(inlining_defaults.one_caller_inline_max_size);
    inlining.set_flexible_inline_max_size(inlining_defaults.flexible_inline_max_size);
    inlining.set_allow_functions_with_loops(inlining_defaults.allow_functions_with_loops);
    inlining.set_partial_inlining_ifs(inlining_defaults.partial_inlining_ifs);

    assert_eq!(check_inlining_options_defaults(inlining), true);

    Ok(())
}

#[test]
fn check_pass_options_defaults() -> anyhow::Result<()> {
    let pass_options_defaults = PassOptions::default();
    let mut pass_options = BasePassOptions::new();
    pass_options.set_validate(pass_options_defaults.validate);
    pass_options.set_validate_globally(pass_options_defaults.validate_globally);
    pass_options.set_optimize_level(pass_options_defaults.optimize_level as i32);
    pass_options.set_shrink_level(pass_options_defaults.shrink_level as i32);
    pass_options.set_traps_never_happen(pass_options_defaults.traps_never_happen);
    pass_options.set_low_memory_unused(pass_options_defaults.low_memory_unused);
    pass_options.set_fast_math(pass_options_defaults.fast_math);
    pass_options.set_zero_filled_memory(pass_options_defaults.zero_filled_memory);
    pass_options.set_debug_info(pass_options_defaults.debug_info);

    assert_eq!(check_pass_options_defaults(pass_options), true);

    Ok(())
}

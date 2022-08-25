use std::collections::HashSet;
use strum::IntoEnumIterator;
use wasm_opt::api::*;
use wasm_opt::base::check_inlining_options_defaults;
use wasm_opt::base::pass_registry;
use wasm_opt::base::InliningOptions as BaseInliningOptions;
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
fn test_inlining_options_defaults() -> anyhow::Result<()> {
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

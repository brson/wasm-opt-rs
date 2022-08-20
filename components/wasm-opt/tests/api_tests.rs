use std::collections::HashSet;
use strum::IntoEnumIterator;
use wasm_opt::base::pass_registry;
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

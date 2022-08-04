pub mod base;

/// Hack to establish linage to wasm-opt-sys.
///
/// See docs for wasm_opt_sys::init.
///
/// FIXME: reevaluate this later
#[doc(hidden)]
pub fn init() -> anyhow::Result<()> {
    wasm_opt_sys::init();

    Ok(())
}

mod api;
mod builder;
pub mod base;
mod passes;
mod run;

pub use api::*;

/// Hack to establish linkage to wasm-opt-sys.
///
/// See docs for wasm_opt_sys::init.
///
/// FIXME: reevaluate this later
#[doc(hidden)]
pub fn init() -> anyhow::Result<()> {
    wasm_opt_sys::init();

    Ok(())
}

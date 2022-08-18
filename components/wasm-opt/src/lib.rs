//! Rust bindings to the `wasm-opt` WebAssembly optimizer.
//!
//! `wasm-opt` is a component of the [Binaryen] toolkit
//! that optimizes [WebAssembly] modules. It is written
//! in C++.
//!
//! [Binaryen]: https://github.com/WebAssembly/binaryen
//! [WebAssembly]: https://webassembly.org/
//!
//! This project provides a Rust crate that builds `wasm-opt` and:
//!
//! 1) makes its command-line interface installable via `cargo install`,
//! 2) provides an API to access it programmatically.
//!
//! **This project is in development and not ready for use.**
//!
//! ## Installing the binary
//!
//! ```text
//! cargo install wasm-opt --locked
//! ```
//!
//! It should behave exactly the same as `wasm-opt` installed from other sources.
//!
//! ## Using the library
//!
//!
//!
//! ## Customizing passes
//!
//! TODO
//!
//! Note that while this crate exposes all Binaryen passes
//! some may not make sense to actually use &mdash; Binaryen
//! is a command-line oriented tool, and some passes are
//! debug-oriented, printing directly to the console.
//!
//!
//! ## Features not included in the library

pub mod base;

mod api;
mod builder;
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

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
//!
//! ## Installing the binary
//!
//! ```text
//! cargo install wasm-opt --locked
//! ```
//!
//! It should behave exactly the same as `wasm-opt` installed from other sources.
//!
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
//!
//! ## Caveats
//!
//! TODO:
//! - Reading/writing stdin ("" or "-").
//! - Console output
//!
//! ## Todo
//!
//! - reader/writer defaults - write default binary

/// The "base" API.
///
/// This API hides the `cxx` types,
/// but otherwise sticks closely to the Binaryen API.
///
/// This is hidden because we don't need to commit to these low-level APIs,
/// but want to keep testing them from the `tests` folder.
#[doc(hidden)]
pub mod base;

/// The entire API surface is exported here.
///
/// Some public methods are defined in other non-pub modules.
pub use api::*;

/// Types and constructors used in the API.
mod api;

/// A builder interface for `OptimizationOptions`.
mod builder;

/// The list of optimization passes.
mod passes;

/// The `run` method that re-implements the logic from `wasm-opt.cpp`
/// on top of `OptimizationOptions`.
mod run;

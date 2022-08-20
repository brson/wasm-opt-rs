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
//! The crate provides an [`OptimizationOptions`] type that
//! follows the builder pattern, with options that closely mirror
//! mirror the command line options of `wasm-opt`. Once built,
//! call [`OptimizationOptions::run`] to load, optimize, and write
//! the optimized module.
//!
//! ```no_run
//! use wasm_opt::OptimizationOptions;
//!
//! let infile = "hello_world.wasm";
//! let infile_sourcemap = Option::<&str>::None;
//! let outfile = "hello_world_optimized.wasm";
//! let outfile_sourcemap = Option::<&str>::None;
//!
//! OptimizationOptions::new_optimize_for_size()
//!     .run(infile, infile_sourcemap, outfile, outfile_sourcemap)?;
//!
//! # Ok::<(), anyhow::Error>(())
//! ```
//!
//! There are constructors for all the typical optimization profiles:
//!
//! - [`OptimizationOptions::new_optimize_for_size`] &middot; `-Os` or `-O`
//! - [`OptimizationOptions::new_optimize_for_size_aggressively`] &middot; `-Oz`
//! - [`OptimizationOptions::new_opt_level_0`] &middot; `-O0`
//! - [`OptimizationOptions::new_opt_level_1`] &middot; `-O1`
//! - [`OptimizationOptions::new_opt_level_2`] &middot; `-O2`
//! - [`OptimizationOptions::new_opt_level_3`] &middot; `-O3`
//! - [`OptimizationOptions::new_opt_level_4`] &middot; `-O4`
//!
//! By default, the `run` method will read either binary `wasm` or text `wat` files,
//! inspecting the first few bytes for the binary header and choosing as appropriate,
//! and it will write a binary `wasm` file.
//! This behavior can be changed with [`OptimizationOptions::reader_file_type`]
//! and [`OptimizationOptions::writer_file_type`].
//!
//!
//! ## Customizing passes
//!
//! All Binaryen optimization passes are represented in the [`Pass`]
//! enum, and can be added to `OptimizationOptions` via [`OptimizationOptions::add_pass`].
//! These are added after the default set of passes, which are
//! enabled by most `OptimizationOptions` constructors. The default passes
//! can be disabled either with the [`OptimizationOptions::new_opt_level_0`] constructor,
//! or by calling [`OptimizationOptions::add_default_passes`]
//! with a `false` argument.
//!
//! ```no_run
//! use wasm_opt::{OptimizationOptions, Pass};
//!
//! let infile = "hello_world.wasm";
//! let infile_sourcemap = Option::<&str>::None;
//! let outfile = "hello_world_optimized.wasm";
//! let outfile_sourcemap = Option::<&str>::None;
//!
//! // Just run the inliner.
//! OptimizationOptions::new_opt_level_0()
//!     .add_pass(Pass::InliningOptimizing)
//!     .run(infile, infile_sourcemap, outfile, outfile_sourcemap)?;
//!
//! # Ok::<(), anyhow::Error>(())
//! ```
//!
//! Note that while this crate exposes all Binaryen passes
//! some may not make sense to actually use &mdash; Binaryen
//! is a command-line oriented tool, and some passes are
//! for debug purposes or print directly to the console.
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

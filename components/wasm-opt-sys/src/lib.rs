//! Native build of `wasm-opt`.
//!
//! This crate builds the C++ code for `wasm-opt` but
//! does not provide any Rust bindings.
//!
//! Rust bindings can be found in [`wasm-opt-cxx-sys`],
//! but you probably want the high level APIs in the [`wasm-opt`] crate.
//!
//! [`wasm-opt-cxx-sys`]: https//docs.rs/wasm-opt-cxx-sys
//! [`wasm-opt`]: https://docs.rs/wasm-opt

/// This needs to be called but doesn't do anything.
///
/// It is a hack, possibly temporary, to convince rustc that the `wasm-opt`
/// crate is actually using the `wasm-opt-sys` crate.
///
/// If `rustc` sees that `wasm-opt` references nothing in this crate, then it
/// won't even attempt to link to it, which will lead the linker to not link in
/// the cpp code.
///
/// This is only a problem because all of the external function
/// definitions for wasm-opt live inside the `wasm-opt` crate,
/// when they would normally live in this crate.
///
/// We have the external definitions living in the "wrong" crate to avoid the
/// huge rebuild times during development this crate currently suffers from.
#[doc(hidden)]
pub fn init() {}

# Rust bindings for Binaryen's `wasm-opt`

[<img alt="github" src="https://img.shields.io/badge/github-brson/wasm--opt--rs-8da0cb?style=for-the-badge&labelColor=555555&logo=github" height="20">](https://github.com/brson/wasm-opt-rs)
[<img alt="crates.io" src="https://img.shields.io/crates/v/wasm-opt.svg?style=for-the-badge&color=fc8d62&logo=rust" height="20">](https://crates.io/crates/wasm-opt)
[<img alt="docs.rs" src="https://img.shields.io/badge/docs.rs-wasm--opt-66c2a5?style=for-the-badge&labelColor=555555&logo=docs.rs" height="20">](https://docs.rs/wasm-opt)
[<img alt="build status" src="https://img.shields.io/github/workflow/status/brson/wasm-opt-rs/CI/master?style=for-the-badge" height="20">](https://github.com/brson/wasm-opt-rs/actions?query=branch%3Amaster)

`wasm-opt` is a component of the [`binaryen`] toolkit
that optimizes [WebAssembly] modules. It is written
in C++.

[`binaryen`]: https://github.com/WebAssembly/binaryen
[WebAssembly]: https://webassembly.org/

This project provides a Rust crate that builds `wasm-opt` and:

1) makes its command-line interface installable via `cargo install`,
2) provides an API to access it programmatically.

**This project is in development and not ready for use.**




## Installing the binary

```
cargo install wasm-opt
```

It should behave exactly the same as `wasm-opt` installed from other sources.




## Using the library

See the [API documentation][api].

[api]: https://docs.rs/wasm-opt




## Toolcahin requirements

Requires Rust TODO and a C++ compiler with C++17 support.
It does not require CMake or other C++ build tools.

These are the earliest C++ compiler versions known to work:

- gcc - TODO
- clang - TODO
- msvc - TODO




## Versioning

TODO




## Maintenance

TODO




## License

Licensed under either of [Apache License, Version 2.0][LICENSE-APACHE]
or [MIT license][LICENSE-MIT] at your option.

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in this project by you, as defined in the Apache-2.0 license,
shall be dual licensed as above, without any additional terms or conditions.

Binaryen itself, code from which is compiled and linked by this project,
is licensed under the terms of the Apache License, Version 2.0.

## 0.111.0

- Upgraded to Binaryen 111.
- [Fixed bugs in feature selection via the API](https://github.com/brson/wasm-opt-rs/issues/123).
- Binaryen now enables the `SignExt` and `MutableGlobals` features by default,
  which are also enabled in the LLVM backend.
  In the future Binaryen will align its default feature selection with the LLVM backend.
  To get the same feature selection as Binaryen 110, call

  ```rust
      opts.mvp_features_only()
  ```
- The `TypedFunctionReferences` feature has been removed. The CLI still accepts
  `--enable-typed-function-references` and `--disabled-type-function-references`
  as no-ops. The `integration` module does not accept these command line arguments.

## 0.110.2

- [Backported Binaryen patch to remove empty memories sections from output](https://github.com/brson/wasm-opt-rs/pull/111).

## 0.110.1

- [Removed Binaryen test suite from published source](https://github.com/brson/wasm-opt-rs/issues/98).
- [Removed duplicate Binaryen source from `wasm-opt-cxx-sys`](https://github.com/brson/wasm-opt-rs/pull/90).
- [Fixed exception handling in bin](https://github.com/brson/wasm-opt-rs/issues/89).

## 0.110.0

- Initial release

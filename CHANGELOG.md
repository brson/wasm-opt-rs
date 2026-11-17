## 0.133.0

- Upgraded Binaryen from 116 to 133.
  Thanks to [@Destructor17](https://github.com/Destructor17) for doing the upgrade
  ([#174](https://github.com/brson/wasm-opt-rs/pull/174),
  [#175](https://github.com/brson/wasm-opt-rs/pull/175))
  and modernizing CI
  ([#172](https://github.com/brson/wasm-opt-rs/pull/172),
  [#176](https://github.com/brson/wasm-opt-rs/pull/176)).
- Building now requires a C++20 compiler.
- [Fixed duplicate symbol errors when linking with LLVM](https://github.com/brson/wasm-opt-rs/issues/154).
  Binaryen's copy of LLVM is now compiled into the `binaryen_llvm` namespace,
  so it no longer conflicts with a real LLVM in the same program.
  The DWARF passes are always built.
- Removed the "dwarf" cargo feature.
- Removed passes that Binaryen removed:
  `GenerateStackIr`, `OptimizeStackIr`, `PrintStackIr`,
  `Jspi`, `LegalizeJsInterfaceMinimally`,
  `ModAsyncifyAlwaysAndOnlyUnwind`, `ModAsyncifyNeverUnwind`,
  `TrapModeClamp`, `TrapModeJs`.
  StackIR is now controlled with the `generate_stack_ir` and `optimize_stack_ir`
  fields of `OptimizationOptions`.
- Added many new passes and features.
- Added new options fields, including
  `world_mode`, `ignore_implicit_traps`, `passes_to_skip`,
  `preserve_type_order`, `emit_exnref`, and `emit_module_names`.
- Binaryen's output differs from 116 in places,
  for example type ordering and StackIR generation.
- [Binaryen changelog](https://github.com/WebAssembly/binaryen/blob/main/CHANGELOG.md)
  (versions 117 through 133).

## 0.116.1

- [Fixed build on wasm32-wasmi](https://github.com/brson/wasm-opt-rs/pull/165).

## 0.116.0

- The "dwarf" feature is enabled by default.
  This feature activates DWARF-related passes in Binaryen.
  It builds C++ code from the LLVM project.
  Disable it to avoid linkage errors with LLVM.
- [Binaryen changelog for 116](https://github.com/WebAssembly/binaryen/blob/main/CHANGELOG.md#v116).
- [Binaryen changelog for 115](https://github.com/WebAssembly/binaryen/blob/main/CHANGELOG.md#v115).

## 0.114.2

- Added the "dwarf" cargo feature, disabled by default.
- [Fixed link-time regression in 0.114.1](https://github.com/brson/wasm-opt-rs/issues/154)

  0.114.1 added missing DWARF passes. Unfortunately these passes, taken from
  LLVM code, cause duplicate symbol linker errors when linked into a program
  that links to LLVM. For now we have put the compilation of these passes under
  the "dwarf" flag and made them non-default. In a future release "dwarf" will
  be a default feature. Version 0.114.1 has been yanked.

## 0.114.1

- [Compiled missing DWARF passes](https://github.com/brson/wasm-opt-rs/pull/151).

## 0.114.0

- Upgraded to Binaryen 114.

## 0.113.0

- Upgraded to Binaryen 113.

## 0.112.0

- Upgraded to Binaryen 112.
- [Fixed the displayed version number in `wasm-opt` bin](https://github.com/brson/wasm-opt-rs/pull/133)

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

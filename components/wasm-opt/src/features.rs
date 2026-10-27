use strum_macros::EnumString;

/// Optional wasm features.
///
/// The [`Feature::Mvp`] feature represents the original spec.
/// Other features are post-MVP,
/// some specified and implemented in all engines,
/// some specified but not implemented, some experimental.
///
/// See [the WebAssembly roadmap][rm] for an indication of which features can be
/// used where.
///
/// [rm]: https://webassembly.org/roadmap/
#[derive(Copy, Clone, Debug, Eq, Hash, PartialEq, EnumString)]
pub enum Feature {
    /// None.
    #[strum(disabled)]
    None,
    /// Atomics.
    ///
    /// [Specification](https://github.com/WebAssembly/threads/blob/master/proposals/threads/Overview.md).
    #[strum(serialize = "threads")]
    Atomics,
    /// Import and export of mutable globals.
    ///
    /// [Specification](https://github.com/WebAssembly/mutable-global/blob/master/proposals/mutable-global/Overview.md).
    #[strum(serialize = "mutable-globals")]
    MutableGlobals,
    #[strum(serialize = "nontrapping-float-to-int")]
    TruncSat,
    /// Fixed-width SIMD.
    ///
    /// [Specification](https://github.com/WebAssembly/simd/blob/master/proposals/simd/SIMD.md).
    #[strum(serialize = "simd")]
    Simd,
    /// Bulk memory operations.
    ///
    /// [Specification](https://github.com/WebAssembly/bulk-memory-operations/blob/master/proposals/bulk-memory-operations/Overview.md).
    #[strum(serialize = "bulk-memory")]
    BulkMemory,
    /// Sign extension operations.
    ///
    /// [Specification](https://github.com/WebAssembly/spec/blob/master/proposals/sign-extension-ops/Overview.md).
    #[strum(serialize = "sign-ext")]
    SignExt,
    /// Exception handling.
    ///
    /// [Specification](https://github.com/WebAssembly/exception-handling/blob/master/proposals/exception-handling/Exceptions.md).
    #[strum(serialize = "exception-handling")]
    ExceptionHandling,
    /// Tail calls.
    ///
    /// [Specification](https://github.com/WebAssembly/tail-call/blob/master/proposals/tail-call/Overview.md).
    #[strum(serialize = "tail-call")]
    TailCall,
    /// Reference types.
    ///
    /// [Specification](https://github.com/WebAssembly/reference-types/blob/master/proposals/reference-types/Overview.md).
    #[strum(serialize = "reference-types")]
    ReferenceTypes,
    /// Multi-value.
    ///
    /// [Specification](https://github.com/WebAssembly/spec/blob/master/proposals/multi-value/Overview.md)
    #[strum(serialize = "multivalue")]
    Multivalue,
    #[strum(serialize = "gc")]
    Gc,
    /// Large memory.
    ///
    /// [Specification](https://github.com/WebAssembly/memory64/blob/main/proposals/memory64/Overview.md).
    #[strum(serialize = "memory64")]
    Memory64,
    /// Relaxed SIMD.
    ///
    /// [Specification](https://github.com/WebAssembly/relaxed-simd/tree/main/proposals/relaxed-simd).
    #[strum(serialize = "relaxed-simd")]
    RelaxedSimd,
    /// Extended constant expressions.
    ///
    /// [Specification](https://github.com/WebAssembly/relaxed-simd/tree/main/proposals/relaxed-simd).
    #[strum(serialize = "extended-const")]
    ExtendedConst,
    #[strum(serialize = "strings")]
    Strings,
    /// Multiple memory.
    ///
    /// [Specification](https://github.com/WebAssembly/multi-memory/blob/master/proposals/multi-memory/Overview.md).
    #[strum(serialize = "multimemory")]
    MultiMemory,
    /// Stack switching.
    ///
    /// [Specification](https://github.com/WebAssembly/stack-switching/blob/main/proposals/stack-switching/Overview.md).
    #[strum(serialize = "stack-switching")]
    StackSwitching,
    /// Shared-everything threads.
    ///
    /// [Specification](https://github.com/WebAssembly/shared-everything-threads/blob/main/proposals/shared-everything-threads/Overview.md).
    #[strum(serialize = "shared-everything")]
    SharedEverything,
    /// Half-precision floating point.
    ///
    /// [Specification](https://github.com/WebAssembly/fp16).
    #[strum(serialize = "fp16")]
    Fp16,
    /// Just the memory.copy and memory.fill operations.
    ///
    /// This is the part of the bulk memory proposal that is also in the
    /// [tool conventions](https://github.com/WebAssembly/tool-conventions/blob/main/Linking.md#target-features-section).
    #[strum(serialize = "bulk-memory-opt")]
    BulkMemoryOpt,
    /// Overlong LEB encodings in call_indirect.
    ///
    /// This is a no-op for compatibility, Binaryen always accepts overlong
    /// LEB call-indirect encodings.
    #[strum(serialize = "call-indirect-overlong")]
    CallIndirectOverlong,
    /// Custom descriptors.
    ///
    /// [Specification](https://github.com/WebAssembly/custom-descriptors/blob/main/proposals/custom-descriptors/Overview.md).
    #[strum(serialize = "custom-descriptors")]
    CustomDescriptors,
    /// Acquire-release atomics.
    ///
    /// [Specification](https://github.com/WebAssembly/shared-everything-threads/blob/main/proposals/shared-everything-threads/Overview.md).
    #[strum(serialize = "acquire-release-atomics")]
    AcquireReleaseAtomics,
    /// Custom page sizes.
    ///
    /// [Specification](https://github.com/WebAssembly/custom-page-sizes/blob/main/proposals/custom-page-sizes/Overview.md).
    #[strum(serialize = "custom-page-sizes")]
    CustomPageSizes,
    /// Multibyte array loads and stores.
    ///
    /// [Specification](https://github.com/WebAssembly/multibyte-array-access).
    #[strum(serialize = "multibyte")]
    Multibyte,
    /// Wide arithmetic.
    ///
    /// [Specification](https://github.com/WebAssembly/wide-arithmetic/blob/main/proposals/wide-arithmetic/Overview.md).
    #[strum(serialize = "wide-arithmetic")]
    WideArithmetic,
    /// Compact import section.
    ///
    /// [Specification](https://github.com/WebAssembly/compact-import-section).
    #[strum(serialize = "compact-imports")]
    CompactImports,
    /// Relaxed atomics.
    ///
    /// [Specification](https://github.com/WebAssembly/shared-everything-threads/blob/main/proposals/shared-everything-threads/Overview.md).
    #[strum(serialize = "relaxed-atomics")]
    RelaxedAtomics,
    /// The original WebAssembly specification.
    ///
    /// It has the same value as `None`.
    #[strum(disabled)]
    Mvp,
    /// The default feature set.
    ///
    /// Includes [`Feature::SignExt`] and [`Feature::MutableGlobals`].
    #[strum(disabled)]
    Default,
    /// All features.
    #[strum(disabled)]
    All,
}

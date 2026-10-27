use strum::EnumString;

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
#[strum(serialize_all = "kebab-case")]
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
    MutableGlobals,
    #[strum(serialize = "nontrapping-float-to-int")]
    TruncSat,
    /// Fixed-width SIMD.
    ///
    /// [Specification](https://github.com/WebAssembly/simd/blob/master/proposals/simd/SIMD.md).
    Simd,
    /// Bulk memory operations.
    ///
    /// [Specification](https://github.com/WebAssembly/bulk-memory-operations/blob/master/proposals/bulk-memory-operations/Overview.md).
    BulkMemory,
    /// Sign extension operations.
    ///
    /// [Specification](https://github.com/WebAssembly/spec/blob/master/proposals/sign-extension-ops/Overview.md).
    SignExt,
    /// Exception handling.
    ///
    /// [Specification](https://github.com/WebAssembly/exception-handling/blob/master/proposals/exception-handling/Exceptions.md).
    ExceptionHandling,
    /// Tail calls.
    ///
    /// [Specification](https://github.com/WebAssembly/tail-call/blob/master/proposals/tail-call/Overview.md).
    TailCall,
    /// Reference types.
    ///
    /// [Specification](https://github.com/WebAssembly/reference-types/blob/master/proposals/reference-types/Overview.md).
    ReferenceTypes,
    /// Multi-value.
    ///
    /// [Specification](https://github.com/WebAssembly/spec/blob/master/proposals/multi-value/Overview.md)
    Multivalue,
    Gc,
    /// Large memory.
    ///
    /// [Specification](https://github.com/WebAssembly/memory64/blob/main/proposals/memory64/Overview.md).
    Memory64,
    /// Relaxed SIMD.
    ///
    /// [Specification](https://github.com/WebAssembly/relaxed-simd/tree/main/proposals/relaxed-simd).
    RelaxedSimd,
    /// Extended constant expressions.
    ///
    /// [Specification](https://github.com/WebAssembly/relaxed-simd/tree/main/proposals/relaxed-simd).
    ExtendedConst,
    Strings,
    /// Multiple memory.
    ///
    /// [Specification](https://github.com/WebAssembly/multi-memory/blob/master/proposals/multi-memory/Overview.md).
    #[strum(serialize = "multimemory")]
    MultiMemory,
    TypedContinuations,
    SharedEverything,
    Fp16,
    BulkMemoryOpt,
    CallIndirectOverlong,
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

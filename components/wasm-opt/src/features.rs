#[derive(Clone, Debug)]
pub enum Feature {
    MVP = 0,
    Atomics = 1 << 0,
    MutableGlobals = 1 << 1,
    TruncSat = 1 << 2,
    SIMD = 1 << 3,
    BulkMemory = 1 << 4,
    SignExt = 1 << 5,
    ExceptionHandling = 1 << 6,
    TailCall = 1 << 7,
    ReferenceTypes = 1 << 8,
    Multivalue = 1 << 9,
    GC = 1 << 10,
    Memory64 = 1 << 11,
    TypedFunctionReferences = 1 << 12,
    // TODO: Remove this feature when the wasm spec stabilizes.
    GCNNLocals = 1 << 13,
    RelaxedSIMD = 1 << 14,
    ExtendedConst = 1 << 15,
    // GCNNLocals are opt-in: merely asking for "All" does not apply them. To
    // get all possible values use AllPossible. See setAll() below for more
    // details.
    All = ((1 << 16) - 1) & !(1 << 13),
    AllPossible = 1 << 16,
}

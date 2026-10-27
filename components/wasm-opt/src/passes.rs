use crate::base::pass_registry;
use strum::{Display, EnumIter, EnumString, IntoStaticStr};

/// A Binaryen optimization pass.
///
/// These have the same names as given on the command line to
/// `wasm-opt`, but with Rust capitalization conventions.
// Keep these in the same order as PassRegistry::registerPasses
#[non_exhaustive]
#[derive(Clone, Debug, EnumIter, EnumString, IntoStaticStr, Display)]
#[strum(serialize_all = "kebab-case")]
pub enum Pass {
    /// Lower unaligned loads and stores to smaller aligned ones.
    AlignmentLowering,
    /// Async/await style transform, allowing pausing and resuming.
    Asyncify,
    /// Tries to avoid reinterpret operations via more loads.
    AvoidReinterprets,
    /// Removes arguments to calls in an lto-like manner.
    Dae,
    /// Removes arguments to calls in an lto-like manner, and optimizes where removed.
    DaeOptimizing,
    /// Refine and merge abstract (never-created) types.
    AbstractTypeRefining,
    /// Reduce # of locals by coalescing.
    CoalesceLocals,
    /// Reduce # of locals by coalescing and learning.
    CoalesceLocalsLearning,
    /// Push code forward, potentially making it not always execute.
    CodePushing,
    /// Fold code, merging duplicates.
    CodeFolding,
    /// Hoist repeated constants to a local.
    ConstHoisting,
    /// Propagate constant struct field values.
    Cfp,
    /// Propagate constant struct field values, using ref.test.
    CfpReftest,
    /// Removes unreachable code.
    Dce,
    /// Forces all loads and stores to have alignment 1.
    Dealign,
    /// Propagate debug location from parents or previous siblings to child nodes.
    PropagateDebugLocs,
    /// Instrument the wasm to convert NaNs into 0 at runtime.
    Denan,
    /// Turns indirect calls into direct ones.
    Directize,
    /// Discards global effect info.
    DiscardGlobalEffects,
    /// Optimizes using the DataFlow SSA IR.
    Dfo,
    /// Dump DWARF debug info sections from the read binary.
    Dwarfdump,
    /// Removes duplicate imports.
    DuplicateImportElimination,
    /// Removes duplicate functions.
    DuplicateFunctionElimination,
    /// Emit the target features section in the output.
    EmitTargetFeatures,
    /// Modify the wasm (destructively) for closed-world.
    EncloseWorld,
    /// Leaves just one function (useful for debugging).
    ExtractFunction,
    /// Leaves just one function selected by index.
    ExtractFunctionIndex,
    /// Flattens out code, removing nesting.
    Flatten,
    /// Emulates function pointer casts, allowing incorrect indirect calls to (sometimes) work.
    FpcastEmu,
    /// Reports function metrics.
    FuncMetrics,
    /// Generate dynCall fuctions used by emscripten ABI.
    GenerateDyncalls,
    /// Generate dynCall functions used by emscripten ABI, but only for functions with i64 in their signature (which cannot be invoked via the wasm table without JavaScript BigInt support).
    GenerateI64Dyncalls,
    /// Generate global effect info (helps later passes).
    GenerateGlobalEffects,
    /// Refine the types of globals.
    GlobalRefining,
    /// Globally optimize struct values.
    Gsi,
    /// Globally optimize GC types.
    Gto,
    /// Grand unified flow analyses.
    ///
    /// Optimize the entire program using information about what content can actually appear in each location.
    Gufa,
    /// GUFA plus add casts for all inferences.
    GufaCastAll,
    /// Gufa plus local optimizations in functions we modified.
    GufaOptimizing,
    /// Optimizes J2CL specific constructs.
    OptimizeJ2cl,
    /// Merges itable structures into vtables to make types more compact.
    MergeJ2clItables,
    /// Apply more specific subtypes to type fields where possible.
    TypeRefining,
    /// Replace GC allocations with locals.
    #[strum(serialize = "heap2local")]
    Heap2Local,
    /// Optimize heap (GC) stores.
    HeapStoreOptimization,
    /// Inline __original_main into main.
    InlineMain,
    /// Inline functions (you probably want inlining-optimizing).
    Inlining,
    /// Inline functions and optimizes where we inlined.
    InliningOptimizing,
    /// Lower away binaryen intrinsics.
    IntrinsicLowering,
    /// Wrap imports and exports for JavaScript promise integration.
    Jspi,
    /// Legalizes i64 types on the import/export boundary.
    LegalizeJsInterface,
    /// Legalizes the import/export boundary and prunes when needed.
    LegalizeAndPruneJsInterface,
    /// Common subexpression elimination inside basic blocks.
    LocalCse,
    /// Apply more specific subtypes to locals where possible.
    LocalSubtyping,
    /// Instrument the build with logging of where execution goes.
    LogExecution,
    /// Lower all uses of i64s to use i32s instead.
    I64ToI32Lowering,
    /// Instrument the build with code to intercept specific function calls.
    TraceCalls,
    /// Instrument the build with code to intercept all loads and stores.
    InstrumentLocals,
    /// Instrument the build with code to intercept all loads and stores.
    InstrumentMemory,
    /// Loop invariant code motion.
    Licm,
    /// Attempt to merge segments to fit within web limits.
    LimitSegments,
    /// Lower loads and stores to a 64-bit memory to instead use a 32-bit one.
    Memory64Lowering,
    /// Alias for memory64-lowering.
    Table64Lowering,
    /// Lower memory.copy and memory.fill to wasm mvp and disable the bulk-memory feature.
    LlvmMemoryCopyFillLowering,
    /// Packs memory into separate segments, skipping zeros.
    MemoryPacking,
    /// Merges blocks to their parents.
    MergeBlocks,
    /// Merges similar functions when benefical.
    MergeSimilarFunctions,
    /// Merges locals when beneficial.
    MergeLocals,
    /// Reports metrics.
    Metrics,
    /// Minifies import names (only those, and not export names), and emits a mapping to the minified ones.
    MinifyImports,
    /// Minifies both import and export names, and emits a mapping to the minified ones.
    MinifyImportsAndExports,
    /// Minifies both import and export names, and emits a mapping to the minified ones, and minifies the modules as well.
    MinifyImportsAndExportsAndModules,
    /// Split types into minimal recursion groups.
    MinimizeRecGroups,
    /// Apply the assumption that asyncify imports always unwind, and we never rewind.
    ModAsyncifyAlwaysAndOnlyUnwind,
    /// Apply the assumption that asyncify never unwinds.
    ModAsyncifyNeverUnwind,
    /// Creates specialized versions of functions.
    Monomorphize,
    /// Creates specialized versions of functions (even if unhelpful).
    MonomorphizeAlways,
    /// Combines multiple memories into a single memory.
    MultiMemoryLowering,
    /// Combines multiple memories into a single memory, trapping if the read or write is larger than the length of the memory's data.
    MultiMemoryLoweringWithBoundsChecks,
    /// Name list.
    Nm,
    /// (Re)name all heap types.
    NameTypes,
    /// Mark functions as no-inline.
    NoInline,
    /// Mark functions as no-inline (for full inlining only).
    NoFullInline,
    /// Mark functions as no-inline (for partial inlining only).
    NoPartialInline,
    /// Lower nontrapping float-to-int operations to wasm mvp and disable the nontrapping fptoint feature.
    LlvmNontrappingFptointLowering,
    /// Reduces calls to code that only runs once.
    OnceReduction,
    /// Optimizes added constants into load/store offsets.
    OptimizeAddedConstants,
    /// Optimizes added constants into load/store offsets, propagating them across locals too.
    OptimizeAddedConstantsPropagate,
    /// Eliminate and reuse casts.
    OptimizeCasts,
    /// Optimizes instruction combinations.
    OptimizeInstructions,
    /// Outline instructions.
    /// TODO: This is gated behind conditional compilation in the CPP.
    /// Need to figure out how to handle that on the rust end.
    Outlining,
    /// Pick load signs based on their uses.
    PickLoadSigns,
    /// Tranform Binaryen IR into Poppy IR.
    Poppify,
    /// Miscellaneous optimizations for Emscripten-generated code.
    PostEmscripten,
    /// Early optimize of the instruction combinations for js.
    OptimizeForJs,
    /// Computes compile-time evaluatable expressions.
    Precompute,
    /// Computes compile-time evaluatable expressions and propagates.
    PrecomputePropagate,
    /// Print in s-expression format.
    Print,
    /// Print in minified s-expression format.
    PrintMinified,
    /// Print options for enabled features.
    PrintFeatures,
    /// Print in full s-expression format.
    PrintFull,
    /// Print call graph.
    PrintCallGraph,
    /// Print a map of function indexes to names.
    PrintFunctionMap,
    /// (Alias for print-function-map).
    Symbolmap,
    /// Propagate global values to other globals (useful for tests).
    PropagateGlobalsGlobally,
    /// Removes operations incompatible with js.
    RemoveNonJsOps,
    /// Removes imports and replaces them with nops.
    RemoveImports,
    /// Removes memory segments.
    RemoveMemory,
    /// Removes breaks from locations that are not needed.
    RemoveUnusedBrs,
    /// Removes unused module elements.
    RemoveUnusedModuleElements,
    /// Removes unused module elements that are not functions.
    RemoveUnusedNonfunctionModuleElements,
    /// Removes names from locations that are never branched to.
    RemoveUnusedNames,
    /// Remove unused private GC types.
    RemoveUnusedTypes,
    /// Sorts functions by name (useful for debugging).
    ReorderFunctionsByName,
    /// Sorts functions by access frequency.
    ReorderFunctions,
    /// Sorts globals by access frequency.
    ReorderGlobals,
    /// Sorts locals by access frequency.
    ReorderLocals,
    /// Re-optimize control flow using the relooper algorithm.
    Rereloop,
    /// Remove redundant local.sets.
    Rse,
    /// Write the module to binary, then read it.
    Roundtrip,
    /// Instrument loads and stores to check for invalid behavior.
    SafeHeap,
    /// Sets specified globals to specified values.
    SetGlobals,
    /// Write data segments to a file and strip them from the module.
    SeparateDataSegments,
    /// Remove params from function signature types where possible.
    SignaturePruning,
    /// Apply more specific subtypes to signature types where possible.
    SignatureRefining,
    /// Lower sign-ext operations to wasm mvp.
    SignextLowering,
    /// Miscellaneous globals-related optimizations.
    SimplifyGlobals,
    /// Miscellaneous globals-related optimizations, and optimizes where we replaced global.gets with constants.
    SimplifyGlobalsOptimizing,
    /// Miscellaneous locals-related optimizations.
    SimplifyLocals,
    /// Miscellaneous locals-related optimizations (no nesting at all; preserves flatness).
    SimplifyLocalsNonesting,
    /// Miscellaneous locals-related optimizations (no tees).
    SimplifyLocalsNotee,
    /// Miscellaneous locals-related optimizations (no structure).
    SimplifyLocalsNostructure,
    /// Miscellaneous locals-related optimizations (no tees or structure).
    SimplifyLocalsNoteeNostructure,
    /// Emit Souper IR in text form.
    Souperify,
    /// Emit Souper IR in text form (single-use nodes only).
    SouperifySingleUse,
    /// Spill pointers to the C stack (useful for Boehm-style GC).
    SpillPointers,
    /// Stub out unsupported JS operations.
    StubUnsupportedJs,
    /// Ssa-ify variables so that they have a single assignment.
    Ssa,
    /// Ssa-ify variables so that they have a single assignment, ignoring merges.
    SsaNomerge,
    /// Gathers wasm strings to globals.
    StringGathering,
    /// Lowers wasm strings and operations to imports.
    StringLowering,
    /// Same as string-lowering, but encodes well-formed strings as magic imports.
    StringLoweringMagicImports,
    /// Same as string-lowering-magic-imports, but raise a fatal error if there are invalid strings.
    StringLoweringMagicImportsAssert,
    /// Deprecated; same as strip-debug.
    Strip,
    /// Enforce limits on llvm's __stack_pointer global.
    StackCheck,
    /// Strip debug info (including the names section).
    StripDebug,
    /// Strip dwarf debug info.
    StripDwarf,
    /// Strip the wasm producers section.
    StripProducers,
    /// Strip EH instructions.
    StripEh,
    /// Strip the wasm target features section.
    StripTargetFeatures,
    /// Deprecated; same as translate-to-exnref.
    TranslateToNewEh,
    /// Translate old Phase 3 EH instructions to new ones with exnref.
    TranslateToExnref,
    /// Replace trapping operations with clamping semantics.
    TrapModeClamp,
    /// Replace trapping operations with js semantics.
    TrapModeJs,
    /// Optimize trivial tuples away.
    TupleOptimization,
    /// Mark all leaf types as final.
    TypeFinalizing,
    /// Merge types to their supertypes where possible.
    TypeMerging,
    /// Create new nominal types to help other optimizations.
    TypeSsa,
    /// Mark all types as non-final (open).
    TypeUnfinalizing,
    /// Removes unnecessary subtyping relationships.
    Unsubtyping,
    /// Removes local.tees, replacing them with sets and gets.
    Untee,
    /// Removes obviously unneeded code.
    Vacuum,
}

impl Pass {
    /// Get Binaryen's description of the pass.
    pub fn description(&self) -> String {
        // NB: This will abort if the name is invalid
        pass_registry::get_pass_description(self.into())
    }
}

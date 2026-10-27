use crate::base::pass_registry;
use strum_macros::EnumIter;

/// A Binaryen optimization pass.
///
/// These have the same names as given on the command line to
/// `wasm-opt`, but with Rust capitalization conventions.
// Keep these in the same order as PassRegistry::registerPasses
#[non_exhaustive]
#[derive(Clone, Debug, EnumIter)]
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
    /// Experimental reimplementation of DAE.
    Dae2,
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
    /// Finds and uses mathematical constraints on locals.
    ConstraintAnalysis,
    /// Propagate constant struct field values.
    Cfp,
    /// Propagate constant struct field values, using ref.test.
    CfpRetest,
    /// Removes unreachable code.
    Dce,
    /// Forces all loads and stores to have alignment 1.
    Dealign,
    /// Instrument the wasm to convert NaNs into 0 at runtime.
    DeNan,
    /// Turns indirect calls into direct ones.
    Directize,
    /// Discards global effect info.
    DiscardGlobalEffects,
    /// Optimizes using the DataFlow SSA IR.
    Dfo,
    /// Dump DWARF debug info sections from the read binary.
    DwarfDump,
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
    FpCastEmu,
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
    /// Globally optimize GC types.
    Gto,
    /// Globally optimize struct values.
    Gsi,
    /// Globally optimize struct values, also emitting ref.cast_desc_eq.
    GsiDescCast,
    /// Grand unified flow analyses.
    ///
    /// Optimize the entire program using information about what content can actually appear in each location.
    Gufa,
    /// GUFA plus add casts for all inferences.
    GufaCastAll,
    /// Gufa plus local optimizations in functions we modified.
    GufaOptimizing,
    /// Apply more specific subtypes to type fields where possible.
    TypeRefining,
    /// Apply more specific subtypes to type fields where possible (using GUFA).
    TypeRefiningGufa,
    /// Replace GC allocations with locals.
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
    /// Legalizes the import/export boundary and prunes when needed.
    LegalizeAndPruneJsInterface,
    /// Legalizes i64 types on the import/export boundary.
    LegalizeJsInterface,
    /// Common subexpression elimination inside basic blocks.
    LocalCse,
    /// Apply more specific subtypes to locals where possible.
    LocalSubtyping,
    /// Instrument the build with logging of where execution goes.
    LogExecution,
    /// Lower all uses of i64s to use i32s instead.
    I64ToI32Lowering,
    /// Instrument the build with code to intercept all loads and stores.
    InstrumentLocals,
    /// Instrument the build with code to intercept all loads and stores.
    InstrumentMemory,
    /// Instrument branch hints so we can see which guessed right.
    InstrumentBranchHints,
    /// Loop invariant code motion.
    Licm,
    /// Lower memory.copy and memory.fill to wasm mvp and disable the bulk-memory feature.
    LlvmMemoryCopyFillLowering,
    /// Lower nontrapping float-to-int operations to wasm mvp and disable the nontrapping fptoint feature.
    LlvmNontrappingFptointLowering,
    /// Attempt to merge segments to fit within web limits.
    LimitSegments,
    /// Make structs and arrays shared and functions unshared.
    MakeSharedObjects,
    /// Lower loads and stores to a 64-bit memory to instead use a 32-bit one.
    Memory64Lowering,
    /// Lower 64-bit tables to 32-bit ones.
    Table64Lowering,
    /// Packs memory into separate segments, skipping zeros.
    MemoryPacking,
    /// Merges blocks to their parents.
    MergeBlocks,
    /// Merges similar functions when benefical.
    MergeSimilarFunctions,
    /// Merges itable structures into vtables to make types more compact.
    MergeJ2clItables,
    /// Merges locals when beneficial.
    MergeLocals,
    /// Split types into minimal recursion groups.
    MinimizeRecGroups,
    /// Reports metrics.
    Metrics,
    /// Minifies import names (only those, and not export names), and emits a mapping to the minified ones.
    MinifyImports,
    /// Minifies both import and export names, and emits a mapping to the minified ones.
    MinifyImportsAndExports,
    /// Minifies both import and export names, and emits a mapping to the minified ones, and minifies the modules as well.
    MinifyImportsAndExportsAndModules,
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
    /// Mark functions as no-inline (for full inlining only).
    NoFullInline,
    /// Mark functions as no-inline.
    NoInline,
    /// Mark functions as no-inline (for partial inlining only).
    NoPartialInline,
    /// Mark JS called functions (using configureAll) as doing so.
    MarkJsCalled,
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
    /// Optimizes J2CL specific constructs.
    OptimizeJ2cl,
    /// Outline instructions.
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
    /// Print boundary in JSON format.
    PrintBoundary,
    /// (Alias for print-function-map).
    Symbolmap,
    /// Propagate debug location from parents or previous siblings to child nodes.
    PropagateDebugLocs,
    /// Propagate global values to other globals (useful for tests).
    PropagateGlobalsGlobally,
    /// Removes operations incompatible with js.
    RemoveNonJsOps,
    /// Removes imports and replaces them with nops.
    RemoveImports,
    /// Removes exports using a wildcard.
    RemoveExports,
    /// Removes exports of empty functions.
    RemoveEmptyFunctionExports,
    /// Removes memory segments.
    RemoveMemory,
    /// Removes memory initialization.
    RemoveMemoryInit,
    /// Replaces relaxed SIMD instructions with unreachable.
    RemoveRelaxedSimd,
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
    RecorderLocals,
    /// Sorts private types by access frequency.
    ReorderTypes,
    /// Re-optimize control flow using the relooper algorithm.
    Rereloop,
    /// Remove redundant local.sets.
    Rse,
    /// Write the module to binary, then read it.
    Roundtrip,
    /// Instrument loads and stores to check for invalid behavior.
    SafeHeap,
    /// Write data segments to a file and strip them from the module.
    SeparateDataSegments,
    /// Sets specified globals to specified values.
    SetGlobals,
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
    /// Deprecated; same as strip-debug.
    Strip,
    /// Enforce limits on llvm's __stack_pointer global.
    StackCheck,
    /// Gathers wasm strings to globals.
    StringGathering,
    /// Lowers wasm strings and operations to imports.
    StringLowering,
    /// Lift string imports to wasm strings.
    StringLifting,
    /// Same as string-lowering, but encodes well-formed strings as magic imports.
    StringLoweringMagicImports,
    /// Same as string-lowering-magic-imports, but raise a fatal error if there are invalid strings.
    StringLoweringMagicImportsAssert,
    /// Strip debug info (including the names section).
    StripDebug,
    /// Strip dwarf debug info.
    StripDwarf,
    /// Strip the wasm producers section.
    StripProducers,
    /// Strip EH instructions.
    StripEh,
    /// Strip the wasm target features section.
    StripTargetFeatuers,
    /// Strip all toolchain-specific code annotations.
    StripToolchainAnnotations,
    /// Convert calls in tail position to return calls.
    TailCall,
    /// Translate old EH instructions to new ones.
    TranslateToNewEh,
    /// Translate old Phase 3 EH instructions to new ones with exnref.
    TranslateToExnref,
    /// Instrument the build with code to intercept specific function calls.
    TraceCalls,
    /// Merge types to their supertypes where possible.
    TypeMerging,
    /// Mark all leaf types as final.
    TypeFinalizing,
    /// Create new nominal types to help other optimizations.
    TypeSsa,
    /// Mark all types as non-final (open).
    TypeUnfinalizing,
    /// Optimize trivial tuples away.
    TupleOptimization,
    /// Removes unnecessary subtyping relationships.
    Unsubtyping,
    /// Removes local.tees, replacing them with sets and gets.
    Untee,
    /// Removes obviously unneeded code.
    Vacuum,
}

impl Pass {
    /// Returns the name of the pass.
    ///
    /// This is the same name used by Binaryen to identify the pass on the command line.
    pub fn name(&self) -> &'static str {
        use Pass::*;
        match self {
            AlignmentLowering => "alignment-lowering",
            Asyncify => "asyncify",
            AvoidReinterprets => "avoid-reinterprets",
            Dae => "dae",
            DaeOptimizing => "dae-optimizing",
            Dae2 => "dae2",
            AbstractTypeRefining => "abstract-type-refining",
            CoalesceLocals => "coalesce-locals",
            CoalesceLocalsLearning => "coalesce-locals-learning",
            CodePushing => "code-pushing",
            CodeFolding => "code-folding",
            ConstHoisting => "const-hoisting",
            ConstraintAnalysis => "constraint-analysis",
            Cfp => "cfp",
            CfpRetest => "cfp-reftest",
            Dce => "dce",
            Dealign => "dealign",
            DeNan => "denan",
            DiscardGlobalEffects => "discard-global-effects",
            Directize => "directize",
            Dfo => "dfo",
            DwarfDump => "dwarfdump",
            DuplicateImportElimination => "duplicate-import-elimination",
            DuplicateFunctionElimination => "duplicate-function-elimination",
            EmitTargetFeatures => "emit-target-features",
            EncloseWorld => "enclose-world",
            ExtractFunction => "extract-function",
            ExtractFunctionIndex => "extract-function-index",
            Flatten => "flatten",
            FpCastEmu => "fpcast-emu",
            FuncMetrics => "func-metrics",
            GenerateDyncalls => "generate-dyncalls",
            GenerateI64Dyncalls => "generate-i64-dyncalls",
            GenerateGlobalEffects => "generate-global-effects",
            GlobalRefining => "global-refining",
            Gto => "gto",
            Gsi => "gsi",
            GsiDescCast => "gsi-desc-cast",
            Gufa => "gufa",
            GufaCastAll => "gufa-cast-all",
            GufaOptimizing => "gufa-optimizing",
            TypeRefining => "type-refining",
            TypeRefiningGufa => "type-refining-gufa",
            Heap2Local => "heap2local",
            HeapStoreOptimization => "heap-store-optimization",
            InlineMain => "inline-main",
            Inlining => "inlining",
            InliningOptimizing => "inlining-optimizing",
            IntrinsicLowering => "intrinsic-lowering",
            LegalizeAndPruneJsInterface => "legalize-and-prune-js-interface",
            LegalizeJsInterface => "legalize-js-interface",
            LocalCse => "local-cse",
            LocalSubtyping => "local-subtyping",
            LogExecution => "log-execution",
            I64ToI32Lowering => "i64-to-i32-lowering",
            InstrumentLocals => "instrument-locals",
            InstrumentMemory => "instrument-memory",
            InstrumentBranchHints => "instrument-branch-hints",
            Licm => "licm",
            LlvmMemoryCopyFillLowering => "llvm-memory-copy-fill-lowering",
            LlvmNontrappingFptointLowering => "llvm-nontrapping-fptoint-lowering",
            LimitSegments => "limit-segments",
            MakeSharedObjects => "make-shared-objects",
            Memory64Lowering => "memory64-lowering",
            Table64Lowering => "table64-lowering",
            MemoryPacking => "memory-packing",
            MergeBlocks => "merge-blocks",
            MergeSimilarFunctions => "merge-similar-functions",
            MergeJ2clItables => "merge-j2cl-itables",
            MergeLocals => "merge-locals",
            MinimizeRecGroups => "minimize-rec-groups",
            Metrics => "metrics",
            MinifyImports => "minify-imports",
            MinifyImportsAndExports => "minify-imports-and-exports",
            MinifyImportsAndExportsAndModules => "minify-imports-and-exports-and-modules",
            Monomorphize => "monomorphize",
            MonomorphizeAlways => "monomorphize-always",
            MultiMemoryLowering => "multi-memory-lowering",
            MultiMemoryLoweringWithBoundsChecks => "multi-memory-lowering-with-bounds-checks",
            Nm => "nm",
            NameTypes => "name-types",
            NoFullInline => "no-full-inline",
            NoInline => "no-inline",
            NoPartialInline => "no-partial-inline",
            MarkJsCalled => "mark-js-called",
            OnceReduction => "once-reduction",
            OptimizeAddedConstants => "optimize-added-constants",
            OptimizeAddedConstantsPropagate => "optimize-added-constants-propagate",
            OptimizeCasts => "optimize-casts",
            OptimizeInstructions => "optimize-instructions",
            OptimizeJ2cl => "optimize-j2cl",
            Outlining => "outlining",
            PickLoadSigns => "pick-load-signs",
            Poppify => "poppify",
            PostEmscripten => "post-emscripten",
            OptimizeForJs => "optimize-for-js",
            Precompute => "precompute",
            PrecomputePropagate => "precompute-propagate",
            Print => "print",
            PrintMinified => "print-minified",
            PrintFeatures => "print-features",
            PrintFull => "print-full",
            PrintCallGraph => "print-call-graph",
            PrintFunctionMap => "print-function-map",
            PrintBoundary => "print-boundary",
            Symbolmap => "symbolmap",
            PropagateDebugLocs => "propagate-debug-locs",
            PropagateGlobalsGlobally => "propagate-globals-globally",
            RemoveNonJsOps => "remove-non-js-ops",
            RemoveImports => "remove-imports",
            RemoveExports => "remove-exports",
            RemoveEmptyFunctionExports => "remove-empty-function-exports",
            RemoveMemory => "remove-memory",
            RemoveMemoryInit => "remove-memory-init",
            RemoveRelaxedSimd => "remove-relaxed-simd",
            RemoveUnusedBrs => "remove-unused-brs",
            RemoveUnusedModuleElements => "remove-unused-module-elements",
            RemoveUnusedNonfunctionModuleElements => "remove-unused-nonfunction-module-elements",
            RemoveUnusedNames => "remove-unused-names",
            RemoveUnusedTypes => "remove-unused-types",
            ReorderFunctionsByName => "reorder-functions-by-name",
            ReorderFunctions => "reorder-functions",
            ReorderGlobals => "reorder-globals",
            ReorderTypes => "reorder-types",
            RecorderLocals => "reorder-locals",
            Rereloop => "rereloop",
            Rse => "rse",
            Roundtrip => "roundtrip",
            SafeHeap => "safe-heap",
            SetGlobals => "set-globals",
            SeparateDataSegments => "separate-data-segments",
            SignaturePruning => "signature-pruning",
            SignatureRefining => "signature-refining",
            SignextLowering => "signext-lowering",
            SimplifyGlobals => "simplify-globals",
            SimplifyGlobalsOptimizing => "simplify-globals-optimizing",
            SimplifyLocals => "simplify-locals",
            SimplifyLocalsNonesting => "simplify-locals-nonesting",
            SimplifyLocalsNotee => "simplify-locals-notee",
            SimplifyLocalsNostructure => "simplify-locals-nostructure",
            SimplifyLocalsNoteeNostructure => "simplify-locals-notee-nostructure",
            Souperify => "souperify",
            SouperifySingleUse => "souperify-single-use",
            SpillPointers => "spill-pointers",
            StubUnsupportedJs => "stub-unsupported-js",
            Ssa => "ssa",
            SsaNomerge => "ssa-nomerge",
            Strip => "strip",
            StackCheck => "stack-check",
            StringGathering => "string-gathering",
            StringLowering => "string-lowering",
            StringLifting => "string-lifting",
            StringLoweringMagicImports => "string-lowering-magic-imports",
            StringLoweringMagicImportsAssert => "string-lowering-magic-imports-assert",
            StripDebug => "strip-debug",
            StripDwarf => "strip-dwarf",
            StripProducers => "strip-producers",
            StripEh => "strip-eh",
            StripTargetFeatuers => "strip-target-features",
            StripToolchainAnnotations => "strip-toolchain-annotations",
            TailCall => "tail-call",
            TranslateToNewEh => "translate-to-new-eh",
            TranslateToExnref => "translate-to-exnref",
            TraceCalls => "trace-calls",
            TypeFinalizing => "type-finalizing",
            TypeMerging => "type-merging",
            TypeSsa => "type-ssa",
            TypeUnfinalizing => "type-unfinalizing",
            TupleOptimization => "tuple-optimization",
            Unsubtyping => "unsubtyping",
            Untee => "untee",
            Vacuum => "vacuum",
        }
    }

    /// Get Binaryen's description of the pass.
    pub fn description(&self) -> String {
        // NB: This will abort if the name is invalid
        pass_registry::get_pass_description(self.name())
    }
}

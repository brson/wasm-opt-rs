use crate::base::pass_registry;

/// A binaryen optimization pass.
///
/// These have the same names as given on the command line to
/// `wasm-opt`, but with Rust capitalization conventions.
// Keep these in the same order as PassRegistry::registerPasses
#[derive(Clone, Debug)]
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
    /// Reduce # of locals by coalescing.
    CoalesceLocals,
    /// Reduce # of locals by coalescing and learning.
    CoalesceLocalsLearning,
    /// Push code forward, potentially making it not always execute.
    CodePushing,
    /// Fold code, merging duplicates.
    CodeFolding,
    /// Hoist repeated constants to a local.
    CodeHoisting,
    /// Propagate constant struct field values.
    Cfp,
    /// Removes unreachable code.
    Dce,
    /// Forces all loads and stores to have alignment 1.
    Dealign,
    /// Instrument the wasm to convert NaNs into 0 at runtime.
    DeNan,
    /// Turns indirect calls into direct ones.
    Directize,
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
    /// Generate Stack IR.
    GenerateStackIr,
    /// Refine the types of globals.
    GlobalRefining,
    /// Globally optimize GC types.
    Gto,
    /// Globally optimize struct values.
    Gsi,
    /// Apply more specific subtypes to type fields where possible.
    TypeRefining,
    /// Replace GC allocations with locals.
    Heap2Local,
}

impl Pass {
    /// Returns the name of the pass.
    ///
    /// This is the same name used by binaryen to identify the pass on the command line.
    pub fn name(&self) -> &'static str {
        use Pass::*;
        match self {
            AlignmentLowering => "alignment-lowering",
            Asyncify => "asyncify",
            AvoidReinterprets => "avoid-reinterprets",
            Dae => "dae",
            DaeOptimizing => "dao-optimizing",
            CoalesceLocals => "coalesce-locals",
            CoalesceLocalsLearning => "coalesce-locals-learning",
            CodePushing => "code-pushing",
            CodeFolding => "code-folding",
            CodeHoisting => "code-hoisting",
            Cfp => "cfp",
            Dce => "dce",
            Dealign => "dealign",
            DeNan => "denan",
            Directize => "directize",
            Dfo => "dfo",
            DwarfDump => "dwarfdump",
            DuplicateImportElimination => "duplicate-import-elimination",
            DuplicateFunctionElimination => "duplicate-function-elimination",
            EmitTargetFeatures => "emit-target-features",
            ExtractFunction => "extract-function",
            ExtractFunctionIndex => "extract-function-index",
            Flatten => "flatten",
            FpCastEmu => "fpcast-emu",
            FuncMetrics => "func-metrics",
            GenerateDyncalls => "generate-dyncalls",
            GenerateI64Dyncalls => "generate-i64-dyncalls",
            GenerateStackIr => "generate-stack-ir",
            GlobalRefining => "global-refining",
            Gto => "gto",
            Gsi => "gsi",
            TypeRefining => "type-refining",
            Heap2Local => "heap-2-local",
        }
    }

    /// Get binaryen's description of the pass.
    pub fn description(&self) -> String {
        // NB: This will abort if the name is invalid
        pass_registry::get_pass_description(self.name())
    }
}

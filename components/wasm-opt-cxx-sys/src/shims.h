#ifndef wasmopt_shims_h
#define wasmopt_shims_h

#include "../../wasm-opt-sys/binaryen/src/pass.h"
#include "../../wasm-opt-sys/binaryen/src/wasm-io.h"
#include "../../wasm-opt-sys/binaryen/src/support/colors.h"

#include <stdexcept> // runtime_error
#include <memory> // unique_ptr

namespace wasm_shims {
  std::runtime_error parse_exception_to_runtime_error(const wasm::ParseException& e) {
    if (e.line == -1ul) {
      return std::runtime_error(e.text);
    } else {
      std::ostringstream buf;
      buf << "At " << e.line << ", " << e.col << ": " << e.text;
      return std::runtime_error(buf.str());
    }
  }
}

namespace wasm_shims {
  typedef wasm::Module Module;

  std::unique_ptr<Module> newModule() {
    return std::make_unique<Module>();
  }
}

namespace wasm_shims {
  typedef wasm::ModuleReader ModuleReader;

  std::unique_ptr<ModuleReader> newModuleReader() {
    return std::make_unique<ModuleReader>();
  }

  void ModuleReader_setDebugInfo(ModuleReader& reader, bool debug) {
    reader.setDebugInfo(debug);
  }

  // Wrapper to handle by-val string.
  void ModuleReader_readText(ModuleReader& reader,
                             const std::string& filename,
                             Module& wasm) {
    try {
      reader.readText(std::string(filename), wasm);
    } catch (const wasm::ParseException &e) {
      throw parse_exception_to_runtime_error(e);
    }
  }

  void ModuleReader_readBinary(ModuleReader& reader,
                               const std::string& filename,
                               Module& wasm,
                               const std::string& sourceMapFilename) {
    try {
      reader.readBinary(std::string(filename),
                        wasm,
                        std::string(sourceMapFilename));
    } catch (const wasm::ParseException &e) {
      throw parse_exception_to_runtime_error(e);
    }
  }

  void ModuleReader_read(ModuleReader& reader,
                         const std::string& filename,
                         Module& wasm,
                         const std::string& sourceMapFilename) {
    try {
      reader.readBinary(std::string(filename),
                        wasm,
                        std::string(sourceMapFilename));
    } catch (const wasm::ParseException &e) {
      throw parse_exception_to_runtime_error(e);
    }
  }
}

namespace wasm_shims {
  typedef wasm::ModuleWriter ModuleWriter;

  std::unique_ptr<ModuleWriter> newModuleWriter() {
    return std::make_unique<ModuleWriter>();
  }

  void ModuleWriter_setDebugInfo(ModuleWriter& writer, bool debug) {
    writer.setDebugInfo(debug);
  }
  
  void ModuleWriter_writeText(ModuleWriter& writer,
                              Module& wasm,
                              const std::string& filename) {
    writer.writeText(wasm, std::string(filename));
  }

  void ModuleWriter_writeBinary(ModuleWriter& writer,
                                Module& wasm,
                                const std::string& filename) {
    writer.writeBinary(wasm, std::string(filename));
  }
}

namespace wasm_shims {
  std::unique_ptr<std::vector<std::string>> getRegisteredNames() {
    auto r = wasm::PassRegistry::get();
    return std::make_unique<std::vector<std::string>>(r->getRegisteredNames());
  }

  std::unique_ptr<std::string> getPassDescription(const std::string& name) {
    auto r = wasm::PassRegistry::get();
    return std::make_unique<std::string>(r->getPassDescription(std::string(name)));
  }

  bool isPassHidden(const std::string& name) {
    auto r = wasm::PassRegistry::get();
    return r->isPassHidden(std::string(name));
  }
}

namespace wasm_shims {
  struct InliningOptions {
    wasm::InliningOptions inner;

    void setAlwaysInlineMaxSize(uint32_t size) {
      inner.alwaysInlineMaxSize = size;
    }

    void setOneCallerInlineMaxSize(uint32_t size) {
      inner.oneCallerInlineMaxSize = size;
    }

    void setFlexibleInlineMaxSize(uint32_t size) {
      inner.flexibleInlineMaxSize = size;
    }

    void setAllowFunctionsWithLoops(bool allow) {
      inner.allowFunctionsWithLoops = allow;
    }

    void setPartialInliningIfs(uint32_t number) {
      inner.partialInliningIfs = number;
    }
  };
    
  std::unique_ptr<InliningOptions> newInliningOptions() {
    return std::make_unique<InliningOptions>();
  }
}

namespace wasm_shims {
  struct PassOptions {
    wasm::PassOptions inner;

    void setDebug(bool debug) {
      inner.debug = debug;
    }

    void setValidate(bool validate) {
      inner.validate = validate;
    }

    void setValidateGlobally(bool validate) {
      inner.validateGlobally = validate;
    }

    void setOptimizeLevel(int32_t level) {
      inner.optimizeLevel = level;
    }

    void setShrinkLevel(int32_t level) {
      inner.shrinkLevel = level;
    }

    void setInliningOptions(std::unique_ptr<wasm_shims::InliningOptions> inlining) {
      inner.inlining = inlining->inner;
    }
    
    void setTrapsNeverHappen(bool ignoreTraps) {
      inner.trapsNeverHappen = ignoreTraps;
    }

    void setLowMemoryUnused(bool memoryUnused) {
      inner.lowMemoryUnused = memoryUnused;
    }

    void setFastMath(bool fastMath) {
      inner.fastMath = fastMath;
    }

    void setZeroFilledMemory(bool zeroFilledMemory) {
      inner.zeroFilledMemory = zeroFilledMemory;
    }

    void setDebugInfo(bool debugInfo) {
      inner.debugInfo = debugInfo;
    }
  };

  std::unique_ptr<PassOptions> newPassOptions() {
    return std::make_unique<PassOptions>();
  }
}

namespace wasm_shims {
  struct PassRunner {
    wasm::PassRunner inner;

    PassRunner(Module* wasm) : inner(wasm::PassRunner(wasm)) {}
    PassRunner(Module* wasm, PassOptions options) : inner(wasm::PassRunner(wasm, options.inner)) {}

    void add(const std::string& passName) {
      inner.add(std::string(passName));
    }

    void addDefaultOptimizationPasses() {
      inner.addDefaultOptimizationPasses();
    }

    void run() {
      inner.run();
    }
  };

  std::unique_ptr<PassRunner> newPassRunner(Module& wasm) {
    return std::make_unique<PassRunner>(&wasm);
  }

  std::unique_ptr<PassRunner> newPassRunnerWithOptions(Module& wasm, std::unique_ptr<wasm_shims::PassOptions> options) {
    return std::make_unique<PassRunner>(&wasm, *options);
  }
}

#endif // wasmopt_shims_h


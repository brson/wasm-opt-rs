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
  struct PassOptions {
    wasm::PassOptions inner;

    void setOptimizeLevel(int32_t level) {
      inner.optimizeLevel = level;
    }

    void setShrinkLevel(int32_t level) {
      inner.shrinkLevel = level;
    }
  };

  std::unique_ptr<PassOptions> newPassOptions() {
    return std::make_unique<PassOptions>();
  }
}

namespace wasm_shims {
  typedef wasm::PassRunner PassRunner;

  std::unique_ptr<PassRunner> newPassRunner(Module& wasm) {
    return std::make_unique<PassRunner>(&wasm);
  }

  std::unique_ptr<PassRunner> newPassRunnerWithOptions(Module& wasm, std::unique_ptr<wasm_shims::PassOptions> options) {
    return std::make_unique<PassRunner>(&wasm, options->inner);
  }
}

#endif // wasmopt_shims_h


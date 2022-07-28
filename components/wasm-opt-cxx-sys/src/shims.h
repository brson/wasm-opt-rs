#ifndef wasmopt_shims_h
#define wasmopt_shims_h

#include "../../wasm-opt-sys/binaryen/src/pass.h"
#include "../../wasm-opt-sys/binaryen/src/wasm-io.h"

#include <stdexcept> // runtime_error
#include <memory> // unique_ptr

namespace wasm {
  std::runtime_error parse_exception_to_runtime_error(const ParseException& e) {
    if (e.line == -1ul) {
      return std::runtime_error(e.text);
    } else {
      std::ostringstream buf;
      buf << "At " << e.line << ", " << e.col << ": " << e.text;
      return std::runtime_error(buf.str());
    }
  }
}

namespace wasm {
  std::unique_ptr<Module> newModule() {
    return std::make_unique<Module>();
  }
}

namespace wasm {
  std::unique_ptr<ModuleReader> newModuleReader() {
    return std::make_unique<ModuleReader>();
  }

  // Wrapper to handle by-val string.
  void ModuleReader_readText(ModuleReader& reader,
                             const std::string& filename,
                             Module& wasm) {
    try {
      reader.readText(std::string(filename), wasm);
    } catch (const ParseException &e) {
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
    } catch (const ParseException &e) {
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
    } catch (const ParseException &e) {
      throw parse_exception_to_runtime_error(e);
    }
  }
}

namespace wasm {
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

namespace wasm {
  std::unique_ptr<PassRunner> newPassRunner(Module& wasm) {
    return std::make_unique<PassRunner>(&wasm);
  }
}

#endif // wasmopt_shims_h


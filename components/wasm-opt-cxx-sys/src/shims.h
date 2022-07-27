#ifndef wasmopt_shims_h
#define wasmopt_shims_h

#include "../../wasm-opt-sys/binaryen/src/wasm-io.h"

#include <memory> // unique_ptr

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
    reader.readText(std::string(filename), wasm);
  }

  void ModuleReader_readBinary(ModuleReader& reader,
                               const std::string& filename,
                               Module& wasm,
                               const std::string& sourceMapFilename) {
    reader.readBinary(std::string(filename),
                      wasm,
                      std::string(sourceMapFilename));
  }

  void ModuleReader_read(ModuleReader& reader,
                         const std::string& filename,
                         Module& wasm,
                         const std::string& sourceMapFilename) {
    reader.readBinary(std::string(filename),
                      wasm,
                      std::string(sourceMapFilename));
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

#endif // wasmopt_shims_h


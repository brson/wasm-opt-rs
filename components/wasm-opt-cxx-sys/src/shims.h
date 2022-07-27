#ifndef wasmopt_shims_h
#define wasmopt_shims_h

#include "../../wasm-opt-sys/binaryen/src/wasm-io.h"

#include <memory> // unique_ptr

namespace wasm {
  std::unique_ptr<Module> newModule() {
    return std::make_unique<Module>();
  }

  std::unique_ptr<ModuleReader> newModuleReader() {
    return std::make_unique<ModuleReader>();
  }

  std::unique_ptr<ModuleWriter> newModuleWriter() {
    return std::make_unique<ModuleWriter>();
  }
}

#endif // wasmopt_shims_h


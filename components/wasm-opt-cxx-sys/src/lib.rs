#[cxx::bridge(namespace = "wasm")]
pub mod ffi {
    unsafe extern "C++" {
        include!("shims.h");

        type ModuleReader;

        fn newModuleReader() -> UniquePtr<ModuleReader>;
    }
}

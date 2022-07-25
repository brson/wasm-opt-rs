fn main() -> anyhow::Result<()> {
    cxx_build::bridge("src/lib.rs")
        .include("src")
        .include("../wasm-opt-sys/binaryen/src")
        .flag("-std=c++17")
        .flag("-Wno-unused-parameter")
        .compile("wasm-opt-cxx");

    Ok(())
}

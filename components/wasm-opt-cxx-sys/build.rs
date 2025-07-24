fn main() -> anyhow::Result<()> {
    let mut builder = cxx_build::bridge("src/lib.rs");

    {
        let target_env = std::env::var("CARGO_CFG_TARGET_ENV")?;
        let target = std::env::var("TARGET").unwrap_or_default();
        let host = std::env::var("HOST").unwrap_or_default();
        let is_cross_compile = target != host;

        let mut flags = if target_env != "msvc" {
            vec!["-std=c++17", "-Wno-unused-parameter", "-DBUILD_LLVM_DWARF"]
        } else {
            vec!["/std:c++17", "/DBUILD_LLVM_DWARF"]
        };

        // Add additional flags for `aarch64-unknown-linux-gnu` cross-compilation to fix cinttypes issues.
        if is_cross_compile && target == "aarch64-unknown-linux-gnu" {
            flags.extend_from_slice(&["-D__STDC_FORMAT_MACROS"]);
        }

        for flag in flags {
            builder.flag(flag);
        }
    }

    builder.include("src").compile("wasm-opt-cxx");

    Ok(())
}

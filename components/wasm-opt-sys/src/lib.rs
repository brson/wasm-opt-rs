/*mod c {
    use libc::{c_int, c_char};

    #[link(name = "wasm-opt-cc")]
    extern "C" {
        pub fn wasm_opt_main(argc: c_int, argv: *const *const c_char) -> c_int;
    }
}

pub fn wasm_opt_main() -> anyhow::Result<()> {
    unsafe {
        c::wasm_opt_main(0, std::ptr::null());
    }
    Ok(())
}*/

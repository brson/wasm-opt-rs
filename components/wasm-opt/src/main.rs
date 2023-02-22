// Establish linking with wasm_opt_sys, which contains no Rust code.
extern crate wasm_opt_sys;

fn main() -> anyhow::Result<()> {
    wasm_opt_main()
}

#[cfg(not(windows))]
mod c {
    use libc::{c_char, c_int};

    extern "C" {
        pub fn wasm_opt_main(argc: c_int, argv: *const *const c_char) -> c_int;
    }
}

#[cfg(windows)]
mod c {
    use libc::{wchar_t, c_int};

    extern "C" {
        pub fn wasm_opt_main(argc: c_int, argv: *const *const wchar_t) -> c_int;
    }
}

#[cfg(windows)]
pub fn wasm_opt_main() -> anyhow::Result<()> {
    use libc::{wchar_t, c_int};
    use std::ffi::OsString;
    use std::os::windows::ffi::OsStrExt;

    let args: Vec<OsString> = std::env::args_os().collect();

    type NativeChar = wchar_t;

    let c_args: Vec<Vec<NativeChar>> =
        args
        .into_iter()
        .map(|s| {
            s.encode_wide().chain(Some(0 as NativeChar)).collect()
        })
        .collect();
                       
    let c_ptrs: Vec<*const NativeChar> = c_args.iter().map(|s| s.as_ptr() as *const NativeChar).collect();

    let argc = c_ptrs.len() as c_int;
    let argv = c_ptrs.as_ptr();

    let c_return;
    unsafe {
        c_return = c::wasm_opt_main(argc, argv);
    }

    drop(c_ptrs);
    drop(c_args);

    std::process::exit(c_return)
}

#[cfg(not(windows))]
pub fn wasm_opt_main() -> anyhow::Result<()> {
    use libc::{c_char, c_int};
    use std::ffi::OsString;
    #[cfg(unix)]
    use std::os::unix::ffi::OsStrExt;

    let args: Vec<OsString> = std::env::args_os().collect();

    #[cfg(unix)]
    let c_args: Result<Vec<std::ffi::CString>, _> = args
        .into_iter()
        .map(|s| std::ffi::CString::new(s.as_bytes()))
        .collect();

    #[cfg(windows)]
    let c_args: Result<Vec<std::ffi::CString>, _> = args
        .into_iter()
        .map(|s| std::ffi::CString::new(s.to_str().expect("utf8").as_bytes()))
        .collect();

    let c_args = c_args?;
    let c_ptrs: Vec<*const c_char> = c_args.iter().map(|s| s.as_ptr() as *const c_char).collect();

    let argc = c_ptrs.len() as c_int;
    let argv = c_ptrs.as_ptr();

    let c_return;
    unsafe {
        c_return = c::wasm_opt_main(argc, argv);
    }

    drop(c_ptrs);
    drop(c_args);

    std::process::exit(c_return)
}

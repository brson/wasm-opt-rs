# Creating `wasm-opt` Rust bindings with `cxx`

`wasm-opt` is a component of the [Binaryen] toolkit,
writtin in C++,
that optimizes [WebAssembly] modules,
I have recently created a [`wasm-opt`] bindings crate for Rust
(with the extensive help of my partner [Aimeedeer]).
The `wasm-opt` crate allows `wasm-opt` to be installed via `cargo`,
and also includes an idiomatic Rust API to access `wasm-opt` programatically.

This was a fun bite-sized project that involved several interesting topics:
Rust FFI via the [`cxx`] crate,
converting C++ abstractions to Rust abstractions,
designing Rust APIs,
creating tests to catch upstream changes in C++ code,
creating tests to verify conformance with upstream behavior,
professional networking and grant proposal writing.

[Aimeedeer]: https://github.com/Aimeedeer
[`wasm-opt`]: https://github.com/brson/wasm-opt-rs
[Binaryen]: https://github.com/WebAssembly/binaryen
[WebAssembly]: https://webassembly.org/
[`cxx`]: https://github.com/dtolnay/cxx

## Table of Contents

- [Preface: Installing and using the `wasm-opt` crate](#user-content-preface-installing-and-using-the-wasm-opt-crate)
- [Summary](#user-content-summary)
- [The plan: Our bin strategy](#user-content-the-plan-our-bin-strategy)
- [The plan: Our `cxx` lib strategy](#user-content-the-plan-our-cxx-lib-strategy)
- [Building Binaryen without `cmake`](#user-content-building-binaryen-without-cmake)
- [Dividing the FFI between crates](#user-content-dividing-the-ffi-between-crates)
- [Linking to crates that contain no Rust code](#user-content-linking-to-crates-that-contain-no-rust-code)
- [Calling the C++ `main` function from Rust](#user-content-calling-c++-main-function-from-rust)
- [`cxx` and Binaryen](#user-content-cxx-and-binaryen)
- [Our C++ shim layer](#user-content-our-c++-shim-layer)
- [What about lifetimes in `cxx`?](#user-content-what-about-lifetimes-in-cxx)
- [A Rusty API](#user-content-a-rusty-api)
- [Toolchain integration via `Command`-based API](#user-content-toolchain-integration-via-command-based-api)
- [Six layers of abstraction](#user-content-six-layers-of-abstraction)
- [Testing for maintainability](#user-content-testing-for-maintainability)
- [Outcome and future plans](#user-content-outcome-and-future-plans)
- [Appendix: The W3F grant experience](#user-content-appendix-the-w3f-grant-experience)




## Preface: Installing and using the `wasm-opt` crate

If you are interested in using this tool,
to install `wasm-opt` via `cargo`:

```
cargo install wasm-opt --locked
```

You'll end up with a `wasm-opt` binary in [`$CARGO_HOME/bin`],
and it should work exactly the same as the `wasm-opt` you install from any other source:

```
$ wasm-opt -Os infile.wasm -o outfile.wasm
```

To use `wasm-opt` as a library,
follow [the API docs](https://docs.rs/wasm-opt).

Basic usage looks like

```rust
use wasm_opt::OptimizationOptions;

let infile = "hello_world.wasm";
let outfile = "hello_world_optimized.wasm";

OptimizationOptions::new_optimize_for_size()
    .run(infile, outfile)?;
```




## Summary

We decided to build this after [a recent experience][arexp]
with [`cargo-contract`], the tool for building [Ink!] programs,
in which we had to go "outside" the Rust ecosystem to find and install `wasm-opt`
(downloading and extracting a tarball from GitHub, setting up `PATH`).
A minor inconvenience,
but as a Rust programmer working with a Rust toolset I want to `cargo install` whenever I can.

Many platforms that use wasm as their VM end up creating their own
tools for building and packaging their wasm programs,
and many of those delegate to `wasm-opt` to shrink their output.
So making `wasm-opt` available as a Rust crate seemed like
an obviously useful thing to do for both `cargo-contract`
and all Rust-based wasm-targetting tools.

We proposed [a W3F grant] to build it,
which was accepted gladly.
This was a perfect subject for a grant:
clear benefit, clear scope, low risk.
And it worked out almost exactly as expected.

We had the opportunity to use the [`cxx`] crate,
which creates safe Rust bindings to C++ code,
for the first time;
and had to solve a bunch of minor problems,
one of which required [upstream Binaryen changes][bchange].

While leveraging Binaryen's module readers / writers and optimization passes,
we ended up duplicating the application-level logic of the `wasm-opt` program itself in Rust,
as `wasm-opt` is a command-line program not suitable to use as a library.
This duplication necessitated writing carefully chosen tests to both
help ensure that the crate's behavior matches the CLI's,
but also that as Binaryen changes in the future
we notice those changes and adapt to them.

In the end we had [six layers of Rust abstractions][sixabs],
including C++ shims for all the C++ APIs we needed,
a Rust-style builder API,
and a nearly-complete reimplementation of `wasm-opt`s own CLI argument parsing on top of the builder.
This feels like overkill for such a small project,
but they all have a clear role in the stack,
and several layers are doing simple transformations around the FFI boundary.

The next sections discuss our objectives at the outset of the project,
then the bulk of this post is about our experience attempting to fulfill them.

Links to `wasm-opt-rs` point to
[commit 11dfc725](https://github.com/brson/wasm-opt-rs/tree/11dfc7252c92be3000cbfede5f7b0e36c45ba976)
corresponding to version `0.110.0`.
Links to Binaryen point to
[commit c74d5eb6](https://github.com/WebAssembly/binaryen/tree/c74d5eb62e13e11da4352693a76eec405fccd565),
corresponding to version `110`.

[arexp]: https://github.com/w3f/Grants-Program/blob/master/applications/wasm-opt-for-rust.md#appendix-the-wasm-opt-installation-experience
[`cargo-contract`]: https://github.com/paritytech/cargo-contract/
[Ink!]: https://github.com/paritytech/ink
[a w3f grant]: https://github.com/w3f/Grants-Program/blob/master/applications/wasm-opt-for-rust.md
[bchange]: https://github.com/WebAssembly/binaryen/pull/5087
[sixabs]: #user-content-six-layers-of-abstraction




## The plan: Our bin strategy

The intent of this project was to make `wasm-opt` available to Rust programmers
in two ways: as a command-line program via `cargo install`,
and as a Rust library.

When installing the CLI program the resulting binary must behave the same
as the "native" Binaryen.

The obvious way to do that is to just use `cargo` as a frontend to the existing
Binaryen build system,
building `wasm-opt` in the `cargo` build script,
and installing `wasm-opt` during `cargo install`.

This can't be done quite so simply though because there are no programmable hooks into `cargo install`.
`cargo` will install any Rust binaries it builds directly,
but it can't be instructed to install arbitrary additional files.

So to get `cargo` to install `wasm-opt`,
we would create a Rust crate called `wasm-opt` whose `main` function
did nothing but call the C++ `main` function.

There would be some minor wrinkles to this stategy,
but this is the easy part of the project.




## The plan: Our `cxx` lib strategy

The hard part of this project would be
wrapping Binaryen APIs in a Rust FFI,
layering on top of that an idiomatic Rust API,
capturing all the features of the underlying tool,
and ensuring that they worked the same.

We proposed to use the [`cxx`] crate for the FFI.
Though we had never used it,
and had no sense of how it worked or would work for our purpose,
it is created by [`dtolnay`],
who has designed many excellent Rust libraries,
so we were enthusiastic to try it.

[`cxx`]: http://docs.rs/cxx
[`dtolnay`]: https://github.com/dtolnay

On top of the `cxx` API we would layer an idiomatic Rust API,
though we did not know at the outside the form it would take.




## Building Binaryen without `cmake`

We gave ourselves one extra challenge:
do not use any build system external to `cargo`.
We want to impose as few requirements on `wasm-opt` embedders as possible,
and Binaryen is a relatively simple codebase,
so we decided not to use Binaryen's build system (CMake-based) to build Binaryen.

Instead we built Binaryen in [a `cargo` build script][build-script]
using the [`cc`] crate.
This build script lives in the [`wasm-opt-sys` crate][wos],
[`*-sys` crates][sc] being special cargo convention for managing access to native libraries.

[build-script]: https://github.com/brson/wasm-opt-rs/blob/11dfc7252c92be3000cbfede5f7b0e36c45ba976/components/wasm-opt-sys/build.rs
[`cc`]: https://github.com/rust-lang/cc-rs
[wos]: https://github.com/brson/wasm-opt-rs/tree/11dfc7252c92be3000cbfede5f7b0e36c45ba976/components/wasm-opt-sys
[sc]: https://doc.rust-lang.org/cargo/reference/build-scripts.html?highlight=sys#-sys-packages

The [`cc`] crate compiles C and C++ source files,
packages them into an archive (`.a`) file,
and emits the correct metadata to tell cargo
to include the archive in the crate's library (`.rlib`) file,
and subsequently in the final executable.
It is widely used in the Rust ecosystem and has a whole lot of platform-specific,
toolchain-specific knowledge about how to drive various parts of the C/C++ toolchain.
But it is mostly intended for building small bits of code to supplement Rust crates.
It is not a full build system.

Writing our custom build script for Binaryen was the first step of the project.
The build script ended up being more complex than I would prefer,
and will present more debugging challenges when upgrading Binaryen in the future,
but it was all implementable without great difficulty.

The initial task was to simply discover all
the `.cpp` files that needed to be compiled into `wasm-opt` &mdash;
Binaryen encompasses multiple tools
and not all of them require all of the source files.
We did this the brute-force way:
write a build script that compiled only [`wasm-opt.cpp`](https://github.com/WebAssembly/binaryen/blob/c74d5eb62e13e11da4352693a76eec405fccd565/src/tools/wasm-opt.cpp);
run the build until the link step,
at which point the linker would emit many errors about missing symbols;
grep the source for the likely source of a single symbol;
add the new source, build again and repeat until there were no more linker errors.

That strategy nearly worked completely,
except for a few obstacles:

The first was an unexpected surprise:
The `cc` crate,
generally intended for building a handful of files,
not entire applications,
puts all of its output object files
in the same directory (`cargo`'s `OUT_DIR` for that crate),
regardless of the original source structure.
This bit us because Binaryen has two source files called `intrinsics.cpp`,
causing `cc` to want to create two object files in the same location called `intrinsics.o`.

We created a hacky workaround:
for one of these two files we call a function, `disambiguate_file`,
that copies a source file to a new location while giving it an unambiguous name:

```rust
    let file_intrinsics = disambiguate_file(&ir_dir.join("intrinsics.cpp"), "intrinsics-ir.cpp")?;
```

Like the object files, the disambiguated source file gets put in `OUT_DIR`:

```rust
fn disambiguate_file(input_file: &Path, new_file_name: &str) -> anyhow::Result<PathBuf> {
    let output_dir = std::env::var("OUT_DIR")?;
    let output_dir = Path::new(&output_dir);
    let output_file = output_dir.join(new_file_name);

    fs::copy(input_file, &output_file)?;

    Ok(output_file)
}
```

The second and third obstacle were due to preprocessing done by Binaryen's build system.
When configuring its build Binaryen creates a `config.h` file that contains Binaryen's version number.
This number can either come from the `CMakeLists.txt` configuration file,
or from parsing the output of `git`.
Since we already knew one of our prospective clients was parsing the `wasm-opt` version,
we decided to reproduce this behavior exactly,
and our build script has two functions that pull the version number from each place
and put them into `config.h` as appropriate.

Binaryen's build configuration also hex-encodes and embeds a binary called `wasm-intrinsics.wat` into its source code.
So we again had to repruce that logic.

Adapting our custom build process to Binaryen as it changes in the future will
likely be the most difficult ongoing maintenance task on this project.
We have already performed one upgrade, from version 109 to 110,
and it involved resolving link errors and adding source files until everything linked again.




## Dividing the FFI between crates

From our experience getting the `wasm-opt-sys` crate to build
we knew that rebuilding that crate took a long time,
multiple minutes on my underpowered laptop.

This is because the `cc` crate doesn't support any kind of incremental recompliation:
any time the `wasm-opt-sys` crate needs to rebuild, it compiles every C++ file in the project.
The lack of incremental recompilation is intentional &mdash;
`cc` is not a full build system.

We could just use an external `CMake`,
and we also considered adding a basic, if imperfect, caching layer on top of `cc`
that would make development faster.
But we still did not want to introduce an external build tool,
and while creating that caching build system sounded fun,
it seemed out of scope for our grant.

Instead we decided to create a division of responsibilities between
the crates in our project that would minimize the amount of rebuilding
we needed to do during development:
we put no essentially no Rust code in the `wasm-opt-sys` crate,
no Rust bindings at all.

That way, once we were done figuring out how to successfully build Binaryen,
we wouldn't continually invalidate the Binaryen build while hacking on Rust code.

This is not how `-sys` crates typically work.
They usually include the lowest level of Rust bindings.
But we just used `wasm-opt-sys` to build and link our native code.

Instead we settled on this division of responsibilities between crates:

- `wasm-opt-sys` - Just build the native library.
- `wasm-opt-cxx-sys` - Create the Rust bindings to the native library via `cxx`.
  `cxx` emits both Rust and C++ at build time, so this crate is also performing
  a native build. In typical bindings this crate would be part of `wasm-opt-sys`.
- `wasm-opt` - The library and binary, with both a `lib.rs` and `main.rs`,
  calling Binaryen code via `wasm-opt-cxx-sys`.

Editing either `wasm-opt-cxx-sys` or `wasm-opt-sys` does not invalidate `wasm-opt-sys`,
so during development we don't need to sit through repeated complete builds of Binaryen.

One awkward result of the division between `wasm-opt-sys` and `wasm-opt-cxx-sys` is
that they both need identical copies of the Binaryen source code,
as `cxx` generates C++ code that accesses Binaryen headers.
This complicates our deploy process slightly,
and also implies that we must be careful about managing the version numbers
of these two crates such that compatible versions always carry identical Binaryen source.




# Linking to crates that contain no Rust code

The decision to put no Rust code into `wasm-opt-sys` led to one big oddity.
And it would be difficult to understand and debug if I wasn't previously aware of it.

After `cc` compiles all of its C and C++ (`.c` / `.cpp`) files into object (`.o`) files,
it then packages them with the `ar` tool into an archive (`.a`) file,
and then instructs `cargo` to package that archive into the `.rlib` file
that represents the compiled Rust library for the crate being built.

Later, `rustc` will link all of the code inside the `.rlib` into the final executable.

What isn't obvious though is that `rustc` doesn't actually attempt to link every crate it is told to:
it will notice when no Rust code ever calls into a crate,
decide that crate is not used,
and quietly not link it.

This manifests as linker errors with many missing C++ symbols.

With our decision to put the FFI bindings in a separate crate from `wasm-opt-sys`,
`rustc` did not actually link to our native libarary.

The way we solved this was to add this function to `wasm-opt-sys`'s `lib.rs`:

```rust
#[doc(hidden)]
pub fn init() {}
```

with [a big comment][abc] explaining its existence.

[abc]: https://github.com/brson/wasm-opt-rs/blob/11dfc7252c92be3000cbfede5f7b0e36c45ba976/components/wasm-opt-sys/src/lib.rs#L12-L26

Both the `wasm-opt` and `wasm-opt-cxx-sys` crate then each call this function once,
`wasm-opt-sys` from another `doc(hidden)` `pub fn`,
and `wasm-opt` from its `main` function.

`rustc` then thinks that `wasm-opt-sys` is used and links it.

There is another clever pattern that accomplishes this same thing,
that we only learned of after implementing the no-op `init` function:
unnamed imports. For example:

```rust
use wasm_opt_sys as _;
```

It looks useless,
but this is an idiomatic way to tell the compiler that a crate is used even though it otherwise looks unused.
This is also useful when activating the [`unused_crate_dependencies`] lint,
to tell the compiler about a crate that is only used in some configurations (e.g. Windows-only), but not all.

[`unused_crate_dependencies`]: https://doc.rust-lang.org/rustc/lints/listing/allowed-by-default.html#unused-crate-dependencies




## Calling the C++ `main` function from Rust

With a working build of all the source needed by `wasm-opt`,
we had to write our Rust `main.rs` file and call the C++ `main` function.
For this we did not use `cxx` as the FFI was easy to write by hand
(and `cxx` wouldn't have helped us much with the `argc` and `argv` parameters anyway).
The `wasm-opt` crate's `main.rs` calls the FFI directly,
bypassing the `cxx` layer and the `wasm-opt-cxx-sys` crate.

This is mostly straightforward,
except that we can't simply call the existing `main` function from Rust,
for at least one reason,
possibly several.

`wasm-opt`'s `main` function is declared as:

```c++
int main(int argc, const char* argv[]) {
```

This is a C++ function,
and Rust can only call C functions.

To declare it a C function it needs to be:

```c++
extern "C" int main(int argc, const char* argv[]) {
```

At the least this will disable [name mangling][nm] for the `main` function,
so that the symbol `main` can be linked. I am not clear on whether
it has any impact on the calling convention of the function.

[nm]: https://en.wikipedia.org/wiki/Name_mangling

The above about name mangling is true generally,
but may not be true for a function named `main`.
In brief experiments,
even without declaring `main` as `extern "C"`,
I did see that the resulting object file contained an unmangled
function named `main`,
that appeared to be this function.
This on linux with `gcc`.
So maybe `gcc` doesn't name-mangle the `main` function.

I don't know how MSVC treats `main` on Windows.

But it's probably best to declare this function we want to call `extern "C"`.

Regardless,
I need this function to be `extern "C"` because
I need to rename it anyway:
`rustc` _also_ wants to create an unmangled function named `main`,
so I have to rename this one to something else.
(The `main` function emitted by `rustc` is not the `main` function you write though &mdash;
it is a synthetic function generated by the compiler that calls the standard library,
which later calls your name-mangled `main` function).

I want this main to be called `wasm_opt_main` and declared like:

```c++
extern "C" int wasm_opt_main(int argc, const char* argv[]) {
```

So that Rust code can declare it as an extern like

```rust
    extern "C" {
        pub fn wasm_opt_main(argc: c_int, argv: *const *const c_char) -> c_int;
    }
```

As part of our build script we wrote a function
that reads the `wasm-opt.cpp` source file,
replaces `int main` with `extern "C" int wasm_opt_main`,
then outputs the modified source to `OUT_DIR`.
We then build our modified `wasm-opt.cpp`.

The obvious alternative would be to carry a patch on a fork of Binaryen
that makes that change and commits it to git.
We needed to be able to build `wasm-opt` normally though for testing,
and preferred not to maintain a fork,
so preferred this little dynamic rewrite.

The [full source] of the Rust `main.rs` is simple,
though ugly, just a bunch of raw FFI.
It is small and interesting enough that I'll just
list it all here for commentary:

[full source]: https://github.com/brson/wasm-opt-rs/blob/11dfc7252c92be3000cbfede5f7b0e36c45ba976/components/wasm-opt/src/main.rs

```rust
fn main() -> anyhow::Result<()> {
    wasm_opt_sys::init();

    wasm_opt_main()
}

mod c {
    use libc::{c_char, c_int};

    extern "C" {
        pub fn wasm_opt_main(argc: c_int, argv: *const *const c_char) -> c_int;
    }
}

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
```

This file contains a `main` function that calls
the previously-described `wasm_opt_sys::init`,
which does nothing except fool `rustc` into linking
the native code inside the `wasm-opt-sys` crate.

The `wasm_opt_main` Rust function's only
responsibilities are to translate Rust's command-line
arguments to C-compatible command-line arguments,
call the C++ `wasm_opt_main`,
and report its error code.

Its basic strategy is to collect the arguments
into a `Vec<OsString>`,
convert those into a `Vec` of the type the C++ code wants,
then collect another `Vec` of _pointers_ to those,
then pass the length and pointer to that `Vec`'s buffer
to the C++ `wasm_opt_main`.

The string handling is a mess here because of the differences
between strings on Unix and Windows,
and it is still wrong:
this code is passing a buffer of bytes to `wasm_opt_main` on Windows,
and that _is_ what the Binaryen code is asking for,
but Binaryen is then [not treating those bytes as Unicode][bb],
at least when interpreting them as paths.

[bb]: https://github.com/brson/wasm-opt-rs/issues/40

The result of this is that paths with extended Unicode characters
do not work with `wasm-opt` (either the bindings or the original CLI program) on Windows.

What _probably_ (based on my brief research of modern C++)
should happen here is that on Windows,
the Rust code should be calling [`OsStrExt::encode_wide`]
to get (potentially ill-formed) UTF-16,
and passing that to Binaryen;
Binaryen then would need to be adapted to accept and process "wide" (16-bit)
`char`s on Windows, perhaps leveraging the C++ [`std::path`] type.
We left this large upstream task to future work.

[`OsStrExt::encode_wide`]: https://doc.rust-lang.org/std/os/windows/ffi/trait.OsStrExt.html#tymethod.encode_wide
[`std::filesystem::path`]: https://en.cppreference.com/w/cpp/filesystem/path

The two calls to [`drop`] in this function are functionally useless;
they are just a written reminder that we want to lose access to the raw pointers
before losing access to the things they point to.

[`drop`]: https://doc.rust-lang.org/std/mem/fn.drop.html




## `cxx` and Binaryen

We dedicated the [`wasm-opt-cxx-sys`] to creating bindings with [`cxx`].
We were happy with this decision. `cxx` was great and worked as advertised.
We didn't have to think much about memory-safety across the FFI as `cxx` guided us to the safe solutions.

We used `cxx` version `1.0.72`.
There may be new versions by now with new features.

The `cxx` docs are pretty great,
with [good API docs](https://docs.rs/cxx/latest/cxx/),
and [a book](https://cxx.rs/).

The [table showing the correspondence between C++ and Rust types][cxxt] is invaluable.

[cxxt]: https://cxx.rs/bindings.html

The purpose of `cxx` is to make it possible to communicate between C++ and Rust using _safe_ Rust.
As such, `cxx` is very opinionated about what the code on both sides of the FFI look like,
and supports a relatively small set of types.

This is great for projects that are in control of both the C++ and Rust APIs,
and it probably will help the C++ side be disciplined about ownership and const-correctness.

Binaryen was not designed for compatibility with with `cxx`,
so we ended up creating a full C++ shim layer to adapt between Binaryen's APIs
and APIs that were suitable for binding throug `cxx`.
Fortunately Binaryen's API surface is reasonable and modern and easy to understand,
so our shims are simple.

`cxx` is capable of creating bindings in both directions of the FFI:
to let Rust call C++, but also to let C++ call Rust.
The former are done in macros containing [`extern "C++"] blocks;
the latter [`extern "Rust"`] blocks.
We only used the former, calling from Rust to C++.

[`extern "C++"`]: https://cxx.rs/extern-c++.html
[`extern "Rust"`]: https://cxx.rs/extern-rust.html

This section will discuss our experience with `cxx`,
but I want to stress that there is probably a lot we don't know about `cxx`
and things I say may be incorrect:
we learned enough `cxx` to get our bindings working acceptably,
but there may be better patterns that we didn't discover.

The next sections will discuss some of the obstacles
we encountered creating `cxx` bindings,
then we'll show what the final C++ shims look like.




### Defining `cxx` bindings

[Our `cxx` bindings][ourb].

[ourb]: https://github.com/brson/wasm-opt-rs/blob/11dfc7252c92be3000cbfede5f7b0e36c45ba976/components/wasm-opt-cxx-sys/src/lib.rs

In `cxx` bindings are defined in a dedicated module annotated with `#[cxx::bridge]`.
Within that module are any number of `extern "C++"` (or `extern "Rust"`) blocks.

The pattern we followed used many `unsafe extern "C++"` blocks,
one for each C++ class we wanted bindings for,
each of those blocks then declared a single type,
and one or more constructor functions and methods.

Here is our bindings declaration for Binaryen's `ModuleReader`:

```rust
#[cxx::bridge(namespace = "wasm_shims")]
pub mod wasm {
    unsafe extern "C++" {
        type ModuleReader;

        fn newModuleReader() -> UniquePtr<ModuleReader>;

        fn setDebugInfo(self: Pin<&mut Self>, debug: bool);

        fn setDwarf(self: Pin<&mut Self>, dwarf: bool);

        fn readText(
            self: Pin<&mut Self>,
            filename: &CxxString,
            wasm: Pin<&mut Module>,
        ) -> Result<()>;

        fn readBinary(
            self: Pin<&mut Self>,
            filename: &CxxString,
            wasm: Pin<&mut Module>,
            sourceMapFilename: &CxxString,
        ) -> Result<()>;

        fn read(
            self: Pin<&mut Self>,
            filename: &CxxString,
            wasm: Pin<&mut Module>,
            sourceMapFilename: &CxxString,
        ) -> Result<()>;
    }
}
```

This example includes the surrounding module,
but omits many other `extern "C++"` blocks within that module.

This is a [DSL] interpreted by a [proc macro].
It looks a lot like Rust,
but it is not quite Rust,
and using `cxx` means learning what its syntax means.

[DSL]: https://en.wikipedia.org/wiki/Domain-specific_language
[proc macro]: https://doc.rust-lang.org/reference/procedural-macros.html

Some things to notice here:

- The `unsafe` keyword here is a declaration that using these bindings is
  _safe_. Think of it the same as the use of `unsafe` around an expression.
  It is possible to write `cxx` bindings that propagate unsafety as well by omitting `unsafe`.
- The naming conventions are a mashup of Rust and C++:
  function names necessarily come from C++;
  the `UniquePtr` type is the Rust wrapper for the C++ `std::unique_ptr` type.
- `newModule` is a free function. It is not a C++ constructor.
  It doesn't appear that `cxx` handles C++ constructors directly,
  so the C++ side must define extra constructor functions.
- Non-primitive types need to be passed as pointers,
  mostly `UniquePtr` or references.
- Functions with an initial argument named `self` are interpreted
  as methods of the single `type` declared in the block.
  This intepretation of `self` necessitates multiple `extern` blocks,
  since each must define the single type to associate with methods.
- The `Result` type is a typedef of `std::Result` where the
  error type is [`cxx::Exception`]. `cxx` will catch at the boundary
  any exception that implements [`std::exception`] and return it as an error.
- `&CxxString` is a `const` reference to a C++ `std::string`.

[`std::exception`]: https://en.cppreference.com/w/cpp/error/exception

The final thing to note is that the `self` type of
these methods is `Pin<&mut Self>`.
What this means is that the underlying method is non-`const`,
it is declared such that it may mutate its fields.

Access to mutable `C++` types from Rust is always through [`Pin`],
to prevent the ability to move their underlying value.
Move semantics in Rust and C++ are different.

[`Pin`]: https://doc.rust-lang.org/std/pin/struct.Pin.html

Binaryen's methods are not ["`const`-correct"][cc]:
they are all declared non-`const`,
even when they do no mutation.
This could be worth fixing in Binaryen,
but for our purposes we could easily hide this
in higher-layers of our API.
Our next layer up, the [`base` API],
hides all the interaction with `Pin`,
though it still exposes incorrect mutability,
and high-still layers of API hide the `base` API from users,
exposing only APIs with correct `mut` declarations.

[cc]: https://isocpp.org/wiki/faq/const-correctness
[`base` API]: https://github.com/brson/wasm-opt-rs/blob/11dfc7252c92be3000cbfede5f7b0e36c45ba976/components/wasm-opt/src/base.rs

Naming these types correctly is not exactly easy,
especially the difficult-to-understand `Pin` type,
but `cxx` gives a lot of help,
and in our experience did not let us
write a bindings declaration that differed from
the actual C++ declaration.

When you define a Rust binding to C++ code,
`cxx` will emit static checks that the types of the Rust declarations
match the types of the C++ declarations.
This is a great feature,
and gives me confidence about the maintainability of the bindings.

The errors that are emitted when there is a declaration mismatch
are emitted by the C++ compiler,
and are quite challending to understand,
but at least they stop you from running the code with mismatched types.

Here's an example of the error emitted when
the above `read` method is declared to take an incorrect `&Self` self-parameter
(slightly reformatted for slightly-better readability):

```
  cargo:warning=/home/brian/wasm-opt-rs/target/debug/build/wasm-opt-cxx-sys-5a105a63051bad83/out/cxxbridge/sources/wasm-opt-cxx-sys/src/lib.rs.cc:
  In function ‘rust::cxxbridge1::{anonymous}::repr::PtrLen wasm_shims::wasm_shims$cxxbridge1$ModuleReader$read(const ModuleReader&, const string&, wasm_shims::Module&, const string&)’:

  cargo:warning=/home/brian/wasm-opt-rs/target/debug/build/wasm-opt-cxx-sys-5a105a63051bad83/out/cxxbridge/sources/wasm-opt-cxx-sys/src/lib.rs.cc:145:152:
  error: cannot convert ‘void (wasm_shims::ModuleReader::*)(const string&, wasm_shims::Module&, const string&)’ {aka ‘void (wasm_shims::ModuleReader::*)(const std::__cxx11::basic_string<char>&, wasm::Module&, const std::__cxx11::basic_string<char>&)’} to ‘void (wasm_shims::ModuleReader::*)(const string&, wasm_shims::Module&, const string&) const’ {aka ‘void (wasm_shims::ModuleReader::*)(const std::__cxx11::basic_string<char>&, wasm::Module&, const std::__cxx11::basic_string<char>&) const’} in initialization

  cargo:warning=  145 |   void (::wasm_shims::ModuleReader::*read$)(const ::std::string &, ::wasm_shims::Module &, const ::std::string &) const = &::wasm_shims::ModuleReader::read;
```

I was able to figure these out at least.
Mostly not from the text of the errors,
but just by thinking about what I might have done wrong.




## Our C++ shim layer

To give the Binaryen C++ API a shape that fit the `cxx` model,
we created a ["shim" C++ layer][shims] the lightly wraps everything
we want to call from Rust.
These shims aren't strictly necessary in all instances,
but following a consistent pattern is valuable for maintainability,
so all our library calls go through `shims.h`,
which lives in the `wasm-opt-cxx-sys` crate with the `cxx` bindings.

[shims]: https://github.com/brson/wasm-opt-rs/blob/11dfc7252c92be3000cbfede5f7b0e36c45ba976/components/wasm-opt-cxx-sys/src/shims.h

It has been many years since I programmed in C++ regularly.
If the C++ shim code linked above can be improved, pull requests are welcome.

The structure of `shims.h` mostly mirrors the structure of our `cxx` bindings,
with the major exception that C++ requires items that reference each other
to be ordered such that items being referred to lexically proceed items doing the referring,
so some of our C++ shims are ordered differently than our Rust declarations.

Binaryen mostly puts its definitions in the C++ `wasm` namespace,
and we put our shims in their own `wasm_shims` namespace.

Like the previously-described `cxx` bindings,
our shims are organized such that within a single block
we define a C++ `struct` containing an inner Binaryen type,
methods on that struct that present an interface `cxx` can work with,
and which transform their arguments to the arguments expected by the
underlying Binaryen APIs,
and free-standing constructor functions as required by `cxx`
(since `cxx` can't call constructors).

Here is the shim declaration that corresponds to the previous `ModuleReader` `cxx` bindings:

```c++
namespace wasm_shims {
  struct ModuleReader {
    wasm::ModuleReader inner;

    void setDebugInfo(bool debug) {
      inner.setDebugInfo(debug);
    }

    void setDwarf(bool dwarf) {
      inner.setDWARF(dwarf);
    }

    void readText(const std::string& filename, Module& wasm) {
      try {
        inner.readText(std::string(filename), wasm);
      } catch (const wasm::ParseException &e) {
        throw parse_exception_to_runtime_error(e);
      }
    }

    void readBinary(const std::string& filename,
                    Module& wasm,
                    const std::string& sourceMapFilename) {
      try {
        inner.readBinary(std::string(filename),
                         wasm,
                         std::string(sourceMapFilename));
      } catch (const wasm::ParseException &e) {
        throw parse_exception_to_runtime_error(e);
      } catch (const wasm::MapParseException &e) {
        throw map_parse_exception_to_runtime_error(e);
      }
    }

    void read(const std::string& filename,
              Module& wasm,
              const std::string& sourceMapFilename) {
      try {
        inner.read(std::string(filename),
                   wasm,
                   std::string(sourceMapFilename));
      } catch (const wasm::ParseException &e) {
        throw parse_exception_to_runtime_error(e);
      } catch (const wasm::MapParseException &e) {
        throw map_parse_exception_to_runtime_error(e);
      }
    }
  };

  std::unique_ptr<ModuleReader> newModuleReader() {
    return std::make_unique<ModuleReader>();
  }
}
```

Although unnecessary,
for organizational purposes,
and to mirror the many `unsafe extern "C++"` block of the bindings,
we use many `namespace wasm_shims { ... }` blocks to group related declarations.
We could also just surround every shim type in a single `namespace wasm_shims` block.

Some things to notice about these shims:

- Many of the Binaryen APIs take `std::string` by value.
  It is not though possible to pass `std::string` by value across
  the FFI boundary.
  These shims instead accept a `const` reference to `std::string`,
  then make a full copy of the string to pass to the inner method.
  For our purposes this is fine, others' might want to avoid the copy.
- While `cxx` automatically catches exceptions that implement `std::exception`
  and return them as Rust errors, Binaryen's `wasm::ParseException` and
  `wasm::MapParseException` do not implement `std::exception`,
  so these shims have to handle those cases explicitly.
- `newModuleReader` is a free function that constructs a `std::unique_ptr`
  by deferring to `std::make_unique`, which eventually calls the actual constructor.




## What about lifetimes in `cxx`?

`cxx` is also able to express methods that return types containing lifetimes,
adding extra safety that the original C++ types can't express.

In our case the Binaryen `PassRunner`,
the type responsible for running optimization passes to transform a wasm `Module`,
holds a pointer to a `Module` and mutates the value it points to.

In the C++ code this is expressed with raw pointers.
Here are the shims:

```c++
namespace wasm_shims {
  struct PassRunner {
    wasm::PassRunner inner;

    PassRunner(Module* wasm) : inner(wasm::PassRunner(wasm)) {}

    ...

    void run() {
      inner.run();
    }
}
```

In the Rust bindings we add some extra lifetimes,
and this ensures that no other code can touch the contained
`Module` as long as the `PassRunner` is live:

```rust
    unsafe extern "C++" {
        type PassRunner<'wasm>;

        fn newPassRunner<'wasm>(wasm: Pin<&'wasm mut Module>) -> UniquePtr<PassRunner<'wasm>>;

        ...

        fn run(self: Pin<&mut Self>);
    }
```





## A Rusty API

While creating the bindings we soon realized that the binaryen API
was not quite suitable for presenting to Rust users directly.
The API is good, but doesn't translate directly to ideomatic Rust,
particularly with all its methods being mutable,
and requiring a fair bit of boilerplate to set up the way `wasm-opt` does.

We decided to put the direct bindings,
which could still be usable if somebody wanted low level access,
in a `base` module,
and add a builder-style API on top.

With the builder, one sets up all the configuration declaratively,
then runs a single `run` method that performs the work of reading
the module, setting up the `PassRunner`, running the passes,
and writing the module back to disk.

Configuring the builder is like passing the command line arguments
to `wasm-opt`, and the `run` method contains essentially the same
logic as the `wasm-opt` binary. The details of how to drive the
binaryen APIs are hidden.

todo example



## Toolchain integration via `Command`-based API




## Six layers of abstraction

This project ended up defining six clear layers of abstraction,
which strikes me as a lot,
but on examination I don't want to get rid of any of them.
Some of them are imposed by the nature of FFI,
and seem worth enumerating:

- [The C++ shims](https://github.com/brson/wasm-opt-rs/blob/11dfc7252c92be3000cbfede5f7b0e36c45ba976/components/wasm-opt-cxx-sys/src/shims.h).
  I tiny layer of types and methods that wrap the Binaryen types,
  but present an interface that is easy to call via `cxx` bindings.
- [The `cxx` declarations](https://github.com/brson/wasm-opt-rs/blob/11dfc7252c92be3000cbfede5f7b0e36c45ba976/components/wasm-opt-cxx-sys/src/lib.rs).
  The declarations used to auto-generate safe Rust types and C++ glue.
- [The `base` API](https://github.com/brson/wasm-opt-rs/blob/11dfc7252c92be3000cbfede5f7b0e36c45ba976/components/wasm-opt/src/base.rs).
  This layer does several bits of API cleanup so other modules don't have to deal with FFI issues:
  encapsulates `cxx::UniquePtr<SomeBinaryenType>` in a Rust struct,
  uses Rust naming conventions instead of Binaryen's C++ conventions,
  handles pinning as required by `cxx`,
  handles conversion of `Path` to platform-specific string types, etc.
- [The `OptimizationOptions` configuration types](https://github.com/brson/wasm-opt-rs/blob/11dfc7252c92be3000cbfede5f7b0e36c45ba976/components/wasm-opt/src/api.rs)
  and [the `run` method](https://github.com/brson/wasm-opt-rs/blob/11dfc7252c92be3000cbfede5f7b0e36c45ba976/components/wasm-opt/src/run.rs).
  This is the heart of the Rust API: create `OptimizationOptions` and call `run`.
  The configuration types contained in `OptimizationOptions` closely mirror the `wasm-opt` command-line options.
  Their definitions spill across several modules but they all are reexported at the crate root.
  The `run` method duplicates the application-level logic of the `wasm-opt` binary in Rust.
- [The `OptimizationOptions` builder methods](https://github.com/brson/wasm-opt-rs/blob/11dfc7252c92be3000cbfede5f7b0e36c45ba976/components/wasm-opt/src/builder.rs).
  Overlaid onto `OptimizationOptions`. Most methods are obvious one-liners.
- [The `Command` interpreter](https://github.com/brson/wasm-opt-rs/blob/11dfc7252c92be3000cbfede5f7b0e36c45ba976/components/wasm-opt/src/integration.rs).
  This constructs `OptimizationOptions` by interpreting the argsuments to Rust's `Command` type for launching processes.
  It's a bit of an extravagence: it essentially duplicates `wasm-opt`'s own command-line parser.
  Originally intended to make it easier for projects that already invoke the `wasm-opt` process
  to integrate the API,
  It ended up being invaluable for testing:
  we can run all three of 1) the real `wasm-opt`, 2) our Rust binary `wasm-opt`,
  and 3) our library; all in the same way, ensuring they all behave the identically.




## Testing for maintainability




## Outcome and future plans

This was a great bite-sized project:
perfectly scoped to complete quickly and successfully,
with many clear and distinct tasks to split between myself and my partner.
Most hacking isn't so clearcut, so I am grateful we found this one.

It has already been [integrated into the master branch of `cargo-contract`][ccmb],
and &mdash; amazingly &mdash;
somebody other than us took the initiative to [integrate it into Substrate's `wasm-builder`][sswb].

[ccmb]: todo
[sswb]: todo

The final crate has a few caveats for prospective integrators to consider:

- The `wasm-opt-sys` crate takes a non-negligible amount of time to build. It
  also does not do any incremental recompilation, so if the build is invalidated
  it will rebuild the C++ code from scratch. The lack of incremental
  recompilation is a limitation self-imposed by not using cmake or other
  external build system.
- `wasm-opt` on Windows does not support extended unicode paths (probably
  anything non-ASCII). This is a [limitation of
  binaryen](https://github.com/brson/wasm-opt-rs/issues/40) and not a regression
  of the bindings. It may or may not be fixed in the future. The APIs will
  return an error if this occurs.
- `cargo tarpaulin` (code coverage) [segfaults running any `wasm-opt`
  crates](https://github.com/brson/wasm-opt-rs/issues/59), reason unknown. This
  behavior could infect other crates that link to `wasm-opt`. If you use
  tarpaulin, you might verify it continues to work.

These are mentioned in the project readme.

This crate will need light maintenance over time to keep up with Binaryen releases,
which happen a few times a year.
The Web3 Foundation, which funded this project,
has another process for "maintenance grants",
and we plan to apply for one.
As part of that maintenance we would also upgrade crate dependencies,
and submit `wasm-opt` updates to projects the W3F cares about,
including Ink!'s `cargo-contract` and Substrate's `wasm-builder`.
Assuming that is accepted,
prospective integrators can be confident this crate will be maintained in the future.

We may also propose fixing Binaryen's Unicode support on Windows,
if Binaryen maintainers want that.
It would probably be a bunch of churn for Binaryen,
but I am not too comfortable having a Rust crate that breaks in surprising ways on Windows.

We are also interested in writing a pure-Rust wasm minifier,
with much reduced scope compared to `wasm-opt`.
Being pure Rust would fix all the aforementioned caveats about this crate as it stands today;
and I have a few ideas for minification techniques that `wasm-opt` doesn't employ,
though it could (shrinking symbol names, function outlining, profiling (TODO make sure binaryen doesn't do these)).
Also, it would just be fun to write.
But it's a big project,
and justifying it in a grant is harder than this project.




## Appendix: The W3F grant experience

This project was funded by [a grant from the Web3 Foundation][w3fg].
We are thankful for the support of the orginization and the individuals responsible for helping us secure the grant.

[w3fg]: https://github.com/w3f/Grants-Program/blob/master/applications/wasm-opt-for-rust.md

The process for this particular grant went as smoothly as possible,
for a number of reasons.
I would not expect most grants to be as easy,
but still I thought I would outline what we did for the sake of other prospective proposal writers.

Some factors that made this project successful include:

- The scope of this project and what success would look like was well-defined, and small:
  bind `wasm-opt`, use it in `cargo-contract`.
- The path to implement the project technically had few risks and unknowns.
- The cost was modest: 30,000 USD. More about the cost below.

But also:

- I have a well-known history with Rust and the Rust blockchain industry,
  and am more-or-less a recognized expert,
  so it is easier to approve my proposal than someone unknown.
- Though we had never worked together previously,
  I have had professional contact for years with both Polkadot and W3F employees.
  
Networking and "building your brand" has a compounding beneficial effect over one's career.
I am grateful to know so many people in the industry,
and that many of them remain willing to work with me.

As background,
in 2020 I wrote [a series of blog posts][b1]
in wich I explored [Ink!],
the Rust DSL for smart contracts on [Substrate].
I had some chats with one of the Ink! maintainers at the time.
In 2021 I [wrote another][b2].
So the Ink! maintainers were aware of me and my interest in their project.

This year (2022) I participated in, but did not complete, the [Substrate hackathon][sht].
I intended to blog about it again, but [did not achieve enough for it to be worthwhile][b3].

I did note this time though that the experience of running [`cargo-contract`],
Ink!'s build tool,
was not as smooth as I would expect,
one issue being that `wasm-opt` was not trivial to install.

A solution to this little inconvenience was obvious to me,
and it seemed a great candidate for a grant.

So I pinged one of the Ink! maintainers whom by now I already knew and told them about my experience,
and my idea for creating `wasm-opt` Rust bindings.
The agreed with the idea and indicated that it would be an easy grant to approve;
and though the Ink maintainers are not the ones responsible for approving a grant,
it surely can only help to have the support of the maintainers of the project one is looking to improve when seeking funding for that project.

Since this project was to create a binding to the 3rd-party Binaryen project,
I _also_ pinged the author of that project,
who I _also_ knew previously (we worked together at Mozilla).
I was looking to see whether they approved or disapproved of the idea (they liked it),
whether they knew of any obvious obstacles,
and whether there were any prior efforts to bind Binaryen that I was not considering (there was).

When building consensus for a proposal of any kind,
having a sense ahead of time how that proposal is likely to proceed is helpful.
Maintainers don't generally like to be surprised with big changes, even if the ideas are great.
In this case I had been laying the groundwork to make a good proposal of this nature for years.

Proposing a W3F grant requires filling out [a template] and submitting a pull request.
The process is completely open on GitHub.
For an open source hacker, this is awesome:
I love working on GitHub, I love working in the open.

[Our proposal] was pretty simple.
I tried to make the deliverables precise and measurable.

W3F grants are based on deliverables at milestones,
each milestone receiving an agreed payout if the deliverables are completed as specified in the approved proposal.
The W3F has three funding tiers that require progressively more approvals.
The first tier is for proposals less than (TODO).
This is a very small amount of compensation, and only suitable for tiny projects, or perhaps students looking to start their career.
The second tier is the sweet spot,
providing funding for up to 30,000 USD,
and only requiring a modest number of approvals.
The third tier requires many approvals.

I was a little concerned about completing the work for a budget of 30,000 USD,
but thought we could likely do it without going too far overbudget and undervaluing ourselves.
In any case, even if we did go overbudget, I suspected we wouldn't go too far over budget,
and having a solid success with the W3F would be good for our future prospects.

So we asked for 30,000 USD.
I didn't attempt to do any estimation of how many hours it would take besides looking at the deliverables we were proposing
and thinking hard about whether we could do it within budget at our typical hourly rates.
I don't have a lot of faith in software estimation.

The W3F wants a grant to be divided into milestones,
with payment at each,
and has [a list of specifics items] they want at each milestone.
I didn't really think this project was large enough for more than one milestone,
but for the sake of getting paid at a reasonable interval,
I split the project into two milestones,
the first (M1) was to "prove the concept",
in which we promised to get the bindings working end to end,
with a rough sketch of a high-level API;
the second (M2) was to do everything else.

Fortunately, there were no high-risk setbacks discovered in the implementation of this project.
In our [M1 deliverable] we made clear a few things we hadn't known or considered during the proposal:

- The crate would require a Rust 1.48+ compiler
- The crate would require a c++17 compiler
- Binaryen [did not provide suitable error handling] in some cases,
  and this would require an unexpected but doable upstream fix.
- We discovered that [Binaryen did not handle Unicode correctly on Windows].
- `wasm-opt` had fuzzing capabilities that we had not mentioned in the proposal,
  and we did not intend to expose them to the Rust API.

We communicated every negative we knew about the project as clearly as we could.

We were asked to ammend the original proposal to indicate that fuzzing was out of scope,
so that its omission could be evaluated in the final M2 delivery,
and [we did so].

We also published [a preview build of the crate] so the API and its docs could be evaluated.
Although we spent a lot of thought on the design of the Rust API,
nobody at any stage of the process actually commented on it one way or the other.
And in practice, any one `wasm-opt` integrator is only going to use a small part of the total API surface.
They reasonably just care that it works like `wasm-opt`.
I am proud though of the API and its docs.

The second milestone (M2) stretched out as we spent a lot of time
identifying areas in need of polish and perfection.
As we were nearing completion,
we were delighted when someone we did not know
produced [a pull request to Substrate's `wasm-builder`] integrating our bindings.
Though they used the preview build of the crate which was broken in various ways,
this gave us a lot of encouragement that other people were interested in using our work.

Throughout the project we used the [GitHub issue tracker]
to track work items,
and assigned issues to GitHub milestones,
either M1, M2, or none.
This project was thankfully amenable to subdivision into small tasks,
which my junior partner could often complete on her own without my oversight.

What about the 30,000 USD budget? Did we go over it?
I track my time precisely, and I performed about 20,000 USD worth of work on this project.
My partner, whose time we charge less for, but whose time we did not track precisely,
nevertheless _definitely_ put more hours into the project than I.
So I think that we ended up almost perfectly on budget.

I was pretty shocked by that,
as the original estimate was a driven not by any real estimation,
but just by a hunch that we could do it within the allocated budget.

I still do not believe in software estimation.

One of the deliverables W3F asks for every milestone is a blog post.
I declined to offer a milestone (M1) blog post,
but promised to deliver one for M2 &mdash; this one!
I kept notes throughout the project, and snippets of text to inform the blog,
so that when it came time to finish it I would remember what was important.

This blog post was probably the single largest work item of the entire project,
taking at least 10 hours of my time.
I don't mind that at all though &mdash; I'm happy with how it turned out,
lots of solid technical content,
a strong addition to my website.

And now that the blog post is published we can submit the M2 deliverables.
How that turns out is yet to be determined.

[b1]: todo
[b2]: todo
[Ink!]: todo
[Substrate]: todo
[sht]: todo
[b3]: todo
[`cargo-contract`]: todo



## TODO topics

- talking to the stakeholders
- integration into cargo-contract
  - Command-api
  - planning for reversion
- thread safety
- cost-effectiveness
- testing for maintainability
- wasm-opt-sys vs wasm-opt-cxxsys
  - linkage hack
- once_cell = ">= 1.9.0, < 1.15.0"
- wasm-opt-sys build times with cc crate
- check_cxx17_support
- 1.48 compatibility
- cxx
  - [Constructors and `cxx`]
  - [By-val `std::string`]
  - [`const`-correctness]
  - [Exceptions and `std::exception`]
- [Binaryen-specific surprises]
  - [Colors]
  - [Some Binaryen APIs make assertions about how they are called]
  - [Binaryen early exits]
  - [Unicode paths don't work on Windows]
  - [Thread safety]
- change grant link to the pull request
- arm
- todo confirm cc puts archives into the rlib
- file issue about catching exceptions in main

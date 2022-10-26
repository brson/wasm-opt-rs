# Creating `wasm-opt` Rust bindings with `cxx`

`wasm-opt` is a component of the [Binaryen] toolkit,
written in C++,
that optimizes [WebAssembly] modules,
I have recently created a [`wasm-opt`] bindings crate for Rust
(with the extensive help of my partner [Aimeedeer]).
The `wasm-opt` crate allows `wasm-opt` to be installed via `cargo`,
and also includes an idiomatic Rust API to access `wasm-opt` programmatically.

This was a fun bite-sized project that involved several interesting topics:
Rust FFI via the [`cxx`] crate,
converting C++ abstractions to Rust abstractions,
designing Rust APIs,
creating tests to catch upstream changes in C++ code,
creating tests to verify conformance with upstream behavior,
and the experience of writing and fulfilling a grant proposal,
all of which I will describe herein.

[Aimeedeer]: https://github.com/Aimeedeer
[`wasm-opt`]: https://github.com/brson/wasm-opt-rs
[Binaryen]: https://github.com/WebAssembly/binaryen
[WebAssembly]: https://webassembly.org/
[`cxx`]: https://github.com/dtolnay/cxx

Thanks to
Alon Zakai,
David Tolnay,
Marcin Górny,
Michael Müller,
and
Robin Freyler
for their contributions to and support of this work.

Thanks to the [Web3 Foundation] for [funding this project][a W3F grant].

[Web3 Foundation]: https://github.com/w3f




## Table of Contents

- [Preface: Installing and using the `wasm-opt` crate](#user-content-preface-installing-and-using-the-wasm-opt-crate)
- [Summary](#user-content-summary)
- [The plan: Our bin strategy](#user-content-the-plan-our-bin-strategy)
- [The plan: Our `cxx` lib strategy](#user-content-the-plan-our-cxx-lib-strategy)
- [Six layers of abstraction](#user-content-six-layers-of-abstraction)
- [Building Binaryen without `cmake`](#user-content-building-binaryen-without-cmake)
- [Dividing the FFI between crates](#user-content-dividing-the-ffi-between-crates)
- [Linking to crates that contain no Rust code](#user-content-linking-to-crates-that-contain-no-rust-code)
- [Creating a Rust bin with a C++ `main` function](#user-content-creating-a-rust-bin-with-a-c-main-fuction)
- [`cxx` and Binaryen](#user-content-cxx-and-binaryen)
- [Defining `cxx` bindings](#user-content-defining-cxx-bindings)
- [Our C++ shim layer](#user-content-our-c-shim-layer)
- [Moving owned strings across the FFI with `cxx`](#user-content-moving-owned-strings-across-the-ffi-with-cxx)
- [A better shim pattern for non-`const` methods](#user-content-a-better-shim-pattern-for-non-const-methods)
- [Lifetimes in `cxx`](#user-content-lifetimes-in-cxx)
- [(Custom) exception handling with `cxx`](#user-content-custom-exception-handling-in-cxx)
- [Sharing C++ headers between crates with `cxx_build`](#user-content-sharing-c-headers-between-crates-with-cxx_build)
- [A Rusty API](#user-content-a-rusty-api)
- [Toolchain integration considerations and a `Command`-based API](#user-content-toolchain-integration-considerations-and-a-command-based-api)
- [Testing for maintainability](#user-content-testing-for-maintainability)
- [Outcome and future plans](#user-content-outcome-and-future-plans)
- [Appendix: The W3F grant experience](#user-content-appendix-the-w3f-grant-experience)




## Preface: Installing and using the `wasm-opt` crate

If you are interested in using this tool,
to install `wasm-opt` via `cargo`:

```
cargo install wasm-opt --locked
```

You'll end up with a `wasm-opt` binary in `$CARGO_HOME/bin`,
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
and had to solve a bunch of minor problems including:
giving the C++ API a shape suitable for binding to Rust,
dealing with the differing move semantics of C++ and Rust,
working around C++ `const`-correctness issues,
exception handling between FFI layers.
We needed to make one [upstream Binaryen change][bchange].

We were happy with the decision to use `cxx`. It worked as advertised:
we didn't have to think much about memory-safety across the FFI as `cxx` guided us to the safe solutions.
The `cxx` docs are pretty great,
with [good API docs](https://docs.rs/cxx/latest/cxx/),
and [a book](https://cxx.rs/).
The [table showing the correspondence between C++ and Rust types][cxxt] is invaluable.

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

Prior to publication of this blog post we asked David Tolnay (dtolnay),
the author of `cxx` to review our usage of his library.
He made many insightful suggestions and contributions,
some of which I'll pass on here.

The next sections discuss our objectives at the outset of the project,
then the bulk of this post is about our experience attempting to fulfill them.

Links to `wasm-opt-rs` point to
[commit bae78101](https://github.com/brson/wasm-opt-rs/tree/bae781010f6a2a7d774adc05d251cdf7608bc271).
Links to Binaryen point to
[commit c74d5eb6](https://github.com/WebAssembly/binaryen/tree/c74d5eb62e13e11da4352693a76eec405fccd565),
corresponding to version `110`.

[arexp]: https://github.com/w3f/Grants-Program/blob/master/applications/wasm-opt-for-rust.md#appendix-the-wasm-opt-installation-experience
[`cargo-contract`]: https://github.com/paritytech/cargo-contract/
[Ink!]: https://github.com/paritytech/ink
[a W3F grant]: https://github.com/w3f/Grants-Program/blob/master/applications/wasm-opt-for-rust.md
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

There would be some minor wrinkles to this strategy,
and it turns out that there is a much simpler way to use a C++ `main` function
than calling it from Rust,
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
it is created by [dtolnay],
who has designed many excellent Rust libraries,
so we were enthusiastic to try it.

[`cxx`]: http://docs.rs/cxx
[dtolnay]: https://github.com/dtolnay

On top of the `cxx` API we would layer an idiomatic Rust API,
though we did not know at the outside the form it would take.

Both the lib and bin would live in the same `wasm-opt` crate,
a decision with tradeoffs.




## Six layers of abstraction

This project ended up defining six clear layers of abstraction,
which strikes me as a lot,
but on examination I don't want to get rid of any of them.
Some of them are imposed by the nature of FFI,
and seem worth enumerating.
Most of this post will be walking through the process of building
these from bottom to top.

- [The C++ shims](https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt-cxx-sys/src/shims.h).
  A tiny layer of types and methods that wrap the Binaryen types,
  but present an interface that is easy to call via `cxx` bindings.
- [The `cxx` declarations](https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt-cxx-sys/src/lib.rs).
  The declarations used to auto-generate safe Rust types and C++ glue.
- [The `base` API](https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/base.rs).
  This layer does several bits of API cleanup so other modules don't have to deal with FFI issues:
  encapsulates `cxx::UniquePtr<SomeBinaryenType>` in a Rust struct,
  uses Rust naming conventions instead of Binaryen's C++ conventions,
  handles pinning as required by `cxx`,
  handles conversion of `Path` to platform-specific string types, etc.
- [The `OptimizationOptions` configuration types](https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/api.rs)
  and [the `run` method](https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/run.rs).
  This is the heart of the Rust API: create `OptimizationOptions` and call `run`.
  The configuration types contained in `OptimizationOptions` closely mirror the `wasm-opt` command-line options.
  Their definitions spill across several modules but they all are reexported at the crate root.
  The `run` method duplicates the application-level logic of the `wasm-opt` binary in Rust.
- [The `OptimizationOptions` builder methods](https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/builder.rs).
  Overlaid onto `OptimizationOptions`. Most methods are obvious one-liners.
- [The `Command` interpreter](https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/integration.rs).
  This constructs `OptimizationOptions` by interpreting the arguments to Rust's `Command` type for launching processes.
  It's a bit of extravagance: it essentially duplicates `wasm-opt`'s own command-line parser.
  Originally intended to make it easier for projects that already invoke the `wasm-opt` process
  to integrate the API,
  It ended up being invaluable for testing:
  we can run all three of 1) the real `wasm-opt`, 2) our Rust binary `wasm-opt`,
  and 3) our library; all in the same way, ensuring they all behave the identically.




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

[build-script]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt-sys/build.rs
[`cc`]: https://github.com/rust-lang/cc-rs
[wos]: https://github.com/brson/wasm-opt-rs/tree/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt-sys
[sc]: https://doc.rust-lang.org/cargo/reference/build-scripts.html?highlight=sys#-sys-packages

The [`cc`] crate compiles C and C++ source files,
packages them into an archive (`.a`) file,
and emits the correct metadata to tell cargo
to include the archive in the crate's library (`.rlib`) file,
and subsequently in the final executable.
It is widely used in the Rust ecosystem and contains a great deal of platform-specific,
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
write a build script that compiled only [`wasm-opt.cpp`],
run the build until the link step,
at which point the linker would emit many errors about missing symbols;
grep the source for the likely source of a single symbol;
add the new source, build again and repeat until there were no more linker errors.

[`wasm-opt.cpp`]: https://github.com/WebAssembly/binaryen/blob/c74d5eb62e13e11da4352693a76eec405fccd565/src/tools/wasm-opt.cpp

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
we decided to [reproduce this behavior exactly][rp1],
and our build script has two functions that pull the version number from each place
and put them into `config.h` as appropriate.

Binaryen's build configuration also hex-encodes and embeds a binary called `wasm-intrinsics.wat` into its source code.
So we again had to [reproduce that logic][rp2].

[rp1]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt-sys/build.rs#L332-L369
[rp2]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt-sys/build.rs#L332-L369

Adapting our custom build process to Binaryen as it changes in the future will
likely be the most difficult ongoing maintenance task on this project.
We have already performed one upgrade, from version 109 to 110,
and it involved resolving link errors and adding source files until everything linked again.




## Dividing the FFI between crates

From our experience getting the `wasm-opt-sys` crate to build
we knew that rebuilding that crate took a long time,
multiple minutes on my underpowered laptop.

This is because the `cc` crate doesn't support any kind of incremental recompilation:
any time the `wasm-opt-sys` crate needs to rebuild, it compiles every C++ file in the project.
The lack of incremental recompilation within `cc` is intentional &mdash;
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
we put essentially no Rust code in the `wasm-opt-sys` crate,
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

Editing either `wasm-opt-cxx-sys` or `wasm-opt` does not invalidate `wasm-opt-sys`,
so during development we don't need to sit through repeated complete builds of Binaryen.

One awkward result of the division between `wasm-opt-sys` and `wasm-opt-cxx-sys` is
that they both need access to the Binaryen source code,
as `cxx` generates C++ code that accesses Binaryen headers.
This complicates our deploy process slightly,
and also implies that we must be careful about managing the version numbers
of these two crates such that compatible versions always use compatible Binaryen source code.

We originally packaged the full Binaryen source code
with both `wasm-opt-sys` and `wasm-opt-cxx-sys`,
and this amounted to _72 MB of C++ source code_.

After review, `cxx` author dtolnay clued us in that

1) We don't need to package the 26 MB Binaryen test suite, and
2) [`cxx_build` has a solution to sharing headers between crates][cxxshare]

[cxxshare]: #user-content-sharing-c-headers-between-crates-with-cxx_build




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
`rustc` did not actually link to our native library.

The way to solve this is to "fool" rustc into thinking the crate in question is used.

There are multiple ways to do so,
but the recommended way is to just mention it in an `extern crate` declaration.
So for us, both the `wasm-opt` lib and `wasm-opt-cxx-sys` crates contain

```rust
extern crate wasm_opt_sys;
```

And otherwise do nothing with the crate.

This is also useful when activating the [`unused_crate_dependencies`] lint,
to tell the compiler about a crate that is only used in some configurations (e.g. Windows-only).

[`unused_crate_dependencies`]: https://doc.rust-lang.org/rustc/lints/listing/allowed-by-default.html#unused-crate-dependencies

I have also seen crates use unnamed imports for this:

```rust
use wasm_opt_sys as _;
```

It's not clear to me if there is any meaningful difference between these two patterns.




## Creating a Rust bin with a non-Rust `main` function

With a working build of all the source needed by `wasm-opt`,
we needed to create a `main.rs` file that would delegate to the C++ `main` function.

Firstly, I'll describe the easy, and arguably _right_, way to do it.
Then I'll describe how we did it!

The easy way is to have `cc` compile the source containing the main function
just as you would any other source;
then create a `main.rs` that contains

```rust
// Use a foreign main function.
#![no_main]

// Make sure to link to it.
extern crate wasm_opt_sys;
```

That's it. For just running a foreign `main` you don't need anything else.
The Rust compiler won't look for a Rust `main` function,
and it won't emit any startup code.
It'll just assume you have set everything up correctly.

We did not do that.
We did not think to do that,
but if we had it would have influenced our initial design.
Instead we wrote a Rust `main` function that
called the C++ `main` function,
and the final design ended up
_requiring_ us to do this unless we [split the `wasm-opt` library and binary into two different crates][split].

[split]: https://github.com/brson/wasm-opt-rs/issues/93

Anyway, what we did:

We had to write our Rust `main.rs` file and call the C++ `main` function.
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
This is on linux with `gcc`.
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

The [full source] of the Rust `main.rs` is simple,
though ugly, just a bunch of raw FFI.
It is small and interesting enough that I'll just
list it all here for commentary:

[full source]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/main.rs

```rust
// Establish linking with wasm_opt_sys, which contains no Rust code.
extern crate wasm_opt_sys;

mod c {
    use libc::{c_char, c_int};

    extern "C" {
        pub fn wasm_opt_main(argc: c_int, argv: *const *const c_char) -> c_int;
    }
}

fn main() -> anyhow::Result<()> {
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

The `main` Rust function's only
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
`char`s on Windows, perhaps leveraging the C++ [`std::filesystem::path`] type.
We left this large upstream task to future work.

[`OsStrExt::encode_wide`]: https://doc.rust-lang.org/std/os/windows/ffi/trait.OsStrExt.html#tymethod.encode_wide
[`std::filesystem::path`]: https://en.cppreference.com/w/cpp/filesystem/path

The two calls to [`drop`] in this function are functionally useless;
they are just a written reminder that we want to lose access to the raw pointers
before losing access to the things they point to.

[`drop`]: https://doc.rust-lang.org/std/mem/fn.drop.html




## `cxx` and Binaryen

We dedicated the [`wasm-opt-cxx-sys`] crate to creating bindings with [`cxx`].
We were happy with the decision to use `cxx`. It worked as advertised:
we didn't have to think much about memory-safety across the FFI as `cxx` guided us to the safe solutions.

[`wasm-opt-cxx-sys`]: https://github.com/brson/wasm-opt-rs/tree/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt-cxx-sys

The `cxx` docs are pretty great,
with [good API docs](https://docs.rs/cxx/latest/cxx/),
and [a book](https://cxx.rs/).
The [table showing the correspondence between C++ and Rust types][cxxt] is invaluable.

[cxxt]: https://cxx.rs/bindings.html

We used `cxx` version `1.0.79`.
There may be new versions by now with new features.

The purpose of `cxx` is to make it possible to communicate between C++ and Rust using _safe_ Rust.
As such, `cxx` is very opinionated about what the code on both sides of the FFI look like,
and supports a relatively small set of types.

This is great for projects that are in control of both the C++ and Rust APIs,
and it probably will help the C++ side be disciplined about ownership and const-correctness.

Binaryen was not designed for compatibility with with `cxx`,
so we ended up creating a full C++ shim layer to adapt between Binaryen's APIs
and APIs that were suitable for binding through `cxx`.
Fortunately Binaryen's API surface is reasonable and modern and easy to understand,
so our shims are simple.

`cxx` is capable of creating bindings in both directions of the FFI:
to let Rust call C++, but also to let C++ call Rust.
The former are done in macros containing [`extern "C++"`] blocks;
the latter [`extern "Rust"`] blocks.
We only used the former, calling from Rust to C++.

[`extern "C++"`]: https://cxx.rs/extern-c++.html
[`extern "Rust"`]: https://cxx.rs/extern-rust.html

The next sections discuss our experience creating `cxx` bindings,
some of the obstacles we encountered,
and what our C++ shim layer looks like.




## Defining `cxx` bindings

In `cxx` bindings are defined in a dedicated module annotated with `#[cxx::bridge]`.
Within that module are any number of `extern "C++"` (or `extern "Rust"`) blocks.

The pattern we followed used many `unsafe extern "C++"` blocks,
one for each C++ class we wanted bindings for.
Each of those blocks then declared a single type,
and one or more constructor functions and methods.

Here our [our bindings][ourb]' declarations for Binaryen's `ModuleReader`:

[ourb]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt-cxx-sys/src/lib.rs

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

- The `unsafe` keyword indicates that we have thought real hard about these
  functions and determine that calling them from Rust will preserve Rust's
  memory safety promises; callers don't need to use `unsafe` to call them.
  If we could not guarantee memory safety, then we could leave off `unsafe`,
  and it would be up to the caller to call these bindings safely within
  an `unsafe` block.
- The `unsafe` keyword here is a declaration that using these bindings is
  _safe_. Think of it the same as the use of `unsafe` around an expression.
  It is possible to write `cxx` bindings that propagate unsafety as well by omitting `unsafe`.
- The naming conventions are a mashup of Rust and C++:
  function names necessarily come from C++;
  the `UniquePtr` type is the Rust wrapper for the C++ `std::unique_ptr` type.
- `newModuleReader` is a free function. It is not a C++ constructor.
  It doesn't appear that `cxx` handles C++ constructors directly,
  so the C++ side must define extra constructor functions.
- Non-primitive types need to be passed as pointers,
  mostly `UniquePtr` or references.
- Functions with an initial argument named `self`,
  and with the `Self` type,
  are interpreted  as methods of the single `type` declared in the block.
  With this interpretation of `Self` it is cleanest to put each type
  in its own `extern` block, though it is possible to put all types into
  a single extern block by naming the self-type explicitly (e.g. `Pin<&mut ModuleReader>`).
- The `Result` type is a typedef of `std::Result` where the
  error type is [`cxx::Exception`]. `cxx` will by default catch at the boundary
  any exception that implements [`std::exception`] and return it as an error,
  and we [further augment this][fat] to catch some Binaryen exceptions that do
  not implement `std::exception`.
- `&CxxString` is a `const` reference to a C++ `std::string`.

[`std::exception`]: https://en.cppreference.com/w/cpp/error/exception
[fat]: #user-content-custom-exception-handling-in-cxx
[`cxx::Exception`]: https://docs.rs/cxx/1.0.79/cxx/struct.Exception.html

The final thing to note is that the `self` type of
these methods is `Pin<&mut Self>`.
What this means is that the underlying method is non-`const`:
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

Papering over the missing `const`-correctness was easy in our case,
but more complex or stateful APIs would cause bigger problems
that might require fixing the underlying declarations.

[cc]: https://isocpp.org/wiki/faq/const-correctness
[`base` API]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/base.rs

We haven't tried it yet,
but `cxx` author dtolnay suggests [a preferred shim pattern][ncs] for
dealing with non-const-correct methods,
described later in this post.

[ncs]: #user-content-a-better-shim-pattern-for-non-const-methods

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
and are quite challenging to understand,
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
Making only small incremental changes before recompiling kept
the errors from getting overwhelming.




## Our C++ shim layer

To give the Binaryen C++ API a shape that fit the `cxx` model,
we created a "shim" C++ layer the lightly wraps everything
we want to call from Rust.
These shims aren't strictly necessary in all instances,
but following a consistent pattern is valuable for maintainability,
so all our library calls go through [`shims.h`],
which lives in the `wasm-opt-cxx-sys` crate with the `cxx` bindings.

[`shims.h`]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt-cxx-sys/src/shims.h

The structure of `shims.h` mostly mirrors the structure of our `cxx` bindings,
with the major exception that C++ requires items that reference each other
to be ordered such that items being referred to lexically proceed items doing the referring,
so some of our C++ shims are ordered differently than our Rust declarations.

Binaryen mostly puts its definitions in the C++ `wasm` namespace,
and we put our shims in their own `wasm_shims` namespace.

Like the previously-described `cxx` bindings,
our shims are organized such that within a single block
we define a C++ `struct` containing an inner Binaryen type,
methods on that struct presenting an interface `cxx` can work with,
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
      inner.readText(std::string(filename), wasm);
    }

    void readBinary(const std::string& filename,
                    Module& wasm,
                    const std::string& sourceMapFilename) {
      inner.readBinary(std::string(filename),
                       wasm,
                       std::string(sourceMapFilename));
    }

    void read(const std::string& filename,
              Module& wasm,
              const std::string& sourceMapFilename) {
      inner.read(std::string(filename),
                 wasm,
                 std::string(sourceMapFilename));
    }
  };

  std::unique_ptr<ModuleReader> newModuleReader() {
    return std::make_unique<ModuleReader>();
  }
}
```

Some things to notice about these shims:

- Many of the Binaryen APIs take `std::string` by value.
  It is not though possible to pass `std::string` by value across
  the FFI boundary.
  These shims instead accept a `const` reference to `std::string`,
  then make a full copy of the string to pass to the inner method.
  For our purposes this is fine, others might want to avoid the copy,
  the pattern for which is described in the next section.
- There is no exception handling. `cxx` does that for us.
- `newModuleReader` is a free function that constructs a `std::unique_ptr`
  by deferring to `std::make_unique`, which eventually calls the actual constructor.




## Moving owned strings across the FFI with `cxx`

Above I said that it isn't possible to pass `std::string` by value from Rust to C++,
and that because of this our bindings pass a reference and then make a copy.

But even though it isn't possible to pass `std::string` by value,
it _is_ possible to move them across the FFI.

We didn't do this because by the time we learned about it,
we had already published the crate and didn't want to break compatibility for it.

Understanding how to move values from Rust across the FFI to C++ requires
a basic understanding of the move semantics of both Rust and C++, and the semantics of Rust's `Pin`,
and I don't fully understand all three of these,
but I'll show how it's done anyway.

Recall our C++ `readText` method:

```C++
    void readText(const std::string& filename, Module& wasm) {
      inner.readText(std::string(filename), wasm);
    }
```

And its corresponding `cxx` binding:

```rust
        fn readText(
            self: Pin<&mut Self>,
            filename: &CxxString,
            wasm: Pin<&mut Module>,
        ) -> Result<()>;
```

This is saying that Rust is letting C++ _look_ at the string `filename`,
but it can't mutate it, and it can't move it,
because it is a `const` reference.

In C++, unlike Rust,
moves happen through non-const references,
so if we instead define `readText` without the `const`,
we can also call `std::move` on `filename`.

```c++
    void readText(std::string& filename, Module& wasm) {
      inner.readText(std::move(filename), wasm);
    }
```

C++ move semantics are very different from Rust.
Moving in C++ invokes a _move constructor_,
something that Rust doesn't know how to do.
When an object is moved in C++,
the original object _still exists_ and is still accessible,
and is still in some kind of valid state,
but everything in that object has been transferred into the receiving object.

Coming from Rust it seems weird and error-prone.

The corresponding Rust bindings are now

```rust
        fn readText(
            self: Pin<&mut Self>,
            filename: Pin<& mut CxxString>,
            wasm: Pin<&mut Module>,
        ) -> Result<()>;
```

This means that Rust is allowing the string to be mutated from C++,
and so it can call the move constructor.

It suggests that there must be some cleverness going on
in `cxx` to make this compatible with Rust.
If C++ moves the value out,
mutating the string,
what is left of the string when the call to `readText` returns?

I tested this by adjusting our call to `readText`:

```rust
    pub fn read_text(&mut self, path: &Path, wasm: &mut Module) -> Result<(), cxx::Exception> {
        let path = convert_path_to_u8(path)?;
        let_cxx_string!(path = path);

        println!("before: {}", path);

        let this = self.0.pin_mut();
        this.readText(path, wasm.0.pin_mut())?

        println!("after: {}", path);

        Ok(())
    }
```

[`let_cxx_string!`] is a `cxx` macro for creating C++ compatible strings.
It returns a `Pin<&mut CxxString>`.

[`let_cxx_string!`]: https://docs.rs/cxx/1.0.79/cxx/macro.let_cxx_string.html

Trying to run this fails:

```
error[E0382]: borrow of moved value: `path`
  --> components/wasm-opt/src/base.rs:49:31
   |
42 |         let_cxx_string!(path = path);
   |         ---------------------------- move occurs because `path` has type `Pin<&mut CxxString>`, which does not implement the `Copy` trait
...
47 |         this.readText2(path, wasm.0.pin_mut())?;
   |                        ---- value moved here
48 |
49 |         println!("after: {}", path);
   |                               ^^^^ value borrowed here after move
   |
   = note: this error originates in the macro `$crate::format_args_nl` (in Nightly builds, run with -Z macro-backtrace for more info)

For more information about this error, try `rustc --explain E0382`.
error: could not compile `wasm-opt` due to previous error
```

It's obvious in retrospect:
we have a `Pin<&mut CxxString>`,
we pass it by value to the `readText` method,
so _it_ can pass it by mutable reference to C++;
and now the Rust side of the FFI no longer has access to that `Pin<&mut CxxString>`.

So whatever C++ did to move the string,
it is unobservable to Rust.

I was expecting we would be stuck with an error-prone empty string,
but `cxx` protected us from that.

Pretty clever.




## A better shim pattern for non-`const` methods

I mentioned previously that Binaryen's methods are not `const`-correct:
it has methods that do not mutate the receiver (the `this` pointer),
but are also not declared `const`.

Taking again our `readText` example, from our shims:

```c++
    void readText(const std::string& filename, Module& wasm) {
      inner.readText(std::string(filename), wasm);
    }
```

The inner method is a method on `ModuleReader` that does not mutate `ModuleReader`,
and this is transitively true for the shim method shown.

To make this `const`-correct we want it to be declared:

```c++
    void readText(const std::string& filename, Module& wasm) const {
      inner.readText(std::string(filename), wasm);
    }
```

Note the `const` on the right side of the method signature.

In the absence of fixing the underlying API,
Rust bindings need to work around this problem to avoid
making the Rust APIs incorrectly mutable.

Within `wasm-opt` this was easy because
we don't expose any of the underlying Binaryen types,
even indirectly,
to the user-facing API:
users call [`OptimizationOptions::run`] and that method does all the interaction with the C++ code.

[`OptimizationOptions::run`]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/run.rs#L88

dtolnay suggested handling the mutability conversion within the C++ shim layer,
by relying on `std::unique_ptr`'s [`operator ->()`][oparrow],
which produces a non-`const` reference.

[oparrow]: https://en.cppreference.com/w/cpp/memory/unique_ptr/operator*

Adjusting our `readText` bindings to do this looks like

```c++
  void ModuleReader_readText(
    const std::unique_ptr<ModuleReader> &reader,
    const std::string& filename,
    Module& wasm
  ) {
    reader->inner.readText(std::string(filename), wasm);
  }
```

And Rust:

```rust
        fn ModuleReader_readText(
            reader: &UniquePtr<ModuleReader>,
            filename: &CxxString,
            wasm: Pin<&mut Module>,
        ) -> Result<()>;
```

Note that this is now a free function and not a method
(hence the ugly naming choice).

This binding can now be used from Rust without exposing
unneeded mutable references.

I don't fully understand the consequences of this pattern.
To my eyes it looks scary:
on the Rust side `&UniquePtr` is promising no mutation,
on the C++ side we're explicitly taking a mutable reference,
but we also know that actually C++ is not going to mutate.
Or at least we think we know that &mdash; we have no guarantees.

This looks like a situation where you need to be familiar with
the C++ code and confident there is no mutation.

This is why `cxx` makes you put `unsafe` annotations around its safe bindings.
As much as `cxx` helps, you still need to understand what is happening on the C++ side.




## Lifetimes in `cxx`

`cxx` is also able to express methods that return types containing lifetimes,
adding extra safety that the original C++ types can't express.

In our case, the Binaryen `PassRunner` &mdash;
the type responsible for running optimization passes to transform a wasm `Module` &mdash;
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

  std::unique_ptr<PassRunner> newPassRunner(Module& wasm) {
    return std::make_unique<PassRunner>(&wasm);
  }
}
```

In the Rust bindings we add some lifetime annotations,
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




## (Custom) exception handling with `cxx`

Any FFI bindings to C++ have to consider what happens if the C++ throws an exception:
it is undefined behavior to unwind the stack from C++ into Rust.

The `cxx` crate provides a lot of help with this
by [automatically converting a C++ `std::exception` to a Rust `cxx::Exception`][ex].
All that one needs to do is declare a C++ function as returning `Result<T, cxx::Exception>`.
And `cxx` bridge modules automatically import a [type alias][ta] that makes `Result<T>` a `Result<T, cxx::Exception>`.

For example, the Binaryen `ModuleReader` has a `readText` method that might throw,
and we declare it as:

```rust
    unsafe extern "C++" {
        type ModuleReader;

        fn readText(
            self: Pin<&mut Self>,
            filename: &CxxString,
            wasm: Pin<&mut Module>,
        ) -> Result<()>;
    }
```

In C++ `readText` has a `void` return type,
but by declaring it as `Result<()>`,
`cxx` will generate bindings that catch any `std::exception`
and convert it to a Rust error.

[ex]: https://cxx.rs/binding/result.html#returning-result-from-c-to-rust
[ta]: https://doc.rust-lang.org/book/ch19-04-advanced-types.html#creating-type-synonyms-with-type-aliases

This is awesome ... if your exceptions inherit from `std::exception`.
If not then the process will probably abort if the exception is raised.

Binaryen has two custom exception types that `readText` might throw,
`ParseException` and `MapParseException`,
but that do not inherit from `std::exception`.

`cxx` includes a mechanism for customizing which exceptions are caught by its bindings.
It requires defining a template function, `rust::behavior::trycatch`,
and this is what the default implementation looks like:

```c++
namespace rust::behavior {
  template <typename Try, typename Fail>
  static void trycatch(Try &&func, Fail &&fail) noexcept try {
    func();
  } catch (const std::exception &e) {
    fail(e.what());
  }
}
```

Exactly how this works I can only guess.
My C++ knowledge is not advanced enough
(why are `Try` and `Fail` double-indirected?!).

But here is our implementation (that `cxx` author dtolnay wrote for us!):

```c++
namespace rust::behavior {
  template <typename Try, typename Fail>
  static void trycatch(Try&& func, Fail&& fail) noexcept try {
    func();
  } catch (const std::exception& e) {
    fail(e.what());
  } catch (const wasm::ParseException& e) {
    Colors::setEnabled(false);
    std::ostringstream buf;
    e.dump(buf);
    fail(buf.str());
  } catch (const wasm::MapParseException& e) {
    Colors::setEnabled(false);
    std::ostringstream buf;
    e.dump(buf);
    fail(buf.str());
  }
}
```

It just adds some extra arms for the Binaryen exception types,
pulls out an explanatory string,
and calls `fail`.
(The `Colors::setEnabled(false)` calls are telling Binaryen not to emit ANSI terminal color escape sequences).





## Sharing C++ headers between crates with `cxx_build`

We split our native build across two crates, `wasm-opt-sys`,
and `wasm-opt-cxx-sys`,
with the Binaryen build being performed in the former,
and the `cxx` bindings in the latter.

This arrangement requires `wasm-opt-sys` to access all of the Binaryen `.cpp` and `.h` files,
and `wasm-opt-cxx-sys` to access all of the `.h` files.
Our initial solution to this was to simply package the entire Binaryen
source code twice, as part of each package.

But `cxx` has a solution to this problem in the [`cxx_build`] crate.

The `cxx_build` crate adds a layer atop the `cc` crate:
when calling `cxx_build::bridge`,
`cxx` does all of its code generation,
creating a bunch of files in `$TARGET/cxxbridge`,
then it returns a regular [`cc::Build`].

One of the things this code generation step can do
is export C++ header paths from one crate to another.
So our `wasm-opt-sys` build script can tell `wasm-opt-cxx-sys`
the set of directories that contain Binaryen C++ headers
that will be needed for the bindings.

To do this, we push include directories onto the `exported_header_dirs`
`Vec` on the global [`CFG`] value.

[`cxx_build`]: https://docs.rs/cxx-build/latest/cxx_build/
[`cc::Build`]: https://docs.rs/cc/latest/cc/struct.Build.html
[`CFG`]: https://docs.rs/cxx-build/latest/cxx_build/static.CFG.html

Here's approximately how it looks in the [`wasm-opt-sys` build script][build-script]:

```rust
    // Set up cxx's include path so that wasm-opt-cxx-sys's C++ header can
    // include from these same dirs.
    CFG.exported_header_dirs.push(&src_dir);
    CFG.exported_header_dirs.push(&tools_dir);
    CFG.exported_header_dirs.push(&output_dir);

    let mut builder = cxx_build::bridge("src/lib.rs");

    builder
        .files(src_files)
        .file(wasm_opt_src)
        .file(wasm_intrinsics_src);

    builder.compile("wasm-opt-cc");
```

All the header files in `src_dir`, `tools_dir`, and `output_dir`
are then available to instances of `cxx_build` in the `wasm-opt-cxx-sys` build script.
The `wasm-opt-cxx-sys` crate doesn't
need to do anything further in its build script:

```rust
    let mut builder = cxx_build::bridge("src/lib.rs");

    builder.include("src").compile("wasm-opt-cxx");
```

I do not know what underlying mechanism `cxx_build` is using to make this possible,
though I gave it a quick look.
It's pretty magical!




## A Rusty API

We went into the project without a preconception of what the Rust API would be.

While creating the bindings we quickly recognized that the Binaryen API
was not quite suitable for presenting to Rust `wasm-opt` users as-is.
The API is clean, but doesn't translate directly to idiomatic Rust,
particularly with all its methods being mutable,
and requiring a fair bit of boilerplate to set up in the way `wasm-opt` does.

We decided to hide the direct API from callers,
and add a builder-style API on top.

With the builder, one sets up a declarative configuration,
then calls a single `run` method that performs the work of reading
the module, setting up the `PassRunner`, running the passes,
and writing the module back to disk.

Configuring the builder is like passing the command line arguments
to `wasm-opt`, and the `run` method contains essentially the same
logic as the `wasm-opt` binary. The details of how to drive the
underlying Binaryen APIs are hidden:

```rust
use wasm_opt::OptimizationOptions;

let infile = "hello_world.wasm";
let outfile = "hello_world_optimized.wasm";

OptimizationOptions::new_optimize_for_size_aggressively()
    .debug_info(true)
    .zero_filled_memory(true)
    .run(infile, outfile)?;
```

The [`run` method] is essentially reproducing the logic of Binaryen's [`wasm-opt.cpp`].
This was necessary because,
while the core optimization functionality of Binaryen is factored into reusable types and optimization passes,
the various drivers of those passes, of which `wasm-opt` is one,
are written as CLI applications,
and not suitable for reuse as libraries.

[`run` method]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/run.rs#L88

Duplicating so much logic in Rust necessitated more testing than we originally anticipated.

We factored the `OptimizationOptions` type across multiple modules
for organizational purposes but reexported everything at the crate root.
Rust allows a lot of organizational flexibility,
and it is fun playing with new patterns.

Here's how our modules are organized,
as [declared in `lib.rs`][lrs]:

[lrs]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/lib.rs#L99

```rust
// Most of the API surface is exported here.
//
// Many public methods are defined in other non-pub modules.
pub use api::*;

// Returned by the `run` method.
pub use run::OptimizationError;

// The "base" API.
//
// This API hides the `cxx` types,
// but otherwise sticks closely to the Binaryen API.
//
// This is hidden because we don't need to commit to these low-level APIs,
// but want to keep testing them from the `tests` folder.
#[doc(hidden)]
pub mod base;

// Types and constructors used in the API.
mod api;

// A builder interface for `OptimizationOptions`.
mod builder;

// The list of optimization passes.
mod passes;

// Definitions of -O1, -O2, etc.
mod profiles;

// The list of wasm features.
mod features;

// The `run` method that re-implements the logic from `wasm-opt.cpp`
// on top of `OptimizationOptions`.
mod run;
```




## Toolchain integration considerations and a `Command`-based API

The builder might have been the final API,
but as we started looking at [integrating the `wasm-opt` crate into `cargo-contract`][cci],
and thinking about how to make the decision as easy as possible for `cargo-contract`'s maintainers,
we came up with new considerations.

[cci]: https://github.com/paritytech/cargo-contract/issues/733

We were particularly concerned that,
given these bindings were new and untested and likely to contain unknown bugs,
and that the crate imposed new compile-time requirements (a C++17 compiler),
client crates might need to quickly backtrack on their adoption of the crate,
at least for a period of time while bugs are resolved.

So we gave ourselves some additional requirements:

- It should be easy to use either the `wasm-opt` binary or the API.
- Switching between the two should be doable at either compile-time or runtime.
- It should be easy to completely revert the code that integrates the `wasm-opt` crate.

We did a survey of a few projects that use `wasm-opt`,
and they all launched it via the standard [`Command`] API,
so it was obvious that the way to make our crate most compatible with existing code
was to be compatible with `Command`.
This would mean parsing command-line arguments the way `wasm-opt` does.
We also discovered that some prospective clients allowed passing arbitrary arguments to `wasm-opt`,
which would mean parsing _all_ command-line arguments the way `wasm-opt` does.

[`Command`]: https://doc.rust-lang.org/std/process/struct.Command.html

So we added a CLI-style [argument parser][cliarg],
that accepted an existing `Command`,
parsed its arguments,
and called all the appropriate builder methods.

[cliarg]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/integration.rs#L116

This felt a little "wrong" &mdash; now we were rewriting an ever larger amount of Binaryen code.

We documented it as "best-effort",
providing parsing necessary for integration,
but not necessarily with full fidelity to whatever `wasm-opt` actually does.

With enough of the CLI parser implemented for `cargo-contract`'s needs,
we [produced a patch series against `cargo-contract`][ccpatch] for discussion that was super-clean,
showing how to progressively go through all of the options for integration:

[ccpatch]: https://github.com/brson/cargo-contract/commits/wasm-opt-rs

- The first patch just added a help suggestion to `cargo install wasm-opt --locked`.
- The second patch used the `Command` API to allow the library and binary to coexist.
- The third patch removed usage of the `Command` API completely and used just the builder API.

In the end the `cargo-contract` developers accepted the full patch series,
not retaining any compatibility with the binary,
and relying entirely on the library.
So we didn't actually need this big chunk of compatibility code for our main client.

But that was fine,
because the most valuable purpose of this CLI parser ended up being testing.




## Testing for maintainability

We entered this project expecting to make a thin layer
of bindings atop Binaryen.
We expected this to need minimal testing,
and we only promised to deliver "smoke tests".
But what we actually did was use Binaryen's [`ModuleReader`] and [`ModuleWriter`]
plus its [`PassRunner`] to completely reimplement the logic of `wasm-opt`,
as defined in [`wasm-opt.cpp`], along with several data structures.

[`ModuleReader`]: https://github.com/WebAssembly/binaryen/blob/c74d5eb62e13e11da4352693a76eec405fccd565/src/wasm-io.h#L43
[`ModuleWriter`]: https://github.com/WebAssembly/binaryen/blob/c74d5eb62e13e11da4352693a76eec405fccd565/src/wasm-io.h#L87
[`PassRunner`]: https://github.com/WebAssembly/binaryen/blob/c74d5eb62e13e11da4352693a76eec405fccd565/src/pass.h#L206

The Binaryen pieces we completely reimplemented, and their Rust counterparts:

| C++ | Rust |
|-----|------|
| [`wasm-opt.cpp`] | [`OptimizationOptions::run`] |
| [`InliningOptions`][iob] | [`InliningOptions`][ior] |
| [`PassOptions`][pob] | [`PassOptions`][por] |
| [pass name strings][pnb] | [`Pass` enum][pnr] |
| [`Feature` enum][feb] | [`Feature` enum][fer] |

[iob]: https://github.com/WebAssembly/binaryen/blob/c74d5eb62e13e11da4352693a76eec405fccd565/src/pass.h#L65
[ior]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/api.rs#L76
[pob]: https://github.com/WebAssembly/binaryen/blob/c74d5eb62e13e11da4352693a76eec405fccd565/src/pass.h#L98
[por]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/api.rs#L104
[pnb]: https://github.com/WebAssembly/binaryen/blob/c74d5eb62e13e11da4352693a76eec405fccd565/src/passes/pass.cpp#L88
[pnr]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/passes.rs#L11
[feb]: https://github.com/WebAssembly/binaryen/blob/c74d5eb62e13e11da4352693a76eec405fccd565/src/wasm-features.h#L27
[fer]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/features.rs#L15

With all these reimplementations,
we must:

1) ensure they are identical to the original definitions,
2) continue to be identical as Binaryen changes in the future.

So we asked ourselves questions like:

- "How can we guarantee the default value the Rust struct is the same as the C++ struct?"
- "How can we detect if the field of a redefined C++ struct is added or removed?"
- "How can we guarantee that our `Pass` enum variants include all C++ pass name strings?"
- "How can we guarantee that our redefined C++ enum variants have the same numerical values as C++?"
- "How can we test that our Rust APIs behave the same as the real `wasm-opt` CLI?"

And for each of these types of questions we figured out how to write a test case.
Here are a few examples:




### Checking that Rust enum variants match a set of C++ strings

In Binaryen, passes are represented as string names.
In Rust we made them variants of the `Pass` enum:

```rust
pub enum Pass {
    /// Lower unaligned loads and stores to smaller aligned ones.
    AlignmentLowering,
    /// Async/await style transform, allowing pausing and resuming.
    Asyncify,
    ...
}
```

Binaryen maintains a global registry of passes that is [statically
initialized][bsi], and has a function, [`PassRegistry::getRegisteredNames`]
that returns the name of every pass.

[bsi]: https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/src/features.rs#L15
[`PassRegistry::getRegisteredNames`]: https://github.com/WebAssembly/binaryen/blob/c74d5eb62e13e11da4352693a76eec405fccd565/src/passes/pass.cpp#L68

If we can call that function from Rust,
and if we can iterate over the variants of `Pass`,
and convert those passes to a string,
then we can create a set of all the C++ pass names,
and all the Rust pass names.

[So we did that](https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt/tests/api_tests.rs#L21).




### Checking that a Rust struct matches a C++ struct definition

Binaryen's `InliningOptions` is a simple plain-old-data struct,
which we duplicated in Rust.
We also duplicate the initialization of this struct in Rust,
as an implementation of `Default`.
We wanted to be sure that our default implementation matched Binaryen's,
and that if any fields were added or removed from
this struct in the future we would know about them.

To do this we construct the Rust version of `InliningOptions`,
and pass that to a hand-written C++ function,
[`checkInliningOptionsDefaults`](https://github.com/brson/wasm-opt-rs/blob/bae781010f6a2a7d774adc05d251cdf7608bc271/components/wasm-opt-cxx-sys/src/shims.h#L306),
that constructs the C++ type and compares all the fields.

It also checks that the C++ type has a known hard-coded size:
if that size ever changes, it probably indicates a field has changed.





### Ensuring that the Rust API's `run` method behaves like `wasm-opt`

The most important testing we did was to esure that our API behaved the same as Binaryen's CLI.

We leveraged our `Command`-based API for this
to create a set of [confarmance tests][cts] that:

[cts]: https://github.com/brson/wasm-opt-rs/tree/bae781010f6a2a7d774adc05d251cdf7608bc271/components/conformance-tests

- build the Binaryen `wasm-opt`
- build the Rust `wasm-opt`

then, the test suite creates command line arguments for exercising `wasm-opt` under various scenarios,
under both binaries and the API, and checks that for all three implementations:

- `wasm-opt` either succeeded or failed
- the output files were exactly the same

These tests caught many bugs in our implementation.




## Outcome and future plans

This was a great bite-sized project:
perfectly scoped to complete quickly and successfully,
with many clear and distinct tasks to split between myself and my partner.
Most hacking isn't so clearcut, so I am grateful we found this one.

It has already been [integrated into the master branch of `cargo-contract`][ccmb],
and somebody other than us took the initiative to [integrate it into Substrate's `wasm-builder`][sswb].

[ccmb]: https://github.com/paritytech/cargo-contract/pull/766
[sswb]: https://github.com/paritytech/substrate/pull/12280

The final crate has a few caveats for prospective integrators to consider:

- The `wasm-opt-sys` crate takes a non-negligible amount of time to build. It
  also does not do any incremental recompilation, so if the build is invalidated
  it will rebuild the C++ code from scratch. The lack of incremental
  recompilation is a limitation self-imposed by not using cmake or other
  external build system.
- `wasm-opt` on Windows does not support extended Unicode paths (probably
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
Being pure Rust would fix all the aforementioned caveats about this crate as it stands today,
and there may be techniques Binaryen doesn't implement that we could pursue.
Also, it would just be fun to write.
But it's a big project,
and justifying it in a grant is harder than this project.




## Appendix: The W3F grant experience

This project was funded by [a grant from the Web3 Foundation][w3fg].
We are thankful for the support of the organization and the individuals responsible for helping us secure the grant.

[w3fg]: https://github.com/w3f/Grants-Program/blob/master/applications/wasm-opt-for-rust.md

The process for this particular grant went as smoothly as possible,
for a number of reasons.
I would not expect most grants to be as easy,
but still I thought I would outline what we did for the sake of other prospective proposal writers.

Some factors that made this project successful include:

- The scope of this project and what success would look like was well-defined, and small:
  bind `wasm-opt`; use it in `cargo-contract`.
- The path to implementing the project technically had a few risks and unknowns.
- The cost was modest: 30,000 USD. More about the cost below.

It also helps that I have had professional contact for years with both Parity and W3F employees:
networking and brand-building have a compounding beneficial effect over one's career.
I am grateful to know many people in the industry,
and that many of them remain willing to work with me.

In 2020 I wrote [a series of blog posts][b1]
in which I explored [Ink!],
the Rust DSL for smart contracts on [Substrate].
I had some chats with one of the Ink! maintainers at the time.
In 2021 I [wrote another][b2].
So the Ink! maintainers were aware of me and my interest in their project.

This year (2022) I participated in, but did not complete, a Substrate hackathon.
I intended to blog about it again, but [did not achieve enough for it to be worthwhile][b3].

I did note this time though that the experience of running [`cargo-contract`],
Ink!'s build tool,
was not as smooth as I would expect,
one issue being that `wasm-opt` was not trivial to install.

A solution to this little inconvenience was obvious to me,
and it seemed a great candidate for a grant.

So I pinged one of the Ink! maintainers whom by now I already knew and told them about my experience,
and my idea for creating `wasm-opt` Rust bindings.
They agreed with the idea and indicated that it would be an easy grant to approve;
and though the Ink! maintainers are not the ones responsible for approving a grant,
it surely can only help to have the support of the maintainers of the project one is looking to improve when seeking funding for that project.

Since this project was to create a binding to the 3rd-party Binaryen project,
I _also_ pinged the author of that project,
who I _also_ knew previously.
I was looking to see whether they approved or disapproved of the idea (they liked it),
whether they knew of any obvious obstacles,
and whether there were any prior efforts to bind Binaryen that I was not considering (there was).

When building consensus for a proposal of any kind,
having a sense ahead of time how that proposal is likely to proceed is helpful.
Maintainers don't generally like to be surprised with big changes, even if the ideas are great.
In this case I had been laying the groundwork to make a good proposal of this nature for years,
mostly by exploring my own interests and meeting people.

Proposing a W3F grant requires filling out [a template] and submitting a pull request.
The process is completely open on GitHub.
For an open source hacker, this is awesome:
I love working on GitHub; I love working in the open.

[a template]: https://github.com/w3f/Grants-Program/blob/master/applications/application-template.md

[Our proposal] was pretty simple.
I tried to make the deliverables precise and measurable.

[Our proposal]: https://github.com/w3f/Grants-Program/pull/1070

W3F grants are based on deliverables at milestones,
each milestone receiving an agreed payout if the deliverables are completed as specified in the approved proposal.
The W3F has three funding tiers that require progressively more approvals.
The first tier is for proposals less than 10,000 USD.
This is a very small amount of compensation, and only suitable for tiny projects, or perhaps students looking to start their careers.
The second tier is the sweet spot for a small project,
providing funding for up to 30,000 USD,
and only requiring a modest number of approvals.
The third tier requires many approvals.

I was a little concerned about completing the work for a budget of 30,000 USD,
but thought we could likely do it without going too far overbudget and undervaluing ourselves.
In any case, even if we did go overbudget, I suspected we wouldn't go too far over budget,
and having a solid success with the W3F would be valuable in the future.

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

[M1 deliverable]: https://github.com/w3f/Grant-Milestone-Delivery/pull/552

- The crate would require a Rust 1.48+ compiler
- The crate would require a c++17 compiler
- Binaryen did not provide suitable error handling in some cases,
  and this would require an unexpected but doable upstream fix.
- We discovered that Binaryen did not handle Unicode correctly on Windows.
- `wasm-opt` had fuzzing capabilities that we had not mentioned in the proposal,
  and we did not intend to expose them to the Rust API.

We communicated every negative we knew about the project as clearly as we could.

We were asked to amend the original proposal to indicate that fuzzing was out of scope,
so that its omission could be evaluated in the final M2 delivery,
and [we did so].

[we did so]: https://github.com/w3f/Grants-Program/pull/1195

We also published [a preview build of the crate][pvb] so the API and its docs could be evaluated.
Although we spent a lot of thought on the design of the Rust API,
nobody at any stage of the process actually commented on it one way or the other.
And in practice, any one `wasm-opt` integrator is only going to use a small part of the total API surface.
They reasonably just care that it works like `wasm-opt`.
I am proud though of the API and its docs.

[pvb]: https://docs.rs/wasm-opt/0.0.1-preview.1

With M1 done,
and the API already in shape (if not actually functioning),
our plan was to file [an issue against `cargo-contract`][cci] early,
explaining our plan,
laying out the options for integrating the crate,
and soliciting feedback.
As with our work prior to submitting the proposal,
we wanted to lay the groundwork early for the end of the project.

The second milestone (M2) stretched out as we spent a lot of time
identifying areas in need of polish and perfection.
As we were nearing completion,
we were delighted when someone we did not know
produced [a pull request to Substrate's `wasm-builder`][sswb] integrating our bindings.
Though they used the preview build of the crate which was broken in various ways,
this gave us a lot of encouragement that other people were interested in using our work.

Throughout the project we used the GitHub issue tracker
to track work items,
and assigned issues to GitHub milestones,
either M1, M2, or none.
This project was thankfully amenable to subdivision into small tasks,
which my junior partner could often complete on her own without my oversight.

We went over the 30,000 budget.

By the time we were about 99% done with the project we were right on budget.
I had performed about 20,000 USD worth of work,
and my partner, whose time we charge less for, but whose time we did not track precisely,
nevertheless probably put more hours into the project than I.
So we were on budget.

One of the deliverables W3F asks for every milestone is a blog post.
I declined to offer a milestone (M1) blog post,
but promised to deliver one for M2 &mdash; this one!
I kept notes throughout the project, and snippets of text to inform the blog,
so that when it came time to finish it I would remember what was important.

This blog post was _definitely_ the single largest work item of the entire project.
After passing the draft to David Tolnay to review,
he came back with many good ideas,
some of which we postponed to the future,
but some of which we needed to take action on,
if only to reflect the mistakes we made with `cxx` in this blog post,
and how to correct them.
I think I worked on the blog for at least 30 hours,
stretching on for weeks after the project was otherwise complete.
I don't mind that at all though &mdash; I'm happy with how it turned out,
lots of solid technical content,
a strong addition to my website.

And now that the blog post is published we can submit the M2 deliverables.
How that turns out is yet to be determined.

[b1]: https://brson.github.io/2020/12/03/substrate-and-ink-part-1
[b2]: https://brson.github.io/2020/12/03/substrate-and-ink-part-2
[Ink!]: https://github.com/paritytech/ink
[Substrate]: https://github.com/paritytech/substrate
[b3]: https://github.com/kris524/Polkadot-Hackathon-North-America-Edition/blob/master/docs/blog.md

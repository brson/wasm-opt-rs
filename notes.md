# Creating `wasm-opt` Rust bindings with `cxx`

`wasm-opt` is a component of the [Binaryen] toolkit,
writtin in C++,
that optimizes [WebAssembly] modules,
and perhaps more importantly,
_shrinks_ WebAssembly modules.
I have recently created a [`wasm-opt`] bindings crate for Rust
(with the extensive help of [Aimeedeer]).
The `wasm-opt` crate allows `wasm-opt` to be installed via cargo,
and also includes an idiomatic Rust API to access `wasm-opt` programatically.

This was a fun bite-sized project that involved several interesting topics:
Rust FFI via the [`cxx`] crate,
converting C++ abstractions to safe Rust abstractions,
designing layered Rust abstractions,
creating tests to catch upstream changes in C++ code,
creating tests to verify conformance with upstream behavior,
professional networking and grant writing.

[Aimeedeer]: https://github.com/Aimeedeer
[`wasm-opt`]: https://github.com/brson/wasm-opt-rs
[Binaryen]: https://github.com/WebAssembly/binaryen
[WebAssembly]: https://webassembly.org/
[`cxx`]: https://github.com/dtolnay/cxx

## Table of Contents

- [Preface: Installing and using the `wasm-opt` crate]
- [Summary]
- [The Plan: Our bin strategy]
- [The Plan: Our `cxx` lib strategy]
- [Building Binaryen without `cmake`]
- [Calling C++ `main` from Rust]
- [`cxx` and Binaryen]
  - [Constructors and `cxx`]
  - [By-val `std::string`]
  - [`const`-correctness]
  - [Exceptions and `std::exception`]
  - [Opinions about `cxx`]
- [Binaryen-specific surprises]
  - [Colors]
  - [Some Binaryen APIs make assertions about how they are called]
  - [Binaryen early exits]
  - [Unicode paths don't work on Windows]
  - [Thread safety]
- [A Rusty API]
- [Toolchain integration via `Command`-based API]
- [Six layers of abstraction]
- [Testing for maintainability]
- [Unexpected obstacles]
  - todo
- [Future plans]
- [Appendix: The w3f grant experience]






## Preface: Installing and using the `wasm-opt` crate

If you are interested in using this tool,
to install `wasm-opt` via cargo:

```
cargo install wasm-opt --locked
```

Youll end up with a `wasm-opt` binary in `$CARGO_HOME/bin`,
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


todo caveats




## Summary

We decided to build this after [a recent experience][arexp]
with [`cargo-contract`], the tool for building [Ink!] programs,
in which we had to go "outside" the Rust ecosystem to find and install `wasm-opt`.
A minor inconvenience,
but as a Rust programmer working with a Rust toolset I want to `cargo install` whenever I can.

Many platforms that use WebAssembly as their VM end up creating their own
tools for building and packaging their wasm programs,
and many of those delegate to `wasm-opt` to shrink their output.

So making `wasm-opt` available as a Rust crate seemed like
an obviously useful thing to do for both [`cargo-contract`]
and any Rust-based wasm-targetting tools.
We proposed [a w3f grant] to build it,
which was accepted gladly.

As a grant application this project was a slam dunk:
clear benefit, clear scope, low risk;
and it worked out almost exactly as expected.

We had the opportunity to use the [`cxx`] crate,
which creates safe Rust bindings to C++ code,
for the first time;
and had to solve a bunch of minor problems,
one of which required [upstream Binaryean changes][bchange].

While leveraging Binaryen's optimization passes,
we ended up duplicating the logic of the `wasm-opt` program itself in Rust,
as `wasm-opt` is a command-line program not suitable to use as a library.
This duplication necessitated writing carefully chosen tests to both
help ensure that the crate's behavior matches the CLI's,
but also that as Binaryen changes in the future,
we notice those changes and adapt to them.

In the end we had [six layers of Rust abstractions][sixabs]
todo

[arexp]: https://github.com/w3f/Grants-Program/blob/master/applications/wasm-opt-for-rust.md#appendix-the-wasm-opt-installation-experience
[`cargo-contract`]: https://github.com/paritytech/cargo-contract/
[Ink!]: https://github.com/paritytech/ink
[a w3f grant]: https://github.com/w3f/Grants-Program/blob/master/applications/wasm-opt-for-rust.md
[bchange]: https://github.com/WebAssembly/binaryen/pull/5087




## The Plan: our bin strategy

The intent of this project was to make `wasm-opt` available to Rust programmers
in two ways: as a command-line program via `cargo install`,
and as a Rust library.

When installing the CLI program the resulting binary must behave the same
as the "native" Binaryen.

The obvious way to do that is to just use cargo as a frontend to the existing
Binaryen build system,
building `wasm-opt` in the cargo build script,
and installing `wasm-opt` during `cargo install`.

This can't be done quite so simply though because there are no hooks into `cargo install`.
cargo will install any Rust binaries it builds,
but it can't be instructed to install arbitrary additional files.

So to get cargo to install `wasm-opt`,
we would Create a Rust crate called `wasm-opt` whose `main` function
did nothing but call the C++ `main` function.

There would be some minor wrinkles to this stategy,
but this is the easy part of the project.




## The Plan: our `cxx` lib strategy

todo


In the end we ended up creating a
[layer of `unique_ptr`-held shim wrappers and methods for every binaryen type][shims]
we needed to instantiate.
A shim layer may not be required if one was developing
the C++ API at the same time as the Rust `cxx` bindings,
but then again, the requirements imposed by `cxx` are strict
enough that it may be difficult to develop a C++ API that is
both C++-idiomatic in a way C++ developers would be happy using
and fully bindable wich `cxx`.
These shims add a small maintenance burden,
but I think it's a fine tradeoff to have the conveniences
of `cxx`.

The next few sections will describe some of the problems
we ran into binding binaryen APIs,
and our solutions.



## Building Binaryen without `cmake`

We gave ourselves one extra challenge:
do not use any build system external to cargo.
We want to impose as few requirements on `wasm-opt` embedders as possible,
and Binaryen is a relatively simple codebase,
so we decided not to use Binaryen's build system (cmake-based) to build Binaryen.

Instead we built binaryen in a cargo build script
using the [`cc`] crate.

todo


[`cc`]: https://github.com/rust-lang/cc-rs



## `cxx` lessons

### Constructors and `cxx`


### By-val `std::string`

Binaryen's `ModuleReader` etc. methods take
`std::string` by value,
but `cxx` can't pass `std:::string` by value.
All methods that take `std::string` need a shim.

So this C++ method:

```c++
  void readText(std::string filename, Module& wasm);
```

Gets a C++ shim:

```c++
  void ModuleReader_readText(ModuleReader& reader,
                             const std::string& filename,
                             Module& wasm) {
    reader.readText(std::string(filename), wasm);
  }
```

This incurs a copy of the string.

### `const`-correctness

Binaryen's APIs are not const-correct,
and `cxx` expects const-correctness.

The same `readText` method on `ModuleReader`:

```c++
  void readText(std::string filename, Module& wasm);
```

does not actually mutate the receiver `ModuleReader`
so could more correctly be declared

```
  void readText(std::string filename, Module& wasm) const;
```

So our wrapper:

```c++
  void ModuleReader_readText(ModuleReader& reader,
                             const std::string& filename,
                             Module& wasm) {
    reader.readText(std::string(filename), wasm);
  }
```

can`t declare `const ModuleReader& reader`,
and our Rust declaration:

```rust
        fn ModuleReader_readText(
            reader: Pin<&mut ModuleReader>,
            filename: &CxxString,
            wasm: Pin<&mut Module>,
        );
```

must accept a `Pin<&mut ModuleReader>` instead
of `&ModuleReader`,
and this leaks into our Rust API,
where the receiver again must take a `&mut self`:

```rust
pub struct ModuleReader(cxx::UniquePtr<wasm::ModuleReader>);

impl ModuleReader {
    // FIXME would rather take &self here but the C++ method is not const-correct
    pub fn read_text(&mut self, path: &Path, wasm: &mut Module) -> Result<(), cxx::Exception> {
        // FIXME need to support non-utf8 paths. Does this work on windows?
        let path = convert_path_to_u8(path)?;
        let_cxx_string!(path = path);

        let this = self.0.pin_mut();
        this.readText(&path, wasm.0.pin_mut())
    }
}
```

To work around the missing C++ const declaration
and present an idiomatic non-mut Rust receiver
will require using interior mutability, e.g.

```rust
pub struct ModuleReader(RefCell<cxx::UniquePtr<wasm::ModuleReader>>);
```

This would allow `ModuleReader` to present `&self` as it logically should,
by quietly mutably borrowing its interior value.
This imposes an extra flag check that should always succeed.
Of course the use of `RefCell` makes `ModuleReader` surprisingly
non-`Sync`.
To fix _that_ we could wrap the `RefCell` in a `Mutex`,
imposing another atomic flag check that should always succeed.




## Opinions about `cxx`

When you define a Rust binding to C++ code,
`cxx` will emit static checks that the types of the Rust declarations
match the types of the C++ declarations.
This is a great feature,
and gives me confidence about the maintainability of the bindings.

The errors that are emitted when there is a declaration mismatch
are emitted by the C++ compiler,
and are quite challending to understand &mdash;


todo example




## Binaryen-specific surprises

### `ParseException` doesn't implement `std::exception`

`cxx` can translate exceptions to Rust as long as they implement
`std::exception`, but `ParseException` does not.



### Colors



## Some binaryen APIs make assertions about how they are called

These abort if they are triggered.

PassRegistry::getPassDescription

todo



### Binaryen calls `exit` on failure to open a file

While testing whether our handling of unicode paths works correctly on Windows (it doesn't)
we discovered that Binaryen's internal file reading and writing
routines call `exit` explicitly in several locations, as in:

```c++
  if (!infile.is_open()) {
    std::cerr << "Failed opening '" << filename << "'" << std::endl;
    exit(EXIT_FAILURE);
  }
```

This is a problem for our API that is insurmountable without modifying binaryen,
so we're going to have to submit a patch upstream to propagate
an exception instead.

We [filed an issue against Binaryen][fileissue] asking if we could modify this behavior.

[fileissue]: https://github.com/WebAssembly/binaryen/issues/4938

This is the first big obstacle we've run into,
and it's going to take a number of hours to resolve.




### Unicode paths don't work on Windows.

We don't know why yet,
but when we use paths with extended unicode characters
Binaryen fails to open them on Windows.
We are currently encoding those paths as UTF-8 before passing them to Binaryen.
Perhaps UCS-16 is expected,
or perhaps we need to pass different compiler flags
to configure MSVC's standard library,
or perhaps Binaryen is broken in this case.

This is the second big obstacle we've run into.

TODO





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




## Testing for maintainability







## Unexpected obstacles

### Obstacle: C++17

### Obstacle: MSRV

### Obstacle: The `cc` crate and rebuild times

### Obstacle: GitHub actions and ARM workers

### Obstacle: binaryen console assumptions

### Obstacle: the binaryen fuzzing features


## Future plans


### Maintenance grant

- publish updates following binaryen releases
- update dependencies
- submit updated prs to cargo-contract and wasm-builder
- fix unicode bug in binaryen


## Appendix: The w3f grant experience




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

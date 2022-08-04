# Creating `wasm-opt` Rust bindings with `cxx`

I have recently created a [`wasm-opt`] crate for Rust.
`wasm-opt` is a component of the [`binaryen`] toolkit,
that optimizes [WebAssembly] modules,
and perhaps more importantly,
it _shrinks_ WebAssembly modules.

`wasm-opt` is such a singularly important tool for wasm development
that it is a dependency of (I think) every wasm-targetting toolchain
I have ever used.


## By-val `std::string`

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

## `const`-correctness

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
pub struct ModuleReader(cxx::UniquePtr<ffi::ModuleReader>);

impl ModuleReader {
    pub fn read_text(&mut self, path: &Path, wasm: &mut Module) {
        // FIXME need to support non-utf8 paths. Does this work on windows?
        let_cxx_string!(path = path.to_str().expect("utf8"));
        ffi::ModuleReader_readText(
            self.0.as_mut().expect("non-null"),
            &path,
            wasm.0.as_mut().expect("non-null"),
        );
    }
}
```

To work around the missing C++ const declaration
and present an idiomatic non-mut Rust receiver
will require using interior mutability, e.g.

```rust
pub struct ModuleReader(RefCell<cxx::UniquePtr<ffi::ModuleReader>>);
```

This would allow `ModuleReader` to present `&self` as it logically should,
by quietly mutably borrowing its interior value.
This imposes an extra flag check that should always succeed.
Of course the use of `RefCell` makes `ModuleReader` surprisingly
non-`Sync`.
To fix _that_ we could wrap the `RefCell` in a `Mutex`,
imposing another atomic flag check that should always succeed.


## `ParseException` doesn't implement `std::exception`

`cxx` can translate exceptions to Rust as long as they implement
`std::exception`, but `ParseException` does not.


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

#!/bin/bash

# replacing version numbers:
#     perl -p -i -e "s/0\.110\.0-beta\.1/0\.110\.0-beta\.2/g" components/*/*toml

set -x -e

# The rust min version we (and cxx) "support" can no longer resolve the crate
# graph correctly (it picks a once_cell that requires rust 2021), so we publish
# with the first version of rust that supported 2021.
RUST_MIN_VERSION=1.48.0
RUST_DEPLOY_VERSION=1.56.0

# This is just to make sure we've got the compiler.
rustc +$RUST_DEPLOY_VERSION --version

rm -rf ./components/wasm-opt-sys/binaryen

cp -r ./binaryen ./components/wasm-opt-sys/

# Make sure we don't publish this recursive submodule.
# Not needed by our build.
rm -rf ./components/wasm-opt-sys/binaryen/third_party/googletest

# Don't publish the large Binaryen test suite.
rm -r ./components/wasm-opt-sys/binaryen/test

# cargo +$RUST_DEPLOY_VERSION publish --manifest-path ./components/wasm-opt-sys/Cargo.toml --dry-run
# cargo +$RUST_DEPLOY_VERSION publish --manifest-path ./components/wasm-opt-cxx-sys/Cargo.toml --dry-run
# cargo +$RUST_DEPLOY_VERSION publish --manifest-path ./components/wasm-opt/Cargo.toml --dry-run


# --allow-dirty lets the binaryen source be shipped in its copied location

cargo +$RUST_DEPLOY_VERSION publish --manifest-path ./components/wasm-opt-sys/Cargo.toml --allow-dirty
echo waiting
sleep 10
cargo +$RUST_DEPLOY_VERSION publish --manifest-path ./components/wasm-opt-cxx-sys/Cargo.toml
echo waiting
sleep 10
cargo +$RUST_DEPLOY_VERSION publish --manifest-path ./components/wasm-opt/Cargo.toml

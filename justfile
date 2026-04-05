set shell := ["bash", "-cu"]

default:
    @just --list

dev:
    cargo run

check:
    cargo fmt --all -- --check
    cargo clippy --all-targets --all-features -- -D warnings
    cargo check --all-targets

test:
    cargo nextest run --all-features --no-tests=warn

ci:
    just check
    just test

fix:
    cargo fmt --all
    cargo clippy --all-targets --all-features --fix --allow-dirty --allow-staged -- -D warnings

watch:
    cargo watch -x check -x test

doctor:
    rustc --version
    cargo --version
    nix --version
    just --version

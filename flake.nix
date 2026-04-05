{
  description = "Rust + Nix vibe-coding harness template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs@{ flake-parts, systems, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;

      perSystem = { pkgs, self', ... }:
        let
          rustToolchain = with pkgs; [
            rustc
            cargo
            rustfmt
            clippy
            rust-analyzer
          ];
        in {
          formatter = pkgs.nixpkgs-fmt;

          packages.default = pkgs.rustPlatform.buildRustPackage {
            pname = "nix-rust-harness-template";
            version = "0.1.0";
            src = ./.;
            cargoLock = {
              lockFile = ./Cargo.lock;
            };
            meta = {
              description = "Rust + Nix vibe-coding harness template";
              mainProgram = "nix-rust-harness-template";
            };
          };

          apps.default = {
            type = "app";
            program = "${self'.packages.default}/bin/nix-rust-harness-template";
            meta = {
              description = "Run the Rust + Nix harness template sample binary";
            };
          };

          devShells.default = pkgs.mkShell {
            strictDeps = true;
            packages = rustToolchain ++ (with pkgs; [
              bacon
              cargo-nextest
              cargo-watch
              clang
              git
              jq
              just
              nil
              nixd
              nixpkgs-fmt
              pkg-config
            ]);

            RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";

            shellHook = ''
              export CARGO_TERM_COLOR=always
              export RUST_BACKTRACE=1
              echo "entered nix develop for nix-rust-harness-template"
            '';
          };
        };
    };
}

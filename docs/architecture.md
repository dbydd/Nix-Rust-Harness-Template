# Architecture

This template is organized into three layers.

## 1. Runtime layer

This layer makes the Rust project reproducible and executable.

- `flake.nix`
- `rust-toolchain.toml`
- `Cargo.toml`
- `src/`
- `justfile`
- `.github/workflows/`

## 2. Harness layer

This layer makes AI-assisted coding effective rather than ad hoc.

- `AGENTS.md`
- `.mcp.json`
- `.agent/skills/`
- `prompts/`

## 3. Project memory layer

This layer stores long-lived context that should survive sessions.

- `.planning/PROJECT.md`
- `.planning/REQUIREMENTS.md`
- `.planning/ROADMAP.md`
- `.planning/STATE.md`

The template intentionally favors explicit guidance over magical automation. The goal is predictable iteration.

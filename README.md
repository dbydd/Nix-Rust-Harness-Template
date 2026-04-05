# Nix Rust Harness Template

This template is a starting point for vibe-coding Rust projects on Nix.

It is designed around three goals:

1. Reproducible local development through Nix.
2. Fast AI-assisted iteration through explicit repo guidance.
3. Durable project memory so the agent does not restart from zero each session.

## What this template includes

- A Rust crate that builds under Nix.
- A Nix flake with a default development shell.
- A `justfile` with standard development commands.
- An `AGENTS.md` contract for repo-specific agent behavior.
- MCP configuration and prompt/skill scaffolding for tool-driven coding sessions.
- A `.planning/` directory for requirements, roadmap, state, and architectural memory.

## Quick start

1. Install Nix and enable flakes.
2. Install `direnv` and allow the repo.
3. Enter the repository and run:

```bash
direnv allow
just doctor
just check
just test
```

## Mental model

This repository is not only a Rust project template. It is a coding harness.
The runtime layer keeps the environment reproducible. The harness layer teaches the agent how to work. The planning layer preserves context across sessions.

## Important files

- `flake.nix`: environment, package, formatter
- `rust-toolchain.toml`: Rust version intent
- `justfile`: human and agent entrypoints
- `AGENTS.md`: repo rules for AI coding agents
- `.mcp.json`: tool contract for MCP-compatible clients
- `.planning/`: durable project memory
- `.agent/skills/`: reusable workflow guides
- `prompts/`: task starter prompts

## Included sample skills

- `rust-feature`: add focused Rust features without broad refactors
- `bugfix`: debug and fix issues with minimal churn
- `nix-maintenance`: change flake/dev-shell tooling with explicit validation
- `crate-discovery`: evaluate new crates with Cargo metadata and documentation checks

## Suggested first customizations

1. Rename the crate in `Cargo.toml`.
2. Update `AGENTS.md` with project-specific architectural rules.
3. Trim or extend `.mcp.json` to match your actual tool stack.
4. Replace the sample prompts and skills with your team's real workflows.

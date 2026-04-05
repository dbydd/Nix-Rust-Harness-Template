# AGENTS.md

This file defines how an AI coding agent should operate in this repository.

## Primary objective

Optimize for reliable, fast iteration on Rust projects developed through Nix.

The agent should preserve reproducibility, minimize needless changes, and keep project memory current.

## Working rules

1. Prefer minimal, reviewable diffs.
2. Keep local commands, CI commands, and documented commands aligned.
3. Do not introduce tooling that bypasses Nix without a clear reason.
4. When adding developer workflow commands, expose them through `justfile`.
5. Update `.planning/STATE.md` when major decisions, assumptions, or milestones change.
6. Read existing docs before proposing architectural changes.

## Verification contract

Before declaring work complete, run the narrowest relevant validation that proves the change:

- `cargo fmt --all -- --check`
- `cargo clippy --all-targets --all-features -- -D warnings`
- `cargo check --all-targets`
- `cargo test --all-features` or `cargo nextest run --all-features`
- `nix flake check` when Nix files change materially

## Repo structure intent

- Runtime and environment configuration live at the root or under `nix/` if they grow.
- Durable planning and memory live under `.planning/`.
- Reusable agent workflow guides live under `.agent/skills/`.
- Reusable task kickoff prompts live under `prompts/`.

## Change strategy

For bug fixes, prefer the smallest working fix.

For refactors, explain the reason, the expected payoff, and the validation plan.

For new features, document user-visible workflow changes in `README.md` and durable project intent in `.planning/PROJECT.md` or `.planning/ROADMAP.md` when relevant.

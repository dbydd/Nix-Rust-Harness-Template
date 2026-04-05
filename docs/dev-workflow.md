# Development Workflow

## Day 0

1. Install Nix and `direnv`.
2. Clone the repository.
3. Run `direnv allow`.
4. Run `just doctor`.

## Day 1

1. Read `AGENTS.md` and `README.md`.
2. Review `.planning/PROJECT.md` and `.planning/ROADMAP.md`.
3. Implement changes through `just check` and `just test` loops.

## Ongoing workflow

- Use `just dev` for the default local run path.
- Use `just watch` during rapid iteration.
- Keep documentation and planning artifacts current when intent changes.

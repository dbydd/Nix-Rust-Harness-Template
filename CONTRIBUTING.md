# Contributing

## Development Setup

1. Install Nix and enable flakes.
2. Install `direnv` and allow the repo.
3. Run `direnv allow`.
4. Run `just doctor` to verify environment.
5. (Optional) Run `nix flake check` to verify flake evaluation.

## Development Workflow

- Use `just dev` for the default local run path.
- Use `just watch` during rapid iteration.
- Keep documentation and planning artifacts current when intent changes.

## Code Style

We use `rustfmt` and `clippy` for code quality:

```bash
just check  # Runs fmt --check and clippy with -D warnings
```

Please ensure both pass before submitting PRs.

## Commit Format

We follow [conventional commits](https://www.conventionalcommits.org/) for clear history and changelog generation:

- `feat: add feature X`
- `fix: correct bug in Y`
- `docs: update Z documentation`
- `refactor: simplify W`
- `test: add coverage for V`

## Pull Request Process

1. **Draft PRs welcome:** Use GitHub's Draft PR mechanism for work in progress.
2. **Describe changes:** List what changed and why in the PR description.
3. **Link issues:** Use "Closes #123" or "Fixes #456" to auto-close related issues.
4. **Run verification:** Ensure `just check` and `just test` pass locally.
5. **Request review:** CI must pass before merge.

## Release Workflow

Releases follow [semantic versioning](https://semver.org/):

1. Update `Cargo.toml` version.
2. Ensure CI passes: `nix develop --command just ci`.
3. Tag the release: `git tag v0.1.0`.
4. Push the tag: `git push --tags`.
5. CI publishes artifacts automatically.

## Code of Conduct

We are all living beings, and what is most important is that we respect each other and work together. If you cannot uphold this simple standard, then your contributions are not welcome.
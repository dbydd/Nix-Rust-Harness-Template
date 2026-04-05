# Prompt: Add a feature

Implement a new feature in this repository.

Before editing, read `AGENTS.md`, `README.md`, and `.planning/PROJECT.md` for project context.

Then:

1. Summarize the feature boundary: what it does and why.
2. Identify the narrowest module that can own the change.
3. Implement the smallest complete version with tests.
4. Run verification: `just check && just test`.
5. Update documentation if workflow changed.

**Workflow guidance:** See `.agent/skills/rust-feature.md` for the full feature workflow with verification checklist.

**Planning context:** If this feature changes project intent, update `.planning/STATE.md`.
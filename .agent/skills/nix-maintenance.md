# Nix Maintenance Skill

Use this workflow when changing Nix environment, flake outputs, or shell tooling.

## Goals

- Keep `flake.nix`, `flake.lock`, dev shell behavior, and CI in sync.
- Make Nix changes reviewable and reproducible.
- Prove that both flake evaluation and repo entrypoints still work after the change.
- Use concrete command sequences with pass/fail criteria—not vague advice.

## Workflow

### Before Editing

1. Read the current state:
   ```bash
   cat flake.nix      # Understand current outputs and inputs
   cat flake.lock     # Check current input versions
   cat justfile       # Understand repo entrypoints
   ```
   Know what each output does before changing it.

### After Editing

2. **Step 1: Validate flake evaluation**
   ```bash
   nix flake check
   ```
   **Must:** Exit with code 0 (no evaluation errors)

   **What this checks:**
   - Flake evaluates correctly
   - All outputs are valid
   - No circular dependencies

3. **Step 2: Validate dev shell from inside**
   ```bash
   nix develop --command bash -lc 'just check && just test && just ci'
   ```
   **Must:** All commands complete without error

   **What this proves:**
   - Dev shell provides all required tools
   - Repo commands work in the Nix environment
   - CI workflow is reproducible locally

4. **Step 3: Review lock file changes**
   ```bash
   git diff flake.lock
   ```
   **Must:** Intentional dependency changes only

   **What to check:**
   - Input hashes changed for intentional updates
   - No surprise transitive dependency bumps
   - Lock file matches flake.nix edits

### When to Run Which Validation

| Change Type | `nix flake check` | `nix develop --command` |
|-------------|-------------------|-------------------------|
| flake.nix edit | ✓ Always | ✓ Always |
| flake.lock update | ✓ Always | ✓ If inputs changed |
| Dev shell tooling | ✓ Always | ✓ Always |
| Output names | ✓ Always | ✗ Optional |
| Comments/formatting | ✗ Optional | ✗ Optional |

## Verification Checklist

After any meaningful Nix change:

- [ ] `nix flake check` exits with code 0
- [ ] `nix develop --command bash -lc 'just check && just test && just ci'` completes without error
- [ ] `git diff flake.lock` shows only intentional changes
- [ ] README documented new commands or tools (if workflow changed)
- [ ] `.planning/STATE.md` updated (if workflow expectations changed)

## Guardrails

- Do not add duplicate ways to run the same workflow without a clear need.
- Do not bypass Nix for convenience unless the project explicitly wants that tradeoff.
- Do not update Nix inputs casually; keep dependency movement intentional and reviewable.
- Do not change shell tooling without checking whether README and CI still describe the repo accurately.
- Do not skip `nix flake check` after flake.nix edits.
- Do not assume evaluation success means dev shell works—validate from inside `nix develop`.
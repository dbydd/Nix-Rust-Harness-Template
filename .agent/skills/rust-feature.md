# Rust Feature Skill

Use this workflow when adding a new Rust feature.

## Goals

- Keep the feature small and testable.
- Preserve crate structure clarity.
- Add validation with the feature, not later.
- Maintain code quality boundaries.
- Document intent changes when workflow changes.

## Workflow

### Before Implementation

1. **Define the feature boundary:**
   ```bash
   # List the files you expect to touch
   git diff --stat main...HEAD
   ```
   **What this checks:**
   - Feature scope is understood before coding
   - Related modules identified

   **Must:** Feature boundary documentedscope is deliberate

2. **Identify existing patterns:**
   ```bash
   rg -l "similar_functionality" src/
   ```
   **What this checks:**
   - No duplicate implementation exists
   - Extension points are clear

   **Expected:** Empty output means new module may be needed

### Implementation Phase

3. **Implement the smallest complete version:**
   ```bash
   cargo check --all-targets
   ```
   **Must:** Exit with code 0

   **What this proves:**
   - Feature compiles without errors
   - All targets build correctly

4. **Add or update tests:**
   ```bash
   cargo nextest run --all-features
   ```
   **Must:** All tests pass

   **What this proves:**
   - Feature has test coverage
   - No regressions introduced

### Verification Phase

5. **Run the verification contract:**
   ```bash
   just check && just test
   ```
   **Must:** Both commands complete without error

   **What this proves:**
   - Formatting is correct (`cargo fmt --check`)
   - No clippy warnings (`cargo clippy -- -D warnings`)
   - All tests pass

## Feature Checklist

Before submitting a feature:

### Scope
- [ ] Feature boundary is clearly defined
- [ ] No unrelated refactors mixed in
- [ ] Narrowest module boundary owns the change

### Testing
- [ ] Tests added for new functionality
- [ ] Tests added for edge cases
- [ ] Existing tests still pass

### Quality
- [ ] `just check` passes
- [ ] `just test` passes
- [ ] No new clippy warnings introduced
- [ ] Code follows existing patterns

### Documentation
- [ ] Public API documented
- [ ] README updated if workflow changed
- [ ] `.planning/STATE.md` updated if intent changed

## Guardrails

- Do not mix unrelated refactors with the feature.
- Do not weaken lint rules to make the change pass.
- Do not skip tests for new public interfaces.
- Do not add dependencies without crate-discovery skill evaluation.
- Do not change module structure without documenting rationale.
- Do not bypass the verification contract.
# Bugfix Skill

Use this workflow for debugging and fixing broken behavior.

## Goals

- Fix root causes, not symptoms.
- Add regression tests when practical.
- Preserve minimal change footprint.
- Maintain code quality under pressure.

## Workflow

### Reproduction Phase

1. **Reproduce the issue:**
   ```bash
   cargo test <test_name>
   ```
   **Must:** Issue reproduces consistently

   **What this proves:**
   - Bug is real, not intermittent
   - You have a test case to validate fix

2. **Document expected vs actual behavior:**
   ```bash
   cargo test <test_name> --nocapture
   ```
   **What this checks:**
   - Clear understanding of the gap
   - Test case captures the bug

### Investigation Phase

3. **Identify the smallest plausible root cause:**
   ```bash
   RUST_BACKTRACE=1 cargo test <test_name> -- --nocapture
   ```
   **What this checks:**
   - Error location identified
   - Call stack understood

4. **Verify root cause with minimal fix candidate:**
   ```bash
   git diff
   ```
   **What this checks:**
   - Change addresses cause, not symptom
   - Diff is minimal and focused

### Fix Phase

5. **Apply the fix:**
   ```bash
   cargo check --all-targets
   ```
   **Must:** Exit with code 0

   **What this proves:**
   - Fix compiles correctly
   - No new errors introduced

6. **Verify fix with narrow test:**
   ```bash
   cargo test <test_name>
   ```
   **Must:** Test passes

   **What this proves:**
   - Bug is fixed
   - Regression test validates

7. **Run full verification:**
   ```bash
   just check && just test
   ```
   **Must:** Both commands complete without error

   **What this proves:**
   - Fix doesn't break other code
   - Quality bar maintained

## Bugfix Checklist

Before submitting a fix:

### Investigation
- [ ] Issue reproduced consistently
- [ ] Root cause identified (not just symptom)
- [ ] Root cause documented in commit message

### Fix Quality
- [ ] Change is minimal (smallest plausible fix)
- [ ] Change addresses root cause
- [ ] No opportunistic refactors included
- [ ] `just check` passes
- [ ] `just test` passes

### Testing
- [ ] Regression test added (when practical)
- [ ] Regression test would have caught the bug
- [ ] Existing tests still pass

### Documentation
- [ ] Fix explained in commit message
- [ ] Related issue linked (if applicable)

## Guardrails

- Avoid opportunistic refactors during a bugfix.
- Do not remove failing tests to make CI pass.
- Do not mask symptoms—fix root causes.
- Do not expand scope—keep fix minimal.
- Do not skip reproduction step—verify the bug is real.
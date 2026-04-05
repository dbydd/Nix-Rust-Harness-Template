# Phase 3: Team workflow refinement - Research

**Researched:** 2026-04-05
**Domain:** Team collaboration assets, workflow documentation, release automation
**Confidence:** HIGH

## Summary

This phase focuses on polishing the team-facing workflow layer by expanding lightweight skills to match the depth and specificity of mature skills, tailoring prompts to real usage, and adding release and contribution workflow documentation. The polished skills (`crate-discovery.md`, `nix-maintenance.md`) demonstrate a clear pattern: phased workflows, explicit commands with pass/fail criteria, evaluation checklists, and concrete guardrails. The lightweight skills (`rust-feature.md`, `bugfix.md`) and prompts (`add-feature.md`, `debug-failure.md`) need expansion following this proven template pattern.

**Primary recommendation:** Expand skills and prompts using the phased workflow, concrete commands, and checklist patterns established in `crate-discovery.md` and `nix-maintenance.md`, and create release/contribution workflow documentation following proven open-source patterns.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- **D-01:** Phase 3 should make the harness internally consistent by promoting lightweight skills and sample prompts into team-ready assets rather than leaving them as stubs.
- **D-02:** `rust-feature.md` and `bugfix.md` should be expanded to a similar practical depth and specificity as `crate-discovery.md` and `nix-maintenance.md`.
- **D-03:** Existing prompts should be tailored to real usage patterns instead of remaining generic placeholder text.
- **D-04:** Prompts should remain concise task entrypoints, not full duplicated workflows.
- **D-05:** Skills and planning docs remain the source of truth for detailed workflow guidance; prompts should explicitly point to them.

### the agent's Discretion
- Exact section layout and wording for the refined prompts and expanded skills
- Whether prompt wording should emphasize solo developer use, team collaboration, or both, as long as prompts remain concise entrypoints

### Deferred Ideas (OUT OF SCOPE)
- Exact release workflow design remains to be discussed in this phase
- Exact contribution workflow design remains to be discussed in this phase
- Optional CLI/library/service template profiles remain deferred from Phase 2 and are not part of this phase
</user_constraints>

## Standard Stack

### Core Workflow Assets
| Asset | Purpose | Current State | Target State |
|-------|---------|---------------|--------------|
| `.agent/skills/rust-feature.md` | Rust feature workflow | Lightweight (~22 lines) | Polished (~80+ lines) |
| `.agent/skills/bugfix.md` | Bug fix workflow | Lightweight (~16 lines) | Polished (~80+ lines) |
| `prompts/add-feature.md` | Feature kickoff | Placeholder (~13 lines) | Tailored (~20 lines) |
| `prompts/debug-failure.md` | Debug kickoff | Placeholder (~11 lines) | Tailored (~18 lines) |
| `CONTRIBUTING.md` | Contribution guide | Does not exist | Create |
| `.github/PULL_REQUEST_TEMPLATE.md` | PR template | Does not exist | Create |

### Supporting Tools
| Tool | Version | Purpose | When to Use |
|------|---------|---------|-------------|
| `cargo-release` | 0.25+ | Automated crate releases | Version bumping, publishing |
| `git-cliff` | 2.4+ | Changelog generation | Pre-release hook |
| Conventional commits | N/A | Commit message format | PR history, changelog consistency |

## Architecture Patterns

### Polished Skill Structure (from crate-discovery.md, nix-maintenance.md)

**Verified pattern** from existing polished skills:

```markdown
# [Skill Name]

Use this workflow when [trigger condition].

## Goals

- [Goal 1]
- [Goal 2]
- [Goal 3]

## Workflow

### [Phase Name]

1. [Action with command]:
   ```bash
   command
   ```
   **What this checks/proves:**
   - [Verification criteria]

### [Next Phase]

[Continue with numbered steps]

## [Evaluation/Verification] Checklist

Before [completing action]:

### [Category]
- [ ] [Checklist item]
- [ ] [Checklist item with command]

## Guardrails

- Do not [anti-pattern 1].
- Do not [anti-pattern 2].
```

**Key characteristics:**
- Goals section with 3-5 specific objectives
- Phased workflow with numbered steps and sub-steps
- Concrete commands with expected outputs
- "**What this checks/proves:**" annotations
- Checklist sections with checkboxes
- Negative guardrails ("Do not...")
- Explicit pass/fail criteria

### Lightweight Skill Pattern (current rust-feature.md, bugfix.md)

**Current structure** (insufficient):

```markdown
# [Skill Name]

Use this workflow when [trigger condition].

## Goals

- [Goal 1]
- [Goal 2]

## Workflow

1. [Step without detail]
2. [Step without command]
3. [Step without verification]

## Guardrails

- Do not [single guardrail].
```

**Missing elements:**
- Phased workflow structure
- Concrete commands
- Verification criteria
- Evaluation checklists

### Prompt Structure (Target: D-04, D-05)

**Pattern** (concise entrance pointing to skills/planning):

```markdown
# Prompt: [Action Name]

[One-line purpose statement].

Before editing, read [project context references].

Then:

1. [High-level step 1]
2. [High-level step 2]
3. [High-level step 3 with skill reference]: See `.agent/skills/[skill].md` for workflow.

[Reference to planning docs if applicable]
```

**Pattern source:** D-04 requires prompts remain concise entrypoints, D-05 requires prompts point to skills/planning docs.

### Release Workflow Pattern

**Reference:** Trunk project CONTRIBUTING.md (HIGH confidence)

```markdown
## Release Workflow

We follow [semver](https://semver.org/) for versioning.

- [ ] Update `Cargo.toml` `version` & execute `cargo update`
- [ ] Ensure CI completes successfully
- [ ] Add a new tag to the repo matching the new version
- [ ] Verify release artifacts published
```

**Tool integration (cargo-release):**
```toml
# release.toml
pre-release-hook = ["git", "cliff", "-o", "CHANGELOG.md", "--tag", "{{version}}"]
pre-release-replacements = [
  {file="CHANGELOG.md", search="Unreleased", replace="{{version}}"},
  {file="CHANGELOG.md", search="ReleaseDate", replace="{{date}}"},
]
```

### Contribution Workflow Pattern

**Reference:** Gitmore PR template guide (HIGH confidence)

**Essential sections for CONTRIBUTING.md:**

1. **Code of conduct reference** - Respect and collaboration standard
2. **Development setup** - Prerequisites and first-time setup
3. **Linting/formatting** - Run `cargo fmt`, `cargo clippy` before PR
4. **Commit format** - Conventional commits for changelog generation
5. **PR process** - Draft PRs, describe changes, link issues
6. **Release process** - How releases are tagged and published

**PR template structure:**

```markdown
## Description

<!-- What changed and why -->

## Type of Change

- [ ] New feature
- [ ] Bug fix
- [ ] Refactoring
- [ ] Documentation
- [ ] Infrastructure

## Changes Made

- [Specific change 1]
- [Specific change 2]

## How to Test

1. [Step 1]
2. [Step 2]

## Checklist

- [ ] Code follows style guidelines
- [ ] Self-reviewed code
- [ ] Tests added/updated
- [ ] Existing tests pass (`just test`)
- [ ] Lints pass (`just check`)
- [ ] Documentation updated

## Related Issues

<!-- Closes #123, Fixes #456 -->
```

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Version bumping automation | Custom scripts | `cargo-release` | Handles version, tag, publish in one workflow |
| Changelog generation | Manual editing | `git-cliff` | Parses conventional commits, generates structured changelog |
| PR templates | Ad-hoc descriptions | GitHub PR template files | Auto-populates PR description, ensures consistency |
| Skill structure improvisation | Generic advice | Follow polished skill patterns | Proven structure: goals, workflow phases, checklists, guardrails |

**Key insight:** The template already has proven patterns in `crate-discovery.md` and `nix-maintenance.md`. Replicate their structure rather than inventing new patterns.

## Common Pitfalls

### Pitfall 1: Expanding prompts into full workflows

**What goes wrong:** Prompts become long, duplicated skill documents, violating D-04 and D-05.

**Why it happens:** Without clear guidance, prompts naturally grow to include all workflow details.

**How to avoid:** Each prompt should:
1. State the one-line purpose
2. List 3-5 high-level steps
3. **Explicitly point to skills/planning docs** for detailed workflows
4. Stay under 25 lines

**Warning signs:**
- Prompt exceeds 30 lines
- Prompt includes detailed commands (belongs in skill)
- Prompt duplicates content from `.agent/skills/` or `.planning/`

### Pitfall 2: Adding release workflow without aligning to CI

**What goes wrong:** Release documentation references commands that don't exist in `justfile` or conflict with `.github/workflows/ci.yml`.

**Why it happens:** Phase 2 enhanced CI but release planning was deferred.

**How to avoid:**
1. Check `justfile` for available commands before documenting workflows
2. Align release steps with CI verification (`just ci` runs check + test)
3. Reference existing `nix develop --command just ci` pattern from Nix maintenance skill

**Warning signs:**
- Release docs reference commands not in `justfile`
- Documentation contradicts CI workflow behavior

### Pitfall 3: Generic skill expansion without concrete verification

**What goes wrong:** Expanded skills add content but no actionable verification steps.

**Why it happens:** It's easy to add advice without specific commands and pass/fail criteria.

**How to avoid:** Every workflow step should include:
- A concrete command (when applicable)
- "**What this checks/proves:**" annotation
- Pass/fail criteria

**Reference:** Compare current `bugfix.md` to target pattern — need to add verification commands, not just advice.

### Pitfall 4: Inconsistent guardrail style

**What goes wrong:** New skills use different guardrail formats than existing polished skills.

**Why it happens:** Without cross-checking, new skills adopt inconsistent phrasing.

**How to avoid:** Use "Do not [action]. [Reason]" format consistently across all skills.

**Pattern from crate-discovery.md:**
- "Do not add a new crate before checking..."
- "Do not pick a crate by download counts alone..."
- "Do not recommend crates with unclear licensing..."
- "Do not skip documentation lookup..."
- "Do not assume MIT/Apache..."

## Code Examples

### Polished Skill Pattern Example (nix-maintenance.md)

```markdown
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

### When to Run Which Validation

| Change Type | `nix flake check` | `nix develop --command` |
|-------------|-------------------|-------------------------|
| flake.nix edit | ✓ Always | ✓ Always |
| flake.lock update | ✓ Always | ✓ If inputs changed |
```

### Expanded rust-feature.md Target Pattern

```markdown
# Rust Feature Skill

Use this workflow when adding a new Rust feature.

## Goals

- Keep the feature small and testable.
- Preserve crate structure clarity.
- Add validation with the feature, not later.
- Maintain code quality boundaries.

## Workflow

### Before Implementation

1. Define the feature boundary:
   ```bash
   # List the files you expect to touch
   git diff --stat main...HEAD
   ```
   **What this checks:**
   - Feature scope is understood before coding
   - Related modules identified

2. Identify existing patterns:
   ```bash
   rg -l "similar_functionality" src/
   ```
   **What this checks:**
   - No duplicate implementation exists
   - Extension points are clear

### Implementation Phase

3. Implement the smallest complete version:
   ```bash
   # Focus on core functionality first
   cargo check --all-targets
   ```
   **Must:** Exit with code 0

   **What this proves:**
   - Feature compiles without errors
   - All targets build correctly

4. Add or update tests:
   ```bash
   cargo nextest run --all-features
   ```
   **Must:** All tests pass

   **What this proves:**
   - Feature has test coverage
   - No regressions introduced

### Verification Phase

5. Run the verification contract:
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
```

### Expanded bugfix.md Target Pattern

```markdown
# Bugfix Skill

Use this workflow for debugging and fixing broken behavior.

## Goals

- Fix root causes, not symptoms.
- Add regression tests when practical.
- Preserve minimal change footprint.
- Maintain code quality under pressure.

## Workflow

### Reproduction Phase

1. Reproduce the issue:
   ```bash
   # Run the failing command or test
   cargo test <test_name>
   ```
   **Must:** Issue reproduces consistently

   **What this proves:**
   - Bug is real, not intermittent
   - You have a test case to validate fix

2. Document the expected vs actual behavior:
   ```bash
   # Add a focused replication test
   cargo test <test_name> --nocapture
   ```
   **What this checks:**
   - Clear understanding of the gap
   - Test case captures the bug

### Investigation Phase

3. Identify the smallest plausible root cause:
   ```bash
   # Trace execution
   RUST_BACKTRACE=1 cargo test <test_name> -- --nocapture
   ```
   **What this checks:**
   - Error location identified
   - Call stack understood

4. Verify root cause:
   ```bash
   # Apply minimal fix candidate
   git diff
   ```
   **What this checks:**
   - Change addresses cause, not symptom
   - Diff is minimal and focused

### Fix Phase

5. Apply the fix:
   ```bash
   cargo check --all-targets
   ```
   **Must:** Exit with code 0

   **What this proves:**
   - Fix compiles correctly
   - No new errors introduced

6. Verify fix with narrow test:
   ```bash
   cargo test <test_name>
   ```
   **Must:** Test passes

   **What this proves:**
   - Bug is fixed
   - Regression test validates

7. Run full verification:
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
```

### CONTRIBUTING.md Pattern

```markdown
# Contributing

## Development Setup

1. Install Nix and enable flakes.
2. Install `direnv` and allow the repo.
3. Run `direnv allow`.
4. Run `just doctor` to verify environment.

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
```

### Tailored Prompt Example (add-feature.md)

```markdown
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
```

### Tailored Prompt Example (debug-failure.md)

```markdown
# Prompt: Debug a failure

Investigate a failing command, test, or CI job in this repository.

Before changing code, reproduce the issue:

1. Run the failing command or test locally.
2. Capture the error message and backtrace.
3. Identify the smallest plausible root cause.
4. Apply a minimal fix that addresses the root cause.
5. Run verification: `just check && just test`.

**Workflow guidance:** See `.agent/skills/bugfix.md` for the full debugging workflow with checklist.

**Quality bar:** Do not remove failing tests. Fix root causes, not symptoms.
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Generic skill stubs | Phased workflow with concrete commands | Phase 2 (crate-discovery, nix-maintenance) | Higher command confidence, explicit pass/fail criteria |
| Placeholder prompts | Concise entrance pointing to skills | Phase 3 target | Prompts remain lightweight, skills remain authoritative |
| No release docs | CONTRIBUTING.md with release workflow | Trunk project pattern | Team clarity on versioning and tagging |
| No PR structure | PR template with checklist | Gitmore best practices | Consistent PR descriptions, faster reviews |

**Deprecated/outdated:**
- Skills without concrete commands (need expansion)
- Prompts that duplicate skill content (need trimming and pointing)
- Ad-hoc contribution instructions (need structured CONTRIBUTING.md)

## Open Questions

1. **Release workflow tooling integration**
   - What we know: `cargo-release` and `git-cliff` are standard for Rust (HIGH confidence)
   - What's unclear: Whether to add `release.toml` configuration now or document manual release steps
   - Recommendation: Document manual release steps in CONTRIBUTING.md now, consider tooling automation post-phase

2. **Issue template needs**
   - What we know: PR templates have clear value (Gitmore research shows 30%+ merge rate improvement)
   - What's unclear: Whether bug report and feature request templates are needed
   - Recommendation: Start with PR template only, add issue templates if Phase 3 planning identifies team need

## Environment Availability

| Dependency | Required By | Available | Version | Fallback |
|------------|------------|-----------|---------|----------|
| Nix | Dev environment | ✓ | Verified by CI | — |
| `just` | Task runner | ✓ | Verified by CI | — |
| `cargo` | Rust build | ✓ | Via Nix dev shell | — |
| `cargo-release` | Release automation | Optional | Not installed | Manual release steps |
| `git-cliff` | Changelog generation | Optional | Not installed | Manual changelog editing |

**Missing dependencies with no fallback:**
- None (release tooling is optional)

**Missing dependencies with fallback:**
- `cargo-release`: Use manual version bump and git tag workflow
- `git-cliff`: Manually edit CHANGELOG.md

## Validation Architecture

Step 2.6: Environment Availability Audit was performed—no blocking dependencies. Release tooling is optional and can be handled manually.

**Test Framework:**
| Property | Value |
|----------|-------|
| Framework | cargo-nextest (via just test) |
| Config file | None — uses Cargo.toml test config |
| Quick run command | `just check && just test` |
| Full suite command | `nix develop --command just ci` |

**Phase Requirements → Test Map:**

Since no explicit requirement IDs were provided for this phase, validation focuses on verifying documentation changes and skill functionality:

| Validation Target | Test Type | Automated Command | Manual Check |
|-------------------|-----------|-------------------|--------------|
| Expanded skills | Manual | — | Verify structure matches polished patterns |
| Tailored prompts | Manual | — | Verify prompts point to skills/planning |
| CONTRIBUTING.md | Manual | — | Verify setup steps match justfile |
| PR template | Manual | — | Verify checklist items match verification contract |

**Sampling Rate:**
- **Per task commit:** Review changed skill/prompt structure
- **Per wave merge:** Verify all documentation links resolve
- **Phase gate:** Confirm expanded skills follow crate-discovery/nix-maintenance patterns

**Wave 0 Gaps:**
None — this phase is documentation-focused without automated test requirements.

## Sources

### Primary (HIGH confidence)
- Context7 cargo-release docs - release workflow commands and version bumping
- Trunk project CONTRIBUTING.md - Rust release workflow pattern
- Gitmore PR template guide - PR template structure and benefits
- Existing polished skills (`crate-discovery.md`, `nix-maintenance.md`) - Proven pattern structure

### Secondary (MEDIUM confidence)
- GitHub conventional commits guidance - Commit message format
- Web search for release-plz - Alternative release automation tool (not chosen)

### Tertiary (LOW confidence)
- None — all findings verified with primary sources

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH - All assets exist in template or have clear patterns to follow
- Architecture: HIGH - Polished skill pattern is verified from existing files
- Pitfalls: HIGH - Pitfalls derived from analysis of current vs target state

**Research date:** 2026-04-05
**Valid until:** 30 days (stable documentation patterns, tooling versions may evolve)
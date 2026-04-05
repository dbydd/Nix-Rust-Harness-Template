---
phase: 03
slug: team-workflow-refinement
status: draft
nyquist_compliant: true
wave_0_complete: true
created: 2026-04-05
---

# Phase 03 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | manual documentation review + repository verification commands |
| **Config file** | none — this phase refines skills, prompts, and workflow docs |
| **Quick run command** | `nix develop --command bash -lc 'just check && just test'` |
| **Full suite command** | `nix develop --command bash -lc 'just ci && nix flake check'` |
| **Estimated runtime** | ~30 seconds |

---

## Sampling Rate

- **After every task commit:** Re-read changed prompts/skills/docs and run the quick command when workflow-facing files change
- **After every plan wave:** Run `nix develop --command bash -lc 'just ci && nix flake check'`
- **Before `/gsd-verify-work`:** Full suite must be green and documentation links must resolve
- **Max feedback latency:** 60 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 03-01-01 | 01 | 1 | D-01 to D-03 | docs review | `grep -n "## Goals\|## Workflow\|## Guardrails" .agent/skills/rust-feature.md .agent/skills/bugfix.md` | ✅ | ⬜ pending |
| 03-01-02 | 01 | 1 | D-04 to D-05 | docs review | `grep -n "\.agent/skills/\|\.planning/" prompts/add-feature.md prompts/debug-failure.md` | ✅ | ⬜ pending |
| 03-02-01 | 02 | 1 | release workflow | docs review | `test -f CONTRIBUTING.md && grep -n "release\|just ci\|version" CONTRIBUTING.md` | ❌ W0 | ⬜ pending |
| 03-02-02 | 02 | 1 | contribution workflow | docs review | `test -f .github/PULL_REQUEST_TEMPLATE.md && grep -n "Checklist\|How to Test\|Description" .github/PULL_REQUEST_TEMPLATE.md` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [x] Existing repository verification commands cover workflow validation.
- [ ] `CONTRIBUTING.md` — contribution and release workflow guidance to be added in execution.
- [ ] `.github/PULL_REQUEST_TEMPLATE.md` — pull request checklist template to be added in execution.

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Expanded skills match polished pattern quality | D-01 to D-03 | Documentation quality and workflow usefulness are not fully asserted by grep alone | Read `rust-feature.md` and `bugfix.md` end-to-end and confirm they now resemble the structure and specificity of `crate-discovery.md` and `nix-maintenance.md`. |
| Prompts remain concise entrypoints | D-04 to D-05 | Requires judgment about duplication and ergonomics | Read `prompts/add-feature.md` and `prompts/debug-failure.md` and confirm they stay short, point to skills/planning docs, and do not duplicate full workflows. |
| Contribution and release docs align with repo reality | team workflow refinement | Needs human comparison against repo commands and CI semantics | Read `CONTRIBUTING.md`, `.github/PULL_REQUEST_TEMPLATE.md`, `justfile`, and `.github/workflows/ci.yml` together and confirm the documented commands and expectations match the actual repo contract. |

---

## Validation Sign-Off

- [x] All tasks have automated verification or explicit manual review guidance.
- [x] Sampling continuity is preserved through per-wave full-suite validation.
- [x] Wave 0 covers all missing documentation artifacts required by this phase.
- [x] No watch-mode flags.
- [x] Feedback latency < 60s.
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** approved 2026-04-05

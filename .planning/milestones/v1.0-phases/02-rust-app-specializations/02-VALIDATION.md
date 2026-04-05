---
phase: 02
slug: rust-app-specializations
status: draft
nyquist_compliant: true
wave_0_complete: true
created: 2026-04-05
---

# Phase 02 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | manual skill/documentation review + repository verification commands |
| **Config file** | none — this phase updates Markdown skill files and planning artifacts |
| **Quick run command** | `nix develop --command bash -lc 'just check && just test'` |
| **Full suite command** | `nix develop --command bash -lc 'just ci && nix flake check'` |
| **Estimated runtime** | ~30 seconds |

---

## Sampling Rate

- **After every task commit:** Re-read changed skill/planning files and run the quick command when workflow commands changed.
- **After every plan wave:** Run `nix develop --command bash -lc 'just ci && nix flake check'`.
- **Before `/gsd-verify-work`:** Full suite must be green and the skill text must remain actionable.
- **Max feedback latency:** 60 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 02-01-01 | 01 | 1 | D-02 to D-04 | docs review | `grep -n "cargo search\|cargo info\|Context7" .agent/skills/crate-discovery.md` | ✅ | ⬜ pending |
| 02-01-02 | 01 | 1 | D-05 to D-06 | docs review | `grep -n "nix flake check\|nix develop --command" .agent/skills/nix-maintenance.md` | ✅ | ⬜ pending |
| 02-02-01 | 02 | 1 | D-07 | workflow verification | `nix develop --command bash -lc 'just ci && nix flake check'` | ✅ | ⬜ pending |
| 02-02-02 | 02 | 1 | Phase 2 planning memory | docs review | `test -f .planning/phases/02-rust-app-specializations/02-CONTEXT.md && test -f .planning/phases/02-rust-app-specializations/02-RESEARCH.md && test -f .planning/phases/02-rust-app-specializations/02-VALIDATION.md` | ✅ | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [x] Existing repository verification commands cover workflow validation.
- [x] Existing planning directory structure covers the required artifacts.

*Existing infrastructure covers all phase requirements.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Skill clarity and usefulness | D-02 to D-06 | Documentation quality cannot be fully asserted by automated commands | Read each skill file end-to-end and confirm a developer can execute the workflow without guessing next steps. |
| Scope discipline | D-07 | Requires judgment about whether plans accidentally expand into full template profiles too early | Review plan objectives and ensure they strengthen harness workflows rather than generating full CLI/library/service scaffolds. |

---

## Validation Sign-Off

- [x] All tasks have automated verification or explicit manual review guidance.
- [x] Sampling continuity is preserved through per-wave full-suite validation.
- [x] Wave 0 covers all required verification infrastructure.
- [x] No watch-mode flags.
- [x] Feedback latency < 60s.
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** approved 2026-04-05

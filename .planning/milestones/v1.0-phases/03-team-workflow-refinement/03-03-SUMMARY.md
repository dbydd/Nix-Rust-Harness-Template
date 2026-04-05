---
phase: 03-team-workflow-refinement
plan: 03
subsystem: workflow
tags: [prompts, skills, documentation, developer-experience]

# Dependency graph
requires:
  - phase: 03-01
    provides: Expanded rust-feature and bugfix skills for reference
provides:
  - Tailored add-feature.md prompt entrypoint
  - Tailored debug-failure.md prompt entrypoint
affects: [developer-experience, team-onboarding]

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "Prompts as concise entrypoints pointing to skills"
    - "Skill references for detailed workflows"
    - "Planning context references for project state"

key-files:
  created: []
  modified:
    - prompts/add-feature.md
    - prompts/debug-failure.md

key-decisions:
  - "Prompts remain under 20 lines (concise entrypoints per D-04)"
  - "Explicit skill references replace generic placeholder text"
  - "Verification commands (just check && just test) included in prompts"

patterns-established:
  - "Prompt structure: purpose → context refs → steps → skill ref → planning ref"

requirements-completed: [D-01, D-03, D-04, D-05]

# Metrics
duration: 5min
completed: 2026-04-05
---

# Phase 3 Plan 3: Tailored Prompts Summary

**Replaced generic placeholder prompts with concise, actionable entrypoints pointing to expanded skills for detailed workflows.**

## Performance

- **Duration:** 5 min
- **Started:** 2026-04-05T09:07:25Z
- **Completed:** 2026-04-05T09:12:00Z
- **Tasks:** 2
- **Files modified:** 2

## Accomplishments

- Tailored `add-feature.md` from 13-line placeholder to 16-line actionable prompt with skill reference
- Tailored `debug-failure.md` from 11-line placeholder to 14-line actionable prompt with skill reference
- Both prompts now explicitly point to `.agent/skills/` for detailed workflows
- Both prompts include concrete verification commands (`just check && just test`)
- Planning context references added for project state management

## Task Commits

**Note:** This repository is not currently a git repository. Work was completed on the filesystem without commits.

1. **Task 1: Tailor add-feature.md prompt** - filesystem change
2. **Task 2: Tailor debug-failure.md prompt** - filesystem change

## Files Created/Modified

- `prompts/add-feature.md` - Tailored from generic placeholder to concise entrypoint (16 lines)
  - Added skill reference: `.agent/skills/rust-feature.md`
  - Added planning context reference: `.planning/PROJECT.md` and `.planning/STATE.md`
  - Added verification command: `just check && just test`
  
- `prompts/debug-failure.md` - Tailored from generic placeholder to concise entrypoint (14 lines)
  - Added skill reference: `.agent/skills/bugfix.md`
  - Added quality bar: "Do not remove failing tests. Fix root causes, not symptoms."
  - Added verification command: `just check && just test`

## Decisions Made

None - followed plan as specified. Both prompts follow the target pattern from RESEARCH.md exactly.

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Verification Results

All automated verifications passed:

```
Prompt line counts:
- add-feature.md: 16 lines (max 25) ✓
- debug-failure.md: 14 lines (max 20) ✓

Skill references:
- add-feature.md: 1 reference to rust-feature.md ✓
- debug-failure.md: 1 reference to bugfix.md ✓

Planning context:
- add-feature.md: 2 references to .planning/ files ✓

Quality bar:
- debug-failure.md: 3 references to "root cause" ✓

No workflow duplication:
- No section headers (Goals/Workflow/Checklist) in either file ✓

Verification commands:
- Both prompts reference `just check && just test` ✓
```

## Next Phase Readiness

- Phase 3 team workflow refinement complete
- All prompts and skills now follow consistent patterns
- Prompts point to skills, skills contain detailed workflows
- Harness is internally consistent per D-01

---
*Phase: 03-team-workflow-refinement*
*Completed: 2026-04-05*

## Self-Check: PASSED

- ✓ SUMMARY.md created at `.planning/phases/03-team-workflow-refinement/03-03-SUMMARY.md`
- ✓ add-feature.md exists and contains required references
- ✓ debug-failure.md exists and contains required references
- ✓ Both prompts under their line limits
- ✓ No workflow duplication from skills
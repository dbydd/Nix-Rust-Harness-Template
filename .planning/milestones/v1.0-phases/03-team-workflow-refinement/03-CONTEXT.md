# Phase 3: Team workflow refinement - Context

**Gathered:** 2026-04-05
**Status:** Ready for planning

<domain>
## Phase Boundary

Refine the team-facing workflow layer of the template by tailoring prompts and skills to real usage patterns and by adding release and contribution workflows. This phase improves how teams use the harness; it does not expand the runtime scaffold or re-open Phase 2 Rust specialization scope.

</domain>

<decisions>
## Implementation Decisions

### Prompt and skill depth
- **D-01:** Phase 3 should make the harness internally consistent by promoting lightweight skills and sample prompts into team-ready assets rather than leaving them as stubs.
- **D-02:** `rust-feature.md` and `bugfix.md` should be expanded to a similar practical depth and specificity as `crate-discovery.md` and `nix-maintenance.md`.
- **D-03:** Existing prompts should be tailored to real usage patterns instead of remaining generic placeholder text.

### Prompt role
- **D-04:** Prompts should remain concise task entrypoints, not full duplicated workflows.
- **D-05:** Skills and planning docs remain the source of truth for detailed workflow guidance; prompts should explicitly point to them.

### the agent's Discretion
- Exact section layout and wording for the refined prompts and expanded skills
- Whether prompt wording should emphasize solo developer use, team collaboration, or both, as long as prompts remain concise entrypoints

</decisions>

<specifics>
## Specific Ideas

- The current repo has a split between polished operational skills (`crate-discovery`, `nix-maintenance`) and much lighter assets (`rust-feature`, `bugfix`, `prompts/add-feature.md`, `prompts/debug-failure.md`). Phase 3 should remove that inconsistency.
- Prompts should stay ergonomic and short, but they should no longer read like placeholders.

</specifics>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Project intent and constraints
- `.planning/PROJECT.md` — Template purpose, non-goals, and emphasis on explicit AI-assisted workflows
- `.planning/REQUIREMENTS.md` — Repository requirements around stable workflow entrypoints and durable workflow memory
- `.planning/ROADMAP.md` — Phase boundary for Team workflow refinement
- `.planning/STATE.md` — Current completed decisions from Phases 1 and 2
- `AGENTS.md` — Repo rules, verification contract, and structure intent

### Existing workflow assets
- `README.md` — Documents current harness surface and explicitly frames prompts/skills as customizable
- `docs/dev-workflow.md` — Existing developer lifecycle and usage framing
- `docs/architecture.md` — Runtime/harness/memory layering that Phase 3 must preserve
- `.agent/skills/rust-feature.md` — Lightweight Rust feature workflow to deepen
- `.agent/skills/bugfix.md` — Lightweight bugfix workflow to deepen
- `.agent/skills/crate-discovery.md` — Reference example of a polished, checklist-driven skill
- `.agent/skills/nix-maintenance.md` — Reference example of a polished, validation-driven skill
- `prompts/add-feature.md` — Current short feature-entry prompt
- `prompts/debug-failure.md` — Current short debug-entry prompt

### Team workflow surfaces
- `.github/workflows/ci.yml` — Existing CI contract that release/contribution workflows must align with
- `justfile` — Current team entrypoints and command vocabulary
- `.mcp.json` — Existing MCP contract sketch that may constrain workflow guidance

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `.agent/skills/crate-discovery.md`: Example of a mature skill with phased workflow, checklist, and guardrails
- `.agent/skills/nix-maintenance.md`: Example of a mature skill with concrete validation loops and decision matrix
- `prompts/add-feature.md` and `prompts/debug-failure.md`: Existing prompt entrypoints to evolve rather than replace blindly
- `justfile`: Existing user-facing command surface for team workflows
- `.github/workflows/ci.yml`: Existing CI behavior that release/contribution guidance must remain consistent with

### Established Patterns
- Skills are Markdown workflow guides with goals, workflow steps, and guardrails
- Stronger skills use explicit commands, checklists, and decision criteria instead of generic advice
- Prompts are short kickoff documents and should stay lighter than skills
- Local and CI workflows are expected to stay aligned through `just` and Nix entrypoints

### Integration Points
- Refined skills belong under `.agent/skills/`
- Refined prompts belong under `prompts/`
- Contribution and release workflow docs will likely need to connect with `README.md`, `justfile`, and `.github/`

</code_context>

<deferred>
## Deferred Ideas

- Exact release workflow design remains to be discussed in this phase
- Exact contribution workflow design remains to be discussed in this phase
- Optional CLI/library/service template profiles remain deferred from Phase 2 and are not part of this phase

</deferred>

---

*Phase: 03-team-workflow-refinement*
*Context gathered: 2026-04-05*

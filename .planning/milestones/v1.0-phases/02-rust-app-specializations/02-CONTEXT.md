# Phase 2: Rust app specializations - Context

**Gathered:** 2026-04-05
**Status:** Ready for planning

<domain>
## Phase Boundary

Expand the template beyond the initial scaffold with Rust-specific workflow specialization. This phase should strengthen the harness for real Rust work, starting with crate-selection guidance and stronger Nix-operations guidance, while leaving larger optional app profiles and packaging presets available for later follow-through inside the same phase.

</domain>

<decisions>
## Implementation Decisions

### Harness namespace
- **D-01:** `.agent/skills/` is the only active skill location. `.opencode/` is obsolete and should not be reintroduced.

### Rust dependency discovery
- **D-02:** The template should ship a dedicated skill for crate discovery and evaluation.
- **D-03:** That skill should instruct agents to start with `cargo search`, inspect candidates with `cargo info`, and check crate usability with official docs and Context7 before recommending adoption.
- **D-04:** Crate selection should consider license, maintenance signals, documentation quality, and ecosystem fit rather than download counts alone.

### Nix operations
- **D-05:** The Nix skill should move beyond generic advice and define a concrete validation loop for `flake.nix`, `flake.lock`, dev shell changes, and CI alignment.
- **D-06:** Any meaningful Nix change should verify `nix flake check` and the repo's `just` entrypoints from inside `nix develop`.

### Scope handling
- **D-07:** This pass focuses on Rust-specific harness specialization, not on generating full CLI/library/service starter profiles yet.

### the agent's Discretion
- Exact wording and section layout inside the skill files
- How much rationale versus checklist detail each skill should include

</decisions>

<specifics>
## Specific Ideas

- The crate-discovery skill should explicitly mention `cargo search`, `cargo info`, and checking crate usability through Context7.
- The Nix skill should help with practical repo operations, not just abstract Nix advice.

</specifics>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Project intent
- `.planning/PROJECT.md` — Template purpose, non-goals, and emphasis on AI-assisted Rust-on-Nix workflows
- `.planning/REQUIREMENTS.md` — Core requirements for reproducibility, explicit agent guidance, durable memory, and aligned workflows
- `.planning/ROADMAP.md` — Phase structure and Phase 2 position in the project
- `.planning/STATE.md` — Current assumptions and immediate follow-up direction

### Harness contract
- `AGENTS.md` — Repo rules, validation contract, and structure intent
- `README.md` — User-facing explanation of the harness and important file locations

### Existing skill patterns
- `.agent/skills/rust-feature.md` — Existing skill tone and workflow structure for Rust changes
- `.agent/skills/bugfix.md` — Existing skill tone and guardrail structure
- `.agent/skills/nix-maintenance.md` — Existing Nix skill to be strengthened in this phase

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `.agent/skills/*.md`: Existing local skill format with short goal/workflow/guardrail sections
- `README.md`: Documents `.agent/skills/` as a first-class harness surface

### Established Patterns
- Skills are short Markdown workflow guides, not large specifications
- Repo contracts prefer explicit verification commands and alignment between local and CI behavior

### Integration Points
- New skill files belong under `.agent/skills/`
- Project memory should be updated in `.planning/STATE.md` when major harness decisions change

</code_context>

<deferred>
## Deferred Ideas

- Full optional profiles for CLI, library, and service templates remain to be fleshed out later in Phase 2
- Richer packaging presets beyond the current harness workflow updates remain deferred

</deferred>

---

*Phase: 02-rust-app-specializations*
*Context gathered: 2026-04-05*

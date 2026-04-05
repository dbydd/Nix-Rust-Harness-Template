# Phase 2: Rust App Specializations - Research

**Researched:** 2026-04-05
**Domain:** Rust harness skills for dependency discovery and Nix operations
**Confidence:** HIGH

## Summary

This phase strengthens existing harness skills rather than creating new ones from scratch. The `crate-discovery.md` and `nix-maintenance.md` skills already exist with foundational workflows. Research shows we should enhance them with:

1. **More comprehensive crate evaluation criteria** beyond simple discovery—adding structured checklists for license, maintenance signals, documentation quality, and ecosystem fit as documented by industry leaders like Embark Studios.

2. **Concrete Nix validation loops** with explicit commands and pass/fail criteria—moving from generic advice to prescriptive `nix flake check` and `nix develop --command` workflows that prove Nix changes work.

3. **Tool ecosystem awareness** including cargo-deny for license/security compliance, cargo-audit for security advisories, and Context7 for up-to-date documentation lookup.

The crate-discovery skill should teach agents to use `cargo search` for initial discovery, `cargo info` for metadata inspection, and Context7 for API verification before recommending adoption. The nix-maintenance skill should enforce running `nix flake check` after meaningful changes and validating workflows from inside `nix develop` shells.

**Primary recommendation:** Enhance existing skills with evaluation checklists and concrete validation commands. Avoid theoretical advice. Focus on repeatable workflows agents can follow step-by-step.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- **D-01:** `.agent/skills/` is the only active skill location. `.opencode/` is obsolete and should not be reintroduced.
- **D-02:** The template should ship a dedicated skill for crate discovery and evaluation.
- **D-03:** That skill should instruct agents to start with `cargo search`, inspect candidates with `cargo info`, and check crate usability with official docs and Context7 before recommending adoption.
- **D-04:** Crate selection should consider license, maintenance signals, documentation quality, and ecosystem fit rather than download counts alone.
- **D-05:** The Nix skill should move beyond generic advice and define a concrete validation loop for `flake.nix`, `flake.lock`, dev shell changes, and CI alignment.
- **D-06:** Any meaningful Nix change should verify `nix flake check` and the repo's `just` entrypoints from inside `nix develop`.
- **D-07:** This pass focuses on Rust-specific harness specialization, not on generating full CLI/library/service starter profiles yet.

### the agent's Discretion
- Exact wording and section layout inside the skill files
- How much rationale versus checklist detail each skill should include

### Deferred Ideas (OUT OF SCOPE)
- Full optional profiles for CLI, library, and service templates remain to be fleshed out later in Phase 2
- Richer packaging presets beyond the current harness workflow updates remain deferred
</user_constraints>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| cargo search | Built-in (Cargo 1.94+) | Discover candidate crates by keyword | Official registry search, lightweight discovery first step |
| cargo info | Built-in (Cargo 1.94+) | Inspect crate metadata (license, version, deps) | Official metadata viewer, shows registry details without adding dependency |
| nix flake check | Built-in (Nix 2.7+) | Validate flake evaluates and builds correctly | Official Nix validation, catches evaluation errors and build failures |
| nix develop | Built-in (Nix 2.4+) | Enter development shell with build environment | Official shell entrypoint, proves dev environment works |

### Supporting
| Tool | Purpose | When to Use |
|------|---------|-------------|
| cargo-deny | Enforce license compatibility and ban problematic crates | After adding dependencies, in CI pipelines |
| cargo-audit | Check dependencies for known security vulnerabilities | Before production releases, in CI pipelines |
| Context7 (MCP) | Fetch up-to-date library documentation | When docs.rs or official docs are insufficient or out-of-date |
| cargo metadata | Extract machine-readable dependency graph | For programmatic dependency analysis |

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| cargo search | Web search on crates.io | cargo search is faster scriptable, web good for browsing |
| Context7 | docs.rs directly | Context7 aggregates multiple sources, handles versioning |
| nix flake check | nix build | check validates outputs; build creates derivations—different purposes |

**Installation:**
- Core tools (cargo search/info, nix commands) are built-in—no installation needed
- Optional: `cargo install cargo-deny cargo-audit` for license/security enforcement
- Context7 requires MCP client configuration (see `.mcp.json`)

**Version verification:** 
- Cargo 1.94.1 (verified via `cargo --version`)
- Nix flakes support requires Nix 2.4+ (nix develop) or 2.7+ (modern output attributes)

## Architecture Patterns

### Pattern 1: Structured Crate Evaluation
**What:** Multi-criteria checklist before adding any dependency, not just "does it compile?"
**When to use:** Every time an agent proposes adding a new crate dependency
**Example:**
```markdown
## Crate Evaluation Checklist

Before adding `<crate>` to dependencies:

1. **License Compatibility**
   - [ ] License is OSI-approved and permissive (MIT, Apache-2.0, BSD, ISC)
   - [ ] All transitive dependencies have compatible licenses
   - Run: `cargo deny check licenses` (if cargo-deny configured)

2. **Maintenance Signals**
   - [ ] Repository has commits in last 6 months (check GitHub/GitLab)
   - [ ] Issues/PRs are actively triaged
   - [ ] Version follows semantic versioning
   - [ ] Recent releases exist (check `cargo info <crate>`)
   
3. **Documentation Quality**
   - [ ] README explains purpose and basic usage
   - [ ] API docs on docs.rs are navigable
   - [ ] Examples demonstrate common use cases
   - Use Context7 if docs.rs is insufficient

4. **Ecosystem Fit**
   - [ ] Crate solves the specific problem (not over-featured)
   - [ ] Transitive dependency count is reasonable
   - [ ] No duplicate versions of same crate in dependency tree
   - Run: `cargo tree --duplicates` after adding to check

5. **Unsafe Auditing** (if applicable)
   - [ ] Amount of unsafe code is proportional to benefit
   - [ ] Safety comments document invariants (if unsafe present)
   - Check: docs.rs source view or repository
```

**Source:** Adapted from Embark Studios' crate-health.md guidelines (HIGH confidence)

### Pattern 2: Nix Validation Loop
**What:** Prescriptive sequence of commands to validate Nix changes, not just "check it works"
**When to use:** After any change to flake.nix, flake.lock, dev shell configuration, or CI workflow
**Example:**
```bash
# Step 1: Evaluate flake without building
nix flake check

# Step 2: Enter dev shell and run repo's validation from inside
nix develop --command bash -lc 'just check && just test && just ci'

# Step 3: Verify lock file reflects intentional changes
git diff flake.lock  # Review before commit
```

**Why this pattern:**
- `nix flake check` catches evaluation errors early (doesn't build derivations)
- Running `just` commands from inside `nix develop` proves dev shell actually works
- Explicit lock diff prevents accidental dependency drift

**Source:** Nix official docs, AGENTS.md verification contract (HIGH confidence)

### Pattern 3: Context7 Documentation Lookup
**What:** MCP-based tool for fetching version-specific library documentation when local knowledge is stale
**When to use:** When crate API or behavior is uncertain, docs.rs is insufficient, or version differs from training data
**Example:**
```
// Tool: context7_resolve-library-id
// Query: "tokio async runtime"
// Returns: /tokio-rs/tokio

// Tool: context7_query-docs
// Query: "How to create a multi-threaded runtime?"
// Returns: Code examples, API signatures, version-specific behavior
```

**Why Context7 over web search:**
- Returns versioned, structured documentation
- Reduces hallucinated APIs from stale training data
- Handles library version specification

**Source:** Context7 MCP documentation (HIGH confidence)

### Anti-Patterns to Avoid

- **Downloading by stars alone:** Popularity != maintenance quality. A crate with 10K stars but no commits in 2 years is risky.
- **Skipping doc verification:** Agent training data may reference old APIs. Always verify current API via docs.rs or Context7.
- **Adding before checking transitive deps:** A small crate can pull in hundreds of transitive dependencies. Check `cargo tree` after adding.
- **Running `nix flake check` only:** Evaluation success != dev shell working. Must validate from inside `nix develop`.
- **Vague guardrails:** "Check for issues" is not actionable. Give agents specific commands with success/failure criteria.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| License enforcement | Custom script to check SPDX ids | cargo-deny | Handles transitive deps, CI integration, exception rules |
| Security advisories | Manual CVE database search | cargo-audit | Queries RustSec database automatically |
| Dependency graph inspection | Ad-hoc Cargo.toml parsing | cargo tree / cargo metadata | Official tooling, handles workspace complexity |
| Crate metadata lookup | Web scrape crates.io | cargo info | Built-in, shows registry data directly |
| Dev shell validation | Manual PATH inspection | nix develop --command | Proves environment variables and tools are available |

**Key insight:** Cargo and Nix have rich built-in introspection. Agents should use these commands rather than guessing or parsing outputs manually. The skill should encode which command solves which problem.

## Common Pitfalls

### Pitfall 1: Skipping Maintenance Signal Check
**What goes wrong:** Agent adds crate that works now but becomes unmaintained, causing security issues or incompatibility later
**Why it happens:** `cargo search` shows downloads, not maintenance activity. High downloads ≠ active development.
**How to avoid:** Always check repository commit history and `cargo info` release dates before adding
**Warning signs:** No releases in 6+ months, open PRs with no response, GitHub repo archived

### Pitfall 2: Context7 Not Configured
**What goes wrong:** Skill mentions Context7 but agent can't use it because `.mcp.json` doesn't include it
**Why it happens:** Context7 is an MCP server, not built-in to the agent
**How to avoid:** Either document Context7 as optional (with fallback to docs.rs) OR ensure `.mcp.json` includes it
**Warning signs:** Agent attempts `context7_resolve-library-id` call and fails

### Pitfall 3: Vague Nix Advice
**What goes wrong:** Skill says "validate changes" without specifying what commands or what success looks like
**Why it happens:** Generic advice is easier to write than prescriptive workflows
**How to avoid:** Give exact command sequences with expected outcomes:
  - `nix flake check` → exit code 0
  - `nix develop --command just check` → "Checking..." output, no errors
**Warning signs:** Skill uses phrases like "make sure it works" without concrete steps

### Pitfall 4: Silent Transitive Deps
**What goes wrong:** Small-looking dependency pulls in 50+ transitive crates, bloating build time and audit surface
**Why it happens:** Cargo.toml only shows direct dependencies
**How to avoid:** Run `cargo tree` after `cargo add` to visualize full dependency graph
**Warning signs:** Build time spikes after adding a "small" crate

### Pitfall 5: License Assumption
**What goes wrong:** Agent assumes MIT/Apache because that's "the Rust way" but crate uses GPL or proprietary license
**Why it happens:** Training data skews toward permissively-licensed crates
**How to avoid:** Never assume—always run `cargo info <crate>` and check license field
**Warning signs:** License field shows non-OSI or custom license

## Code Examples

### Example: Crate Discovery Workflow
```markdown
# Crate Discovery Workflow

## Discovery Phase
1. Run initial search:
   ```bash
   cargo search --limit 20 <problem-domain>
   ```
   Review names, descriptions, and download counts as *signals not decisions*.

2. For promising candidates, inspect metadata:
   ```bash
   cargo info <crate>
   ```
   Note: license, latest version, repository, documentation link.

## Evaluation Phase
3. Check repository freshness:
   - Visit repository URL from `cargo info`
   - Check last commit date, open issues, PR response time
   
4. Verify documentation quality:
   - Open docs.rs/<crate>
   - Check for examples, getting-started guide
   - Use Context7 if docs.rs is incomplete or version differs

5. Review dependency footprint:
   ```bash
   cargo add <crate> --dry-run
   cargo tree --duplicates  # After dry-run
   ```
   Look for duplicate versions or deep dependency trees.

## Decision
6. Document choice in PR/commit:
   - Why this crate over alternatives
   - License checked (MIT/Apache/BSD/etc)
   - Maintenance status confirmed active
   - No smaller alternative found
```

**Source:** cargo docs + Embark crate-health checklist (HIGH confidence)

### Example: Nix Maintenance Checklist
```markdown
# Nix Change Checklist

## Before Editing
- [ ] Read current flake.nix, flake.lock, justfile, and CI workflow
- [ ] Understand what each output does

## After Editing
1. Validate flake evaluation:
   ```bash
   nix flake check
   ```
   Must: exit with code 0

2. Validate dev shell from inside:
   ```bash
   nix develop --command bash -lc 'just check && just test && just ci'
   ```
   Must: all commands complete without error

3. Review lock file changes:
   ```bash
   git diff flake.lock
   ```
   Must: intentional dependency changes only

## Alignment Checks
- [ ] `just doctor` commands match tools in dev shell
- [ ] CI workflow uses same validation as `just ci`
- [ ] README documents new tools or commands introduced
- [ ] `.planning/STATE.md` updated if workflow expectations changed
```

**Source:** AGENTS.md verification contract + Nix docs (HIGH confidence)

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Web search for crates | `cargo search` + `cargo info` | Cargo built-in | Faster, scriptable, shows metadata |
| Guessed API from memory | Context7 versioned docs | MCP ecosystem c. 2025 | Reduces hallucinated APIs, handles version drift |
| "Check Nix works" | `nix flake check` + `nix develop --command` | Nix 2.4+ | Explicit validation commands replace vague advice |
| Manual license checking | cargo-deny CI integration | cargo-deny 2020+ | Enforced compliance in CI pipeline |
| Single evaluation | `nix flake check --no-build` | Nix 2.32+ | Skip building substitutable derivations for speed |

**Deprecated/outdated:**
- Looking at crates.io downloads alone: Use maintenance signals + downloads
- Vague "test it works" guidance: Use explicit command sequences with success criteria
- Assuming docs.rs is current: Use Context7 for version-specific API verification

## Open Questions

1. **Should Context7 be required or optional?**
   - What we know: Context7 is an MCP server, not built into agents
   - What's unclear: Whether all agent environments running this harness will have Context7 configured
   - Recommendation: Document Context7 as primary doc source, with fallback to docs.rs if unavailable

2. **How much detail in evaluation checklist?**
   - What we know: Embark's checklist has 10 categories with detailed items
   - What's unclear: Whether agents need all 10 or a simplified 3-4 category version
   - Recommendation: Start with simplified checklist (License, Maintenance, Docs, Ecosystem), link to full Embark guide for deep evaluation

3. **Should cargo-deny/cargo-audit be in the harness skill or separate?**
   - What we know: These are optional enforcement tools, not required for initial discovery
   - What's unclear: Whether the crate-discovery skill should mention them as follow-up
   - Recommendation: Add lightweight "After adding: consider cargo-deny and cargo-audit in CI" note, keep skill focused on discovery/evaluation

4. **What triggers "meaningful Nix change"?**
   - What we know: Not all edits require full validation
   - What's unclear: Where the threshold is for skipping `nix develop --command`
   - Recommendation: Run `nix flake check` after any flake.nix edit; run `nix develop --command` after dev shell or tool changes

## Environment Availability

> Phase focuses on skill file changes, not external dependencies. All referenced tools (cargo, nix) are built-in.

| Dependency | Required By | Available | Version | Fallback |
|------------|-------------|-----------|---------|----------|
| cargo search/info | Crate discovery | ✓ | Built-in (1.94+) | — |
| nix flake check | Nix validation | ✓ | Built-in (2.7+) | — |
| nix develop | Dev shell entry | ✓ | Built-in (2.4+) | — |
| cargo-deny | License enforcement | ✗ | — | Optional: install via cargo install |
| cargo-audit | Security advisories | ✗ | — | Optional: install via cargo install |
| Context7 MCP | Docs lookup | ✗ | — | Optional: requires MCP config in .mcp.json |

**Missing dependencies with no fallback:**
- None—core workflow uses built-in tools only

**Missing dependencies with fallback:**
- Context7: Fallback to docs.rs for documentation
- cargo-deny/audit: Manual license check, manual RustSec query if not installed

**Step 2.6 Status:** COMPLETE (no blocking dependencies)

## Validation Architecture

> Nyquist validation is ENABLED (default behavior, no config.json override found)

### Test Framework
| Property | Value |
|----------|-------|
| Framework | cargo nextest (just test) |
| Config file | None detected (uses Cargo.toml test config) |
| Quick run command | `cargo nextest run --all-features --no-tests=warn` |
| Full suite command | `just ci` (runs check + test) |

### Phase Requirements → Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| N/A | No explicit requirements | N/A | N/A | N/A |

**Note:** This phase defines no explicit requirements. The validation is implicit: humans can read skill files, agents can follow workflows, and commands execute successfully. No automated tests are needed; evaluation is manual skill review.

### Sampling Rate
- **Per task commit:** No test requirement (content-only changes)
- **Per wave merge:** Review skill content for clarity and actionability
- **Phase gate:** Human reads skills and confirms workflows are clear

### Wave 0 Gaps
- **No test infrastructure needed** — Skills are documentation, not code
- Validation via: Can a human follow the skill? Can an agent execute the workflow?

**Validation approach:** Manual skill review is sufficient. Each enhanced skill should pass:
1. **Clarity check:** Can a developer understand the workflow in < 2 minutes?
2. **Actionability check:** Are commands specific (not vague)?
3. **Completeness check:** Does the checklist cover common failure modes?

## Sources

### Primary (HIGH confidence)
- `/websites/doc_rust-lang_cargo` - cargo search, cargo info, cargo metadata command documentation
- `/nixos/nix` - nix flake check, nix develop command documentation
- Embark Studios crate-health.md (https://gist.github.com/repi/d98bf9c202ec567fd67ef9e31152f43f) - Industry-standard crate evaluation checklist
- AGENTS.md - Verification contract and repo rules (local file)
- CONTEXT.md - Locked decisions and scope (local file)

### Secondary (MEDIUM confidence)
- Nix flake best practices articles (web search, verified against official docs)
- Cargo-deny and cargo-audit documentation (web search, verified against crates.io metadata)
- Context7 MCP server documentation (web search, verified against MCP specification)

### Tertiary (LOW confidence)
- N/A - All core findings verified against primary sources

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH - All tools are built-in Cargo/Nix commands, verified via --help output
- Architecture patterns: HIGH - Derived from Embark checklist (industry reference) and AGENTS.md contract
- Pitfalls: HIGH - Based on common agent failure modes and Nix/Rust ecosystem gotchas
- Validation: HIGH - Skills are documentation; manual review is appropriate validation

**Research date:** 2026-04-05
**Valid until:** 30 days (stable tools and patterns)
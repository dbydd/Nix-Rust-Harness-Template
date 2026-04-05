# Crate Discovery Skill

Use this workflow when you need to find, compare, or justify Rust crates for a new dependency.

## Goals

- Start with lightweight discovery before adding a dependency.
- Prefer maintained, well-documented crates with compatible licenses.
- Evaluate crates on license, maintenance signals, documentation quality, and ecosystem fit—not just download counts.
- Use Context7 for version-specific API documentation when needed.
- Recommend the narrowest crate that solves the problem, and explain why alternatives were rejected.

## Workflow

### Discovery Phase

1. Run initial search:
   ```bash
   cargo search --limit 20 <problem-domain>
   ```
   Review names, descriptions, and download counts as signals—not decisions.

2. For promising candidates, inspect metadata:
   ```bash
   cargo info <crate>
   ```
   Note: license, latest version, repository, documentation link.

### Evaluation Phase

3. Check repository freshness:
   - Visit repository URL from `cargo info` output
   - Check last commit date, open issues, PR response time

4. Verify documentation quality:
   - Open docs.rs/<crate>
   - Check for examples, getting-started guide
   - Use Context7 if docs.rs is incomplete or version differs

5. Review dependency footprint:
   ```bash
   cargo add <crate> --dry-run
   cargo tree --duplicates  # After dry-run to see transitive deps
   ```
   Look for duplicate versions or deep dependency trees.

### Decision Phase

6. Document choice with:
   - Why this crate over alternatives
   - License confirmed compatible
   - Maintenance status confirmed active
   - No smaller alternative found

## Evaluation Checklist

Before recommending `<crate>` for adoption:

### License Compatibility
- [ ] License is OSI-approved and permissive (MIT, Apache-2.0, BSD, ISC)
- [ ] All transitive dependencies have compatible licenses
- [ ] Run: `cargo info <crate>` to verify license field

### Maintenance Signals
- [ ] Repository has commits in last 6 months (check GitHub/GitLab)
- [ ] Issues/PRs are actively triaged
- [ ] Version follows semantic versioning
- [ ] Recent releases exist (check `cargo info <crate>`)

### Documentation Quality
- [ ] README explains purpose and basic usage
- [ ] API docs on docs.rs are navigable
- [ ] Examples demonstrate common use cases
- [ ] Use Context7 for version-specific API if docs.rs is insufficient

### Ecosystem Fit
- [ ] Crate solves the specific problem (not over-featured)
- [ ] Transitive dependency count is reasonable
- [ ] No duplicate versions of same crate in dependency tree
- [ ] Run: `cargo tree --duplicates` after adding to check

## Guardrails

- Do not add a new crate before checking whether the standard library or an existing dependency already solves the problem.
- Do not pick a crate by download counts alone—evaluate maintenance signals, documentation, and ecosystem fit.
- Do not recommend crates with unclear licensing or obviously stale maintenance without calling out the risk.
- Do not skip documentation lookup when the crate API or ecosystem fit is uncertain.
- Do not assume MIT/Apache—always verify the license field with `cargo info <crate>`.
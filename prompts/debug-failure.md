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
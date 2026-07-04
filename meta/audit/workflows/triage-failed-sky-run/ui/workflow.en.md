---
short_description: Reads a failed run's logs, pinpoints the failing node and root cause, and proposes a fix diff without applying anything.
long_description: Use this after a skyway run fails and the cause is not obvious. It fetches the run logs and workflow source, has sonnet name the failing node and root cause with a confidence note, then emits a reviewable unified diff plus the exact update-sky-workflow command to apply it. Nothing is auto-applied; budget-capped at $2.00.
---
Three steps: `fetch` (bash) confirms the .sky file exists and captures `skyway logs <run>` plus the source, `diagnose` (sonnet) identifies the failing node id and concrete root cause, and `propose` (sonnet, resuming the diagnose session via chain_from) outputs a `diff -u` patch and the one-line apply command.

If the failure is environmental (missing run id, daemon down, transient) rather than a source defect, propose says so and skips the diff.

| Variable | Meaning |
|----------|---------|
| `dir` | Directory containing the `.sky` file. |
| `name` | Workflow filename without `.sky`. |
| `run` | The failed run id (required; fetch exits nonzero without it). |

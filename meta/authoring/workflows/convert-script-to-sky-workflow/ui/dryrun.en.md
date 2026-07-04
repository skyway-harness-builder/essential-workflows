---
short_description: Best-effort dry-run of the new workflow.
long_description: Runs skyway run on the generated workflow with the dry-run flag and swallows any failure, so a half-valid draft still surfaces output instead of failing the whole run. Purely informational final step.
---

Pure bash: `skyway run <name> --dry-run || true`.

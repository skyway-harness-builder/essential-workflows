---
short_description: Removes the scratch forge-candidate file so the repo tier is left clean.
long_description: Deterministic bash, no LLM, with `trigger_rule = "all_done"` so it runs whether finalize succeeded, was skipped, or failed. Deletes the temporary `.sky/workflows/forge-candidate.sky` that only ever existed for the dry-run resolver.
---
Best-effort: a missing file is fine. Leaves the `.sky/workflows/` tier exactly as found.

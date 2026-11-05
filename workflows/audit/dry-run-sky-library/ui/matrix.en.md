---
short_description: Renders the aligned PLAN/WORKFLOW/DIAGNOSTIC table and summary counts.
long_description: Collects the per-workflow classifications into one aligned matrix with summary totals. Exits 1 if any workflow FAILed to plan, making the run CI-gate friendly.
---
Only the first diagnostic line is shown per workflow; rerun `skyway run <wf> --dry-run` manually for the full error.

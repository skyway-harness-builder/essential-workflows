---
short_description: Validates the candidate's DAG, vars, cycles, and budget with skyway run --dry-run.
long_description: Deterministic bash, no LLM; runs only when lint is clean. `skyway run forge-candidate --dry-run --format json` renders each node's prompt and resolves the DAG, variable wiring, cycle check, and budget estimate without invoking Claude or executing any bash — the v1 safety boundary.
---
Resolves the candidate by name from the repo-tier `.sky/workflows/`. Exit 0 plus a non-empty JSON array yields `{"dry_ok":"true"}`.

---
short_description: Dry-runs each discovered workflow and classifies it PASS, FAIL, or SKIP.
long_description: Runs `skyway run --dry-run` per workflow — by path first, falling back to cd-plus-name — and captures the first diagnostic line on failure. SKIP is a heuristic for workflows that need vars the audit cannot supply.
---
Runs after `discover`. The name-based fallback relies on the workflow's `name` field matching its filename.

---
short_description: Estimates per-workflow LLM spend across a directory and flags Claude workflows missing a max_budget_usd cap.
long_description: Scans every .sky file in a directory, counts Claude nodes and model tiers, then ranks workflows by rough cost risk. Use it before sharing a library or in CI to catch workflows that could spend without bound. The dollar figures are triage hints; the missing-cap flag is the reliable signal.
---
Runs in two steps: a bash `scan` node globs `"$SKY_DIR"/*.sky` and emits one TSV row per file (name, Claude node count, cap present, models), then a haiku `report` node ranks workflows by rough cost risk and lists every uncapped LLM workflow with a suggested cap.

| Variable | Meaning |
|----------|---------|
| `dir` | Directory to scan for `.sky` files (read as `$SKY_DIR`; defaults to `.sky/workflows`) |

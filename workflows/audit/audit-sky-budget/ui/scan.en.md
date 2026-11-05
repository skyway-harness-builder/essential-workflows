---
short_description: Globs the target directory and classifies every .sky file by Claude usage and budget cap.
long_description: Counts prompt/model nodes per file, detects whether a max_budget_usd cap is declared, and records which model tiers appear. Exits nonzero when the directory is missing or empty, failing the run before any Claude spend.
---
Emits one TSV line per file: name, Claude node count, `has_cap`, models. Reads the target directory from `$SKY_DIR`.

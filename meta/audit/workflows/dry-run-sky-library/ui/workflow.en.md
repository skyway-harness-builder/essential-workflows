---
short_description: Dry-runs every .sky workflow in a directory and prints a PASS/FAIL/SKIP plan matrix.
long_description: Runs `skyway run --dry-run` against each workflow to exercise template substitution and depends_on wiring that static lint cannot see — a deeper class of bug than skyway lint catches. Pure bash, no LLM cost. Exits non-zero if any workflow fails to plan.
---
Three bash steps: `discover` globs the directory, `dryrun` executes a per-workflow dry run and classifies PASS/FAIL/SKIP, and `matrix` renders an aligned summary table. SKIP means the workflow needs vars the audit cannot supply (a heuristic matched from stderr). Exit codes: 0 all pass, 1 any FAIL, 2 bad input directory.

| Variable | Meaning |
|----------|---------|
| `dir` | Absolute path to the directory containing the `.sky` files (read as `$SKY_DIR`) |

---
short_description: Flags dangling sky_event edges — listeners with no emitter and emit signals with no listener.
long_description: "Scans a .sky library for zero-subscription event edges: a trigger.sky_event nobody emits (dead listener) or an emit name nobody listens for (dead signal). The complement of check-sky-trigger-conflicts, which flags over-subscription. Pure bash, exits 1 if any orphan exists."
---
Three bash steps: `collect` greps listener and emitter names from every file, `match` diffs the two lists with comm/grep, and `report` prints both orphan lists and sets the exit code.

| Variable | Meaning |
|----------|---------|
| `dir` | Directory containing the `.sky` files to scan (read as `$SKY_DIR`) |

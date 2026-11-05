---
short_description: Cross-references every .sky file in a directory against run history and lists never-run files as advisory deletion candidates.
long_description: Run this when a .sky workflow library has grown and you suspect dead weight. It greps `skyway logs` for each workflow filename and flags the ones that never appear, printing ready-to-paste delete commands. Pure bash, no Claude cost, and it deletes nothing itself.
---
Three bash steps run in sequence: `list` enumerates every `.sky` file in the target directory, `runs` captures the current `skyway logs` output, and `report` marks each file SEEN-IN-LOGS or NEVER. Every NEVER file gets a suggested `skyway run delete-sky-workflow` command line.

The NEVER verdict is advisory: pruned logs, renamed workflows, or brand-new files all produce false positives. Verify before deleting anything.

| Variable | Meaning |
|----------|---------|
| `dir` | Absolute path to the directory containing the `.sky` files to scan. |

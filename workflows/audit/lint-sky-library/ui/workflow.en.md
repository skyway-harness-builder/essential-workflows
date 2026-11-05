---
short_description: Lints every .sky file in a directory, then runs a Claude fix-loop on the failing files until the whole library is clean.
long_description: "The auto-fix twin of audit-sky-library: instead of only reporting lint failures, it hands the failing files to a sonnet node that edits them in place until `skyway lint` passes everywhere. Budget-capped at $3.00 because the fix node may touch many files. Use the audit workflow instead when you only want a report."
---
Three steps: `scan` lints every file and exits nonzero if any fail, `fix` runs only on that failure and repairs each file per its SKY-WF-* error codes, and `verify` loops (up to 6 attempts) until the entire directory lints clean, failing the run otherwise.

Warning: this workflow edits `.sky` files in place. If everything already lints clean, the fix node is skipped entirely and no tokens are spent.

| Variable | Meaning |
|----------|---------|
| `dir` | Directory containing the `.sky` files to lint and fix (e.g. `.sky/workflows`). |

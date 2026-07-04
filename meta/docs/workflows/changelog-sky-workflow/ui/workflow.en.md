---
short_description: Diff a .sky against its last committed version and append a plain-English changelog entry to CHANGELOG.md.
long_description: Turns uncommitted edits to a workflow file into a dated, reviewable changelog bullet. Diffs the working tree against HEAD, has a cheap haiku node describe the change in one line, and appends it to CHANGELOG.md next to the file. Read-only on the .sky itself; a file with no changes records "no changes" instead of failing.
---

Runs in three steps: **diff** (`git diff HEAD` for the file), **describe** (haiku writes one changelog bullet), **emit** (append under a dated heading to `CHANGELOG.md`). Assumes `dir` is inside a git working tree.

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `dir` | Directory containing the `.sky` and its `CHANGELOG.md`; must be a git working tree |
| `name` | Workflow filename without the `.sky` extension |

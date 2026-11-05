---
short_description: Duplicate a .sky workflow as a new manual template, with the copied trigger neutralized.
long_description: Clones an existing workflow under a new name without the double-fire hazard - a naive copy would keep the source's trigger and start two runs per event. This workflow strips every trigger line from the clone (making it manual by default), retargets the meta name, and lint-fixes any leftovers so the clone ships clean.
---

Runs in four steps: **copy** (never clobbers an existing file), **rewrite** (retarget `name`, strip `trigger.*` lines), **lint** (sonnet loop until `skyway lint` passes, max 6), **describe** (best-effort `skyway describe` summary).

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `dir` | Directory both files live in (e.g. `.sky/workflows`) |
| `name` | Existing kebab-case filename to clone (no `.sky` extension) |
| `new-name` | New filename + workflow name for the clone (no `.sky` extension) |

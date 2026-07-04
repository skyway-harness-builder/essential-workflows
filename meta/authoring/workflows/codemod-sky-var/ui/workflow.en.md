---
short_description: Bulk-rename one token across every .sky in a directory, consistently across its three syntactic forms.
long_description: A var key or node id appears in three places in a .sky file - template {{old}}, bash env $SKY_<UPPER_OLD>, and node-id §old§ plus quoted id refs - and a rename must hit all three or the workflow breaks. This codemod rewrites all forms in one pass, gated behind manual approval because the regex rewrite is fragile, then lint-verifies every touched file. Pure bash, no LLM tokens.
---

Runs in four steps: **scan** (grep all three forms, preview every hit), **gate** (manual approval, 1h timeout), **apply** (portable temp-file sed per affected file), **verify** (`skyway lint` every `.sky`, exit 1 if any fails). Prefer long, distinctive tokens and run in a git working tree so you can `git diff` or revert.

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `dir` | Directory of `.sky` files to codemod (e.g. `.sky/workflows`) |
| `old` | Existing token (kebab-case `--var` key or node id), without `$SKY_` / `§` |
| `new` | Replacement token (kebab-case), without `$SKY_` / `§` |

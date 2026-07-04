---
short_description: Drives one of your Claude Code skills toward a measurable quality bar, then stages a PR.
long_description: Use this when a skill under `.claude/skills/<name>/` underperforms or has never been measured. It synthesizes an eval suite from the skill's own promises, exercises the skill, has an opus judge score it, and loops improvement passes in a throwaway worktree until a fail-closed gate passes — then opens a PR for a human to merge.
---
The pipeline: **read-skill** dumps the skill source into a greppable block, **parse** (haiku) synthesizes 3-5 checkable eval cases, **baseline-exercise** (sonnet) runs the skill against them, **judge** (opus) scores pass/fail per case and prints a machine sentinel, and **gate** (bash, fail-closed) decides `delivers`. If false, **improve** loops up to 3 sonnet passes editing the skill in an isolated worktree. **lint-scripts** statically checks bundled scripts (`bash -n`, `node --check` — never executed), and **finalize** commits the skill tree on a branch and opens a PR. Idempotent: an already-passing skill produces no PR. Bounded by `max_budget_usd = 8.00` and `loop.max = 3`.

| Variable | Meaning |
|----------|---------|
| `skill_name` | Target skill directory under `<repo>/.claude/skills/<skill_name>/` |

---
short_description: Prepares a repo and its GitHub Project for the Dark Factory ladder — labels, project link, field-schema check.
long_description: Onboarding step (rung 0) for the Dark Factory ladder on GitHub. A Projects v2 template reproduces board structure but never carries repo-scoped labels or the auto-add workflow, so this workflow fills exactly that gap. Pure bash + `gh`, deterministic, idempotent, and fail-closed — safe to re-run at any time.
---
Runs five deterministic bash steps against the caller's repo and a GitHub Project you pass by number:

1. **preflight** — resolve owner/repo/project and verify access; abort if anything is missing.
2. **labels**, **link**, **fields** (parallel) — create the 9 lifecycle labels on the repo, link the project to the repo, and verify the project carries the dark-factory field schema (read-only).
3. **report** — summarize what was done and print the two manual UI steps the GitHub API cannot perform (auto-add workflow, label-to-Status automation).

| Variable | Meaning |
|----------|---------|
| `project` | GitHub Project number (required) |
| `owner` | Org or user owning the project (optional; defaults to the repo owner) |
| `repo` | Target repo as `owner/name` (optional; defaults to `gh repo view` in the working dir) |

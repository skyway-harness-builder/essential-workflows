---
short_description: Applies best-practice GitHub settings via `gh` — org/account defaults and repo hardening in one run.
long_description: "Use this to converge a GitHub org and/or repository to a hardened baseline: merge hygiene, Dependabot, branch protection, and secret scanning. Pure bash + `gh`, deterministic, idempotent, and fail-closed — re-running always converges to the same state. Paid-plan-gated settings are applied only when the tier or repo visibility allows them."
---
Preflight resolves the repo, org, scope, and tier, checks the caller's role (repo admin and/or org owner), and emits gating booleans. Five gated bash nodes then run in parallel: org-wide defaults, repo merge hygiene, Dependabot alerts and auto-fixes, branch protection, and secret scanning with push protection. A final report summarizes what was applied versus skipped, with reasons and manual follow-ups.

| Variable | Meaning |
|----------|---------|
| `scope` | `general` (org/account), `repo`, or `both` (default `both`) |
| `tier` | Your GitHub plan: `free` or `paid` (default `free`; prose like "team"/"enterprise" normalizes to `paid`) |
| `org` | Target org (optional; defaults to the repo owner) |
| `repo` | Target repo as `owner/name` (optional; defaults to the working dir's repo) |

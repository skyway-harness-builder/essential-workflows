---
short_description: Renames the candidate to its real name and opens a staged PR — never merges.
long_description: Claude (opus) under worktree isolation; runs only when the gate says delivers is true. Picks the real kebab-case name, writes the renamed workflow plus a `manifest.yaml` entry, pushes a branch, and opens a PR with an explicit routing recommendation in the body.
---
v1 routes the PR to workflows-internal by default; moving a workflow to the public repo is a deliberate human decision. Protected files (MISSION.md, FACTORY_RULES.md, `.github/`, `.sky/` definitions, learnings) are never committed.

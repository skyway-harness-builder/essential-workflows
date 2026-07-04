---
short_description: Commits the improved skill on a branch and opens a PR — never merges.
long_description: Bash + `gh` under worktree isolation. Commits only files under the target skill directory and opens a PR; CI plus a human review is the merge gate. Idempotent — when the worktree has no changes (skill already passing, or improve made no edits) it prints "already passing" and opens nothing.
---
Defense in depth on the protected-files boundary: the commit is scoped with an explicit pathspec, and a guard fails closed if any staged path matches MISSION.md, FACTORY_RULES.md, `.github/`, `.sky/`, or learnings.

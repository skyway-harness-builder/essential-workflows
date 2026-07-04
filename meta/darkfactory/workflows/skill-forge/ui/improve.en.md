---
short_description: Loops up to 3 improvement passes on the skill in a throwaway worktree.
long_description: Claude (sonnet) prompt-body loop, running only when the gate says delivers is false. Each pass is a fresh invocation that fixes the judged failures at their root cause — clarify SKILL.md, add a missing helper script, or repair a buggy one — then re-exercises and self-judges.
---
All edits happen under `isolation = "worktree"`; the live checkout is never touched. Each pass writes a verdict to a per-run sentinel file that `loop.until.bash` greps for `delivers=true`; `loop.max = 3` caps the passes. Protected files (MISSION.md, FACTORY_RULES.md, `.github/`, `.sky/`, learnings) are off limits.

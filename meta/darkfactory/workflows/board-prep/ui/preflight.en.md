---
short_description: Resolves owner, repo, and project, then verifies access before any mutation.
long_description: Deterministic bash + `gh`, no LLM. Resolves the target repo from `--var repo` or the working directory, requires `--var project`, and checks project access (needs the `project` auth scope). Fail-closed — anything missing aborts the whole run here.
---
Emits one JSON line `{owner, repo, project}` that every downstream step consumes. Reads the `$SKY_*` env channel directly and shell-quotes every expansion.

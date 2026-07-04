---
short_description: Links the GitHub Project to the repo so the board can pull its items.
long_description: Deterministic bash + `gh`, no LLM. Runs `gh project link` with the owner, repo, and project number resolved by preflight. Idempotent in effect — an already-linked project is reported, not treated as an error.
---
Connects the project board to the repository; without this link the auto-add workflow and the Kanban view have nothing to pull from.

---
short_description: Creates the 9 repo-scoped lifecycle labels the ladder rungs key off.
long_description: Deterministic bash + `gh`, no LLM. Creates the lifecycle labels from `data/labels.yaml` on the target repo — the one thing no project template can provide, because labels live on the repository, not the project.
---
Uses `gh label create --force`, an idempotent upsert: it creates each label or overwrites its color/description if it already exists, so re-runs are safe.

---
short_description: Draft grouped release notes the moment a GitHub release is published — propose-only, apply with one command.
long_description: Publishing a release with an empty or auto-generated body wastes the one moment users actually read your changelog. This workflow fires on release.published, walks the commits since the previous published tag, and drafts grouped notes (Features / Fixes / Other) that preserve anything hand-written in the release body. Nothing is written back — the draft ends with the exact `gh release edit` command to apply it after review.
changelog:
  - version: "1.0.0"
    date: "2026-07-04"
    note: "Initial release."
---

Two nodes: **collect** (bash, `gh api` — repo, tag, previous tag, current body, commit list) then **draft** (sonnet — grouped notes + apply command).

- Trigger: `release.published` webhook; also runs manually via `skyway run draft-release-notes` (optional `--var tag=v1.2.3`).
- First release (no previous tag) falls back to the last 50 commits at the tag.
- Requires an authenticated `gh` CLI on the daemon host.

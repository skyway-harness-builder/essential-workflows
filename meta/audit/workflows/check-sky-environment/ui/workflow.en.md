---
short_description: Preflight doctor — probe the host environment and flag what will break before a workflow does.
long_description: A fresh sky install can look healthy until the first run fails on something the daemon never checks — a missing claude CLI, an unauthenticated gh, an unreachable git origin, or a secret declared in a workflow but never exported. This one-node pure-bash doctor probes all of it in seconds and exits non-zero on any hard failure, so it slots into CI or a morning cron unchanged.
changelog:
  - version: "1.0.0"
    date: "2026-07-04"
    note: "Initial release."
---

One pure-bash node, no LLM cost. Prints one `OK | WARN | FAIL` line per check:

| Check | On failure |
|-------|-----------|
| claude CLI on PATH | FAIL — prompt nodes cannot run |
| gh present + authenticated | FAIL when unauthenticated, WARN when absent |
| git origin reachable | FAIL when configured but unreachable |
| daemon `/health` | WARN — schedules/webhooks will not fire |
| declared `secrets[]` set in env | FAIL per missing variable |

Run with `--var dir=<library dir>` (scanned for `secrets[]` declarations).

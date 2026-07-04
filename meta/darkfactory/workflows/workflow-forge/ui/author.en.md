---
short_description: Generates the full candidate .sky file body under the sentinel name forge-candidate.
long_description: Claude (opus). Produces a complete, lint-clean `.sky` file that satisfies `{{intent}}`, following the parse plan and the full `.sky` format rules. The ⊕meta⊕ name must be exactly `forge-candidate` so the dry-run resolver can find it by name.
---
Emits only the raw file body — no fences, no prose — because the next step writes its stdout verbatim to disk. The real workflow name is chosen later, at PR time.

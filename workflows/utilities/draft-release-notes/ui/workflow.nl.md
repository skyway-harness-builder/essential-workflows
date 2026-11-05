---
short_description: Stelt gegroepeerde release notes op zodra een GitHub-release gepubliceerd wordt — alleen een voorstel, toepassen met één commando.
long_description: Een release publiceren met een lege of automatisch gegenereerde beschrijving verspilt hét moment waarop gebruikers je changelog echt lezen. Deze workflow vuurt op release.published, loopt de commits sinds de vorige gepubliceerde tag af en stelt gegroepeerde notes op (Features / Fixes / Overig) waarbij handgeschreven tekst in de release-body behouden blijft. Er wordt niets teruggeschreven — het voorstel eindigt met het exacte `gh release edit`-commando om het na review toe te passen.
changelog:
  - version: "1.0.0"
    date: "2026-07-04"
    note: "Eerste release."
---

Twee nodes: **collect** (bash, `gh api` — repo, tag, vorige tag, huidige body, commitlijst) en daarna **draft** (sonnet — gegroepeerde notes + apply-commando).

- Trigger: `release.published`-webhook; ook handmatig via `skyway run draft-release-notes` (optioneel `--var tag=v1.2.3`).
- Eerste release (geen vorige tag) valt terug op de laatste 50 commits bij de tag.
- Vereist een ingelogde `gh` CLI op de daemon-host.

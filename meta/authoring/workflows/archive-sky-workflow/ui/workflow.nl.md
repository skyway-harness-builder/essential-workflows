---
short_description: Archiveert een .sky-workflow naar _archive/ met geneutraliseerde trigger; omkeerbaar via restore-modus.
long_description: Verplaatst een workflow uit het actieve laadpad naar een _archive/-submap en stript eerst elke trigger-regel, zodat het bestand nooit meer automatisch kan afgaan. Een handmatige gate bewaakt de verplaatsing en restore-modus zet het bestand terug als manual-only workflow. Puur bash, geen LLM-kosten.
---

Draait in vier stappen: **find** (bron-/doelpaden bepalen), **gate** (handmatige goedkeuring, timeout 1u), **move** (trigger-regels strippen + `git mv`), **verify** (`skyway lint` op het nieuwe pad). Restore zet het bestand terug maar laat de trigger geneutraliseerd — voeg een trigger-regel toe om te heractiveren.

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `dir` | Map waarin de workflow staat (bijv. `.sky/workflows`) |
| `name` | Workflow-bestandsnaam zonder `.sky` (bijv. `old-flow`) |
| `mode` | `archive` (standaard) of `restore` |

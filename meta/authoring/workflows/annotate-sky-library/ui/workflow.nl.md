---
short_description: Scant een library-map op workflow.sky-bestanden zonder annotaties en annoteert ze één voor één.
long_description: Batch-aansturing voor annotate-sky-workflow. Loopt een library-map door, vindt elke workflow.sky zonder ※id※-annotatieblokken en draait de annotator er sequentieel op. Handig na het importeren of bulk-bewerken van een set workflows.
---

Draait in twee stappen: **scan** (vindt ongeannoteerde workflows) en daarna **annotate-all** (start `annotate-sky-workflow` per gevonden workflow, één run tegelijk). Stopt netjes wanneer alles al geannoteerd is.

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `dir` | Root van de te scannen library (bijv. `meta/authoring/workflows`) |

---
short_description: Annoteert elke workflow.sky in de opgegeven mappen met inline rationale-commentaar en lint elk bestand schoon.
long_description: De batchversie van annotate-sky-workflow in één node - vindt elke workflow.sky onder de opgegeven mappen, voegt vóór elke ongedocumenteerde node-config een ※id※-rationaleblok toe en lint elk bestand na het bewerken. Eén run documenteert een hele library.
---

Eén sonnet-node draait `find {{folders}} -name "workflow.sky"`, annoteert elk bestand in situ, draait `skyway lint` per bestand en print een eindsamenvatting. Budget begrensd op $30 voor grote libraries.

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `folders` | Spatie-gescheiden mappen om te doorzoeken op `workflow.sky`-bestanden |

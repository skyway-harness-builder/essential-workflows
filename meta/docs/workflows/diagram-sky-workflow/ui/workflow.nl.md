---
short_description: Regenereert de ASCII-DAG-header van een .sky-bestand op basis van de echte node-graaf en lint daarna schoon.
long_description: Houdt het leesbare stroomdiagram in de header van een workflow eerlijk - parseert de echte depends_on-, chain_from- en when-edges en hertekent de ASCII-DAG in het bovenste commentaarblok, in situ bewerkt. Het geregenereerde diagram is best-effort; controleer het tegen de node-configs voordat je erop vertrouwt.
---

Draait in twee stappen: **draw** (haiku parseert de node-graaf en herschrijft alleen het headerdiagram) en daarna **lint** (haiku-loop herstelt eventuele delimiter-schade tot `skyway lint` met 0 eindigt, max 6 passes).

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `dir` | Map met het doel-`.sky`-bestand (bijv. `.sky/workflows`) |
| `name` | Doel-workflow-bestandsnaam zonder de `.sky`-extensie |

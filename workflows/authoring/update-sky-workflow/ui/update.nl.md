---
short_description: Past de gevraagde wijziging toe op het workflowbestand.
long_description: Een sonnet-node met de sky-workflow-authoring-skill leest het bestaande bestand, past alleen de in het verzoek beschreven wijziging toe en behoudt al het overige - delimiterblokken, de enkele trigger, node-ids en referenties blijven consistent. Ververst het ASCII-stroomdiagram wanneer de wijziging de DAG-vorm verandert.
---

Leest `{{dir}}/{{name}}.sky`, past `{{request}}` toe en schrijft het bijgewerkte bestand. Linten gebeurt in de volgende stap.

---
short_description: Schrijft de walkthrough van de workflow in gewone taal.
long_description: Een haiku-node leest het opgeloste bestand en schrijft een gestructureerde walkthrough - samenvatting, trigger, elke --var-invoer, de node-DAG in afhankelijkheidsvolgorde, de betekenis van elke edge en een copy-pastebaar skyway run-commando. Vertaalt het delimiterformaat naar proza en bewerkt het bestand nooit.
---

Draait alleen wanneer resolve slaagde (`trigger_rule = "all_success"`). Gebruikt de `sky-workflow-authoring`-skill om het vier-delimiterformaat accuraat te lezen.

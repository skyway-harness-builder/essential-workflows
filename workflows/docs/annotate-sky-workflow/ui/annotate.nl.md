---
short_description: Voegt vóór elke node-config een rationale-commentaarblok toe.
long_description: Een sonnet-node met de sky-workflow-authoring-skill voegt direct vóór elke §id§-opener een bondig ※id※-blok toe dat het doel van de node en de betekenis van elke edge uitlegt. Al het overige - nodes, triggers, prompt-body's, het meta-blok - blijft exact behouden.
---

Bewerkt in situ met de Edit-tool (nooit bash/sed op delimiter-regels). Slaat een node alleen over wanneer er al een identieke `※<id>※`-rationale voor staat.

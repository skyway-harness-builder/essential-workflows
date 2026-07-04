---
short_description: Past minimale formaatfixes toe, alleen wanneer de probe faalde.
long_description: Vuurt alleen bij een gefaalde probe (trigger_rule one_failure), dus een schoon bestand kost nul tokens. Leest het bestand, past per gemelde SKY-WF-*- of SKY-CFG-*-code de kleinste fix toe en herlint binnen zijn eigen beurt tot skyway lint slaagt - met behoud van triggers, node-ids, edges en gedrag.
---

Sonnet-node met de `sky-workflow-authoring`-skill, begrensd door `max_budget_usd`. Alleen chirurgische bewerkingen; herschrijft nooit een hele node.

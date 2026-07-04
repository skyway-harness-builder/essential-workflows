---
short_description: Draait skyway lint in een loop op de gegenereerde workflow en fixt elke fout.
long_description: Elke pass draait skyway lint op het vers geschreven bestand, leest de gemelde SKY-WF-*-codes en bewerkt het bestand om ze op te lossen. Loopt tot lint met 0 eindigt, maximaal 6 passes.
---

Sonnet-node met de `sky-workflow-authoring`-skill. `loop.until.bash` bewaakt de loop met `skyway lint "{{dir}}/{{name}}.sky"`.

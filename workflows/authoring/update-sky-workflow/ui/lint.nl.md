---
short_description: Draait skyway lint in een loop op het bijgewerkte bestand en fixt elke fout.
long_description: Elke pass leest het bestand, draait skyway lint en herstelt alle gemelde SKY-WF-*-fouten en -waarschuwingen met de codetabel van de authoring-skill. Loopt tot lint schoon eindigt, maximaal 6 passes.
---

Sonnet-node met de `sky-workflow-authoring`-skill. `loop.until.bash` bewaakt de loop met `skyway lint "{{dir}}/{{name}}.sky"`.

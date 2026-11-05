---
short_description: Haiku gradeert elke workflow rood/amber/groen en schrijft HEALTH.md.
long_description: Leest de TSV-rijen van de checks-stap en past vaste graderingsregels toe; rood wanneer lint faalt, amber wanneer lint slaagt maar de workflow een LLM-node zonder cap heeft of nooit draaide, anders groen. Schrijft een HEALTH.md van één scherm (samenvattingsregel, gegradeerde tabel, korte legenda) in de bibliotheekmap en overschrijft een eerder rapport.
---
Eén enkele haiku-node; de `max_budget_usd = 0.5` van de workflow begrenst de kosten. De uitvoer landt op `{{dir}}/HEALTH.md`.

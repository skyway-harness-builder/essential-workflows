---
short_description: Herhaalt tot 3 verbeterrondes op de skill in een wegwerp-worktree.
long_description: Claude (sonnet) prompt-body-loop, draait alleen wanneer de gate delivers=false zegt. Elke ronde is een verse aanroep die de beoordeelde fouten bij de wortel aanpakt — SKILL.md verduidelijken, een ontbrekend helperscript toevoegen of een defect script repareren — en daarna opnieuw oefent en zichzelf beoordeelt.
---
Alle bewerkingen gebeuren onder `isolation = "worktree"`; de live checkout wordt nooit geraakt. Elke ronde schrijft een oordeel naar een per-run-sentinelbestand dat `loop.until.bash` grept op `delivers=true`; `loop.max = 3` begrenst de rondes. Beschermde bestanden (MISSION.md, FACTORY_RULES.md, `.github/`, `.sky/`, learnings) zijn verboden terrein.

---
short_description: Hernoemt de kandidaat naar zijn echte naam en opent een gestagete PR — merget nooit.
long_description: Claude (opus) onder worktree-isolatie; draait alleen wanneer de gate delivers=true zegt. Kiest de echte kebab-case-naam, schrijft de hernoemde workflow plus een `manifest.yaml`-entry, pusht een branch en opent een PR met een expliciete routing-aanbeveling in de body.
---
v1 routeert de PR standaard naar workflows-internal; een workflow naar de publieke repo verplaatsen is een bewuste menselijke beslissing. Beschermde bestanden (MISSION.md, FACTORY_RULES.md, `.github/`, `.sky/`-definities, learnings) worden nooit gecommit.

---
short_description: Schrijft een .sky-workflow vanuit een intentie in gewone taal, gegate door sky's eigen lint en dry-run, en staget daarna een PR.
long_description: "Meta-workflow die sky op sky dogfoodt: het genereert een kandidaat-workflow uit je intentie, herhaalt fixes tot `skyway lint` schoon is, valideert de DAG met `skyway run --dry-run`, laat een opus-judge de intentie-afstemming controleren en opent alleen bij een fail-closed gate een gestagete PR. v1 voert de gegenereerde workflow nooit echt uit — het bewijst structurele deugdelijkheid en intentie-afstemming, geen runtime-gedrag."
---
De pipeline: **parse** (haiku) schetst een auteursplan, **author** (opus) levert de volledige kandidaat onder de vaste sentinelnaam `forge-candidate`, **write-candidate** schrijft hem naar schijf, **fix-loop** (opus, max 3 rondes) herschrijft tot lint schoon is, **lint** en **dry-run** zijn de gezaghebbende bash-gates, **judge** (opus) toetst de kandidaat aan de intentie, **gate** (bash, fail-closed) vereist dat alle drie slagen, **finalize** hernoemt de kandidaat en opent een gestagete PR onder worktree-isolatie, en **cleanup** verwijdert het scratchbestand. Begrensd door `max_budget_usd = 8.00` en `loop.max = 3`.

| Variable | Betekenis |
|----------|-----------|
| `intent` | Beschrijving in gewone taal van de te schrijven workflow |

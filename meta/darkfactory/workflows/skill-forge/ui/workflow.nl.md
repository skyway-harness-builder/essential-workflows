---
short_description: Drijft één van je Claude Code-skills naar een meetbare kwaliteitslat en staget daarna een PR.
long_description: Gebruik dit wanneer een skill onder `.claude/skills/<name>/` ondermaats presteert of nooit is gemeten. Het synthetiseert een eval-suite uit de eigen beloften van de skill, oefent de skill uit, laat een opus-judge scoren en herhaalt verbeterrondes in een wegwerp-worktree tot een fail-closed gate slaagt — daarna opent het een PR die een mens merget.
---
De pipeline: **read-skill** dumpt de skill-bron in een grepbaar blok, **parse** (haiku) synthetiseert 3-5 controleerbare eval-cases, **baseline-exercise** (sonnet) draait de skill ertegen, **judge** (opus) scoort pass/fail per case en print een machine-sentinel, en **gate** (bash, fail-closed) beslist `delivers`. Bij false draait **improve** tot 3 sonnet-rondes die de skill bewerken in een geïsoleerde worktree. **lint-scripts** controleert gebundelde scripts statisch (`bash -n`, `node --check` — nooit uitgevoerd), en **finalize** commit de skill-boom op een branch en opent een PR. Idempotent: een al slagende skill levert geen PR op. Begrensd door `max_budget_usd = 8.00` en `loop.max = 3`.

| Variable | Betekenis |
|----------|-----------|
| `skill_name` | Doelskill-map onder `<repo>/.claude/skills/<skill_name>/` |

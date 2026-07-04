---
short_description: Past best-practice GitHub-instellingen toe via `gh` — org/account-standaarden en repo-hardening in één run.
long_description: "Gebruik dit om een GitHub-org en/of repository naar een geharde basislijn te brengen: merge-hygiëne, Dependabot, branch protection en secret scanning. Puur bash + `gh`, deterministisch, idempotent en fail-closed — opnieuw uitvoeren convergeert altijd naar dezelfde staat. Instellingen achter een betaald plan worden alleen toegepast als het tier of de repo-zichtbaarheid dat toelaat."
---
Preflight bepaalt de repo, org, scope en tier, controleert de rol van de aanroeper (repo-admin en/of org-owner) en geeft gating-booleans uit. Vijf gegate bash-knooppunten draaien daarna parallel: org-brede standaarden, repo-merge-hygiëne, Dependabot-alerts en auto-fixes, branch protection, en secret scanning met push protection. Een afsluitend rapport vat samen wat is toegepast versus overgeslagen, met redenen en handmatige vervolgstappen.

| Variable | Betekenis |
|----------|-----------|
| `scope` | `general` (org/account), `repo` of `both` (standaard `both`) |
| `tier` | Je GitHub-plan: `free` of `paid` (standaard `free`; tekst als "team"/"enterprise" wordt genormaliseerd naar `paid`) |
| `org` | Doelorg (optioneel; standaard de repo-eigenaar) |
| `repo` | Doelrepo als `owner/name` (optioneel; standaard de repo van de werkmap) |

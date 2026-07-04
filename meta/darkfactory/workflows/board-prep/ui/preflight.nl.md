---
short_description: Bepaalt owner, repo en project en controleert toegang vóór enige mutatie.
long_description: Deterministische bash + `gh`, geen LLM. Bepaalt de doelrepo uit `--var repo` of de werkmap, vereist `--var project` en controleert projecttoegang (heeft de `project`-auth-scope nodig). Fail-closed — als er iets ontbreekt stopt de hele run hier.
---
Geeft één JSON-regel `{owner, repo, project}` uit die elke volgende stap gebruikt. Leest het `$SKY_*`-env-kanaal rechtstreeks en shell-quotet elke expansie.

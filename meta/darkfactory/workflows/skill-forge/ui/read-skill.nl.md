---
short_description: Dumpt de SKILL.md en gebundelde scripts van de skill in één grepbaar blok.
long_description: Deterministische bash, geen LLM, alleen-lezen. Bepaalt de repo-checkout en de doelskill-map, en voegt daarna SKILL.md, een bestandsinventaris en elk gebundeld script samen tot een stabiel blok, begrensd door `=== skill-source ===`.
---
Dit blok is het kanaal waarlangs de guidance van de skill het model in latere stappen bereikt — `skills = [...]` zou niet werken omdat skill-namen daar niet `{{var}}`-getemplated zijn. Leest `$SKY_SKILL_NAME` uit het env-kanaal.

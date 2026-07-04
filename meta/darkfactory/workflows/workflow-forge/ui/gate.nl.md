---
short_description: "Fail-closed acceptatie-gate: lint schoon EN dry-run ok EN judge zegt true."
long_description: "Deterministische bash, geen LLM. Geeft `{\"delivers\":\"true|false\"}` uit — alleen true wanneer alle drie de signalen kloppen: lint schoon, dry_ok, en een geldige judge-sentinel die true zegt. Een ontbrekende of onleesbare sentinel, een overgeslagen dry-run of een vuile lint leveren allemaal false op."
---
Fail-closed omdat een onterechte "delivers" kapotte gegenereerde code als PR zou verschepen; een vals negatief kost alleen nog een loop.

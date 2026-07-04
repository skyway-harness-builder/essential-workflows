---
short_description: Valideert de DAG, vars, cycli en het budget van de kandidaat met skyway run --dry-run.
long_description: Deterministische bash, geen LLM; draait alleen wanneer lint schoon is. `skyway run forge-candidate --dry-run --format json` rendert de prompt van elk knooppunt en lost de DAG, variabelebekabeling, cyclus-check en budgetraming op zonder Claude aan te roepen of bash uit te voeren — de v1-veiligheidsgrens.
---
Lost de kandidaat op naam op uit de repo-tier `.sky/workflows/`. Exit 0 plus een niet-lege JSON-array levert `{"dry_ok":"true"}` op.

---
short_description: Dry-runt elke .sky-workflow in een map en print een PASS/FAIL/SKIP-planmatrix.
long_description: Draait `skyway run --dry-run` tegen elke workflow om templatesubstitutie en depends_on-bedrading te testen die statische lint niet ziet — een diepere klasse bugs dan skyway lint vangt. Puur bash, geen LLM-kosten. Stopt met een foutcode als een workflow niet kan plannen.
---
Drie bash-stappen: `discover` globt de map, `dryrun` voert per workflow een dry run uit en classificeert PASS/FAIL/SKIP, en `matrix` rendert een uitgelijnde samenvattingstabel. SKIP betekent dat de workflow variabelen nodig heeft die de audit niet kan leveren (een heuristiek op basis van stderr). Exitcodes: 0 alles geslaagd, 1 minstens één FAIL, 2 ongeldige invoermap.

| Variable | Meaning |
|----------|---------|
| `dir` | Absoluut pad naar de map met de `.sky`-bestanden (gelezen als `$SKY_DIR`) |

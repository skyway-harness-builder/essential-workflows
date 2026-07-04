---
short_description: Vindt secret-achtige env-var-referenties in .sky-bestanden die niet in secrets[] gedeclareerd zijn.
long_description: Scant elk .sky-bestand in een map op credential-achtige omgevingsvariabelen die in bash/http-regels gebruikt worden maar ontbreken in de secrets-array van die workflow. Puur bash, geen LLM-tokens. Een heuristische reviewer, geen parser — behandel bevindingen als "bekijk deze".
---
Eén `scan`-node controleert elk bestand: een naam is secret-achtig als hij een underscore bevat (bijv. `DATABASE_URL`) of matcht op `token|secret|password|passwd|apikey|credential` (hoofdletterongevoelig); `$SKY_*`-templatevariabelen zijn uitgezonderd. Stopt met een foutcode als er een ongedeclareerde referentie gevonden wordt.

| Variable | Meaning |
|----------|---------|
| `dir` | Map met `.sky`-bestanden om te scannen (bijv. `.sky/workflows`) |

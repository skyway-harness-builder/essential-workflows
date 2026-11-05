---
short_description: Lint elk .sky-bestand in een map in één keer en rapporteert pass/fail gegroepeerd per bestand.
long_description: De pre-flightcheck voordat je een workflow-library deelt of in CI opneemt. Puur bash, geen LLM-tokens. Stopt met een foutcode als een workflow de lint niet haalt, zodat het een pipeline kan bewaken.
---
Een `scan`-node somt de `.sky`-bestanden in de doelmap op (een lege map is een schone exit, geen fout), waarna `lint` per bestand `skyway lint` draait, OK/FAIL met foutcodes telt en met een foutcode stopt bij elke mislukking.

| Variable | Meaning |
|----------|---------|
| `dir` | Map met `.sky`-bestanden om te linten (bijv. `.sky/workflows`) |

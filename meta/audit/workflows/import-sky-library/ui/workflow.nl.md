---
short_description: Valideert een map met externe .sky-bestanden en importeert de lint-schone bestanden in een doelmap, achter een handmatige goedkeuringspoort.
long_description: Gebruik dit om legacy- of externe .sky-bestanden veilig op te nemen. Elke kandidaat wordt eerst gelint; bestanden die de lint niet halen worden afgewezen met hun foutcodes, bestanden die al in het doel bestaan worden overgeslagen, en er wordt niets gekopieerd totdat je het manifest goedkeurt. Puur bash, geen tokens verbruikt.
---
Vijf stappen: `enumerate` lijst de bronbestanden op, `validate` lint elke kandidaat en zet de geslaagde klaar, `gate` pauzeert voor handmatige goedkeuring met de PASS/FAIL/SKIP-sets, `finalize` kopieert de goedgekeurde bestanden (nooit overschrijven), en `verify` lint elk geïmporteerd bestand opnieuw op zijn nieuwe plek.

| Variable | Betekenis |
|----------|-----------|
| `source` | Map met de externe/legacy `.sky`-bestanden om te importeren. |
| `dir` | Doelmap met `.sky`-workflows om in te importeren. |

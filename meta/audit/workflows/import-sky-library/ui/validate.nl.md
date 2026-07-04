---
short_description: Lint elke kandidaat en deelt hem in als PASS, FAIL of SKIP.
long_description: Draait `skyway lint` op elk kandidaatbestand. Lint-schone bestanden die nog niet in het doel bestaan worden klaargezet in een tijdelijke lijst onder /tmp; fouten worden gelogd met hun SKY-* foutcodes; bestanden met dezelfde naam die al in het doel staan krijgen SKIP.
---
Levert de PASS/FAIL/SKIP-sets die de handmatige poort zal tonen. Alleen klaargezette PASS-bestanden kunnen ooit geïmporteerd worden.

---
short_description: Lint elk geïmporteerd bestand opnieuw en ruimt de staging-lijst op.
long_description: Draait `skyway lint` op elk vers gekopieerd bestand om te bevestigen dat het op zijn nieuwe plek nog schoon is, en verwijdert daarna de staging-lijst in /tmp. Eindigt met een niet-nul exitcode als een geïmporteerd bestand kapot is, waardoor de run faalt.
---
Laatste veiligheidscheck: een import telt pas als geslaagd wanneer elk geland bestand schoon lint in de doelmap.

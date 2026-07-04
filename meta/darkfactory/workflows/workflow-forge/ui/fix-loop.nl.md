---
short_description: Herhaalt opus-herschrijvingen van de kandidaat tot skyway lint hem schoon meldt.
long_description: "Opus-loop met `context = \"fresh\"` — elke fixronde start vanuit een schone sessie. De stopconditie is de lint zelf: `loop.until.bash` draait `skyway lint` op de kandidaat en eindigt met 0 wanneer schoon; `loop.max = 3` begrenst de kosten."
---
Elke ronde leest de lint-diagnostiek en herschrijft het hele bestand ter plekke om de gemelde `SKY-WF-*` / `SKY-CFG-*`-codes op te lossen, met behoud van de naam `forge-candidate` en het beoogde gedrag — repareer het formaat, niet de intentie.

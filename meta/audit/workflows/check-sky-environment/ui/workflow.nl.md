---
short_description: Preflight-dokter — controleert de hostomgeving en meldt wat stuk zal gaan vóór een workflow faalt.
long_description: Een verse sky-installatie kan gezond lijken tot de eerste run stukloopt op iets dat de daemon nooit controleert — een ontbrekende claude CLI, een niet-ingelogde gh, een onbereikbare git origin, of een secret dat in een workflow gedeclareerd is maar nooit geëxporteerd. Deze pure-bash dokter met één node controleert dat allemaal in seconden en eindigt met een foutcode bij elke harde fout, dus hij past ongewijzigd in CI of een ochtend-cron.
changelog:
  - version: "1.0.0"
    date: "2026-07-04"
    note: "Eerste release."
---

Eén pure-bash node, geen LLM-kosten. Print per controle één `OK | WARN | FAIL`-regel:

| Controle | Bij falen |
|----------|-----------|
| claude CLI op PATH | FAIL — prompt-nodes kunnen niet draaien |
| gh aanwezig + ingelogd | FAIL bij niet ingelogd, WARN bij afwezig |
| git origin bereikbaar | FAIL wanneer geconfigureerd maar onbereikbaar |
| daemon `/health` | WARN — schedules/webhooks vuren niet |
| gedeclareerde `secrets[]` gezet in env | FAIL per ontbrekende variabele |

Draai met `--var dir=<library-map>` (gescand op `secrets[]`-declaraties).

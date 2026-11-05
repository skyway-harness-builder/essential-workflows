---
short_description: Schat de LLM-kosten per workflow in een map en markeert Claude-workflows zonder max_budget_usd-limiet.
long_description: Scant elk .sky-bestand in een map, telt Claude-nodes en modelniveaus, en rangschikt workflows op ruw kostenrisico. Gebruik dit voordat je een library deelt of in CI, om workflows te vangen die onbeperkt kunnen uitgeven. De dollarbedragen zijn triagehints; de ontbrekende-limiet-vlag is het betrouwbare signaal.
---
Draait in twee stappen: een bash-node `scan` globt `"$SKY_DIR"/*.sky` en produceert één TSV-regel per bestand (naam, aantal Claude-nodes, limiet aanwezig, modellen), waarna een haiku-node `report` workflows rangschikt op ruw kostenrisico en elke ongelimiteerde LLM-workflow toont met een voorgestelde limiet.

| Variable | Meaning |
|----------|---------|
| `dir` | Map die gescand wordt op `.sky`-bestanden (gelezen als `$SKY_DIR`; standaard `.sky/workflows`) |

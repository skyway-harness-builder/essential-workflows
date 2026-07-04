---
short_description: Rangschikt workflows op ruw kostenrisico en toont elke ongelimiteerde Claude-workflow met een voorgestelde limiet.
long_description: "Een haiku-node die de TSV-uitvoer van de scan leest en drie secties oplevert: workflows zonder max_budget_usd-limiet (met voorgestelde limieten), een benaderende kostenrisico-ranglijst en samenvattende tellingen. Draait alleen als de scan slaagt."
---
Werkt uitsluitend op `SKY_OUTPUT_SCAN` — geen tools, geen bestandsleesacties. Voorgestelde limieten komen uit een grove heuristiek op basis van node-aantal en modelniveau (opus x4, sonnet x2, haiku x1), niet uit echte tokenafrekening.

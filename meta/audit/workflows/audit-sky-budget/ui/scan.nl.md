---
short_description: Globt de doelmap en classificeert elk .sky-bestand op Claude-gebruik en budgetlimiet.
long_description: Telt prompt-/model-nodes per bestand, detecteert of een max_budget_usd-limiet is opgegeven en registreert welke modelniveaus voorkomen. Stopt met een foutcode als de map ontbreekt of leeg is, zodat de run faalt vóór er Claude-kosten zijn.
---
Produceert één TSV-regel per bestand: naam, aantal Claude-nodes, `has_cap`, modellen. Leest de doelmap uit `$SKY_DIR`.

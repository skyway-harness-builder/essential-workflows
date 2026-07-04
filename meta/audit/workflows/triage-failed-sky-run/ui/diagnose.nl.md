---
short_description: Benoemt de falende node en de concrete oorzaak.
long_description: Een sonnet-node leest de vastgelegde logs en workflow-broncode, identificeert de falende node-id, en stelt vast welke regel, config, bash of prompt de faal veroorzaakte en waarom. Het vermeldt de betrouwbaarheid en of de conclusie op een logregel of op broncode-inferentie steunt. Het bewerkt niets.
---
Als de logs geen node noemen, zegt het dat en leidt het de meest waarschijnlijke oorzaak af uit de broncode plus eventuele fouttekst. Gebruikt de sky-workflow-authoring-skill.

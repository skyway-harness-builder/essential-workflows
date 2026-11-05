---
short_description: Verzamelt de drie gezondheidssignalen per workflow in TSV-rijen.
long_description: Registreert per bestand `skyway lint` pass/fail, of een claude-node een max_budget_usd-cap mist, en de laatste-run-recentheid (best effort) uit `skyway logs`. Produceert één tab-gescheiden rij per workflow die de render-stap gradeert.
---
TSV-kolommen: workflow, lint, llm_uncapped, last_run. De recentheidscheck is een tekst-grep over de run-historie, dus "never" is best effort.

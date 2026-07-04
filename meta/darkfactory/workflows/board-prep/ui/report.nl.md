---
short_description: Vat de run samen en toont de twee handmatige UI-stappen die de API niet kan.
long_description: Deterministische bash, geen LLM. Het enige eindknooppunt — het hangt af van labels, link en fields met `trigger_rule = all_done`, dus er komt altijd een samenvatting, ook als een eerdere stap faalde.
---
Herhaalt de output van elk voorgaand knooppunt en toont daarna de twee GitHub Projects-UI-stappen zonder publieke API: de Auto-add-workflow inschakelen gefilterd op deze repo, en de label-naar-Status-kolomautomatisering instellen.

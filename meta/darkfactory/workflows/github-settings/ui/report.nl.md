---
short_description: Vat toegepaste versus overgeslagen instellingen samen per scope en tier.
long_description: Deterministische bash, geen LLM. Het eindknooppunt — het hangt af van alle vijf apply-knooppunten met `trigger_rule = all_done`, dus het draait altijd en levert altijd een samenvatting, inclusief skip-redenen zoals "geen org-owner".
---
Toont per knooppunt wat is toegepast of overgeslagen, de `general_skip_reason` wanneer org-scope werd overgeslagen, en handmatige vervolgstappen zoals org-brede 2FA inschakelen (`two_factor_requirement_enabled` is read-only in de API en wordt alleen gerapporteerd).

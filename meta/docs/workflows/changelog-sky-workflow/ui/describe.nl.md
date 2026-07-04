---
short_description: Zet de diff om in één beoordeelbare changelog-bullet.
long_description: Een haiku-node leest de diff en schrijft precies één markdown-bullet die beschrijft wat er veranderde in beoordeelbare termen - toegevoegde en verwijderde nodes, herbedrade edges, trigger-, budget-, model- en prompt- of bash-wijzigingen. Geeft "- no changes" wanneer de diff leeg is.
---

Leest `$SKY_OUTPUT_DIFF`; citeert nooit rauwe diff-regels, geen koppen of extra tekst.

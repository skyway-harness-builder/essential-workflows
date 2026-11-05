---
short_description: Difft de working tree tegen HEAD voor het doelbestand.
long_description: Produceert de unified git diff van de niet-gecommitte wijzigingen van de workflow. Zonder wijzigingen zendt hij een stabiele no-change-marker uit in plaats van te falen, zodat de run alsnog een changelog-regel oplevert.
---

Puur bash. De diff (of `NO_UNCOMMITTED_CHANGES`) komt in `$SKY_OUTPUT_DIFF` voor de describe-stap.

---
short_description: Herschrijft alle drie tokenvormen in elk geraakt bestand.
long_description: Voor elk bestand dat de scan markeerde, herschrijft een portable temp-file sed de template-vorm, de bash-env-vorm (met word-boundary-bescherming), de node-id-vorm met de bijbehorende prompt-blok-opener, en de gequote id-referenties in depends_on en chain_from. Alleen bestanden die daadwerkelijk een vorm bevatten worden aangeraakt.
---

Puur bash, geen `sed -i`. Herschrijft `{{old}}` -> `{{new}}`, `$SKY_<UPPER_OLD>` -> `$SKY_<UPPER_NEW>`, `§old§`/`∆old∆` -> `§new§`/`∆new∆`, en gequote `"old"` id-referenties.

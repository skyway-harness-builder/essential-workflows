---
short_description: Hernoemt één token in bulk over elke .sky in een map, consistent over de drie syntactische vormen.
long_description: Een var-sleutel of node-id komt op drie plekken in een .sky-bestand voor - template {{old}}, bash-env $SKY_<UPPER_OLD>, en node-id §old§ plus gequote id-referenties - en een rename moet alle drie raken of de workflow breekt. Deze codemod herschrijft alle vormen in één pass, achter een handmatige goedkeuring omdat de regex-rewrite fragiel is, en lint-verifieert daarna elk aangeraakt bestand. Puur bash, geen LLM-tokens.
---

Draait in vier stappen: **scan** (grept alle drie vormen, toont elke hit), **gate** (handmatige goedkeuring, timeout 1u), **apply** (portable temp-file sed per geraakt bestand), **verify** (`skyway lint` op elke `.sky`, exit 1 als er één faalt). Gebruik bij voorkeur lange, onderscheidende tokens en draai in een git working tree zodat je kunt `git diff`-en of terugdraaien.

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `dir` | Map met `.sky`-bestanden voor de codemod (bijv. `.sky/workflows`) |
| `old` | Bestaand token (kebab-case `--var`-sleutel of node-id), zonder `$SKY_` / `§` |
| `new` | Vervangend token (kebab-case), zonder `$SKY_` / `§` |

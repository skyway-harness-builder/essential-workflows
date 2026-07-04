---
short_description: Fail-closed gate die de sentinel van de judge omzet in schone JSON.
long_description: "Deterministische bash, geen LLM. Grept de judge-output op de `SKY_FORGE delivers=...`-sentinel en geeft één schone JSON-regel `{\"delivers\":\"true|false\"}` uit zodat de volgende `when`-conditie altijd parset. Een ontbrekende of onleesbare sentinel levert false op."
---
Bewust fail-closed: een onterechte "delivers=true" zou een kapotte skill via PR verschepen, terwijl een onterechte "delivers=false" alleen een begrensde improve-loop draait — de duurste fout wordt afgeschermd.

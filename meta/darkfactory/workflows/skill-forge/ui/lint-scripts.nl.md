---
short_description: Lint de gebundelde scripts van de skill statisch — alleen parsen, nooit uitvoeren.
long_description: Deterministische bash, geen LLM. Draait `bash -n` op shellscripts en `node --check` op JavaScript waar een toolchain in de container aanwezig is. Talen zonder toolchain (bv. Go) worden doorgeschoven naar CI op de gepushte branch.
---
Bewust niet-fataal: een gefaalde statische check wordt in de PR-body gerapporteerd in plaats van te blokkeren; CI op de gepushte branch is de echte gate. Scripts worden geparset, nooit uitgevoerd — onderdeel van de v1-veiligheidsscope.

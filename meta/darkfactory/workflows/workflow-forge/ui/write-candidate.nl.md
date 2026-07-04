---
short_description: Schrijft de geschreven kandidaat letterlijk naar de twee paden die de gates nodig hebben.
long_description: Deterministische bash, geen LLM. Bewaart de volledige stdout van de author naar `.sky/workflows/forge-candidate.sky` (zodat `skyway run forge-candidate --dry-run` hem op naam vindt) en naar een stabiele `$RUNTMP`-kopie voor lint en latere inspectie.
---
Geen templating en geen shell-splicing van modeloutput in commando's — de onvertrouwde output belandt alleen in een bestand. Print een grepbaar padblok dat de volgende gates lezen.

---
short_description: Scoort elke eval-case pass/fail en wijst aan waar elke fout zit.
long_description: Claude (opus). Beoordeelt de baseline-transcripten tegen de pass-criteria van elke case, classificeert elke fout als prose-ambiguity, missing-script of script-bug, stelt een concrete fix voor en berekent de pass rate. Delivers is alleen true bij pass_rate >= 0.8 zonder script-bugs.
---
Het gestructureerde `output_format` is puur adviserend; het contract is de afsluitende machine-sentinelregel `SKY_FORGE delivers=<true|false> pass_rate=<n>`, die de deterministische gate-stap grept.

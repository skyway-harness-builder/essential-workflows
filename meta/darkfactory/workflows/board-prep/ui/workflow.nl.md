---
short_description: Bereidt een repo en zijn GitHub Project voor op de Dark Factory-ladder — labels, projectkoppeling, veldschema-check.
long_description: Onboardingstap (trede 0) voor de Dark Factory-ladder op GitHub. Een Projects v2-template reproduceert de bordstructuur, maar bevat nooit repo-gebonden labels of de auto-add-workflow; deze workflow vult precies dat gat. Puur bash + `gh`, deterministisch, idempotent en fail-closed — altijd veilig opnieuw uit te voeren.
---
Voert vijf deterministische bash-stappen uit tegen de repo van de aanroeper en een GitHub Project dat je per nummer doorgeeft:

1. **preflight** — bepaalt owner/repo/project en controleert toegang; breekt af als er iets ontbreekt.
2. **labels**, **link**, **fields** (parallel) — maakt de 9 lifecycle-labels aan op de repo, koppelt het project aan de repo en controleert of het project het dark-factory-veldschema draagt (alleen-lezen).
3. **report** — vat samen wat er is gedaan en toont de twee handmatige UI-stappen die de GitHub API niet kan uitvoeren (auto-add-workflow, label-naar-Status-automatisering).

| Variable | Betekenis |
|----------|-----------|
| `project` | GitHub Project-nummer (verplicht) |
| `owner` | Org of gebruiker die het project bezit (optioneel; standaard de repo-eigenaar) |
| `repo` | Doelrepo als `owner/name` (optioneel; standaard `gh repo view` in de werkmap) |

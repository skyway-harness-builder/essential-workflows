---
short_description: Lint één .sky-bestand en past, alleen bij gemelde problemen, minimale formaatfixes toe tot het schoon is.
long_description: Brengt een workflowbestand naar het huidige .sky-formaat zonder tokens uit te geven aan bestanden die al schoon zijn. Een bash-probe eindigt met de exitstatus van lint zelf; de Claude-fix-node vuurt alleen bij een fout (trigger_rule one_failure), past de kleinste bewerkingen toe die elke diagnose oplossen, en een afsluitende diff-stap toont altijd wat er veranderde.
---

Draait in drie stappen: **probe** (`skyway lint`, exitcode bepaalt het vervolg), **fix** (sonnet, alleen bij lint-falen, herlint tot schoon), **diff** (`git diff`, draait altijd - leeg wanneer het bestand al schoon was).

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `dir` | Map met het bestand (een git-repo) |
| `name` | Workflow-naam zonder `.sky`; het bestand is `<dir>/<name>.sky` |

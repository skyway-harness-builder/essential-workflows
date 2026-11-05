---
short_description: Leest elke .sky en schrijft de INDEX.md-tabel.
long_description: Een haiku-node leest elk workflowbestand, haalt de naam, het triggertype, de verwachte vars, een éénregelige DAG-schets en het budget eruit, en schrijft ze als een gesorteerde Markdown-tabel naar INDEX.md. Alleen lezen - er wordt nooit een .sky-bestand gewijzigd.
---

Schrijft `{{dir}}/INDEX.md` met een `| Workflow | Trigger | Vars | Flow | Budget |`-tabel, één rij per workflow.

---
short_description: Post een platte-tekstbericht naar Slack via een incoming-webhook env-var.
long_description: Orchestratie-workflows moeten geen Slack-webhook-curl opnieuw implementeren. Deze deterministische micro-workflow leest de webhook-URL uit een benoemde env-var, bouwt de JSON-payload met jq -n en POST met curl --fail --max-time 30. Roep hem aan vanuit een workflow of draai handmatig. Geen retry op de sink.
changelog:
  - version: "1.0.0"
    date: "2026-07-14"
    note: "Eerste release."
---

Eén pure-bash node. De webhook-URL wordt indirect opgehaald via `webhook_env_name` (bijvoorbeeld `SLACK_WEBHOOK_URL`).

| Variabele | Betekenis |
|-----------|-----------|
| `webhook_env_name` | Naam van de env-var met de Slack incoming webhook URL |
| `text` | Platte-tekst bericht |

Aanroepen vanuit een andere workflow:

```
invoke = { target = "post-slack", vars = { webhook_env_name = "SLACK_WEBHOOK_URL", text = "..." } }
```
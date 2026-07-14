---
short_description: Verstuur één transactionele e-mail via het skyway-daemon mail-endpoint.
long_description: Elke orchestratie-workflow schreef vroeger zelf curl, JSON-quoting en bearer-token-conventies voor e-mail. Deze deterministische micro-workflow neemt to, subject, content en optioneel html aan, bouwt de payload met jq -n en POST naar de daemon mail-API. Roep hem aan vanuit een workflow of draai handmatig. Geen retry op de sink.
changelog:
  - version: "1.0.0"
    date: "2026-07-14"
    note: "Eerste release."
---

Eén pure-bash node. Authenticatie gebruikt `EMAIL_API_TOKEN` wanneer gezet, anders `SKY_MAIL_TOKEN` geïnjecteerd door de daemon.

| Variabele | Betekenis |
|-----------|-----------|
| `to` | E-mailadres ontvanger |
| `subject` | Onderwerpregel |
| `content` | Platte-tekst body |
| `html` | Optionele HTML-body |

Aanroepen vanuit een andere workflow:

```
invoke = { target = "send-email", vars = { to = "...", subject = "...", content = "..." } }
```
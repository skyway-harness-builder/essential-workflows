---
short_description: Send one transactional email via the skyway daemon mail endpoint.
long_description: Every orchestration workflow used to hand-write curl, JSON quoting, and bearer-token conventions for email. This deterministic micro-workflow accepts to, subject, content, and optional html, builds the payload with jq -n, and POSTs to the daemon mail API. Invoke it from any workflow or run it manually. No retry on the sink.
changelog:
  - version: "1.0.0"
    date: "2026-07-14"
    note: "Initial release."
---

One pure-bash node. Auth uses `EMAIL_API_TOKEN` when set, otherwise `SKY_MAIL_TOKEN` injected by the daemon.

| Variable | Meaning |
|----------|---------|
| `to` | Recipient email address |
| `subject` | Subject line |
| `content` | Plain-text body |
| `html` | Optional HTML body |

Invoke from another workflow:

```
invoke = { target = "send-email", vars = { to = "...", subject = "...", content = "..." } }
```
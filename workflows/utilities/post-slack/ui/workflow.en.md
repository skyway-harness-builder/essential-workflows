---
short_description: Post a plain-text message to Slack via an incoming webhook env var.
long_description: Orchestration workflows should not re-implement Slack webhook curl. This deterministic micro-workflow reads the webhook URL from a named env var, builds the JSON payload with jq -n, and POSTs with curl --fail --max-time 30. Invoke it from any workflow or run it manually. No retry on the sink.
changelog:
  - version: "1.0.0"
    date: "2026-07-14"
    note: "Initial release."
---

One pure-bash node. The webhook URL is resolved indirectly from `webhook_env_name` (for example `SLACK_WEBHOOK_URL`).

| Variable | Meaning |
|----------|---------|
| `webhook_env_name` | Env var name holding the Slack incoming webhook URL |
| `text` | Plain-text message body |

Invoke from another workflow:

```
invoke = { target = "post-slack", vars = { webhook_env_name = "SLACK_WEBHOOK_URL", text = "..." } }
```
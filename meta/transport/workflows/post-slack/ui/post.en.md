---
short_description: Resolve the webhook URL and POST the jq-built Slack payload.
long_description: Indirectly expands webhook_env_name to read the URL from the run environment, builds {text: ...} with jq -n, and POSTs with curl --fail --max-time 30. No retry.
---
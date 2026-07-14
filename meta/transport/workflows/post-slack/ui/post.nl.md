---
short_description: Haal de webhook-URL op en POST de jq-gebouwde Slack-payload.
long_description: Expandeert webhook_env_name indirect om de URL uit de run-omgeving te lezen, bouwt {text: ...} met jq -n en POST met curl --fail --max-time 30. Geen retry.
---
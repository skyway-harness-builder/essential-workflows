---
short_description: POST the jq-built mail payload to the daemon /api/mail/send endpoint.
long_description: Builds JSON with jq -n from the run vars, authenticates with Bearer EMAIL_API_TOKEN or SKY_MAIL_TOKEN, and POSTs with curl --fail --max-time 30. No retry.
---
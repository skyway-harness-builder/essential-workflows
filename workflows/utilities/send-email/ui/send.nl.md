---
short_description: POST de jq-gebouwde mail-payload naar het daemon /api/mail/send endpoint.
long_description: Bouwt JSON met jq -n uit de run-vars, authenticeert met Bearer EMAIL_API_TOKEN of SKY_MAIL_TOKEN, en POST met curl --fail --max-time 30. Geen retry.
---
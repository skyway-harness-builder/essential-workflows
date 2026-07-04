---
short_description: "Past org-brede standaarden toe: read-only basispermissie, commit-signoff, Dependabot voor nieuwe repos."
long_description: "Stelt org-brede standaarden in via de GitHub API: `default_repository_permission=read`, verplichte web-commit-signoff, en Dependabot-alerts plus security-updates voor nieuwe repositories. Op het betaalde tier ook de org-standaarden voor advanced security en secret scanning voor nieuwe repos."
---
Draait alleen wanneer preflight `do_general == 'true'` berekende (org-scope gevraagd en de aanroeper is org-owner). Betaald-only-velden worden in het script gegate en falen netjes.

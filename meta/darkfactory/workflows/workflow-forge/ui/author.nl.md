---
short_description: Genereert de volledige kandidaat-.sky-body onder de sentinelnaam forge-candidate.
long_description: Claude (opus). Produceert een compleet, lint-schoon `.sky`-bestand dat `{{intent}}` vervult, volgens het parse-plan en de volledige `.sky`-formaatregels. De ⊕meta⊕-naam moet exact `forge-candidate` zijn zodat de dry-run-resolver hem op naam vindt.
---
Levert uitsluitend de rauwe bestandsbody — geen fences, geen proza — omdat de volgende stap zijn stdout letterlijk naar schijf schrijft. De echte workflownaam wordt later gekozen, op PR-moment.

---
short_description: Configureert de verse clone en pusht de eerste commit.
long_description: Cloont de nieuwe repo naar een tijdelijke map, voert de vendor-token-vervangingen uit, hernoemt de map workflows/__vendor__/ naar de echte vendor-slug, stript de delete-blokken uit de README, en commit en pusht daarna. De tijdelijke map wordt bij afloop opgeruimd.
---

Puur bash met `python3` voor de token-vervangingen (vendor, author, date).

---
short_description: Maakt de GitHub-repo aan vanuit het skelettemplate.
long_description: Draait gh repo create met het workflow-collection-skeleton-template, publieke zichtbaarheid en de opgegeven beschrijving. Faalt wanneer de repo al bestaat - een bestaande collectie wordt nooit overschreven.
---

Puur bash: `gh repo create <org>/<repo> --template workflow-collection-skeleton --public`.

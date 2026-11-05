---
short_description: Validates gh, authentication, and the required vendor var.
long_description: Checks that the gh CLI is installed and authenticated and that the vendor variable is set, then prints the resolved configuration (org, repo, vendor, vendor-name). Exits early so nothing is created when preconditions fail.
---

Pure bash. Defaults are resolved here: `repo` falls back to `<vendor>-workflows`, `org` to the authenticated user.

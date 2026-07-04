---
short_description: Commit de verbeterde skill op een branch en opent een PR — merget nooit.
long_description: Bash + `gh` onder worktree-isolatie. Commit uitsluitend bestanden onder de doelskill-map en opent een PR; CI plus menselijke review is de merge-gate. Idempotent — als de worktree geen wijzigingen heeft (skill slaagde al, of improve bewerkte niets) print het "already passing" en opent het niets.
---
Verdediging in de diepte op de protected-files-grens: de commit is beperkt met een expliciete pathspec, en een guard faalt gesloten als een gestaged pad matcht op MISSION.md, FACTORY_RULES.md, `.github/`, `.sky/` of learnings.

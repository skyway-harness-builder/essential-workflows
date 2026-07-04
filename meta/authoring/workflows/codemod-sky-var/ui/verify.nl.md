---
short_description: Lint elke .sky in de map opnieuw na de rewrite.
long_description: Draait skyway lint over elk .sky-bestand in de map en eindigt met een foutcode als er één faalt, zodat een slechte codemod direct zichtbaar wordt. De fragiele rewrite is pas te vertrouwen als dit slaagt - bekijk sowieso git diff.
---

Pure bash-gate. Een aangeraakt bestand met een kapotte referentie is precies de fout die deze stap moet vangen.

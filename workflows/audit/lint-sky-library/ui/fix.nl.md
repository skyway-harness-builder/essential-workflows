---
short_description: Claude bewerkt elk falend bestand ter plekke totdat het schoon lint.
long_description: Draait alleen wanneer de scan faalde (trigger_rule one_failure). Een sonnet-node leest elk falend bestand, past de standaardfix toe voor elke SKY-WF-* code, en lint opnieuw na elke bewerking. Bestanden die al slaagden worden nooit aangeraakt.
---
Gebruikt de sky-workflow-authoring-skill en zijn foutcodetabel. Maakt de minimale wijziging die de lint schoon krijgt en behoudt de trigger, DAG en veiligheidsmaatregelen van elk bestand.

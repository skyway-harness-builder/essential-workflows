---
short_description: Greps listener and emitter event names from every .sky file into scratch lists.
long_description: Extracts trigger.sky_event.event names and every emit name from files under $SKY_DIR, covering all three emit forms (`emit = "x"`, `emit.name = "x"`, inline table). Writes two scratch lists to /tmp for the match step.
---
Emit detection is word-anchored so the meta `name =` key never matches.

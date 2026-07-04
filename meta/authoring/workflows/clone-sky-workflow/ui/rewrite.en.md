---
short_description: Retargets the clone's name and strips every trigger line.
long_description: Two portable temp-file sed edits on the destination - rename the meta name to the new name, then delete every line starting with trigger. so the clone cannot double-fire with its source. With no trigger block the clone is manual by default, which is what a fresh template should be.
---

Pure bash, no `sed -i` (BSD and GNU differ). The trigger strip is the whole point of this workflow.

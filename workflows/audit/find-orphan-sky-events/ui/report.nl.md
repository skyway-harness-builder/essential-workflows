---
short_description: Print beide wezenlijsten en stopt met exitcode 1 als er een loshangende verbinding bestaat.
long_description: Rapporteert dode listeners (events die niemand emit) en dode signalen (emits waar niemand naar luistert) en ruimt daarna de tijdelijke bestanden op. De niet-nul exitcode maakt de audit CI-vriendelijk.
---
Draait na `match`.

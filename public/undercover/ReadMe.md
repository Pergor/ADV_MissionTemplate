Sets player on captive if he changes to an enemy uniform if param is set to true.
Additionally he can 'go undercover' if he has no weapon equipped or isn't seated in an armed vehicle if the param isn't set or is set to false.
The player will be uncovered if he comes closer than 8 meters to an enemy unit.
CBA_A3 is required.

- Copy over the undercover-folder.
- Copy over initPlayerLocal.sqf or add this to your initPlayerLocal.sqf:

	[false] call compile preprocessFileLineNumbers "undercover\fn_undercover.sqf";
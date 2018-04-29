/*
 * Author: SENSEI, Belbo
 *
 * Sets side of group or array of units (groups units afterwards).
 *
 * Arguments:
 * 0: group/units - <GROUP> or <ARRAY> of <OBJECTS>
 * 1: new side - <SIDE> or <NUMBER>
 *
 * Return Value:
 * new group - <GROUP>
 *
 * Example:
 * [(group this), west] call adv_fnc_setSide;
 *
 * Public: Yes
 */

params [
	["_units", [], [[],grpNull]],
	["_side", west, [west]],
	"_newgrp"
];

if (_side isEqualType 0) then {
	_side = _side call BIS_fnc_sideType;
};

_newgrp = createGroup _side;
call {
	if (_units isEqualType []) exitWith {
		{[_x] joinSilent _newgrp} count _units;
	};
	if (_units isEqualType grpNull) exitWith {
		{[_x] joinSilent _newgrp} count (units _units);
	};
};

_newgrp;
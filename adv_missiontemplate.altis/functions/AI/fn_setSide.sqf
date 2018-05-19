/*
 * Author: SENSEI, Belbo
 *
 * Sets side of group or array of units (groups units afterwards).
 *
 * Arguments:
 * 0: group/unit/units - <GROUP>, <OBJECT>, or <ARRAY> of <OBJECTS>
 * 1: new side - <SIDE> or <NUMBER>
 * 1: existing group/unit, will overwrite side with the side of the existing group/unit (optional) - <GROUP> or <OBJECT>
 *
 * Return Value:
 * group the unit is now in - <GROUP>
 *
 * Example:
 * [group _unit, west] call adv_fnc_setSide;
 * or
 * [_unit, 1] call adv_fnc_setSide;
 * or
 * [[_unit1,_unit2], west, _leader] call adv_fnc_setSide;
 *
 * Public: Yes
 */

params [
	["_units", [], [[],grpNull,objNull]],
	["_side", west, [west,0]],
	["_grp", grpNull, [grpNull,objNull]]
];

if (_side isEqualType 0) then {
	_side = _side call BIS_fnc_sideType;
};

private _newgrp = if ( _grp isEqualType grpNull && {!(_grp isEqualTo grpNull)} ) then { _grp } else {
	if ( _grp isEqualType objNull && {!(_grp isEqualTo objNull)} ) then { group _grp } else {
		createGroup _side
	};
};
call {
	if (_units isEqualType objNull) exitWith {
		[_units] joinSilent _newgrp;
	};
	if (_units isEqualType []) exitWith {
		{[_x] joinSilent _newgrp} count _units;
	};
	if (_units isEqualType grpNull) exitWith {
		{[_x] joinSilent _newgrp} count (units _units);
	};
};

_newgrp;
/*
 * Author: Belbo
 *
 * Sets all units of this group safe for a given time
 *
 * Arguments:
 * 0: unit, units or group to set safe. group or unit has to be local. - <OBJECT> or <GROUP> or <ARRAY> of <OBJECTS>
 * 1: time until captive status is lifted - <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_grp,10] call adv_fnc_setSafe;
 *
 * Public: Yes
 */

params [
	[ "_grp",grpNull,[objNull,grpNull,[]] ]
	,[ "_time",10,[0] ]
];

private _targets = call {
	if (_grp isEqualType grpNull) exitWith {units _grp};
	if (_grp isEqualType objNull) exitWith {[_grp]};
	if (_grp isEqualType []) exitWith {_grp};
	[]
};

{_x setCaptive true} count _targets;
[_targets,_time] spawn {
	params ["_targets","_time"];
	sleep _time;
	{_x setCaptive false} count _targets;
	sleep 1;
	{_x setCaptive false} count _targets;
};

nil;
/*
 * Author: Belbo
 *
 * Changes ownership of units to HC
 *
 * Arguments:
 * 0: HC - <OBJECT>
 * 1: Array of units (optional) - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [HC1, allUnits] call adv_fnc_HCobjects;
 *
 * Public: Yes
 */

if (!isServer) exitWith {};

params [
	["_HC", objNull, [objNull]],
	["_units", allUnits, [[]]]
];

{
	if (!isPlayer _x && !(_x getVariable ["Owned_by_HC",false])) then {
		_x setOwner (owner _HC);
		_x setVariable ["Owned_by_HC",true];
	};
	nil;
} count _units;

true;
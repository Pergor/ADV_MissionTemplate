/*
 * Author: Belbo
 *
 * Outputs all vehicles that contain at least one unit of specified group.
 *
 * Arguments:
 * Group - <GROUP>
 *
 * Return Value:
 * Vehicles - <ARRAY> of <OBJECTS>
 *
 * Example:
 * [group player] call adv_fnc_getGroupVehicles;
 *
 * Public: Yes
 */

params [
	["_grp",grpNull,[grpNull]]
];

private _vehicles = [];

{
	_vehicle = (vehicle _x);
	if ( _vehicle isKindOf "LANDVEHICLE" || _vehicle isKindOf "SEAVEHICLE" || _vehicle isKindOf "AIR" ) then {
		_vehicles pushBackUnique _vehicle;
	};
} forEach (units _grp);

_return = _vehicles;

_return;
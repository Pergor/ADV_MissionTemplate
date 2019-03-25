/*
 * Author: Belbo
 *
 * Finds the nearest entity that has a certain variable set in the provided radius.
 *
 * Arguments:
 * 0: target - <OBJECT>
 * 1: variable name. Only variables with boolean values are allowed - <STRING>
 * 2: radius (optional - default is 500 meters) - <NUMBER>
 *
 * Return Value:
 * Found closest entity or objNull if no entity with the given variable is within radius - <OBJECT>
 *
 * Example:
 * [player,"adv_var_isJamming",500] call adv_fnc_findNearestObject;
 *
 * Public: No
 */

params [
	["_target", [], [objNull,[],""]]
	,["_variable", "adv_var_nil", [""]]
	,["_radius", 500, [0]]
];

//find the position from which to search:
private _pos = [_target] call adv_fnc_getPos;

//define the output if no entity is found:
private _closest = objNull;

//what type of object are we looking for?
private _objects = _pos nearEntities _radius;

//let's loop through the entities to find the closest one:
private _closestdist = _radius+1;

{
	if (_x distance _pos < _closestdist && _x getVariable [_variable,false]) then {
		_closest = _x;
		_closestdist = _x distance _pos;
	};
} forEach _objects;

//return the closest at the end of the function:
_closest;
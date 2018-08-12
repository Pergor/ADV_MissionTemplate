/*
 * Author: Belbo
 *
 * Finds the nearest player to given object, marker or position.
 * If object is player, this unit will not be returned.
 *
 * Arguments:
 * 0: target - <OBJECT>
 * 2: radius (optional - default is 500 meters) - <NUMBER>
 *
 * Return Value:
 * Found closest player or objNull if no player is within radius - <OBJECT>
 *
 * Example:
 * [player,500] call adv_fnc_findNearestPlayer;
 *
 * Public: No
 */

params [
	["_target", [], [objNull,[],""]]
	,["_radius", 500, [0]]
];

//find the position from which to search:
private _pos = [_target] call adv_fnc_getPos;

//define the output if no entity is found:
private _closest = objNull;
private _player = objNull;
if (_target isEqualType objNull) then {
	if (isPlayer _target) then {
		_player = _target;
	};
};

//what type of object are we looking for?
private _objects = _pos nearEntities _radius;

//let's loop through the entities to find the closest one:
private _closestdist = _radius+1;

{
	if (_x distance _pos < _closestdist && isPlayer _x && !(_x isEqualTo _player)) then {
		_closest = _x;
		_closestdist = _x distance _pos;
	};
} forEach _objects;

//return the closest at the end of the function:
_closest;
/*
adv_fnc_simplePatrol:

Creates a simple patrol around a center with the given radius. Group is being spawned at a random location inside the radius.

possible call, has to be executed on either server or headless client:
[["O_Soldier_TL_F","O_Soldier_GL_F"],east,"spawnMarker",200,false] call ADV_fnc_simplePatrol;

_this select 0 = units array - format: array of objects
_this select 1 = side of the units - format: side
_this select 2 = center of the patrol circle. - format: object, marker or position
_this select 3 = radius of the patrol circle - format: number (optional)
_this select 4 = garrison buildings in radius - format: boolean (optional)
*/

if (!isServer && hasInterface) exitWith {};

params [
	["_units", ["O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_F","O_soldier_AR_F","O_medic_F"], [[]]]
	,["_side", east, [west]]
	,["_location", [0,0,0], [[],"",objNull]]
	,["_radius", 300, [0]]
	,["_garrison", false, [true]]
];

private _start = call {
	if (_location isEqualType "") exitWith {getMarkerPos _location};
	if (_location isEqualType objNull) exitWith {getPosATL _location};
	if (_location isEqualType []) exitWith {_location};
	nil;
};

private _dist = random _radius;
private _dir = random 360;
private _pos = [(_start select 0) + (sin _dir) * _dist, (_start select 1) + (cos _dir) * _dist, 0];
private _spawn = [_pos,0,_radius,10,0,0.4,0] call BIS_fnc_findSafePos;

private _grp = [_units,_side,_spawn] call adv_fnc_spawnGroup;

if (_garrison) exitWith {
	[_start, units _grp, _radius, true, true] call adv_fnc_ZenOccupyHouse;
	_grp;
};

[_grp , _start, _radius] call bis_fnc_taskPatrol;
_grp;

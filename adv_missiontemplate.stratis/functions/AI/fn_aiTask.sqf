/*
 * Author: Belbo
 *
 * Creates a simple patrol around a center with the given radius. Group is usually being spawned at a random location preferrably inside the radius.
 * Group will receive a provided task.
 *
 * Arguments:
 * 0: location for spawn (can be position, object or marker) - <ARRAY>, <OBJECT>, <STRING>
 * 1: unit classnames array - <ARRAY> of <STRINGS>
 * 2: side of the units - <SIDE>
 * 3: behaviour mode - <NUMBER>
 * 		0 = regular patrol.
 *		1 = patrol with units searching buildings near waypoints.
 *		2 = garrison buildings in radius around center.
 *		3 = defend area (buildings are being defended, static guns manned and the group leader will patroul around; radius above 150meters will revert to 200 meters).
 * 		4 = attack location around object, marker or position provided in _this select 5 - if nothing or a missing element is provided, the next enemy will be targeted.
 * 4: radius around the spawn position for the group task (optional) - <NUMBER>
 * 5: attack position/object/marker with radius (optional - only necessary with behaviour mode 4) - <ARRAY> in format [position, <NUMBER>]
 *
 * Return Value:
 * Spawned group - <GROUP>
 *
 * Example:
 * ["spawnMarker",["O_Soldier_TL_F","O_Soldier_GL_F"],east,0,200] call adv_fnc_aiTask;
 * or
 * ["spawnMarker",["O_Soldier_TL_F","O_Soldier_GL_F"],east,4,200,[attackLogic,50]] call adv_fnc_aiTask;
 *
 * Public: Yes
 */

if (!isServer && hasInterface) exitWith {};

params [
	["_location", [0,0,0], [[],"",objNull]]
	,["_units", ["O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_F","O_soldier_AR_F","O_medic_F"], [[]]]
	,["_side", east, [west]]
	,["_mode", 0, [0]]
	,["_radius", 300, [0]]
	,["_attack", [objNull,[0,0,0]], [[]]]
];

private _start = call {
	if (_location isEqualType "") exitWith {getMarkerPos _location};
	if (_location isEqualType objNull) exitWith {getPosATL _location};
	if (_location isEqualType []) exitWith {_location};
	nil;
};
//private _dist = random _radius;
//private _dir = random 360;
//private _pos = [(_start select 0) + (sin _dir) * _dist, (_start select 1) + (cos _dir) * _dist, 0];
private _pos = [_start, _radius] call CBA_fnc_randPos;
//private _spawn = [_pos,5,30,2,0,20,0] call BIS_fnc_findSafePos;
private _spawn = _pos findEmptyPosition [5,30];
_spawn set [2,0];
if ((_pos distance _spawn) > 50 ) then {
	_spawn = _pos;
};

private _grp = [_spawn,_units,_side] call adv_fnc_spawnGroup;

call {
	if (_mode isEqualTo 1) exitWith {
		[_grp, _start, _radius, 5, "MOVE", "SAFE", "GREEN", "LIMITED", "STAG COLUMN", "this spawn CBA_fnc_searchNearby", [3,6,9]] call CBA_fnc_taskPatrol;
	};
	if (_mode isEqualTo 2) exitWith {
		[_start, units _grp, _radius, true, false] call adv_fnc_ZenOccupyHouse;
	};
	if (_mode isEqualTo 3) exitWith {
		if (_radius > 200) then { _radius = 200 };
		[_grp, _start, _radius, 2, true] call CBA_fnc_taskDefend;
	};
	if (_mode isEqualTo 4) exitWith {
		_attack params [ ["_obj", objNull], ["_attackRadius", 50] ];
		_target = call {
			if (isNil "_obj") exitWith {[0,0,0]};
			if (_obj isEqualType "") exitWith {getMarkerPos _obj};
			if (_obj isEqualType objNull) exitWith {getPosWorld _obj};
			if (_obj isEqualType []) exitWith {_obj};
			nil;
		};
		if (_target isEqualTo [0,0,0]) then {
			private _leader = (units _grp) select 0;
			private _enemy = [_leader,3000] call adv_fnc_findNearestEnemy;
			_target = getPos _enemy;
			_attackRadius = 50;
		};
		
		_wp = _grp addWaypoint [_target, _attackRadius];
		_wp setWaypointType "SAD";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointCombatMode "YELLOW";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointFormation "WEDGE";
	};
	//[_grp , _start, _radius] call bis_fnc_taskPatrol;
	[_grp, _start, _radius, 7, "MOVE", "SAFE", "GREEN", "LIMITED", "STAG COLUMN", "", [1,1.5,2]] call CBA_fnc_taskPatrol;
};
_grp;
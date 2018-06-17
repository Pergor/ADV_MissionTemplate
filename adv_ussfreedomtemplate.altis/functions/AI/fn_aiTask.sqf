/*
 * Author: Belbo
 *
 * Creates a simple patrol around a center with the given radius. Group is usually being spawned at a random location preferrably inside the radius.
 * Group will receive a provided task.
 *
 * Arguments:
 * 0: location for spawn (can be position, object or marker) - <ARRAY>, <OBJECT>, <STRING>
 * 1: unit classnames array - <ARRAY> of <STRINGS>
 * 2: side of the units - <SIDE> or <NUMBER>
 * 3: behaviour mode - <NUMBER>
 * 		0 = regular patrol.
 *		1 = patrol with units searching buildings near waypoints.
 *		2 = garrison buildings in radius around center.
 *		3 = defend area (buildings are being defended, static guns manned and the group leader will patrol around; radius above 200 meters will revert to 200 meters).
 * 		4 = attack location around object, marker or position provided in _this select 5 - if nothing or a missing element is provided, the next enemy will be targeted.
 *			If no enemy is found within 5000 meters, safePositionAnchor of map will be used.
 * 4: radius around the spawn position for the group task. If spawn location is an area marker and no radius provided, the radius will be the geometric mean of the marker's radiuses (optional) - <NUMBER>
 * 5: attack position/object/marker with radius. If a unit is provided, ai will continually stalk the unit. (optional - only necessary with behaviour mode 4) - <ARRAY> in format [position, <NUMBER>]
 * 6: Code. Will be executed after spawn. Spawned group is _this in code. (optional) - <STRING>
 *
 * Return Value:
 * Spawned group - <GROUP>
 *
 * Example:
 * ["spawnMarker",["O_Soldier_TL_F","O_Soldier_GL_F"],east,0,200] call adv_fnc_aiTask;
 * or
 * ["spawnMarker",["O_Soldier_TL_F","O_Soldier_GL_F"],east,0,200,nil,"{_x unlinkItem (hmd _x)} forEach (units _this)"] call adv_fnc_aiTask;
 * or
 * ["spawnMarker",["O_Soldier_TL_F","O_Soldier_GL_F"],east,4,200,[attackLogic,50]] call adv_fnc_aiTask;
 *
 * Public: Yes
 */

if (!isServer && hasInterface) exitWith {};

params [
	["_location", [0,0,0], [[],"",objNull]]
	,["_units", ["O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_F","O_soldier_AR_F","O_medic_F"], [[],configNull]]
	,["_side", east, [west,0]]
	,["_mode", 0, [0]]
	,["_radius", -1, [0]]
	,["_attack", [objNull,100], [[]]]
	,["_code", "", [""]]
];

//Default fall back if one of the necessary positions isn't found:
private _worldAnchor = getArray (configFile >> "CfgWorlds" >> worldName >> "safePositionAnchor");

//select pos depending on given parameter:
private _start = [_location] call adv_fnc_getPos;

//redefine radius, if the marker already has a radius:
if (_location isEqualType "" && _radius isEqualTo -1) then {
	if (markerShape _location in ["ELLIPSE","RECTANGLE","POLYLINE"]) then {
		private _size = markerSize _location;
		private _biggerSide = (_size select 0) max (_size select 1);
		private _smallerSide = (_size select 0) min (_size select 1);
		//circle with radius of the geometric mean of the ellipse's radius has the same area as the ellipse:
		_radius = sqrt (_biggerSide * _smallerSide);
	};
};

//select random position which should be safe:
private _pos = [_start, _radius] call CBA_fnc_randPos;
private _spawn = [_pos,5,30,3,0,20,0,[],[_start,_start]] call BIS_fnc_findSafePos;

//get side, if side ID is provided:
if (_side isEqualType 0) then {
	_side = _side call BIS_fnc_sideType;
};

//spawn a group
private _grp = [_spawn,_units,_side] call adv_fnc_spawnGroup;
[units _grp,10] call adv_fnc_setSafe;

//give the group it's commands:
call {
	//patrol with building searching:
	if (_mode isEqualTo 1) exitWith {
		[_grp, _start, _radius, 5, "MOVE", "SAFE", "GREEN", "LIMITED", "STAG COLUMN", "this spawn CBA_fnc_searchNearby", [3,6,9]] call CBA_fnc_taskPatrol;
	};
	//occupy all the houses:
	if (_mode isEqualTo 2) exitWith {
		[_start, units _grp, _radius, true, true] call adv_fnc_ZenOccupyHouse;
	};
	//defend the area around the spawn:
	if (_mode isEqualTo 3) exitWith {
		if (_radius > 200) then { _radius = 200 };
		[_grp, _start, _radius, 2, true] call CBA_fnc_taskDefend;
	};
	//attack target:
	if (_mode isEqualTo 4) exitWith {
		_attack params [ ["_obj", objNull], ["_attackRadius", 100] ];
		//find target depending on provided position
		_target = call {
			if (isNil "_obj") exitWith {[0,0,0]};
			if (_obj isEqualType "") exitWith {getMarkerPos _obj};
			if (_obj isEqualType objNull) exitWith {getPosWorld _obj};
			if (_obj isEqualType []) exitWith {_obj};
			nil;
		};
		//find enemy, if no pos is provided:
		if (_target isEqualTo [0,0,0]) then {
			private _leader = (units _grp) select 0;
			private _enemy = [_leader,5000] call adv_fnc_findNearestEnemy;
			_target = getPos _enemy;
			//fall back to world anchor if none is found:
			if (_target isEqualTo [0,0,0]) then {
				_target = _worldAnchor;
			};
			_attackRadius = 100;
		};
		//add waypoints:
		_wp = _grp addWaypoint [_target, _attackRadius];
		_wp setWaypointType "SAD";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointCombatMode "YELLOW";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointFormation "WEDGE";
		if ( _obj isEqualType objNull ) then {
			if ( !(group _obj isEqualTo grpNull) ) then {
				[_grp,group _obj,60,_attackRadius,{!alive _obj},1] spawn bis_fnc_stalk;
			};
		};
	};
	//regular patrol:
	if (_side isEqualTo civilian) exitWith {
		[_grp, _start, _radius, 4, "MOVE", "CARELESS", "BLUE", "LIMITED", "STAG COLUMN", "", [1,1.5,2]] call CBA_fnc_taskPatrol;
		_grp allowFleeing 0;
	};
	[_grp, _start, _radius, 7, "MOVE", "SAFE", "GREEN", "LIMITED", "STAG COLUMN", "", [1,1.5,2]] call CBA_fnc_taskPatrol;
};

_grp call compile _code;

if !(_mode isEqualTo 4 || _mode isEqualTo 3) then {
	_grp enableDynamicSimulation true;
};

//return:
_grp;
/*
 * Author: Belbo
 *
 * Creates attack groups of any side at multiple locations that attack at one given location.
 * If multiple vehicles are spawned, they are placed 10 meters apart.
 * If one or multiple vehicles and infantry units are spawned, the vehicles will be placed 10 meters apart and the infantry in a safe distance to the vehicles. 
 * The first vehicle will be the leader of any group.
 *
 * Arguments:
 * 0: locations for spawns (can be positions, objects or markers) - <ARRAY> of <ARRAYS>, <OBJECTS>, <STRINGS>
 * 1: unit classnames array - <ARRAY> of <STRINGS>
 * 2: side of the units - <SIDE>
 * 3: attack location (can be position, object or marker) - <ARRAY>, <OBJECT>, <STRING>
 * 4: radius around the attack location for waypoint (optional) - <NUMBER>
 *
 * Return Value:
 * Last spawned group - <GROUP>
 *
 * Example:
 * [[spawnLogic,spawnLogic_1,spawnLogic_2],["O_Soldier_TL_F","O_Soldier_GL_F"],east,attackLogic,75] call ADV_fnc_spawnAttack;
 *
 * Public: Yes
 */

if (!isServer && hasInterface) exitWith {};

params [
	["_spawn", [], [[]]]
	,["_units", ["O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_F","O_soldier_AR_F","O_medic_F"], [[]]]
	,["_side", east, [west]]
	,["_attack", [0,0,0], [objNull,"",[]]]
	,["_radius", 75, [0]]
	,"_grp"
];

{
	private _location = _x;
	if (!isNil "_location" && !isNil "_attack") then {
		private _start = call {
			if (_location isEqualType "") exitWith {getMarkerPos _location};
			if (_location isEqualType objNull) exitWith {getPosATL _location};
			if (_location isEqualType []) exitWith {_location};
			nil;
		};
		private _heading = call {
			if (_location isEqualType "") exitWith {markerDir _location};
			if (_location isEqualType objNull) exitWith {getDir _location};
			if (true) exitWith {0};
		};
		private _target = call {
			if (_attack isEqualType "") exitWith {getMarkerPos _attack};
			if (_attack isEqualType objNull) exitWith {getPosWorld _attack};
			if (_attack isEqualType []) exitWith {_attack};
			[0,0,0];
		};
		private _skill = [0.5,0.9,0.65];
		
		private _withVehicles = false;
		private _vehicles = [];
		{
			if ( _x isKindOf "LandVehicle" ) then {
				private _veh = _x;
				_withVehicles = true;
				_units = _units-[_veh];
				_vehicles pushBack _veh;
			};
			nil;
		} count _units;
		call {
			if !(_withVehicles) exitWith {
				_grp = [_start, _side, _units, [], [], _skill,[],[],_heading] call BIS_fnc_spawnGroup;
			};
			
			private _movedPosition = [_start select 0,(_start select 1)+10,_start select 2];
			_grp = [_movedPosition, _side, _units, [], [], _skill,[],[],_heading] call BIS_fnc_spawnGroup;
			private _vehIsLeader = false;
			{
				private _newVeh = [_start, _heading, _x, _grp] call bis_fnc_spawnVehicle;
				_start = [(_start select 0)+10, _start select 1, _start select 2];
				if !(_vehIsLeader) then {
					_grp selectLeader (_newVeh select 0);
					_vehIsLeader = true;
				};
				nil;
			} count _vehicles;
		};
		if (_target isEqualTo [0,0,0]) then {
			private _leader = (units _grp) select 0;
			private _enemy = [_leader,3000] call adv_fnc_findNearestEnemy;
			_target = getPos _enemy;
		};
		_wp = _grp addWaypoint [_target, _radius];
		_wp setWaypointType "SAD";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointCombatMode "YELLOW";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointFormation "WEDGE";
		
		_grp enableDynamicSimulation true;
	};
} forEach _spawn;

_grp;
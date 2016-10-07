/*
ADV_fnc_spawnAttack:

Creates attack groups of any side at multiple locations that attack at one given location.
If multiple vehicles are spawned, they are placed 10 meters apart.
If one or multiple vehicles and infantry units are spawned, the vehicles will be placed 10 meters apart and the infantry in a safe distance to the vehicles. 
The first vehicle will be the leader of any group.

possible call, has to be executed on either server or headless client:
[["O_Soldier_TL_F","O_Soldier_GL_F"],east,75,[spawnLogic,spawnLogic_1,spawnLogic_2],attackLogic] call ADV_fnc_spawnAttack;

_this select 0 = units array - format: ["classname","classname",...]
_this select 1 = side of the units - can either be west, east, independent or civilian
_this select 2 = radius around the attack location - format: number
_this select 3 = object at the spawn location - format: object
_this select 4 = target location - format: object
*/

if (!isServer && hasInterface) exitWith {};

params [
	["_units", ["O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_F","O_soldier_AR_F","O_medic_F"], [[]]],
	["_side", east, [west]],
	["_radius", 75, [0]],
	["_spawn", [], [[]]],
	["_attack", [0,0,0], [objNull,"",[]]],
	"_grp"
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
			nil;
		};
		private _skill = [0.6,0.9,0.7];
		
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
		_wp = _grp addWaypoint [_target, _radius];
		_wp setWaypointType "SAD";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointCombatMode "YELLOW";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointFormation "WEDGE";
	};
} forEach _spawn;

_grp;
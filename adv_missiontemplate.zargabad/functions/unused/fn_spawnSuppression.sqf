/*
ADV_fnc_spawnSuppression:

Creates suppression groups of any side at multiple locations that suppress known enemies as long as they're alive.

possible call, has to be executed on either server or headless client:
[["O_HeavyGunner_F","O_HeavyGunner_F"],east,[spawnLogic_1,"spawnMarker_2"]] call ADV_fnc_spawnSuppression;

_this select 0 = units array - format: ["classname","classname",...]
_this select 1 = side of the units - can either be west, east, independent or civilian
_this select 2 = object at the spawn location - format: object
_this select 3 = direction of suppressive fire - format: integer (optional)
*/

if (!isServer && hasInterface) exitWith {};

params [
	["_units", ["O_Soldier_TL_F","O_HeavyGunner_F","O_HeavyGunner_F","O_Soldier_GL_F"], [[]]],
	["_side", east, [west]],
	["_spawn", [], [[]]],
	["_direction", "", [0,""]],
	"_grp"
];

{
	private _location = _x;
	if (!isNil "_location") then {
		private _start = call {
			if (_location isEqualType "") exitWith {getMarkerPos _location};
			if (_location isEqualType objNull) exitWith {getPosATL _location};
			if (_location isEqualType []) exitWith {_location};
			nil;
		};
		private _heading = call {
			if (_direction isEqualType 0) exitWith {_direction};
			if (_location isEqualType "") exitWith {markerDir _location};
			if (_location isEqualType objNull) exitWith {getDir _location};
			if (true) exitWith {0};
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
		
		private _group = units _grp;
		private _leader = leader _grp;
		
		while { {alive _x} count _group > 0 } do {
			sleep 35;
			{
				_unit = _x;
				_unit disableAI "PATH";
				if (!(assignedTarget _unit isEqualTo "") && someAmmo _unit) then {
					_unit suppressFor 30;
				};
				nil;
			} count _group;
		};
		
		{ _x enableAI "PATH" } count (units _grp);
	};
} forEach _spawn;

_grp;
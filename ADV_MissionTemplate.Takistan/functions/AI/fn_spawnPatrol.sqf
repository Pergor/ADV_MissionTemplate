/*
ADV_fnc_spawnPatrol:

Creates a patrol at all given locations either patroling within one given area or one area for each location.
Uses UPSMON for the patrole settings.
If multiple vehicles are spawned, they are placed 10 meters apart.
If one or multiple vehicles and infantry units are spawned, the vehicles will be placed 10 meters apart and the infantry in a safe distance to the vehicles. 
The first vehicle will be the leader of any group.

possible call, has to be executed on either server or headless client:
[["O_Soldier_TL_F","O_Soldier_GL_F"],"",200,["LIMITED","STAG COLUMN","NOFOLLOW"],[spawnLogic,spawnLogic_1,spawnLogic_2],"UPSAREANAME"] call ADV_fnc_spawnPatrol;

_this select 0 = units array - format: ["classname","classname",...]
_this select 1 = side of the units - can either be west, east, independent or civilian
_this select 2 = radius of the patrol circle - format: number
_this select 3 = UPSMON-Settings - format: ["LIMITED","COLUMN"]
_this select 4 = object at the center of the patrol circle/spawn object or UPSarea for the patrol
_this select 5 = area for UPSmarker - (optional)
*/

if (!isServer && hasInterface) exitWith {};

params [
	["_units", ["O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_F","O_soldier_AR_F","O_medic_F"], [[]]],
	["_side", east, [west]],
	["_radius", 300, [0,""]],
	["_UPS", ["LIMITED", "CARELESS", "NOFOLLOW"], [[]]],
	["_spawn", [], [[]]],
	["_givenArea", "noAreaGiven", [""]],
	"_location","_logic","_area","_heading","_skill","_grp","_withVehicles","_vehicles","_movedPosition","_veh","_newVeh","_vehIsLeader"
];

if (isNil "ADV_patrol_area_name") then { ADV_patrol_area_name = 0 };
{
	_location = _x;
	if (!isNil "_location") then {
			if ((typeName (_spawn select 0)) == "OBJECT") then {
				_logic = getPos _location;
				_heading = getDir _location;
				if (_givenArea == "noAreaGiven") then {
					_area = createMarker [format ["%1%2","ADV_patrol_area_",ADV_patrol_area_name], _logic];
					ADV_patrol_area_name = ADV_patrol_area_name + 1;
					_area setMarkerShape "ELLIPSE";
					_area setMarkerSize [_radius*2,_radius*2];
					_area setMarkerAlpha 0;
				};
			};
			if ((typeName _radius) == "STRING") then {
				_area = _radius;
			};
			if ((typeName (_spawn select 0)) == "STRING") then {
				_logic = getMarkerPos _location;
				_area = _location;
				_heading = markerDir _location;
			};
		_skill = [0.6,0.9,0.7];
		if (_side == civilian) then { _skill = [0.0,0.0,0.0]; };
		
		_withVehicles = false;
		_vehicles = [];
		{
			if (_x isKindOf "LandVehicle") then {
				_veh = _x;
				_withVehicles = true;
				_units = _units-[_veh];
				_vehicles pushBack _veh;
			};
		} forEach _units;
		if (_withVehicles) then {
			_movedPosition = [_logic select 0,(_logic select 1)+10,_logic select 2];
			_grp = [_movedPosition, _side, _units, [], [], _skill,[],[],_heading] call BIS_fnc_spawnGroup;
			_vehIsLeader = false;
			{
				_newVeh = [_logic, _heading, _x, _grp] call bis_fnc_spawnVehicle;
				_logic = [(_logic select 0)+10, _logic select 1, _logic select 2];
				if !(_vehIsLeader) then {
					_grp selectLeader (_newVeh select 0);
					_vehIsLeader = true;
				};
			} forEach _vehicles;
			_grp setBehaviour "AWARE";
			_grp setCombatMode "YELLOW";
		} else {
			_grp = [_logic, _side, _units, [], [], _skill,[],[],_heading] call BIS_fnc_spawnGroup;
		};
		
		if (_givenArea != "noAreaGiven") then {_area = _givenArea;};
		[(leader _grp),_area]+_UPS spawn compile preprocessFileLineNumbers "scripts\upsmon.sqf";
		
	};
} forEach _spawn;

if (true) exitWith { _grp; };
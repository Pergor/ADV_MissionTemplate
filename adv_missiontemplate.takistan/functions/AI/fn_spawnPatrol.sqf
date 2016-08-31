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
	"_area","_grp"
];

if (isNil "adv_patrol_area_name") then { adv_patrol_area_name = 0 };
{
	private _location = _x;
	if (!isNil "_location") then {
		//define starting point
		private _start = call {
			if (_location isEqualType "") exitWith {getMarkerPos _location};
			if (_location isEqualType objNull) exitWith {getPosATL _location};
			if (_location isEqualType []) exitWith {_location};
			nil;
		};
		//define direction in which units are headed upon spawn
		private _heading = call {
			if (_location isEqualType "") exitWith {markerDir _location};
			if (_location isEqualType objNull) exitWith {getDir _location};
			if (true) exitWith {0};
		};
		//if no area has been provided after the spawn array
		private _areaCreation = {
			_start = _this select 0;
			_radius = _this select 1;
			_area = createMarker [format ["%1%2","adv_patrol_area_",adv_patrol_area_name], _start];
			adv_patrol_area_name = adv_patrol_area_name + 1;
			_area setMarkerShape "ELLIPSE";
			_area setMarkerSize [_radius,_radius];
			_area setMarkerAlpha 0;
		};
		if ((toUpper _givenArea) isEqualTo "NOAREAGIVEN") then {
			call {
				if (_location isEqualType objNull) exitWith { [_start,_radius] call _areaCreation };
				if (_location isEqualType "") exitWith {
					if !(toUpper (markerShape _location) in ["RECTANGLE","ELLIPSE"]) then {
						[_start,_radius] call _areaCreation;
					};
				};
				nil;
			};
		};
		//i really don't know what I wanted to do with that...
		if (_radius isEqualType "") then {
			_area = _radius;
		};
		//if an area is supplied, it will be used...
		if !( (toUpper _givenArea) isEqualTo "NOAREAGIVEN" ) then {
			_area = _givenArea;
		};
		//... but only if the spawn isn't a marker and hasn't got a rectangular or elliptic shape
		if (_location isEqualType "") then {
			if (toUpper (markerShape _location) in ["RECTANGLE","ELLIPSE"]) then {
				_area = _location;
			};
		};
		
		private _skill = [0.6,0.9,0.7];
		if (_side == civilian) then { _skill = [0.0,0.0,0.0]; };
		
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
		//what should they do? Walk around:
		[(leader _grp),_area]+_UPS spawn compile preprocessFileLineNumbers "scripts\upsmon.sqf";
	};
} forEach _spawn;

_grp;
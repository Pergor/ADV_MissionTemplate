/*
 * Author: Belbo
 *
 * Creates a group at a given location.
 * If multiple vehicles are spawned, they are placed 10 meters apart.
 * If one or multiple vehicles and infantry units are spawned, the vehicles will be placed 10 meters apart and the infantry in a safe distance to the vehicles. 
 * The first vehicle will be the leader of any group.
 *
 * Arguments:
 * 0: spawn location (can be position, object or marker) - <ARRAY>, <OBJECT>, <STRING>
 * 1: unit classnames array - <ARRAY> of <STRINGS>
 * 2: side of the units - <SIDE> or <NUMBER>
 *
 * Return Value:
 * spawned group - <GROUP>
 *
 * Example:
 * [spawnLogic,["O_Soldier_TL_F","O_Soldier_GL_F"],east] call ADV_fnc_spawnGroup;
 *
 * Public: Yes
 */

if (!isServer && hasInterface) exitWith {};

params [
	["_location", [0,0,0], [[],"",objNull]]
	,["_units", ["O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_F","O_soldier_AR_F","O_medic_F"], [[],configNull]]
	,["_side", east, [west,0]]
	,"_grp"
];

//select pos depending on given parameter:
private _start = [_location] call adv_fnc_getPos;

//define direction in which units are headed upon spawn
private _heading = call {
	if (_location isEqualType "") exitWith {markerDir _location};
	if (_location isEqualType objNull) exitWith {getDir _location};
	if (true) exitWith {0};
};

private _skill = [0.7,0.7];
if (_side isEqualType 0) then {
	_side = _side call BIS_fnc_sideType;
};
if ( _side isEqualTo civilian ) then { _skill = [0.0,0.0]; };

private _withVehicles = 0;
private _vehicles = [];
if (_units isEqualType []) then {
	{
		if ( _x isKindOf "LandVehicle" || _x isKindOf "SeaVehicle" || _x isKindOf "AIR" ) then {
			private _veh = _x;
			_units = _units-[_veh];
			_vehicles pushBack _veh;
			_withVehicles = call {
				if (_x isKindOf "SeaVehicle") exitWith {3};
				if (_x isKindOf "AIR") exitWith {2};
				if (_x isKindOf "LandVehicle") exitWith {1};
				_withVehicles
			};
			_start = call {
				if (_x isKindOf "SeaVehicle") exitWith {ATLToASL _start};
				if (_x isKindOf "AIR") exitWith {[_start select 0, _start select 1, (_start select 2) + 200]};
				_start
			};
		};
		nil;
	} count _units;
};

call {
	if (_withVehicles isEqualTo 0) exitWith {
		_grp = [_start, _side, _units, [], [], _skill,[],[],_heading] call BIS_fnc_spawnGroup;
	};
	
	_yVers=(-15*(sin _heading));
	_xVers=(-15*(cos _heading));
	private _movedPosition = [(_start select 0)+_yVers,(_start select 1)+_xVers,(_start select 2)];
	_grp = [_movedPosition, _side, _units, [], [], _skill,[],[],_heading] call BIS_fnc_spawnGroup;
	
	private _vehIsLeader = false;
	{
		if (_x isKindOf "PLANE") then {
			_start set [2,100];
		};
		private _newVehArray = [_start, _heading, _x, _grp] call bis_fnc_spawnVehicle;
		if (_x isKindOf "PLANE") then {
			_x setvelocity [100 * (sin _dir),100 * (cos _dir),0];
		};
		_newVehArray params ["_newVeh","_crew","_group"];
		_yVers=(-8*(sin _heading))+(10*(cos _heading));
		_xVers=(-8*(cos _heading))-(10*(sin _heading));
		_start = [(_start select 0)+_yVers, (_start select 1)+_xVers, _start select 2];
		if !(_vehIsLeader) then {
			_grp selectLeader _newVeh;
			_vehIsLeader = true;
		};
		/*
		if (_newVeh isKindOf "AIR") exitWith {
		};
		*/
		_newVeh setFeatureType 2;
		_newVeh setVehicleRadar 0;
		nil;
	} count _vehicles;

	if (_side isEqualTo civilian) then {
		_grp setBehaviour "CARELESS";
		_grp setCombatMode "BLUE";
		_grp setSpeedMode "LIMITED";
		_grp allowFleeing 0;
		{ _x disableAI "AUTOCOMBAT"; _x setUnitPos "UP"; _x setSkill ["courage",0.7]; } count (units _grp);
	};
};

{_x setDir _heading} count (units _grp);
_grp setFormDir _heading;

[_grp] call adv_fnc_setSkill;

_grp;
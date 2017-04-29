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
 * 2: side of the units - <SIDE>
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
	,["_units", ["O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_F","O_soldier_AR_F","O_medic_F"], [[]]]
	,["_side", east, [west]]
	,"_grp"
];

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

private _skill = [0.7,0.9,0.65];
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
	if (_side == civilian) then {
		_grp setBehaviour "CARELESS";
		_grp setCombatMode "BLUE";
		_grp setSpeedMode "LIMITED";
		{ _x disableAI "AUTOCOMBAT"; _x setUnitPos "UP"; } count (units _grp);
	};
};
//_grp enableDynamicSimulation true;

_grp;
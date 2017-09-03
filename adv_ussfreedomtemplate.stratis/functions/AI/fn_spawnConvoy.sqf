/*
 * Author: Belbo
 *
 * Creates a convoy.
 * The convoy will be spawned at the provided location and move to a target location with combat mode "SAFE" and "LIMITED" speed. Upon arrival all carried units will be unloaded.
 * Make SURE the first vehicle has enough space to start moving (eg. no houses blocking a whole turning circcle of the vehicle).
 * The first array of units contains the vehicles that make up the convoy.
 * Second array of units contains the units each vehicle with at least as many free cargo spaces will carry. If there are more units in the array than free cargo spaces, no group will spawn!
 *
 * Arguments:
 * 0: spawn location (can be position, object or marker) - <ARRAY>, <OBJECT>, <STRING>
 * 1: target destination (can be position, object or marker) - <ARRAY>, <OBJECT>, <STRING>
 * 2: vehicles classnames array - <ARRAY> of <STRINGS>
 * 3: units classnames array - <ARRAY> of <STRINGS>
 * 4: side of all units in convoy - <SIDE>
 * 5: Speedmode, can be "LIMITED" (default), "NORMAL", "FULL" (optional) - <STRING>
 *
 * Return Value:
 * spawned group of vehicles - <GROUP>
 *
 * Example:
 * [spawnLogic,destinationLogic["O_MRAP_02_hmg_F","O_Truck_02_transport_F","O_Truck_02_transport_F","O_Truck_02_transport_F","O_MRAP_02_hmg_F"],["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_GL_F","O_Soldier_F","O_soldier_LAT_F","O_medic_F"],east,"LIMITED"] call ADV_fnc_spawnConvoy;
 *
 * Public: Yes
 */

if (!isServer && hasInterface) exitWith {};

params [
	["_location", [0,0,0], [[],"",objNull]]
	,["_targetLocation", [0,0,0], [[],"",objNull]]
	,["_vehicles", ["O_MRAP_02_hmg_F","O_Truck_02_transport_F","O_Truck_02_transport_F","O_Truck_02_transport_F","O_MRAP_02_hmg_F"], [[],configNull]]
	,["_units", ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_GL_F","O_Soldier_F","O_soldier_LAT_F","O_Soldier_F","O_Soldier_A_F","O_medic_F"], [[],configNull]]
	,["_side", east, [west]]
	,["_speed","LIMITED",[""]]
];

//select target pos depending on given parameter:
private _destination = [_targetLocation] call adv_fnc_getPos;
//select starting pos depending on given parameter:
private _start = [_location] call adv_fnc_getPos;

//create group of vehicles first:
private _grp = [
	_location
	,_vehicles
	,_side
] call ADV_fnc_spawnGroup;
[_grp,10] call adv_fnc_setSafe;

//add waypoint:
private _wp = _grp addWaypoint [_destination, 10];
_wp setWaypointType "TR UNLOAD";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointCombatMode "GREEN";
_wp setWaypointSpeed _speed;
_wp setWaypointFormation "COLUMN";
_wp setWaypointCompletionRadius 70;
_wp setWaypointStatements ["true", "vehicle this land 'GET OUT'"];

//get all vehicles of vehicle group:
private _allVehiclesConvoy = [_grp] call adv_fnc_getGroupVehicles;
//get all vehicles that can fit a whole group of _units:
private _size = count _units;
private _vehiclesConvoy = [];
{
	if ( (_x emptyPositions "cargo") >= _size ) then {
		_vehiclesConvoy pushBackUnique _x;
	};
} forEach _allVehiclesConvoy;

[_start,_vehiclesConvoy,_units,_side] spawn {
	params ["_start","_vehiclesConvoy","_units","_side"];

	//assignAsCargo and moveInCargo in one:
	private _moveInCargo = {
		params ["_grp","_vehicle"];
		{
			_x assignAsCargo _vehicle;
			_x moveInCargo _vehicle;
			nil;
		} count (units _grp);
	};
	//longer sleep so vehicles can start to move:
	sleep 20;
	//spawn a group for each vehicle and move it in cargo positions:
	{
		_grp_inf = [
			[(_start select 0),(_start select 1)-50,0]
			,_units
			,_side
		] call ADV_fnc_spawnGroup;
		[_grp_inf,10] call adv_fnc_setSafe;
		[_grp_inf,_x] call _moveInCargo;
		[_grp_inf] spawn {
			params ["_grp_inf"];
			sleep 20;
			[
				{ {vehicle _x isEqualTo _x} count (units (_this select 0)) > ((count units (_this select 0))/3) || !alive (leader (_this select 0)) }
				,{ params ["_grp_inf"];[_grp_inf, getPos (leader _grp_inf), 100, 2, true] call CBA_fnc_taskDefend; }
				,[_grp_inf]
			] call CBA_fnc_waitUntilAndExecute;
		};
		nil;
	} count _vehiclesConvoy;
};

_grp;
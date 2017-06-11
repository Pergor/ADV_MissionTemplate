/*
 * Author: Belbo
 *
 * Removes AIR and LAND vehicles from surface of uss freedom and let's them respawn - you can choose whether only wrecks should be removed or all vehicles.
 * If no specific uss freedom object is provided, all uss freedoms present in mission will be 'wiped'.
 *
 * Arguments:
 * 0: Freedom object or array of freedom objects  (optional) - <OBJECT> or <ARRAY> of <OBJECTS>
 * 1: Should only wrecks be removed? - <BOOLEAN>
 *
 * Return Value:
 * Script handle - <HANDLE>
 *
 * Example:
 * _handle = [[freedom_1],true] call adv_fnc_clearFreedom;
 *
 * Public: Yes
 */
 
_handle = _this spawn {

	 params [
		["_ship",objNull,[[],objNull,0]]
		,["_wrecksOnly",true,[true]]
	];

	private _ships = call {
		if ( _ship isEqualType [] ) exitWith {
			if (count _ship isEqualTo 0) exitWith {
				allMissionObjects "Land_Carrier_01_base_F"
			};
		};
		if ( _ship isEqualType 0 || isNull _ship ) exitWith {
			allMissionObjects "Land_Carrier_01_base_F"
		};
		if ( _ship isEqualType objNull && !isNull _ship ) exitWith {
			[_ship]
		};
	};

	private _airVehicles = [];
	{
		private _newVehicles = nearestObjects [_x, ["AIR"], 380];
		_airVehicles append _newVehicles;
		nil;
	} count _ships;

	private _landVehicles = [];
	{
		private _newVehicles = nearestObjects [_x, ["CAR","TANK","MOTORCYCLE"], 380];
		_landVehicles append _newVehicles;
		nil;
	} count _ships;
	
	private _vehicles = _airVehicles+_landVehicles;
	private _vehiclesToRemove = if ( _wrecksOnly ) then {
		_vehicles select { count (crew _x) isEqualTo 0 && ((damage _x) > 0.9 || !(canMove _x)) };
	} else {
		_vehicles select { count (crew _x) isEqualTo 0 };
	};

	{
		private _veh = _x;
		if ( count (crew _veh) isEqualTo 0 ) then {
			_veh allowDamage false;
			{detach _x; deleteVehicle _x; nil;} count (attachedObjects _veh);
			_veh setPos [0,0,-30];
			sleep 0.5;
			_veh allowDamage true;
			_veh setDamage 1;
		};
	} forEach _vehiclesToRemove;
	sleep 10;
	{deleteVehicle _x; nil;} count _vehiclesToRemove;
	
};

_handle
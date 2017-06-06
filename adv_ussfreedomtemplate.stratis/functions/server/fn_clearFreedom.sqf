/*
 * Author: Belbo
 *
 * Removes AIR and LAND vehicles from surface of uss freedom and let's them respawn.
 * If no specific uss freedom object is provided, all uss freedoms present in mission will be 'wiped'.
 *
 * Arguments:
 * 0: Freedom object (optional) - <OBJECT>
 *
 * Return Value:
 * Script handle - <HANDLE>
 *
 * Example:
 * _handle = [freedom_1] call adv_fnc_clearFreedom;
 *
 * Public: Yes
 */
 
_handle = _this spawn {

	 params [
		["_ship",objNull,[objNull]]
	];

	private _ships = [];
	if ( isNull _ship ) then {
		_ships = allMissionObjects "Land_Carrier_01_base_F";
	} else {
		_ships = [_ship];
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
	private _vehiclesToRemove = _vehicles select { count (crew _x) isEqualTo 0 };

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
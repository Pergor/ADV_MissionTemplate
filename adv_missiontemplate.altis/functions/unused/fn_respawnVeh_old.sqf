/*
 * Author: Belbo
 *
 * Respawn handler for vehicles
 *
 * Arguments:
 * 0: vehicle - <OBJECT>
 * 1: respawn delay in seconds (optional) - <NUMBER>
 * 2: vehicle will be replaced with this new classname (optional) - <STRING>
 *
 * Return Value:
 * Script handle - <HANDLE>
 *
 * Example:
 * _handle = [MRAP_1, 30] call adv_fnc_respawnVeh;
 *
 * Public: Yes
 */

if (!isServer) exitWith {};

_handle = _this spawn {

	waitUntil {time > 20};

	params [
		["_veh", objNull, [objNull]],
		["_delay", 5, [0]],
		["_side", west, [west]],
		"_name","_newVehicleName","_markerName","_respawnPos","_vehType"
	];

	//delay
	if (_delay < 5) then {_delay = 5};
	if (_delay == 9999) exitWith {};
	//vehicle side
	_sidePrefix = switch (_side) do {
		default {""};
		case east: {"opf_" };
		case independent: {"ind_"};
	};
	//vehicle classname
	if (count _this > 3) then {_vehType = _this select 3;} else {_vehType = typeOf _veh;};

	//initial respawn position
	_name = vehicleVarname _veh;
	if (_name == "") then {
		if (isNil "ADV_respawnVeh_newNameNumber") then {ADV_respawnVeh_newNameNumber=1;};
		_newVehicleName = format ["%1%2","newVehicle_",ADV_respawnVeh_newNameNumber];
		_veh setVehicleVarname _newVehicleName;
		_name = _newVehicleName;
		ADV_respawnVeh_newNameNumber = ADV_respawnVeh_newNameNumber+1;
	};
	_markerName = format ["%1%2","respPos_",_name];
	_respawnPos = createMarkerLocal [_markerName, getPosASL _veh];
	_respawnPos setMarkerDirLocal (getDir _veh);
	_respHeightPos = getPosASL _veh;
	_objectTextures = getObjectTextures _veh;
	_initLine = _veh getVariable ["adv_vehicleinit",""];

	while {true} do {
		waitUntil {sleep 1; !alive _veh};
		_objectTextures = getObjectTextures _veh;
		sleep 1;
		if (isNull _veh) exitWith {
			deleteMarkerLocal _respawnPos;
		};
		sleep _delay-2;
		{detach _x; deleteVehicle _x} count attachedObjects _veh;
		if (_veh distance2D (getMarkerPos _respawnPos) < 100) then { deleteVehicle _veh; };
		_veh enableSimulation false;
		sleep 2;
		_veh = createVehicle [_vehType, (getMarkerPos _respawnPos), [], 0, "NONE"];
		_veh allowDamage false;
		_veh setPosASL _respHeightPos;
		_veh setDir (markerDir _respawnPos);
		//[_veh,_name] remoteExec ["setVehicleVarName",0];
		//_veh call compile format ["%1 = _this; publicVariable '%1'", _name];
		[_veh,_name] call adv_fnc_changeUnit;
		sleep 2;
		_veh allowDamage true;
		for "_i" from 0 to ((count _objectTextures)-1) do {
			_veh setObjectTextureGlobal [_i,(_objectTextures select _i)];
		};
		
		if ( (str _veh) in ADV_veh_all ) then {
			call compile format ["%1 spawn %2",_veh,adv_manageVeh_codeForAll];
		};
		if ( (str _veh) in ADV_opf_veh_all ) then {
			call compile format ["%1 spawn %2",_veh,adv_opf_manageVeh_codeForAll];
		};
		if ( (str _veh) in ADV_ind_veh_all ) then {
			call compile format ["%1 spawn %2",_veh,adv_ind_manageVeh_codeForAll];
		};
		if !( (str _veh) in ADV_veh_all || (str _veh) in ADV_opf_veh_all || (str _veh) in ADV_ind_veh_all ) then {
			if (_veh isKindOf "Helicopter" || _veh isKindOf "Ship") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,2,false],_sidePrefix,"fnc_vehicleLoad"]; };
			if (_veh isKindOf "Plane") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,1,false],_sidePrefix,"fnc_vehicleLoad"]; };
			if (_veh isKindOf "Tank") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,2,false],_sidePrefix,"fnc_vehicleLoad"]; };
			if (_veh isKindOf "Car") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,1,false],_sidePrefix,"fnc_vehicleLoad"]; };
			if (_veh isKindOf "Motorcycle") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,1,false],_sidePrefix,"fnc_vehicleLoad"]; };
			if (_veh isKindOf "UGV_01_base_F") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,0,false],_sidePrefix,"fnc_vehicleLoad"]; };
		};
		sleep 1;
		call compile format ["%1 call compile %2",_veh,str _initLine];
		_veh setVariable ["adv_vehicleinit",str _initLine];
	};
};

_handle;
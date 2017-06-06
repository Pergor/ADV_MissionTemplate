/*
 * Author: Belbo
 *
 * Respawn handler for vehicles.
 *
 * Arguments:
 * 0: vehicle - <OBJECT>
 * 1: respawn delay in seconds (optional) - <NUMBER>
 * 2: side of the vehicle (optional) - <SIDE>
 *
 * Return Value:
 * Index of killed-Eventhandler - <HANDLE>
 *
 * Example:
 * _index = [MRAP_1, 30, west] call adv_fnc_respawnVeh;
 *
 * Public: Yes
 */

if (!isServer) exitWith {};

params [
	["_veh", objNull, [objNull]],
	["_delay", 5, [0]],
	["_side", west, [west]]
];

//delay
if (_delay < 5) then {_delay = 5};
if (_delay isEqualTo 9999 || isNull _veh) exitWith {};

//vehicle side
private _sidePrefix = switch (_side) do {
	default {""};
	case east: {"opf_" };
	case independent: {"ind_"};
};

//vehiclname:
private _name = vehicleVarname _veh;
if (_name isEqualTo "") then {
	if (isNil "ADV_respawnVeh_newNameNumber") then {ADV_respawnVeh_newNameNumber=1;};
	private _newVehicleName = format ["%1%2","newVehicle_",ADV_respawnVeh_newNameNumber];
	[_veh,_newVehicleName] call adv_fnc_changeUnit;
	_name = _newVehicleName;
	ADV_respawnVeh_newNameNumber = ADV_respawnVeh_newNameNumber+1;
};

//initial respawn position
private _respPos = getPosASL _veh;
private _respVector = [vectorDir _veh, vectorUp _veh];

//store/get variables in vehicle so they can be recalled on respawn:
private _initLine = _veh getVariable ["adv_vehicleinit",""];
_veh setVariable ["adv_respawnevh_vehicleVars",[_delay,_side,_sidePrefix,_name,_initLine,_respPos,_respVector]];

private _respawnEVHCode = {
	_this spawn {

		//basic variables:
		params ["_veh", "_killer", "_instigator", "_useEffects"];
		private _vehicleVars = _veh getVariable ["adv_respawnevh_vehicleVars", [10,west,"",vehicleVarname _veh,"",getPosASL _veh,0]];
		_vehicleVars params ["_delay","_side","_sidePrefix","_name","_initLine","_respPos","_respVector"];
		private _objectTextures = getObjectTextures _veh;
		private _vehType = typeOf _veh;

		sleep _delay-2;
		{detach _x; deleteVehicle _x} count attachedObjects _veh;
		if (_veh distance2D _respPos < 100) then { deleteVehicle _veh; };
		_veh enableSimulation false;
		sleep 2;
		_respPos = [(_respPos select 0),(_respPos select 1),(_respPos select 2)+0.2];
		_veh = createVehicle [_vehType, _respPos, [], 0, "NONE"];
		_veh allowDamage false;
		_veh setPosASL _respPos;
		_veh setVectorDirAndUp _respVector;
		[_veh,_name] call adv_fnc_changeUnit;
		sleep 2;
		_veh allowDamage true;
		for "_i" from 0 to ((count _objectTextures)-1) do {
			_veh setObjectTextureGlobal [_i,(_objectTextures select _i)];
		};
		
		call {
			if ( (str _veh) in (missionNamespace getVariable ["ADV_veh_all",[]]) ) exitWith {
				call compile format ["%1 spawn %2",_veh,adv_manageVeh_codeForAll];
			};
			if ( (str _veh) in (missionNamespace getVariable ["ADV_opf_veh_all",[]]) ) exitWith {
				call compile format ["%1 spawn %2",_veh,adv_opf_manageVeh_codeForAll];
			};
			if ( (str _veh) in (missionNamespace getVariable ["ADV_ind_veh_all",[]]) ) exitWith {
				call compile format ["%1 spawn %2",_veh,adv_ind_manageVeh_codeForAll];
			};
			if (_veh isKindOf "Helicopter" || _veh isKindOf "Ship") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,2,false],_sidePrefix,"fnc_vehicleLoad"]; };
			if (_veh isKindOf "Plane") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,1,false],_sidePrefix,"fnc_vehicleLoad"]; };
			if (_veh isKindOf "Tank") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,2,false],_sidePrefix,"fnc_vehicleLoad"]; };
			if (_veh isKindOf "Car") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,1,false],_sidePrefix,"fnc_vehicleLoad"]; };
			if (_veh isKindOf "Motorcycle") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,1,false],_sidePrefix,"fnc_vehicleLoad"]; };
			if (_veh isKindOf "UGV_01_base_F") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,0,false],_sidePrefix,"fnc_vehicleLoad"]; };
			[_veh, _delay, _side] call adv_fnc_respawnVeh;
			_veh enableDynamicSimulation true;
		};
		sleep 1;
		call compile format ["%1 call compile %2",_veh,str _initLine];
		_veh setVariable ["adv_vehicleinit",str _initLine];
	};
};

//add EVH:
_index = _veh addEventHandler ["killed",_respawnEVHCode];
_veh setVariable ["adv_respawnVeh_hasEVH",true,true];

_index;
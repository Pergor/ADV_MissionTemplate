/*
Vehicle Respawn Script by belbo
Respawnt ein Fahrzeug nach angegebener Zeit.
defined in cfgFunctions (functions\server\fn_respawnVeh.sqf)

_this select 0 = respawnendes Fahrzeuge - object
_this select 1 = Respawn-Zeit - integer
_this select 2 = new vehicle class (optional) - object

call via:

[VEHICLE,DELAY] spawn ADV_fnc_respawnVeh;

*/
if (!isServer) exitWith {};
waitUntil {time > 20};

/*
private ["_veh","_delay","_name","_markerName","_respawnPos","_vehType"];
_veh = [_this, 0, ObjNull, [ObjNull]] call BIS_fnc_param;
_delay = [_this, 1, 5, [0]] call BIS_fnc_param;
*/

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
/*
_respawnPos setMarkerPos [_markerPos select 0, _markerPos select 1, (getPosASL _veh) select 2];
*/

while {true} do {
	waitUntil {sleep 1; !alive _veh};
	sleep 1;
	if (isNull _veh) exitWith {
		deleteMarkerLocal _respawnPos;
	};
	sleep _delay-3;
	{detach _x; deleteVehicle _x} forEach attachedObjects _veh;
	if (_veh distance2D (getMarkerPos _respawnPos) < 100) then { deleteVehicle _veh; };
	_veh enableSimulation false;
	sleep 2;
	_veh = createVehicle [_vehType, (getMarkerPos _respawnPos), [], 0, "CAN_COLLIDE"];
	_veh setPosASL _respHeightPos;
	_veh setDir (markerDir _respawnPos);
	[_veh,_name] remoteExec ["setVehicleVarName",0];
	_veh call compile format ["%1 = _this; publicVariable '%1'", _name];
	sleep 2;
	{_x addCuratorEditableObjects [[_veh],false];} forEach allCurators;
	[_veh] call ADV_fnc_clearCargo;
	if ((str _veh) in ADV_veh_all || (str _veh) in ADV_opf_veh_all || (str _veh) in ADV_ind_veh_all) then {
		call compile format ["[%1] call adv_%2%3",_veh,_sidePrefix,"fnc_addVehicleLoad"];
	} else {
		if (_veh isKindOf "Helicopter" || _veh isKindOf "Ship") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,2,false],_sidePrefix,"fnc_vehicleLoad"]; };
		if (_veh isKindOf "Plane") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,1,false],_sidePrefix,"fnc_vehicleLoad"]; };
		if (_veh isKindOf "Tank") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,2,false],_sidePrefix,"fnc_vehicleLoad"]; };
		if (_veh isKindOf "Car") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,1,false],_sidePrefix,"fnc_vehicleLoad"]; };
		if (_veh isKindOf "Motorcycle") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,1,false],_sidePrefix,"fnc_vehicleLoad"]; };
		if (_veh isKindOf "UGV_01_base_F") then { call compile format ["%1 call ADV_%2%3",[_veh,false,false,0,false],_sidePrefix,"fnc_vehicleLoad"]; };
	};
	if (ADV_par_TIEquipment > 0) then {
		_veh disableTIEquipment true;
		if (ADV_par_TIEquipment > 2) then {
			_veh disableNVGEquipment true;
		};
	};
	if ( ADV_par_Radios > 0 && (_veh isKindOf "CAR" || _veh isKindOf "TANK" || _veh isKindOf "AIR") ) then {
		_veh setVariable ["tf_hasRadio", true, true];
		//_veh setVariable ["tf_side", west, true];
	};
	if ( _name in ADV_veh_artys || _name in ADV_opf_veh_artys || _name in ADV_ind_veh_artys ) then {
		[_veh] call ADV_fnc_showArtiSetting;
	};
	if (_name in ADV_ind_veh_all && ADV_par_indUni != 0) then {
		sleep 2;
		_x setObjectTextureGlobal [0,'#(rgb,8,8,3)color(1,1,1,0.004)'];
		if (str _x in ADV_ind_veh_transport) then {
			_x setObjectTextureGlobal [1,'#(rgb,8,8,3)color(1,1,1,0.004)'];
		};
	};
	if (isClass(configFile >> "CfgPatches" >> "rhs_main")) then {
		[_veh] call ADV_opf_fnc_rhsDecals;
	};
	if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {
		[_veh] call ADV_fnc_rhsDecals;
	};
	call compile format ["[%1] call adv_%2%3",_veh,_sidePrefix,"fnc_disableVehSelector"];
};
	
if (true) exitWith{};
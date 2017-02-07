/*
Vehicle Change Script by belbo
Ersetzt ein Fahrzeug durch ein anderes
defined in cfgFunctions (functions\server\fn_changeVeh.sqf)

_this select 0 = Fahrzeugtyp (arry with vehicle names)
_this select 1 = ersetzende Fahrzeuge (array!)

call via:

[[VEHICLEARRAY],["classname"]] call ADV_fnc_changeVeh;

*/
if (!isServer) exitWith {};

params [
	["_vehicleType", [""], [[]]],
	["_newVehs", [""], [[]]]
];
if (count _vehicleType == 0) exitWith {};

{
	if (isNil _x) exitWith {};
	private _vehObj = missionNamespace getVariable [_x,objNull];
	//_isVehicle = _object in _vehicleType;
	//if (_isVehicle) then {
	[_vehObj,_newVehs] spawn {
		private _vehObj = _this select 0;
		private _newVehs = _this select 1;
		private _newVehType = selectRandom _newVehs;
		private _object = str _vehObj;
		private _name = vehicleVarName _vehObj;
		private _dir = getDir _vehObj; 
		private _pos = getPosATL _vehObj;
		{deleteVehicle _vehObj} count attachedObjects _vehObj;
		deleteVehicle _vehObj;
		sleep 1;
		if (_newVehType == "") exitWith {}; 
		private _veh = createVehicle [_newVehType, _pos, [], 0, "NONE"];
		if ( isNull _veh ) exitWith { diag_log format ["The vehicle class %1 doesn't exist anymore. adv_fnc_changeVeh can't work.",_newVehType]; };
		_veh allowDamage false;
		_veh setDir _dir;
		_veh setPosATL [_pos select 0, _pos select 1, _pos select 2];
		[_veh,_name] remoteExec ["setVehicleVarName",0];
		_veh call compile format ["%1 = _this; publicVariable '%1'", _name];
		sleep 1;
		//code for handled vehicles:
		waitUntil {!isNil "ADV_veh_all" && !isNil "ADV_opf_veh_all" && !isNil "ADV_ind_veh_all"};
		if ( (str _veh) in ADV_veh_all ) then {
			call compile format ["%1 spawn %2",_veh,adv_manageVeh_codeForAll];
			[_veh,ADV_par_vehicleRespawn, west, (typeOf _veh)] spawn ADV_fnc_respawnVeh;
		};
		if ( (str _veh) in ADV_opf_veh_all ) then {
			call compile format ["%1 spawn %2",_veh,adv_opf_manageVeh_codeForAll];
			[_veh,ADV_par_vehicleRespawn, east, (typeOf _veh)] spawn ADV_fnc_respawnVeh;
		};
		if ( (str _veh) in ADV_ind_veh_all ) then {
			call compile format ["%1 spawn %2",_veh,adv_ind_manageVeh_codeForAll];
			[_veh,ADV_par_vehicleRespawn, independent, (typeOf _veh)] spawn ADV_fnc_respawnVeh;
		};
		
		_veh allowDamage true;
		_veh setVariable ["adv_var_vehicleIsChanged",true,true];
	};
	nil;
} count _vehicleType;
	
if (true) exitWith{};
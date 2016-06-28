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
	["_newVehs", [""], [[]]],
	["_side", west, [west]],
	"_newVeh","_object","_isVehicle","_newType","_dir","_object","_dir","_pos","_name","_count","_newVehicle"
];
//if (count _this > 2) then { _initNew = _this select 2;} else { _initNew = {};};

{
	_newVehType = selectRandom _newVehs;
	_object = str _x;
	_isVehicle = _object in _vehicleType;
	if (_isVehicle) then {
		_name = vehicleVarName _x;
		_dir = getDir _x; 
		_pos = getPosATL _x;
		{deleteVehicle _x} count attachedObjects _x;
		deleteVehicle _x;
		sleep 1;
		if (_newVehType == "") exitWith {}; 
		_veh = createVehicle [_newVehType, _pos, [], 0, "NONE"];
		if ( isNull _veh ) exitWith { diag_log format ["The vehicle class %1 doesn't exist anymore. adv_fnc_changeVeh can't work.",_newVehType]; };
		_veh setDir _dir;
		_veh setPosATL [_pos select 0, _pos select 1, _pos select 2];
		[_veh,_name] remoteExec ["setVehicleVarName",0];
		_veh call compile format ["%1 = _this; publicVariable '%1'", _name];
		sleep 2;
		//code for handled vehicles:
		waitUntil {!isNil "ADV_veh_all" && !isNil "ADV_opf_veh_all" && !isNil "ADV_ind_veh_all"};
		if ( (str _veh) in ADV_veh_all ) then {
			call compile format ["%1 spawn %2",_veh,adv_manageVeh_codeForAll];
		};
		if ( (str _veh) in ADV_opf_veh_all ) then {
			call compile format ["%1 spawn %2",_veh,adv_opf_manageVeh_codeForAll];
		};
		if ( (str _veh) in ADV_ind_veh_all ) then {
			call compile format ["%1 spawn %2",_veh,adv_ind_manageVeh_codeForAll];
		};
		
		_veh setVariable ["adv_var_vehicleIsChanged",true,true];
	};
	nil;
} count vehicles;
	
if (true) exitWith{};
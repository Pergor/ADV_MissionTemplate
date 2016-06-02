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

/*
private ["_vehicleType","_newVehs","_newVeh","_newType","_dir","_object","_dir","_pos","_name","_count"];
_vehicleType = _this select 0;
_newVehs = _this select 1;
*/

params [
	["_vehicleType", [""], [[]]],
	["_newVehs", [""], [[]]],
	["_side", west, [west]],
	"_newVeh","_object","_isVehicle","_newType","_dir","_object","_dir","_pos","_name","_count","_newVehicle"
];
//if (count _this > 2) then { _initNew = _this select 2;} else { _initNew = {};};

{
	_newVehType = _newVehs call BIS_fnc_selectRandom;
	_object = str _x;
	_isVehicle = _object in _vehicleType;
	if (_isVehicle) then {
		_name = vehicleVarName _x;
		_dir = getDir _x; 
		_pos = getPosATL _x;
		{deleteVehicle _x} forEach attachedObjects _x;
		deleteVehicle _x;
		sleep 1;
		if (_newVehType == "") exitWith {}; 
		_veh = createVehicle [_newVehType, _pos, [], 0, "NONE"];
		if ( isNull _veh ) exitWith { diag_log format ["The vehicle class %1 doesn't exist anymore. adv_fnc_changeVeh can't work.",_newVehType]; };
		_veh setDir _dir;
		_veh setPosATL [_pos select 0, _pos select 1, _pos select 2];
		[_veh,_name] remoteExec ["setVehicleVarName",0];
		_veh call compile format ["%1 = _this; publicVariable '%1'", _name];
		
		//disables the vehicle if necessary
		[_veh,_name,_side] spawn {
			sleep 1;
			_veh = _this select 0;
			_name = _this select 1;
			_side = _this select 2;
			//vehicle side
			_sidePrefix = switch (_side) do {
				default {""};
				case east: {"opf_" };
				case independent: {"ind_"};
			};
			_newType = typeOf _veh;
			if ( _name in ADV_veh_artys || _name in ADV_opf_veh_artys || _name in ADV_ind_veh_artys ) then {
				[_veh] call ADV_fnc_showArtiSetting;
			};
			if (ADV_par_TIEquipment > 0) then {
				_veh disableTIEquipment true;
				if (ADV_par_TIEquipment > 2) then {
					_veh disableNVGEquipment true;
				};
			};
			[_veh,ADV_par_vehicleRespawn, _side, (typeOf _veh)] spawn ADV_fnc_respawnVeh;
			{_veh addCuratorEditableObjects [[_veh],false];} forEach allCurators;
			if ( ADV_par_Radios > 0 && (_veh isKindOf "CAR" || _veh isKindOf "TANK" || _veh isKindOf "AIR") ) then {
				_veh setVariable ["tf_hasRadio", true, true];
			};
			[_veh] call ADV_fnc_clearCargo;
			sleep 1;
			call compile format ["[%1] call adv_%2%3",_veh,_sidePrefix,"fnc_addVehicleLoad"];
			call compile format ["[%1] call adv_%2%3",_veh,_sidePrefix,"fnc_disableVehSelector"];
			if (isClass(configFile >> "CfgPatches" >> "rhs_main")) then {
				[_veh] call ADV_opf_fnc_rhsDecals;
			};
			if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {
				[_veh] call ADV_fnc_rhsDecals;
			};
			_veh setVariable ["adv_var_vehicleIsChanged",true,true];
		};
	};
} forEach vehicles;
	
if (true) exitWith{};
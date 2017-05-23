/*
 * Author: Belbo
 *
 * Changes vehicles into randomly selected classes from provided classnames
 *
 * Arguments:
 * 0: Vehicles - <ARRAY> of <OBJECTS>
 * 1: Classnames - <ARRAY> of <STRINGS>
 *
 * Return Value:
 * Function executed <BOOL>
 *
 * Example:
 * [[MRAP_1, MRAP_2, ..., MRAP_n], ["B_MRAP_1_F"]] call adv_fnc_changeVeh;
 *
 * Public: Ye
 */

if (!isServer) exitWith {};

params [
	["_vehicleType", [""], [[]]]
	,["_newVehs", [""], [[]]]
];
if (count _vehicleType isEqualTo 0) exitWith {};

{
	if (isNil _x) exitWith {};
	private _vehObj = missionNamespace getVariable [_x,objNull];
	//_isVehicle = _object in _vehicleType;
	//if (_isVehicle) then {
	[_vehObj,_newVehs] spawn {
		params ["_vehObj","_newVehs"];
		private _oldVehType = typeOf _vehObj;
		private _oldVehParent = ([configfile >> "CfgVehicles" >> _oldVehType, true] call BIS_fnc_returnParents) select 1;
		private _oldVehTextures = ([_vehObj] call BIS_fnc_getVehicleCustomization) select 0;
		private _newVehType = selectRandom _newVehs;
		private _newVehParent = ([configfile >> "CfgVehicles" >> _newVehType, true] call BIS_fnc_returnParents) select 1;
		private _object = str _vehObj;
		private _name = vehicleVarName _vehObj;
		private _vector = [vectorDir _vehObj,vectorUp _vehObj];
		private _pos = getPosATL _vehObj;
		{deleteVehicle _vehObj} count attachedObjects _vehObj;
		deleteVehicle _vehObj;
		sleep 1;
		if (_newVehType isEqualTo "") exitWith {};
		private _veh = createVehicle [_newVehType, _pos, [], 0, "NONE"];
		if ( isNull _veh ) exitWith { diag_log format ["The vehicle class %1 doesn't exist anymore. adv_fnc_changeVeh can't work.",_newVehType]; };
		_veh allowDamage false;
		_veh setVectorDirAndUp _vector;
		_veh setPosATL [_pos select 0, _pos select 1, _pos select 2];
		[_veh,_name] remoteExec ["setVehicleVarName",0];
		_veh call compile format ["%1 = _this; publicVariable '%1'", _name];
		sleep 1;
		if (_oldVehParent isEqualTo _newVehParent) then {
			[_veh,_oldVehTextures] call BIS_fnc_initVehicle;
		};
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
		
		_veh allowDamage true;
		_veh setVariable ["adv_var_vehicleIsChanged",true,true];
	};
	nil;
} count _vehicleType;
	
true;
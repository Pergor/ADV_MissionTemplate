/*
 * Author: Belbo
 *
 * Retextures vehicle if some conditions are met.
 *
 * Arguments:
 * 0: vehicle - <OBJECT>
 *
 * Return Value:
 * texture applied - <BOOL>
 *
 * Example:
 * [MRAP_1] call adv_fnc_retexture;
 *
 * Public: Yes
 */

params [
	["_target", objNull, [objNull]]
];

if ( toUpper (typeOf _target) in ['B_T_LSV_01_UNARMED_F','B_T_LSV_01_ARMED_F','B_LSV_01_UNARMED_F','B_LSV_01_ARMED_F'] ) exitWith {
	if ( (toUpper worldname) in ADV_var_lushMaps ) exitWith {
		[_target,'OLIVE',nil] call BIS_fnc_initVehicle;
		true;
	};
};
if ( toUpper (typeOf _target) in ['O_T_LSV_02_ARMED_F','O_T_LSV_02_UNARMED_F','O_LSV_02_ARMED_F','O_LSV_02_UNARMED_F'] ) exitWith {
	[_target,'BLACK',nil] call BIS_fnc_initVehicle;
	true;
};
if ( toUpper (typeOf _target) in ['I_MRAP_03_F','I_MRAP_03_HMG_F','I_MRAP_03_GMG_F'] ) exitWith {
	[_target,'BLUFOR',true] call BIS_fnc_initVehicle;
	true;
};
if ( isClass(configFile >> "CfgPatches" >> "adv_retex") ) exitWith {
	if ( toUpper (typeOf _target) in ['B_MRAP_01_F','B_MRAP_01_HMG_F','B_MRAP_01_GMG_F'] && (toUpper worldname) in ADV_var_aridMaps ) exitWith {
		[_target] call adv_retex_fnc_setTextureRHSHunter;
		true;
	};
	if ( toUpper (typeOf _target) isEqualTo 'I_APC_WHEELED_03_CANNON_F' ) exitWith {
		[_target] call adv_retex_fnc_setTextureNATOGorgon;
		true;
	};
	if ( toUpper (typeOf _target) isEqualTo 'O_APC_WHEELED_02_RCWS_F' ) exitWith {
		[_target] call adv_retex_fnc_setTextureMarid;
		true;
	};
	if ( toUpper (typeOf _target) isEqualTo 'I_APC_TRACKED_03_CANNON_F' ) exitWith {
		[_target] call adv_retex_fnc_setTextureMora;
		true;
	};
	false
};
if ( toUpper (typeOf _target) in ['BWA3_EAGLE_TROPEN'] ) exitWith {
	[_target,['Tropen', 0.5, 'Tropen3', 0.5],["backpack_back",1]] call BIS_fnc_initVehicle;
	true;
};
if ( toUpper (typeOf _target) in ['BWA3_EAGLE_FLW100_TROPEN'] ) exitWith {
	[_target,['Tropen2', 0.5, 'Tropen6', 0.5],["backpack_back",1]] call BIS_fnc_initVehicle;
	true;
};

false;
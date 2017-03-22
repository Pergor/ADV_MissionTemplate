params [
	["_target", objNull, [objNull]]
];

if ( (toUpper worldname) in ADV_var_lushMaps ) exitWith {
	if ( toUpper (typeOf _target) in ['B_T_LSV_01_UNARMED_F','B_T_LSV_01_ARMED_F','B_LSV_01_UNARMED_F','B_LSV_01_ARMED_F'] ) exitWith {
		[_target,'OLIVE',nil] call BIS_fnc_initVehicle;
	};
};
if ( toUpper (typeOf _target) in ['O_T_LSV_02_ARMED_F','O_T_LSV_02_UNARMED_F','O_LSV_02_ARMED_F','O_LSV_02_UNARMED_F'] ) exitWith {
	[_target,'BLACK',nil] call BIS_fnc_initVehicle;
};
if ( toUpper (typeOf _target) in ['I_MRAP_03_F','I_MRAP_03_HMG_F','I_MRAP_03_GMG_F'] ) exitWith {
	[_target,'BLUFOR',true] call BIS_fnc_initVehicle;
};
if ( isClass(configFile >> "CfgPatches" >> "adv_retex") ) exitWith {
	if ( toUpper (typeOf _target) in ['B_MRAP_01_F','B_MRAP_01_HMG_F','B_MRAP_01_GMG_F'] && (toUpper worldname) in ADV_var_aridMaps ) exitWith {
		[_target] call adv_retex_fnc_setTextureRHSHunter;
	};
	if ( toUpper (typeOf _target) isEqualTo 'I_APC_WHEELED_03_CANNON_F' ) exitWith {
		[_target] call adv_retex_fnc_setTextureNATOGorgon;
	};
	if ( toUpper (typeOf _target) isEqualTo 'O_APC_WHEELED_02_RCWS_F' ) exitWith {
		[_target] call adv_retex_fnc_setTextureMarid;
	};
	if ( toUpper (typeOf _target) isEqualTo 'I_APC_TRACKED_03_CANNON_F' ) exitWith {
		[_target] call adv_retex_fnc_setTextureMora;
	};
};
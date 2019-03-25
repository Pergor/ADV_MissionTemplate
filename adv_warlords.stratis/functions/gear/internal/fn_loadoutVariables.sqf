/*
 * Author: Belbo
 *
 * Defines a whole lot of variables necessary for the loadout scripts, to be available in the scope of the loadout functions.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * call adv_fnc_loadoutVariables;
 *
 * Public: No
 */

//mission variables and parameters:
_par_customLoad = missionNamespace getVariable ["adv_par_customLoad",["param_customLoad",1] call BIS_fnc_getParamValue];

_par_customWeap = missionNamespace getVariable ["adv_par_customWeap",["param_customWeap",0] call BIS_fnc_getParamValue];
_par_opfWeap = missionNamespace getVariable ["adv_par_opfWeap",["param_opfWeap",0] call BIS_fnc_getParamValue];
_par_indWeap = missionNamespace getVariable ["adv_par_indWeap",["param_indWeap",0] call BIS_fnc_getParamValue];

_par_customUni = missionNamespace getVariable ["adv_par_customUni",["param_customUni",0] call BIS_fnc_getParamValue];
_par_indUni = missionNamespace getVariable ["adv_par_indUni",["param_indUni",0] call BIS_fnc_getParamValue];
_par_opfUni = missionNamespace getVariable ["adv_par_opfUni",["param_opfUni",0] call BIS_fnc_getParamValue];

_par_NVGs = missionNamespace getVariable ["adv_par_NVGs",["param_NVGs",0] call BIS_fnc_getParamValue];
_par_opfNVGs = missionNamespace getVariable ["adv_par_opfNVGs",["param_opfNVGs",0] call BIS_fnc_getParamValue];

_par_optics = missionNamespace getVariable ["adv_par_optics",["param_optics",1] call BIS_fnc_getParamValue];
_par_opfOptics = missionNamespace getVariable ["adv_par_opfOptics",["param_opfOptics",1] call BIS_fnc_getParamValue];

_par_Silencers = missionNamespace getVariable ["adv_par_silencers",["param_silencers",0] call BIS_fnc_getParamValue];
_par_opfSilencers = missionNamespace getVariable ["adv_par_opfSilencers",["param_opfSilencers",0] call BIS_fnc_getParamValue];

_par_tablets = missionNamespace getVariable ["adv_par_tablets",["param_tablets",1] call BIS_fnc_getParamValue];
_par_radios = missionNamespace getVariable ["adv_par_radios",["param_radios",1] call BIS_fnc_getParamValue];

_par_ace_medical_GivePAK = missionNamespace getVariable ["adv_par_ace_medical_GivePAK",["param_ace_medical_GivePAK",1] call BIS_fnc_getParamValue];

_var_aridMaps = missionNamespace getVariable ["adv_var_aridMaps",[]];
_var_saridMaps = missionNamespace getVariable ["adv_var_saridMaps",[]];
_var_lushMaps = missionNamespace getVariable ["adv_var_lushMaps",[]];
_var_europeMaps = missionNamespace getVariable ["adv_var_europeMaps",[]];

_par_TIEquipment = missionNamespace getVariable ["adv_par_TIEquipment",["param_TIEquipment",0] call BIS_fnc_getParamValue];
_par_invinciZeus = missionNamespace getVariable ["adv_par_invinciZeus",["param_invinciZeus",0] call BIS_fnc_getParamValue];
_par_logisticAmount = missionNamespace getVariable ["adv_par_logisticAmount",["param_logisticAmount",0] call BIS_fnc_getParamValue];

_loadoutVariables = true;

_loadoutVariables;
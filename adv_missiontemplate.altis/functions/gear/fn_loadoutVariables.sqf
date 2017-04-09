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
_par_customLoad = missionNamespace getVariable ["adv_par_customLoad",1];

_par_customWeap = missionNamespace getVariable ["adv_par_customWeap",0];
_par_opfWeap = missionNamespace getVariable ["adv_par_opfWeap",0];
_par_indWeap = missionNamespace getVariable ["adv_par_indWeap",0];

_par_customUni = missionNamespace getVariable ["adv_par_customUni",0];
_par_indUni = missionNamespace getVariable ["adv_par_indUni",0];
_par_opfUni = missionNamespace getVariable ["adv_par_opfUni",0];

_par_NVGs = missionNamespace getVariable ["adv_par_NVGs",1];
_par_opfNVGs = missionNamespace getVariable ["adv_par_opfNVGs",1];

_par_optics = missionNamespace getVariable ["adv_par_optics",1];
_par_opfOptics = missionNamespace getVariable ["adv_par_opfOptics",1];

_par_Silencers = missionNamespace getVariable ["adv_par_silencers",0];
_par_opfSilencers = missionNamespace getVariable ["adv_par_opfSilencers",0];

_par_tablets = missionNamespace getVariable ["adv_par_tablets",1];
_par_radios = missionNamespace getVariable ["adv_par_radios",1];

_par_ace_medical_GivePAK = missionNamespace getVariable ["adv_par_ace_medical_GivePAK",1];

_var_aridMaps = missionNamespace getVariable ["adv_var_aridMaps",[]];
_var_saridMaps = missionNamespace getVariable ["adv_var_saridMaps",[]];
_var_lushMaps = missionNamespace getVariable ["adv_var_lushMaps",[]];
_var_europeMaps = missionNamespace getVariable ["adv_var_europeMaps",[]];

_par_TIEquipment = missionNamespace getVariable ["adv_par_TIEquipment",0];
_par_invinciZeus = missionNamespace getVariable ["adv_par_invinciZeus",0];
_par_logisticAmount = missionNamespace getVariable ["adv_par_logisticAmount",0];

_loadoutVariables = true;

_loadoutVariables;
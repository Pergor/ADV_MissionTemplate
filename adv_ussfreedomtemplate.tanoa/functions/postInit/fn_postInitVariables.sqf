/*
 * Author: Belbo
 *
 * Contains or creates all the variables that are important for adv_missiontemplate and need to be called in postInit.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [] call adv_fnc_postInitVariables;
 *
 * Public: No
 */
 
private _return = false;

//ADV-ACE CPR stuff:
adv_aceCPR_onlyDoctors = missionNamespace getVariable ["adv_par_adv_aceCPR_onlyDoctors",0];
if ( isClass(configFile >> "CfgWeapons" >> "adv_aceCPR_AED") && missionNamespace getVariable ["adv_par_adv_aceCPR_AED",1] isEqualTo 2 ) then {
	private _probs = missionNamespace getVariable ["adv_aceCPR_probabilities", [40,15,5,85]];
	adv_aceCPR_probabilities set [0,((_probs select 0)-10) max 10];
	adv_aceCPR_probabilities set [1,((_probs select 1)-5) max 5];
};

//return:
_return = true;
_return
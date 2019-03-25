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
if ( isClass(configFile >> "CfgWeapons" >> "adv_aceCPR_AED") ) then {
	if ( missionNamespace getVariable ["adv_par_adv_aceCPR_AED",1] isEqualTo 2 ) then {
		/*
		private _probs = missionNamespace getVariable ["adv_aceCPR_probabilities", [40,15,5,85]];
		adv_aceCPR_probabilities set [0,((_probs select 0)-10) max 10];
		adv_aceCPR_probabilities set [1,((_probs select 1)-5) max 5];
		*/
	};
	private _aceCPR_maxTime = missionNamespace getVariable ["adv_par_adv_aceCPR_maxTime",0];
	if ( _aceCPR_maxTime > 0 ) then {
		private _base = missionNamespace getVariable ["ace_medical_maxReviveTime",3200];
		private _result = _base * (_aceCPR_maxTime/100);
		missionNamespace setVariable ["adv_aceCPR_maxTime",_result];
	};
};

//return:
_return = true;
_return
/*
 * Author: Belbo
 *
 * Contains or creates all the ace parameters that are important for adv_missiontemplate.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [] call adv_fnc_aceParams;
 *
 * Public: No
 */
 
missionNamespace setVariable ["ace_medical_level",missionNamespace getVariable ["adv_par_ace_medical_level",2]];
missionNamespace setVariable ["ace_medical_consumeItem_PAK",missionNamespace getVariable ["adv_par_ace_medical_consumeItem_PAK",0]];
missionNamespace setVariable ["ace_medical_enableRevive",missionNamespace getVariable ["adv_par_ace_medical_enableRevive",1]];
missionNamespace setVariable ["ace_medical_maxReviveTime",missionNamespace getVariable ["adv_par_ace_medical_maxReviveTime",900]];
missionNamespace setVariable ["ace_medical_enableFor",missionNamespace getVariable ["adv_par_ace_medical_enableFor",0]];
missionNamespace setVariable ["ace_medical_enableUnconsciousnessAI",missionNamespace getVariable ["adv_par_ace_medical_enableUnconsciousnessAI",0]];
missionNamespace setVariable ["ace_rearm_level",missionNamespace getVariable ["adv_par_ace_rearm_level",1]];

{
	private _variable = _x;
	private _param = format ["adv_par_%1",_variable];
	if ( missionNamespace getVariable [_param,0] isEqualTo 0 ) then {
		missionNamespace setVariable [_variable,false];
	} else {
		missionNamespace setVariable [_variable,true];
	};
	nil;
} count [
	"ace_medical_enableAdvancedWounds"
	,"ace_medical_healHitPointAfterAdvBandage"
	,"ace_medical_preventInstaDeath"
	,"ace_mk6mortar_useAmmoHandling"
];
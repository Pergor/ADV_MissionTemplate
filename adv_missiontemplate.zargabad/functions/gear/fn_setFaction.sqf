/*
 * Author: Belbo
 *
 * Sets ace_nametags_faction to the provided faction or depending on adv_missiontemplate-variables.
 *
 * Arguments:
 * 0: target - <OBJECT>
 * 1: New faction (optional) - <STRING>
 *
 * Return Value:
 * New faction - <STRING>
 *
 * Example:
 * [player, "RHS_FACTION_USARMY_WD"] call adv_fnc_setFaction;
 *
 * Public: Yes
 */

params [
	["_unit", player, [objNull]],
	["_faction", "", [""]]
];

if !(_faction isEqualTo "") exitWith {
	_unit setVariable ["ace_nametags_faction", _faction, true];
	_faction;
};

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

if (side (group _unit) == west) then {
	_faction = switch (true) do {
		case (_par_customWeap == 1 || (_par_customUni == 1 || _par_customUni == 2) ): {"BWA3_Faction"};
		case (_par_customUni == 7 ): {"RHS_FACTION_USARMY_WD"};
		case (_par_customUni == 8 ): {"RHS_FACTION_USARMY_D"};
		case (_par_customUni == 9 ): {"RHS_FACTION_USMC_D"};
		case (_par_customUni == 10 ): {"RHS_FACTION_USMC_WD"};
		case (_par_customUni == 9 ): {"BLU_G_F"};
		default {"BLU_F"};
	};
};
if (side (group _unit) == east) then {
	_faction = switch (true) do {
		case (_par_opfUni == 5 || _par_opfUni == 6): {"OPF_G_F"};
		case (_par_opfUni == 1 || _par_opfUni == 2 || _par_opfUni == 3): {"RHS_FACTION_MSV"};
		case (_par_opfUni == 4): {"RHS_FACTION_VDV"};
		default {"OPF_F"};
	};
};
if (side (group _unit) == independent) then {
	_faction = switch (true) do {
		case (_par_indUni == 1): {"IND_G_F"};
		default {"IND_F"};
	};
};

_unit setVariable ["ace_nametags_faction", _faction, true];

_faction;
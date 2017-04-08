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

if (side (group _unit) == west) then {
	_faction = switch (true) do {
		case (adv_par_customWeap == 1 || (adv_par_customUni == 1 || adv_par_customUni == 2) ): {"BWA3_Faction"};
		case (adv_par_customUni == 7 ): {"RHS_FACTION_USARMY_WD"};
		case (adv_par_customUni == 8 ): {"RHS_FACTION_USARMY_D"};
		case (adv_par_customUni == 9 ): {"RHS_FACTION_USMC_D"};
		case (adv_par_customUni == 10 ): {"RHS_FACTION_USMC_WD"};
		case (adv_par_customUni == 9 ): {"BLU_G_F"};
		default {"BLU_F"};
	};
};
if (side (group _unit) == east) then {
	_faction = switch (true) do {
		case (adv_par_opfUni == 5 || adv_par_opfUni == 6): {"OPF_G_F"};
		case (adv_par_opfUni == 1 || adv_par_opfUni == 2 || adv_par_opfUni == 3): {"RHS_FACTION_MSV"};
		case (adv_par_opfUni == 4): {"RHS_FACTION_VDV"};
		default {"OPF_F"};
	};
};
if (side (group _unit) == independent) then {
	_faction = switch (true) do {
		case (adv_par_indUni == 1): {"IND_G_F"};
		default {"IND_F"};
	};
};

_unit setVariable ["ace_nametags_faction", _faction, true];

_faction;
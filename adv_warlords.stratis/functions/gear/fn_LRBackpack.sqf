/*
 * Author: Belbo
 *
 * Returns backpack radio depending on adv_missiontemplate-variables.
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * Type of backpack radio - <STRING>
 *
 * Example:
 * _backpackRadio = [player] call adv_fnc_LRBackpack;
 *
 * Public: No
 */

params [
	["_unit", player, [objNull]]
];

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

if ( isClass(configFile >> "CfgPatches" >> "task_force_radio") ) exitWith {
	private _backpack = switch (side (group _unit)) do {
		default {
			switch (_par_CustomUni) do {
				case 1: { ["tfar_rt1523g_bwmod"] };
				case 2: { ["tfar_rt1523g_bwmod"] };
				case 9: { ["tfar_rt1523g_rhs"] };
				case 12: { ["UK3CB_BAF_B_Bergen_MTP_Radio_H_A","UK3CB_BAF_B_Bergen_MTP_Radio_H_B"] };
				case 13: { ["tfar_rt1523g_bwmod"] };
				case 14: { ["tfar_rt1523g_bwmod"] };
				default { ["tfar_rt1523g_rhs"] };
			};
		};
		case east: {
			switch (_par_opfUni) do {
				case 1: { ["tfar_mr3000_rhs"] };
				case 2: { ["tfar_mr3000_rhs"] };
				case 3: { ["tfar_mr3000_rhs"] };
				case 4: { ["tfar_mr3000_rhs"] };
				case 5: { [""] };
				default { ["tfar_bussole"] };
			};
		};
		case independent: {
			switch (_par_indUni) do {
				default { ["tfar_anprc155_coyote"] };
				case 0: { ["tfar_anprc155"] };
			};
		};
	};
	_backpack = selectRandom _backpack;
	_backpack;
};

if ( isClass(configFile >> "CfgPatches" >> "acre_main") ) exitWith {
	private _backpack = switch (side (group _unit)) do {
		default {
			switch (_par_CustomUni) do {
				case 1: { ["BWA3_AssaultPack_Tropen"] };
				case 2: { ["BWA3_AssaultPack_Fleck"] };
				case 12: { ["UK3CB_BAF_B_Bergen_MTP_Radio_L_A","UK3CB_BAF_B_Bergen_MTP_Radio_L_B"] };
				case 20: { ["B_AssaultPack_tna_F"] };
				default { ["B_AssaultPack_blk"] };
			};
		};
		case east: {
			switch (_par_opfUni) do {
				case 1: { ["rhs_assault_umbts"] };
				case 2: { ["rhs_assault_umbts"] };
				case 3: { ["rhs_assault_umbts"] };
				case 4: { ["rhs_assault_umbts"] };
				case 5: { ["B_AssaultPack_blk"] };
				case 6: { ["rhs_sidor"] };
				case 20: { ["B_AssaultPack_tna_F"] };
				default { ["B_AssaultPack_blk"] };
			};
		};
		case independent: {
			switch (_par_indUni) do {
				case 1: { ["B_AssaultPack_blk"] };
				case 20: { ["B_AssaultPack_rgr"] };
				default { ["B_AssaultPack_dgtl"] };
			};
		};
	};
	_backpack = selectRandom _backpack;
	_backpack;
};

false;
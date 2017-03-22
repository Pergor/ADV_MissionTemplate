/*
adv_fnc_addLRRadios by BlauBaer/Belbo

_this select 0 = unit that will have the weapon in its gunbag.
_this select 1 = weapon to be put in the gunbag

Return: Nothing
*/

params [
	["_unit", player, [objNull]]
	,["_selection", 0, [0,true]]
	,"_backpack"
];
if (_selection == 0 || missionNamespace getVariable ["adv_par_noLRRadios",false]) exitWith {};

if ( isClass(configFile >> "CfgPatches" >> "task_force_radio") ) exitWith {
	private _backpackArray = switch (side (group _unit)) do {
		default {
			switch (ADV_par_CustomUni) do {
				case 0: { ["tf_rt1523g_rhs","tf_rt1523g_big"] };
				case 1: { ["tf_rt1523g_bwmod","tf_rt1523g_big_bwmod_tropen"] };
				case 2: { ["tf_rt1523g_bwmod","tf_rt1523g_big_bwmod"] };
				case 3: { ["tf_rt1523g_rhs","tf_rt1523g_sage"] };
				case 12: { [["UK3CB_BAF_B_Bergen_MTP_Radio_H_A","UK3CB_BAF_B_Bergen_MTP_Radio_H_B"],["UK3CB_BAF_B_Bergen_MTP_Radio_L_A","UK3CB_BAF_B_Bergen_MTP_Radio_L_B"]] };
				case 13: { ["tf_rt1523g_bwmod","tf_rt1523g_black"] };
				case 14: { ["tf_rt1523g_bwmod","tf_rt1523g_black"] };
				default { ["tf_rt1523g_rhs","tf_rt1523g_big_rhs"] };
			};
		};
		case east: {
		};
	};
	_backpack = _backpackArray select _selection+1;
	if ( (typeName (_backpack)) == "ARRAY" ) then { _backpack = selectRandom _backpack; };
	_unit addBackpackGlobal _backpack
};


if ( isClass (configFile >> "CfgPatches" >> "acre_main") && (ADV_par_Radios == 1 || ADV_par_Radios == 3) && _giveBackpackRadio ) then {
	_backpack = switch (ADV_par_CustomUni) do {
		case 1: {"BWA3_AssaultPack_Tropen"};
		case 2: {"BWA3_AssaultPack_Fleck"};
		case 12: {["UK3CB_BAF_B_Bergen_MTP_Radio_L_A","UK3CB_BAF_B_Bergen_MTP_Radio_L_B"]};
		case 20: {"B_AssaultPack_tna_F"};
		default {"B_AssaultPack_blk"};
	};
};

nil;
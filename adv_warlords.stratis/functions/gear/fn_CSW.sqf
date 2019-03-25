/*
 * Author: Belbo
 *
 * Adds crew served weapon packs to a unit. Can be called after (_unit getVariable "ADV_var_hasLoadout").
 *
 * Arguments:
 * 0: target - <OBJECT>
 * 1: Kind of weapon pack (1 = HMG weapon backpack; 2 = HMG tripod; 3 = Mortar tube; 4 = Mortar base plate;) - <NUMBER>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [player,1] call adv_fnc_CSW;
 *
 * Public: No
 */

params [
	["_target", player, [objNull]],
	["_type", 1, [0]],
	"_backpack"
];

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

switch (side (group _target)) do {
	case west: {
		_backpack = switch ( _type ) do {
			case 1: {"B_HMG_01_weapon_F"};
			case 2: {"B_HMG_01_support_F"};
			case 3: {"B_Mortar_01_weapon_F"};
			case 4: {"B_Mortar_01_support_F"};
			case 5: {"B_AT_01_weapon_F"};
			case 6: {"B_HMG_01_support_F"};
			case 7: {"B_GMG_01_weapon_F"};
			default {""};
		};
	};
	case east: {
		_backpack = switch ( _type ) do {
			case 1: {"O_HMG_01_weapon_F"};
			case 2: {"O_HMG_01_support_F"};
			case 3: {"O_Mortar_01_weapon_F"};
			case 4: {"O_Mortar_01_support_F"};
			case 5: {"O_AT_01_weapon_F"};
			case 6: {"O_HMG_01_support_F"};
			case 7: {"O_GMG_01_weapon_F"};
			default {""};
		};
	};
	case independent: {
		_backpack = switch ( _type ) do {
			case 1: {"I_HMG_01_weapon_F"};
			case 2: {"I_HMG_01_support_F"};
			case 3: {"I_Mortar_01_weapon_F"};
			case 4: {"I_Mortar_01_support_F"};
			case 5: {"I_AT_01_weapon_F"};
			case 6: {"I_HMG_01_support_F"};
			case 7: {"I_GMG_01_weapon_F"};
			default {""};
		};
	};
	default {
		_backpack = "";
	};
};

if ( isClass(configFile >> "CfgPatches" >> "rhsusf_main") ) then {
	if !(side (group _target) isEqualTo east) then {
		_backpack = switch ( _type ) do {
			case 1: {"RHS_M2_Gun_Bag"};
			case 2: {"RHS_M2_MiniTripod_Bag"};
			case 3: {"rhs_M252_Gun_Bag"};
			case 4: {"rhs_M252_Bipod_Bag"};
			case 5: {"rhs_Tow_Gun_Bag"};
			case 6: {"rhs_TOW_Tripod_Bag"};
			default {""};
		};
	};
};
if ( isClass(configFile >> "CfgPatches" >> "rhs_main") ) then {
	if ( _par_opfWeap > 0 && (side (group _target) isEqualTo east) ) then {
		_backpack = switch ( _type ) do {
			case 1: {"RHS_Kord_Gun_Bag"};
			case 2: {"RHS_Kord_Tripod_Bag"};
			case 3: {"RHS_Podnos_Gun_Bag"};
			case 4: {"RHS_Podnos_Bipod_Bag"};
			case 5: {"RHS_SPG9_Gun_Bag"};
			case 6: {"RHS_SPG9_Tripod_Bag"};
			default {""};
		};
	};
};

if !(backpack _target isEqualTo "") then { removeBackpack _target; };

_target addBackpack _backpack;

true;
/*
 * Author: Belbo
 *
 * Returns a standard weapon for the provided side depending on adv_missiontemplate-variables.
 *
 * Arguments:
 * 0: side to check for standard weapon - <SIDE>
 *
 * Return Value:
 * Array in format ["WEAPON", MAGAZINEINDEX (can be integer or string), "SILENCER"] - <ARRAY>
 *
 * Example:
 * _standardWeapon = [west] call adv_fnc_standardWeapon;
 *
 * Public: No
 */

params [
	["_side", west, [west]]
];

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

if ( _side == west ) exitWith {
	private _standardWeapon = switch ( _par_customweap ) do {
		default { ["arifle_MX_Black_F", "30Rnd_65x39_caseless_mag", "muzzle_snds_H", "optic_Holosight"] };
		//bwmod
		case 1: {
			if (isClass(configFile >> "CfgPatches" >> "hlcweapons_g36")) then {
				["hlc_rifle_G36A1", "hlc_30rnd_556x45_EPR_G36", "", "HLC_Optic_G36dualoptic35x2d"];
			} else {
				["BWA3_G36", "BWA3_30Rnd_556x45_G36", "BWA3_muzzle_snds_G36", "BWA3_optic_ZO4x30"];
			};
		};
		//rhs army
		case 2: { ["rhs_weap_m4_carryhandle", "30Rnd_556x45_Stanag_red", "rhsusf_acc_rotex5_grey", "rhsusf_acc_eotech_552"] };
		//rhs marines
		case 3: { ["rhs_weap_m16a4_carryhandle", "30Rnd_556x45_Stanag_red", "rhsusf_acc_rotex5_grey", "rhsusf_acc_eotech_552"] };
		//rhs specops
		case 4: { ["rhs_weap_hk416d145", "30Rnd_556x45_Stanag_red", "rhsusf_acc_rotex5_grey", "rhsusf_acc_eotech_552"] };
		//cup mk16
		case 5: { ["CUP_arifle_Mk16_STD", "30Rnd_556x45_Stanag_red", "CUP_muzzle_snds_SCAR_L", "CUP_optic_ELCAN_SpecterDR"] };
		//cup m4
		case 6: { ["CUP_arifle_M4A1", "30Rnd_556x45_Stanag_red", "CUP_muzzle_snds_M16", "CUP_optic_RCO"] };
		//cup l85
		case 7: { ["CUP_arifle_L85A2", "30Rnd_556x45_Stanag_red", "CUP_muzzle_snds_L85", "CUP_optic_SUSAT"] };
		//uk3cb
		case 8: { ["UK3CB_BAF_L85A2", "30Rnd_556x45_Stanag_red", "UK3CB_BAF_Silencer_L85", "UK3CB_BAF_SUSAT_3D"] };
		//hlc g3
		case 9: { ["hlc_rifle_g3a3ris", "hlc_20rnd_762x51_b_G3", "", ""] };
		//apex
		case 20: { ["arifle_SPAR_01_blk_F", "30Rnd_556x45_Stanag_red", "muzzle_snds_M", "optic_Holosight_blk_F"] };
	};
	_standardWeapon;
};

if ( _side == independent ) exitWith {
	private _standardWeapon = switch ( _par_indweap ) do {
		default { ["arifle_MX_Black_F", "30Rnd_65x39_caseless_mag", "muzzle_snds_H", "optic_Holosight"] };
		//vanilla aaf
		case 1: { ["arifle_Mk20_plain_F", "muzzle_snds_M", "30Rnd_556x45_Stanag_red", "optic_Holosight"] };
		//rhs
		case 2: { ["rhs_weap_m4_carryhandle", "30Rnd_556x45_Stanag_red", "rhsusf_acc_rotex5_grey", "rhsusf_acc_eotech_552"] };
		//hlc fal
		case 3: { ["hlc_rifle_FAL5061", "hlc_20rnd_762x51_B_fal", "", ""] };
		//apex
		case 20: { ["arifle_AKM_F", "30Rnd_762x39_Mag_F", "", ""] };
	};
	_standardWeapon;
};

if ( _side == east ) exitWith {
	private _standardWeapon = switch ( _par_opfweap ) do {
		default { ["arifle_Katiba_F", "30Rnd_65x39_caseless_mag", "muzzle_snds_H", "optic_ACO_grn"] };
		//rhs
		case 1: { ["rhs_weap_ak74m", "rhs_30Rnd_545x39_AK", "rhs_acc_tgpa", ""] };
		//rhs guerilla
		case 2: { ["rhs_weap_akm", "rhs_30Rnd_545x39_AK", "", ""] };
		//cup AK
		case 3: { ["CUP_arifle_AK107", "CUP_30Rnd_545x39_AK_M", "CUP_muzzle_PBS4", ""] };
		//hlc AK
		case 4: { ["hlc_rifle_ak74", 0, "hlc_muzzle_545SUP_AK", ""] };
		//apex
		case 20: { ["arifle_CTAR_blk_F", "30Rnd_580x42_Mag_F", "muzzle_snds_58_blk_F", "optic_ACO_grn"] };
		//apex ak12
		case 21: { ["arifle_AK12_F", "30Rnd_762x39_Mag_F", "muzzle_snds_B", ""] };
	};
	_standardWeapon;
};
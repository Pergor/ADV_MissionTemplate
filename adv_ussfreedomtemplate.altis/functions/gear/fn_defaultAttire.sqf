/*
 * Author: Belbo
 *
 * Returns default types of attire items depending on loadout variables
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Default helmet type - <ARRAY> of <STRINGS>
 *
 * Example:
 * [] call adv_fnc_defaultAttire; // returns: ["helmet","vest","uniform"]
 *
 * Public: No
 */

private _par_customUni = missionNamespace getVariable ["adv_par_customUni",0];
private _isArid = (toUpper worldname) in (missionNamespace getVariable ["adv_var_aridMaps",[]]);
private _isLush = (toUpper worldname) in (missionNamespace getVariable ["adv_var_lushMaps",[]]);

private _helmet = switch _par_customUni do {
	case 1: { "BWA3_MICH_Tropen" };
	case 2: { "BWA3_MICH_Fleck" };
	case 6: {
		if (_isArid) then {
			"CUP_H_BAF_Helmet_1_DDPM"
		} else {
			if (_isLush) then {
				"CUP_H_BAF_Helmet_1_DPM"
			} else {
				"CUP_H_BAF_Helmet_1_MTP"
			};
		};		
	};
	case 7: { "rhsusf_ach_helmet_ocp" };
	case 8: { "rhsusf_ach_helmet_ucp" };
	case 10: {
		if (_isArid) then {
			"rhsusf_mich_helmet_marpatd"
		} else {
			"rhsusf_mich_helmet_marpatwd"
		};
	};
	case 9: { "H_Cap_blk" };
	case 12: { "UK3CB_BAF_H_Mk7_Camo_A" };
	case 13: { "H_Cap_blk" };
	case 14: { "TRYK_H_woolhat_WH" };
	case 20: { "H_HelmetB_tna_F" };
	//case 30: { "H_HelmetB_tna_F" };
	default { "H_HelmetB" };
};

private _uniform = switch _par_customUni do {
	case 1: { "BWA3_Uniform_idz_Tropen" };
	case 2: { "BWA3_Uniform_idz_Fleck" };
	case 6: {
		if (_isArid) then {
			"CUP_U_B_BAF_DDPM_S2_UnRolled"
		} else {
			if (_isLush) then {
				"CUP_U_B_BAF_DPM_S2_UnRolled"
			} else {
				"CUP_U_B_BAF_MTP_S2_UnRolled"
			};
		};	
	};
	case 7: { "rhs_uniform_cu_ocp" };
	case 8: { "rhs_uniform_cu_ucp" };
	case 10: {
		if (_isArid) then {
			"rhs_uniform_FROG01_d"
		} else {
			"rhs_uniform_FROG01_wd"
		};	
	};
	case 9: { "U_BG_Guerilla2_1" };
	case 12: { "UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve_RM" };
	case 13: { "TRYK_shirts_DENIM_od" };
	case 14: { "TRYK_U_B_PCUHsW6" };
	case 20: { "U_B_T_Soldier_F" };
	case 30: { "U_B_CTRG_1" };
	default { "U_B_CombatUniform_mcam" };
};

private _vest = switch _par_customUni do {
	case 1: { "BWA3_Vest_Rifleman1_Tropen" };
	case 2: { "BWA3_Vest_Rifleman1_Fleck" };
	case 6: {
		if (_isArid) then {
			"CUP_V_BAF_Osprey_Mk2_DDPM_Soldier1"
		} else {
			if (_isLush) then {
				"CUP_V_BAF_Osprey_Mk2_DPM_Soldier1"
			} else {
				"CUP_V_BAF_Osprey_Mk4_MTP_Rifleman"
			};
		};	
	};
	case 7: { "rhsusf_iotv_ocp_Rifleman" };
	case 8: { "rhsusf_iotv_ucp_Rifleman" };
	case 10: { "rhsusf_spc_rifleman" };
	case 9: { "V_TacVest_oli" };
	case 12: { "UK3CB_BAF_V_Osprey_Rifleman_A" };
	case 13: { "TRYK_V_tacv1_BK" };
	case 14: { "TRYK_V_ArmorVest_Winter" };
	case 20: { "V_PlateCarrier1_tna_F" };
	case 30: { "V_PlateCarrierL_CTRG" };
	default { "V_PlateCarrier1_rgr" };
};

_return = [_helmet,_uniform,_vest];

_return;
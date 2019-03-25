

adv_var_mags_rifle = switch ( adv_par_customweap ) do {
	case 0: { ["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag_Tracer"] };
	//default (2,3,4,5,6,7,8,20)
	default { ["30Rnd_556x45_Stanag_red","30Rnd_556x45_Stanag_Tracer_Red"] };
	case 1: {
		if ( isClass(configFile >> "CfgPatches" >> "hlcweapons_g36") && !isClass(configFile >> "CfgPatches" >> "adv_hlcG36_bwmod") ) then {
			["hlc_30rnd_556x45_EPR_G36","hlc_30rnd_556x45_SPR_G36"]
		} else {
			["BWA3_30Rnd_556x45_G36","BWA3_30Rnd_556x45_G36_Tracer"]
		};
	};
	case 9: { ["hlc_20rnd_762x51_b_G3","hlc_20rnd_762x51_T_G3"] };
};

adv_var_mags_LMG = switch ( adv_par_customweap ) do {
	default { ["100Rnd_65x39_caseless_mag_Tracer",""] };
	case 0: { ["100Rnd_65x39_caseless_mag_Tracer",""] };
	case 20: { ["200Rnd_556x45_Box_Red_F",""] };
	case 1: { ["BWA3_200Rnd_556x45","BWA3_200Rnd_556x45_Tracer"] };
	case 2: { ["rhsusf_200Rnd_556x45_soft_pouch",""] };
	case 3: { ["rhsusf_200Rnd_556x45_soft_pouch","30Rnd_556x45_Stanag_Tracer_Red"] };
	case 4: { ["rhsusf_200Rnd_556x45_soft_pouch",""] };
	case 5: { ["CUP_200Rnd_TE4_Red_Tracer_556x45_M249",""] };
	case 6: { ["CUP_200Rnd_TE4_Red_Tracer_556x45_M249",""] };
	case 7: { ["CUP_200Rnd_TE4_Red_Tracer_556x45_L110A1",""] };
	case 8: { ["UK3CB_BAF_200Rnd_T",""] };
	case 9: { ["hlc_50rnd_762x51_M_FAL",""] };
};

adv_var_mags_MG = switch ( adv_par_customweap ) do {
	default { ["130Rnd_338_Mag",""] };
	case 0: { ["130Rnd_338_Mag",""] };
	case 20: { ["130Rnd_338_Mag",""] };
	case 1: { ["BWA3_120Rnd_762x51","BWA3_120Rnd_762x51_Tracer"] };
	case 2: { ["rhsusf_100Rnd_762x51_m80a1epr",""] };
	case 3: { ["rhsusf_100Rnd_762x51_m80a1epr",""] };
	case 4: { ["rhsusf_100Rnd_762x51_m80a1epr",""] };
	case 5: { ["CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",""] };
	case 6: { ["CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",""] };
	case 7: { ["CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",""] };
	case 8: { ["UK3CB_BAF_75Rnd","UK3CB_BAF_75Rnd_T"] };
	case 9: { ["hlc_100Rnd_762x51_M_M60E4",""] };
};

adv_var_mags_MM = switch ( adv_par_customweap ) do {
	default { ["20Rnd_762x51_Mag"] };
	case 0: { ["20Rnd_762x51_Mag"] };
	case 20: { ["20Rnd_762x51_Mag"] };
	case 1: { ["BWA3_10Rnd_762x51_G28_LR"] };
	case 2: { ["rhsusf_20Rnd_762x51_m118_special_Mag"] };
	case 3: { ["rhsusf_20Rnd_762x51_m118_special_Mag"] };
	case 4: { ["rhsusf_20Rnd_762x51_m118_special_Mag"] };
	case 5: { ["CUP_20Rnd_762x51_B_M110","CUP_20Rnd_762x51_B_SCAR"] };
	case 6: { ["20Rnd_762x51_Mag"] };
	case 7: { ["20Rnd_762x51_Mag"] };
	case 8: { ["UK3CB_BAF_20Rnd"] };
	case 9: { ["hlc_20rnd_762x51_b_G3","hlc_20rnd_762x51_b_fal"] };
};

adv_var_mags_pistol = switch ( adv_par_customweap ) do {
	default { ["11Rnd_45ACP_Mag"] };
	case 0: { ["11Rnd_45ACP_Mag"] };
	case 20: { ["11Rnd_45ACP_Mag"] };
	case 1: { ["BWA3_15Rnd_9x19_P8"] };
	case 2: { ["rhsusf_mag_15Rnd_9x19_JHP"] };
	case 3: { ["rhsusf_mag_7x45acp_MHP"] };
	case 4: { ["rhsusf_mag_15Rnd_9x19_JHP"] };
	case 5: { ["CUP_15Rnd_9x19_M9"] };
	case 6: { ["CUP_15Rnd_9x19_M9"] };
	case 7: { ["CUP_17Rnd_9x19_glock17"] };
	case 8: { ["UK3CB_BAF_17Rnd_9mm"] };
	case 9: { ["11Rnd_45ACP_Mag","RH_7Rnd_45cal_m1911"] };
};




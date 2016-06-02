/*
ADV_Variables by Belbo
contains all the variables that are important for a mission
call from init.sqf AND initPlayerLocal.sqf via (as early as possible):
call compile preprocessfilelinenumbers "ADV_Setup\ADV_Variables.sqf";
*/

//standard Variables:
if ( isNil "ADV_taskVar" ) then { ADV_taskVar = 0; };
if ( isNil "ADV_spawnVar" ) then { ADV_spawnVar = 0; };
if ( isNil "ADV_var_useDLCContent" ) then { ADV_par_useDLCContent = 1; };
/*
//TFAR:
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
	call ADV_fnc_tfarSettings;
};
//ACRE:
if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	call ADV_fnc_acreSettings;
};
*/

missionNamespace setVariable ["ace_medical_healHitPointAfterAdvBandage",true,true];

//map variables:
ADV_var_aridMaps = [
	"MCN_ALIABAD","BMFAYSHKHABUR","CLAFGHAN","FALLUJAH","FATA","HELLSKITCHEN","HELLSKITCHENS","MCN_HAZARKOT","PRAA_AV","RESHMAAN",
	"SHAPUR_BAF","TAKISTAN","TORABORA","TUP_QOM","ZARGABAD","PJA307","PJA306","MOUNTAINS_ACR","TUNBA","KUNDUZ"
];
ADV_var_sAridMaps = [
	"STRATIS","ALTIS","PORTO","ISLADUALA3"
];
ADV_var_lushMaps = [
	"LINGOR3","MAK_JUNGLE","PJA305","TROPICA","TIGERIA","TIGERIA_SE","SARA","SARALITE","SARA_DBE1","INTRO","CHERNARUS","CHERNARUS_SUMMER",
	"FDF_ISLE1_A","MBG_CELLE2","WOODLAND_ACR","BOOTCAMP_ACR","THIRSK","BORNHOLM","UTES","ANIM_HELVANTIS_V2","ABRAMIA","PANTHERA3","VT5"
];
switch (ADV_par_customUni) do {
	case 1: { ADV_par_customUni = if ((toUpper worldname) in ADV_var_lushMaps) then {2} else {1}; };
	case 2: { ADV_par_customUni = if ((toUpper worldname) in ADV_var_aridMaps) then {1} else {2}; };
	case 4: { ADV_par_customUni = if ((toUpper worldname) in ADV_var_aridMaps) then {5} else {4}; };
	case 5: { ADV_par_customUni = if ((toUpper worldname) in ADV_var_lushMaps) then {4} else {5}; };
	case 10: { ADV_par_customUni = if ((toUpper worldname) in ADV_var_lushMaps) then {11} else {10}; };
	case 11: { ADV_par_customUni = if ((toUpper worldname) in ADV_var_aridMaps) then {10} else {11}; };
	default {};
};

if (isClass(configFile >> "CfgPatches" >> "ace_rearm") && (ADV_par_modTankAssets == 2 || ADV_par_modTankAssets == 1)) then {
	missionNamespace setVariable ["ace_rearm_level",0,true];
};

if (isNil "ADV_par_Tablets") then { ADV_par_Tablets = ["param_Tablets",1] call BIS_fnc_getParamValue; };
//cTab-specials:
if (isClass (configFile >> "CfgPatches" >> "cTab") && ADV_par_Tablets == 1) then {
	cTab_encryptionKey_west = "b";
	cTab_encryptionKey_east = "o";
	cTab_encryptionKey_guer = "i";
	cTab_encryptionKey_civ = "c";
    cTab_vehicleClass_has_FBCB2 = ["Car","Armored"
		/*
		"MRAP_01_base_F","MRAP_02_base_F","MRAP_03_base_F","Wheeled_APC_F","Tank","Truck_01_base_F","Truck_03_base_F",
		"Fennek_Flecktarn","Fennek_Flecktarn_mg","Fennek_Flecktarn_gmg","Fennek_Flecktarn_san",
		"Fennek_Tropen","Fennek_Tropen_mg","Fennek_Tropen_gmg","Fennek_Tropen_san",
		"Fennek_Winter","Fennek_Winter_mg","Fennek_Winter_gmg","Fennek_Winter_san",
		"Fennek_UN","Fennek_UN_san",
		"BW_Dingo_Des","BW_Dingo_GL_Des",
		"BW_Dingo_Wdl","BW_Dingo_GL_Wdl",
		"BWA3_Puma_Fleck","BWA3_Puma_Tropen",
		"BWA3_Leopard2A6M_Fleck","BWA3_Leopard2A6M_Tropen",
		"Cha_Lav25","Cha_Lav25_HQ","Cha_Lav25A2",
		"Cha_des1_Lav25","Cha_des1_Lav25_HQ","Cha_des1_Lav25A2",
		"Cha_win1_Lav25","Cha_win1_Lav25_HQ","Cha_win1_Lav25A2",
		"M1126_ICV_M2NEST_DG1_NOSLATDES","M1126_ICV_m2_nestslatDES","M1126_ICV_M134_DG1_SLATDES","M1126_ICV_M134_DG1_NOSLATDES","M1126_ICV_M2_DG1_SLATDES",
		"M1126_ICV_M2_DG1_NOSLATDES","M1126_ICV_mk19_DG1_SLATDES","M1126_ICV_mk19_DG1_NOSLATDES","M1130_CV_DG1_SLATDES","M1130_CV_DG1_NOSLATDES",
		"M1129_MC_DG1_SLATDES","M1129_MC_DG1_NOSLATDES","M1135_ATGMV_DG1_SLATDES","M1135_ATGMV_DG1_NOSLATDES","M1128_MGS_DG1_SLATDES","M1128_MGS_DG1_NOSLATDES",
		"M1133_MEV_DG1_SLATDES","M1133_MEV_DG1_NOSLATDES","M1126_ICV_M2NEST_DG1_NOSLATWOOD","M1126_ICV_m2_nestslatWOOD","M1126_ICV_M134_DG1_SLATWOOD",
		"M1126_ICV_M134_DG1_NOSLATWOOD","M1126_ICV_M2_DG1_SLATWOOD","M1126_ICV_M2_DG1_NOSLATWOOD","M1126_ICV_mk19_DG1_SLATWOOD","M1126_ICV_mk19_DG1_NOSLATWOOD",
		"M1130_CV_DG1_SLATWOOD","M1130_CV_DG1_NOSLATWOOD","M1129_MC_DG1_SLATWOOD","M1129_MC_DG1_NOSLATWOOD","M1135_ATGMV_DG1_SLATWOOD","M1135_ATGMV_DG1_NOSLATWOOD",
		"M1128_MGS_DG1_SLATWOOD","M1128_MGS_DG1_NOSLATWOOD","M1133_MEV_DG1_SLATWOOD","M1133_MEV_DG1_NOSLATWOOD",
		"Steve_MBT_Kuma","Steve_IFV_Warrior","Steve_IFV_Marid",
		"DAR_MaxxPro","DAR_MaxxProDeploy","DAR_MaxxProDXM","DAR_MaxxProPlus",
		"DAR_MK23","DAR_MK23A","DAR_MK23AD","DAR_MK23ADT","DAR_MK27","DAR_MK27T","DAR_4x4","DAR_LHS_8","DAR_LHS_16",
		"Burnes_aav_des","AAVB",
		"Burnes_M1A2_MEU_01_Public","Burnes_M1A2_MEU_02_Public","Burnes_M1A2_MEU_03_Public","Burnes_M1A2_MEU_04_Public",
		"Burnes_FV4034_01","Burnes_FV4034_02","Burnes_FV4034_03","Burnes_FV4034_04",
		"EWK_m1151_m2_deployment_Bumper","EWK_m1151_m2_deployment_Jtac","EWK_m1151_m2_deployment_AT4","EWK_m1151_m2_deployment","EWK_HMMWV_Light","EWK_HMMWV_Medevac",
		"EWK_M1114_Armored","EWK_m1151_m240_deployment","EWK_m1151_TOW_deployment","EWK_M997A2_Ambulance","EWK_M997A2_Ambulance_NoBackLights","EWK_M997A2_Ambulance_Tan",
		"EWK_M997A2_Ambulance_Tan_NoBackLights","EWK_M998A2_sov","EWK_M998A2_sov_M2",
		"BAF_Offroad_D","BAF_Offroad_W","BAF_Jackal2_L2A1_D","BAF_Jackal2_L2A1_W",
		"16aa_truck_man_transport_d","16aa_truck_man_transport_wd","16aa_truck_man_ammo_d","16aa_truck_man_ammo_wd",
		"rhsusf_m998_d_s_4dr","rhsusf_m998_w_s_4dr","rhsusf_m1025_d_s","rhsusf_m1025_w_s","rhsusf_m1025_d_m2","rhsusf_m1025_w_m2",
		"rhsusf_m113d_usarmy","RHS_M2A2","RHS_M2A2_BUSKI","RHS_M2A3","RHS_M2A3_BUSKI","RHS_M2A3_BUSKIII",
		"rhsusf_m113_usarmy","RHS_M2A2_wd","RHS_M2A2_BUSKI_WD","RHS_M2A3_wd","RHS_M2A3_BUSKI_wd","RHS_M2A3_BUSKIII_wd",
		"rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a1hc_d","rhsusf_m1a1aim_tuski_d","rhsusf_m1a1aimd_usarmy","rhsusf_m109d_usarmy",
		"rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a1aimwd_usarmy","rhsusf_m109_usarmy"
		*/
	];
    cTab_vehicleClass_has_TAD = ["Helicopter","Plane"];
} else {
    cTab_vehicleClass_has_FBCB2 = [];
    cTab_vehicleClass_has_TAD = [];
};

//DLP:
//CL_IE_Module_Enabled = true;

//tawVD:
tawvd_disablenone = true;

//finalization:
ADV_variables_defined = true;

if (true) exitWith {};
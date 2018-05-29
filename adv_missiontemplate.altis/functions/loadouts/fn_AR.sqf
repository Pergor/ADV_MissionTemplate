//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};
params ["_player",["_special",""]];
/*
 * Author: Belbo
 *
 * Loadout function
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [player] call adv_fnc_AR;
 *
 * Public: No
 */

//clothing - (string)
_uniform = ["U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest","U_B_CombatUniform_mcam"];
_vest = ["V_PlateCarrier1_rgr","V_PlateCarrier2_rgr","V_PlateCarrierGL_rgr","V_PlateCarrierGL_rgr"];
_headgear = ["H_HelmetSpecB_paint1","H_HelmetSpecB_paint2","H_HelmetB_black","H_HelmetB_desert","H_HelmetB_grass","H_HelmetB_paint"];
_backpack = ["B_AssaultPack_rgr"];
_insignium = "";
_useProfileGoggles = 1;		//If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "G_Combat";
_unitTraits = [["medic",false],["engineer",false],["explosiveSpecialist",false],["UAVHacker",false],["camouflageCoef",1.0],["audibleCoef",1.0],["loadCoef",0.8]];

//weapons - primary weapon - (string)
_primaryWeapon = ["MMG_02_black_F"];
if ((toUpper worldname) in _var_aridMaps) then {_primaryWeapon pushback "MMG_02_sand_F";};
	
//primary weapon items - (array)
_optic = [""];
_attachments = ["bipod_01_F_blk"];
if ( _par_NVGs > 0 ) then { _attachments pushback "acc_flashlight"; };
_silencer = "muzzle_snds_338_black";		//if silencer is added

//MarksmenDLC-objects:
if ( (304400 in (getDLCs 1) || 332350 in (getDLCs 1)) && (missionNamespace getVariable ["adv_par_DLCContent",1]) > 0 ) then {
};

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
_primaryweaponAmmo = [1,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.
_additionalAmmo = [3,0,false];
_additionalAmmo1 = [0,0,false];

//40mm Grenades - (integer)
_40mmHeGrenadesAmmo = 0;
_40mmSmokeGrenadesWhite = 0;
_40mmSmokeGrenadesYellow = 0;
_40mmSmokeGrenadesOrange = 0;
_40mmSmokeGrenadesRed = 0;
_40mmSmokeGrenadesPurple = 0;
_40mmSmokeGrenadesBlue = 0;
_40mmSmokeGrenadesGreen = 0;
_40mmFlareWhite = 0;
_40mmFlareYellow = 0;
_40mmFlareRed = 0;
_40mmFlareGreen = 0;
_40mmFlareIR = 0;

//weapons - handgun - (string)
_handgun = "hgun_Pistol_heavy_01_F";

//handgun items - (array)
_itemsHandgun = [];
_handgunSilencer = "muzzle_snds_acp";		//if silencer is added

//handgun ammo (if a handgun is given) - (integer)
_handgunAmmo = [2,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//weapons - launcher - (string)
_launcher = "";

//launcher ammo (if a launcher is given) - (integer) 
_launcherAmmo = [0,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//binocular - (string)
_binocular = "";

//throwables - (integer)
_grenadeSet = 1;		//contains 2 HE grenades, 1 white and one coloured smoke grenade and 1 red chemlight. Select 0 if you want to define your own grenades.
_grenades = [""];		//depending on the custom loadout the colours may be merged. add like this: ["HE","HE","WHITE"] (adds two HE and one white smoke grenade).
_chemlights = [""];		//add like this: ["RED","RED","GREEN"] (adds two red and one green chemlight).
_IRgrenade = 0;

//first aid kits and medi kits- (integer)
_FirstAidKits = 2;
_MediKit = 0;		//if set to 1, a MediKit and all FirstAidKits will be added to the backpack; if set to 0, FirstAidKits will be added to inventory in no specific order.

//items added specifically to uniform: - (array)
_itemsUniform = [];

//items added specifically to vest: - (array)
_itemsVest = [];

//items added specifically to Backpack: - (array)
_itemsBackpack = [];

//linked items (don't put "ItemRadio" in here, as it's set with _equipRadio) - (array)
_itemsLink = [
	"ItemWatch",
	"ItemCompass",
	"ItemMap",
	"NVGoggles_OPFOR"
];
		
//items added to any container - (array)
_items = [];

	//CustomMod items//

//TFAR or ACRE radios
_giveRiflemanRadio = true;
_givePersonalRadio = false;
_giveBackpackRadio = false;
_tfar_microdagr = 0;				//adds the tfar microdagr to set the channels for a rifleman radio

//ACE items (if ACE is running on the server) - (integers)
_ACE_EarPlugs = 1;

_ace_FAK = 1;		//Adds a standard amount of medical items. Defined in fn_aceFAK.sqf
_ACE_fieldDressing = 0;
_ACE_elasticBandage = 0;
_ACE_packingBandage = 0;
_ACE_quikclot = 0;
_ACE_atropine = 0;
_ACE_adenosine = 0;
_ACE_epinephrine = 0;
_ACE_morphine = 0;
_ACE_tourniquet = 0;
_ACE_bloodIV = 0;
_ACE_bloodIV_500 = 0;
_ACE_bloodIV_250 = 0;
_ACE_plasmaIV = 0;
_ACE_plasmaIV_500 = 0;
_ACE_plasmaIV_250 = 0;
_ACE_salineIV = 0;
_ACE_salineIV_500 = 0;
_ACE_salineIV_250 = 0;
_ACE_bodyBag = 0;
_ACE_surgicalKit = 0;
_ACE_personalAidKit = 0;

_ACE_SpareBarrel = 0;
_ACE_EntrenchingTool = 0;
_ACE_UAVBattery = 0;
_ACE_wirecutter = 0;
_ACE_Clacker = 0;
_ACE_M26_Clacker = 0;
_ACE_DeadManSwitch = 0;
_ACE_DefusalKit = 0;
_ACE_Cellphone = 0;
_ACE_FlareTripMine = 0;
_ACE_MapTools = 0;
_ACE_CableTie = 0;
_ACE_sprayPaintColor = "NONE";
_ACE_gunbag = 0;

_ACE_key = 0;	//0 = no key, 1 = side dependant key, 2 = master key, 3 = lockpick
_ACE_flashlight = 1;
_ACE_kestrel = 0;
_ACE_altimeter = 0;
_ACE_ATragMX = 0;
_ACE_rangecard = 0;
_ACE_DAGR = 0;
_ACE_microDAGR = 0;
_ACE_RangeTable_82mm = 0;
_ACE_MX2A = 0;
_ACE_HuntIR_monitor = 0;
_ACE_HuntIR = 0;
_ACE_m84 = 0;
_ACE_HandFlare_Green = 0;
_ACE_HandFlare_Red = 0;
_ACE_HandFlare_White = 0;
_ACE_HandFlare_Yellow = 0;

//AGM Variables (if AGM is running) - (bool)
_ACE_isMedic = 0;		//0 = no medic; 1 = medic; 2 = doctor;
_ACE_isEngineer = 0;	//0 = no specialist; 1 = engineer; 2 = repair specialist;
_ACE_isEOD = false;
_ACE_isPilot = false;

//Tablet-Items
_tablet = false;
_androidDevice = false;
_microDAGR = true;
_helmetCam = false;

//scorch inv items
_scorchItems = ["sc_dogtag","sc_mre"];
_scorchItemsRandom = [""];

//Addon Content:
switch (_par_customWeap) do {
	case 1: {
		//BWmod
		_primaryweapon = "BWA3_MG3";
		_optic = ["BWA3_optic_ZO4x30"];
		_additionalAmmo set [0,4];
		_silencer = "BWA3_muzzle_snds_MG5";
		if (isClass(configFile >> "CfgPatches" >> "hlcweapons_MG3s")) then {
			call {
				if ((toUpper worldname) in _var_aridMaps) exitWith {
					_primaryweapon = ["hlc_lmg_MG3KWS","hlc_lmg_MG3KWS_b"];
				};
					_primaryweapon = "hlc_lmg_MG3KWS_b";
			};
			_optic = ["BWA3_optic_Shortdot"];
			_primaryweaponAmmo = [1,"hlc_100Rnd_762x51_M_MG3"];
			_additionalAmmo = [5,"hlc_100Rnd_762x51_M_MG3",true];
			_silencer = "";
		};
		if ( _par_NVGs > 0 ) then { _attachments = ["BWA3_acc_VarioRay_irlaser"]; };
		_handgun = "BWA3_P8";
		_itemsHandgun = [];
		_handgunSilencer = "";		//if silencer is added
	};
	case 2: {
		//RHS Army
		_primaryWeapon = ["rhs_weap_m240B"];
		_optic = ["rhsusf_acc_ELCAN"];
		_attachments = [""];
		_silencer = "";		//if silencer is added
		_primaryweaponAmmo = [1,8];
		_additionalAmmo = [4,8,true];
		_handgun = "rhsusf_weap_m9";
		_itemsHandgun = [""];
		_handgunSilencer = "";
	};
	case 3: {
		//RHS Marines
		_primaryWeapon = ["rhs_weap_m240G"];
		_optic = ["rhsusf_acc_ELCAN"];
		if (isClass(configFile >> "CfgPatches" >> "hlcweapons_m60e4")) then {
			_primaryWeapon = ["hlc_lmg_m60","hlc_lmg_M60E4"];
			_optic = ["rhsusf_acc_ACOG","rhsusf_acc_ACOG3"];
			_primaryweaponAmmo set [1,1];
			_additionalAmmo = [4,1,true];
		} else {
			_primaryweaponAmmo = [1,8];
			_additionalAmmo = [4,8,true];	
		};
		_attachments = [""];
		_silencer = "";		//if silencer is added
		_handgun = "rhsusf_weap_m1911a1";
		_itemsHandgun = [""];
		_handgunSilencer = "";
	};
	case 4: {
		//RHS SOF
		_primaryWeapon = ["rhs_weap_m240B","rhs_weap_m240G"];
		_optic = ["rhsusf_acc_ACOG_MDO"];
		_attachments = [""];
		_silencer = "";		//if silencer is added
		_primaryweaponAmmo = [1,8];
		_additionalAmmo = [4,8,true];
		_handgun = "rhsusf_weap_m9";
		_itemsHandgun = [""];
		_handgunSilencer = "";
	};
	case 5: {
		//SELmods CUP Mk16
		_primaryweapon = switch (true) do {
			case ((toUpper worldname) in _var_lushMaps): {"CUP_lmg_Mk48_wdl"};
			case ((toUpper worldname) in _var_aridMaps): {"CUP_lmg_Mk48_des"};
			default {"CUP_lmg_M240"};
		};
		_optic = ["CUP_optic_ElcanM145"];
		_attachments = [""];
		_silencer = "";		//if silencer is added
		_handgun="CUP_hgun_M9";
		_itemsHandgun=[];
		_handgunSilencer = "CUP_muzzle_snds_M9";		//if silencer is added
	};
	case 6: {
		//SELmods CUP M4
		_primaryweapon = switch (true) do {
			case ((toUpper worldname) in _var_lushMaps): {"CUP_lmg_Mk48_wdl"};
			case ((toUpper worldname) in _var_aridMaps): {"CUP_lmg_Mk48_des"};
			default {"CUP_lmg_M240"};
		};
		_optic = ["CUP_optic_ElcanM145"];
		_attachments = [""];
		_silencer = "";		//if silencer is added
		_handgun="CUP_hgun_M9";
		_itemsHandgun=[];
		_handgunSilencer = "CUP_muzzle_snds_M9";		//if silencer is added
	};
	case 7: {
		//BAF
		_primaryweapon="CUP_lmg_L7A2";
		_optic = ["CUP_optic_ElcanM145"];
		_attachments = [""];
		_silencer = "";		//if silencer is added
		_handgun="CUP_hgun_Glock17";
		_itemsHandgun=["CUP_acc_Glock17_Flashlight"];
		_handgunSilencer = "muzzle_snds_L";		//if silencer is added
	};
	case 8: {
		//UK3CB
		_primaryweapon = ["UK3CB_BAF_L7A2"];
		_optic = ["UK3CB_BAF_SpecterLDS_3D"];
		_attachments = [""];
		_silencer = "";
		_handgun = "UK3CB_BAF_L131A1";
		_itemsHandgun=["UK3CB_BAF_Flashlight_L131A1"];
		_handgunSilencer = "muzzle_snds_L";
	};
	case 9: {
		_primaryWeapon = ["hlc_lmg_m60","hlc_lmg_M60E4"];
		_optic = [""];
		_attachments = [""];
		_silencer = "";
		_primaryweaponAmmo set [1,1];
		_additionalAmmo = [4,1,true];
		if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
			_handgun = ["RH_m1911"];
			_itemsHandgun = [""];
			_handgunSilencer = "";
		};
	};
	case 20: {
		//APEX HK416
		_optic = ["optic_Arco_blk_F","optic_MRCO"];
	};
	default {};
};
switch (_par_customUni) do {
	case 1: {
		//BWmod Tropen
		_uniform = ["BWA3_Uniform_idz_Tropen"];
		_vest = ["BWA3_Vest_Autorifleman_Tropen"];
		_headgear = ["BWA3_MICH_Tropen"];
		_backpack = ["BWA3_PatrolPack_Tropen"];
		if (isClass(configFile >> "CfgPatches" >> "PBW_German_Common")) then {
			_uniform = ["PBW_Uniform1_tropen","PBW_Uniform3_tropen","PBW_Uniform3K_tropen"];
			_headgear = ["PBW_Helm4_tropen","PBW_Helm1_tropen"];
			_items pushback "PBW_muetze1_tropen";
		};
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 2: {
		//BWmod Fleck
		_uniform = ["BWA3_Uniform_idz_Fleck"];
		_vest = ["BWA3_Vest_Autorifleman_Fleck"];
		_headgear = ["BWA3_MICH_Fleck"];
		_backpack = ["BWA3_PatrolPack_Fleck"];
		if (isClass(configFile >> "CfgPatches" >> "PBW_German_Common")) then {
			_uniform = ["PBW_Uniform1_fleck","PBW_Uniform3_fleck","PBW_Uniform3K_fleck"];
			_vest = ["pbw_splitter_mg"];
			_headgear = ["PBW_Helm4_fleck","PBW_Helm1_fleck"];
			_items pushback "PBW_muetze1_fleck";
		};
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 3: {
		//TFA Mixed
	};
	case 4: {
		//TFA Woodland
	};
	case 5: {
		//TFA Desert
	};
	case 6: {
		//CUP BAF
		switch (true) do {
			case ((toUpper worldname) in _var_aridMaps): {
				_uniform = ["CUP_U_B_BAF_DDPM_S1_RolledUp","CUP_U_B_BAF_DDPM_Tshirt"];
				_vest = ["CUP_V_BAF_Osprey_Mk2_DDPM_Soldier1","CUP_V_BAF_Osprey_Mk2_DDPM_Soldier2","CUP_V_BAF_Osprey_Mk2_DDPM_Officer","CUP_V_BAF_Osprey_Mk2_DDPM_Sapper"];
				_headgear = ["CUP_H_BAF_Helmet_1_DDPM","CUP_H_BAF_Helmet_Net_2_DDPM","CUP_H_BAF_Helmet_4_DDPM"];
			};
			case ((toUpper worldname) in _var_lushMaps): {
				_uniform = ["CUP_U_B_BAF_DPM_S1_RolledUp","CUP_U_B_BAF_DPM_Tshirt"];
				_vest = ["CUP_V_BAF_Osprey_Mk2_DPM_Soldier1","CUP_V_BAF_Osprey_Mk2_DPM_Soldier2","CUP_V_BAF_Osprey_Mk2_DPM_Officer","CUP_V_BAF_Osprey_Mk2_DPM_Sapper"];
				_headgear = ["CUP_H_BAF_Helmet_1_DPM","CUP_H_BAF_Helmet_Net_2_DPM","CUP_H_BAF_Helmet_4_DPM"];
			};
			default {
				_uniform = ["CUP_U_B_BAF_MTP_S1_RolledUp","CUP_U_B_BAF_MTP_Tshirt","CUP_U_B_BAF_MTP_S3_RolledUp","CUP_U_B_BAF_MTP_S6_UnRolled"];
				_vest = ["CUP_V_BAF_Osprey_Mk4_MTP_MachineGunner"];
				_headgear = ["CUP_H_BAF_Helmet_1_MTP","CUP_H_BAF_Helmet_Net_2_MTP","CUP_H_BAF_Helmet_4_MTP"];
			};
		};
		_backpack = ["CUP_B_Bergen_BAF"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["CUP_NVG_HMNVS"];
	};
	case 7: {
		//RHS OCP
		_uniform = ["rhs_uniform_cu_ocp"];
		_vest = ["rhsusf_iotv_ocp_SAW"];
		_headgear = ["rhsusf_ach_helmet_ocp","rhsusf_ach_helmet_headset_ocp","rhsusf_ach_helmet_ESS_ocp","rhsusf_ach_helmet_headset_ess_ocp",
			"rhsusf_mich_bare_tan","rhsusf_mich_bare_tan_headset","rhsusf_ach_bare_tan_ess","rhsusf_ach_bare_tan_headset_ess"];
		_backpack = ["rhsusf_assault_eagleaiii_ocp","rhsusf_falconii"];
		_items pushBack "rhsusf_patrolcap_ocp";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
	};
	case 8: {
		//RHS UCP:
		_uniform = ["rhs_uniform_cu_ucp"];
		_vest = ["rhsusf_iotv_ucp_SAW"];
		_headgear = ["rhsusf_ach_helmet_ucp","rhsusf_ach_helmet_headset_ucp","rhsusf_ach_helmet_ESS_ucp","rhsusf_ach_helmet_headset_ess_ucp",
			"rhsusf_mich_bare_norotos_alt","rhsusf_mich_bare_headset","rhsusf_ach_bare_ess","rhsusf_ach_bare_headset_ess"];
		_backpack = ["rhsusf_assault_eagleaiii_ucp","rhsusf_falconii"];
		_items pushBack "rhsusf_patrolcap_ucp";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
	};
	case 10: {
		//RHS MARPAT
		switch (true) do {
			case ((toUpper worldname) in _var_aridMaps): {
				_uniform = ["rhs_uniform_FROG01_d"];
				_headgear = ["rhsusf_lwh_helmet_marpatd","rhsusf_mich_helmet_marpatd","rhsusf_mich_helmet_marpatd_alt","rhsusf_mich_helmet_marpatd_norotos"];
				_items pushBack "rhs_Booniehat_marpatd";
			};
			default {
				_uniform = ["rhs_uniform_FROG01_wd"];
				_headgear = ["rhsusf_lwh_helmet_marpatwd","rhsusf_mich_helmet_marpatwd","rhsusf_mich_helmet_marpatwd_alt","rhsusf_mich_helmet_marpatwd_norotos"];
				_items pushBack "rhs_Booniehat_marpatwd";
			};
		};
		_backpack = ["rhsusf_assault_eagleaiii_coy"];
		_vest = ["rhsusf_spc_mg"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
	};	
	case 11: {
	};
	case 9: {
		//Guerilla
		_uniform = ["U_BG_Guerrilla_6_1","U_BG_Guerilla2_2","U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_BG_Guerilla3_1"];
		_headgear = ["H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk","H_Cap_headphones","H_MilCap_mcamo","H_MilCap_gry","H_MilCap_blue","H_Cap_tan_specops_US",
			"H_Cap_usblack","H_Cap_oli_hs","H_Cap_blk","H_Booniehat_tan","H_Booniehat_oli","H_Booniehat_khk","H_Watchcap_khk","H_Watchcap_cbr","H_Watchcap_camo"];
	};
	case 12: {
		//UK3CB
		_uniform = ["UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve_RM","UK3CB_BAF_U_CombatUniform_MTP_TShirt","UK3CB_BAF_U_CombatUniform_MTP_TShirt_RM","UK3CB_BAF_U_CombatUniform_MTP_RM","UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve_RM"];
		_vest = ["UK3CB_BAF_V_Osprey_MG_A","UK3CB_BAF_V_Osprey_MG_B"];
		_headgear = ["UK3CB_BAF_H_Mk7_Camo_A","UK3CB_BAF_H_Mk7_Camo_B","UK3CB_BAF_H_Mk7_Camo_C","UK3CB_BAF_H_Mk7_Camo_D","UK3CB_BAF_H_Mk7_Camo_E","UK3CB_BAF_H_Mk7_Camo_F","UK3CB_BAF_H_Mk7_Net_A","UK3CB_BAF_H_Mk7_Net_B","UK3CB_BAF_H_Mk7_Net_C","UK3CB_BAF_H_Mk7_Net_D"];
		_backpack = ["UK3CB_BAF_B_Bergen_MTP_Rifleman_L_A","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_B","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_C","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_D"];
		_items pushBack "UK3CB_BAF_H_Beret_RM_Bootneck";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["UK3CB_BAF_HMNVS"];
	};
	case 13: {
		//CUP PMC
		_uniform = ["CUP_I_B_PMC_Unit_20","CUP_I_B_PMC_Unit_17","CUP_I_B_PMC_Unit_13","CUP_I_B_PMC_Unit_15","CUP_I_B_PMC_Unit_3"
			,"CUP_I_B_PMC_Unit_5","CUP_I_B_PMC_Unit_6","CUP_I_B_PMC_Unit_24","CUP_I_B_PMC_Unit_23","CUP_I_B_PMC_Unit_11"];
		_vest = ["V_PlateCarrier1_blk","V_PlateCarrier1_rgr","V_PlateCarrier2_blk","V_PlateCarrier2_rgr","V_PlateCarrier1_rgr_noflag_F","V_PlateCarrier2_rgr_noflag_F"];
		_headgear = ["H_Cap_headphones","H_MilCap_blue","H_Cap_oli_hs","H_Cap_blk","",""
			,"CUP_H_PMC_Cap_Grey","CUP_H_PMC_Cap_Tan","CUP_H_C_TrackIR_01","CUP_H_PMC_Cap_EP_Grey","CUP_H_PMC_Cap_EP_Tan"
			,"CUP_H_PMC_Cap_Back_EP_Grey","CUP_H_PMC_Cap_Back_EP_Tan","CUP_H_FR_Cap_Headset_Green","CUP_H_FR_Headset","CUP_H_FR_Headset"];
	};
	case 14: {
		//TRYK Snow
		_uniform = ["TRYK_U_B_PCUHsW6","TRYK_U_B_PCUHsW4","TRYK_U_B_PCUHsW","TRYK_U_B_PCUHsW5"];
		_vest = ["TRYK_V_ArmorVest_Winter"];
		_headgear = ["TRYK_H_woolhat_WH","TRYK_H_woolhat_WH",""];
		_backpack = ["TRYK_B_Carryall_wh","TRYK_Winter_pack"];
		_useProfileGoggles = 0;
		_goggles = ["TRYK_kio_balaclava_WH","",""];
	};
	case 20: {
		//APEX NATO
		_uniform = ["U_B_T_Soldier_AR_F","U_B_T_Soldier_SL_F","U_B_T_Soldier_F","U_B_T_Soldier_F"];
		_vest = ["V_PlateCarrierGL_tna_F"];
		_headgear = ["H_HelmetB_tna_F","H_HelmetB_Enh_tna_F","H_HelmetB_Light_tna_F"];
		_backpack = ["B_Kitbag_rgr"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["NVGoggles_tna_F"];
	};
	case 30: {
		//Vanilla CTRG
		_uniform = ["U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3"];
		_vest = ["V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","V_PlateCarrierIAGL_oli"];
		if (worldName == "TANOA") then {
			_uniform = ["U_B_CTRG_Soldier_F","U_B_CTRG_Soldier_2_F","U_B_CTRG_Soldier_3_F"];
			_headgear = ["H_HelmetB_TI_tna_F"];
		};
	};
	case 31: {
		//adv_retex WDL
		if (isClass(configFile >> "CfgPatches" >> "adv_retex")) then {
			_uniform = ["adv_retex_u_CombatUniform_wdl","adv_retex_u_CombatUniform_wdl_vest","adv_retex_u_CombatUniform_wdl_tshirt","adv_retex_u_CombatUniform_i_wdl","adv_retex_u_CombatUniform_i_wdl_shortsleeve"];
			_headgear = ["H_HelmetIA_wdl"];
		};
	};
	default {};
};

///// No editing necessary below this line /////

[_player] call ADV_fnc_gear;

true;
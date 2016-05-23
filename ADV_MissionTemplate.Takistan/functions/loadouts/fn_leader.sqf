/*
unit loadout script by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set _primaryweaponAmmo to 0 and add those
magazines one for one in _items.
*/

//clothing - (string)
_uniform = ["U_B_SpecopsUniform_sgg"];
_vest = ["V_PlateCarrier1_rgr","V_PlateCarrier2_rgr"];
_headgear = ["H_HelmetSpecB_blk"];
_backpack = [""];
if ( ADV_par_NVGs == 1 ) then { _backpack = ["B_AssaultPack_blk"]; };
_insignium = "";
_useProfileGoggles = 1;		//If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "";
_unitTraits = [["medic",true],["engineer",false],["explosiveSpecialist",false],["UAVHacker",false],["camouflageCoef",1.0],["audibleCoef",1.0]];

//weapons - primary weapon - (string)
_primaryweapon = "arifle_MX_GL_Black_F";

//primary weapon items - (array)
_optic = ["optic_Hamr"];
_attachments = [""];
if ( ADV_par_NVGs == 1 ) then { _attachments pushback "acc_flashlight"; };
if ( ADV_par_NVGs == 2 ) then { _attachments pushback "acc_pointer_IR"; };
_silencer = "muzzle_snds_H";		//if silencer is added

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
_primaryweaponAmmo = [4,1];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.
_additionalAmmo = [3,0,false];
_additionalAmmo1 = [0,0,false];
_additionalAmmo2 = [0,0,false];

//40mm Grenades - (arrays)
_40mmHeGrenadesAmmo = 3;
_40mmSmokeGrenadesWhite = 0;
_40mmSmokeGrenadesYellow = 1;
_40mmSmokeGrenadesOrange = 0;
_40mmSmokeGrenadesRed = 1;
_40mmSmokeGrenadesPurple = 0;
_40mmSmokeGrenadesBlue = 0;
_40mmSmokeGrenadesGreen = 1;
_40mmFlareWhite = 0;
_40mmFlareYellow = 4;
_40mmFlareRed = 0;
_40mmFlareGreen = 0;
_40mmFlareIR = 0;

//weapons - handgun - (string)
_handgun = "hgun_Pistol_heavy_01_F";

//handgun items - (array)
_itemsHandgun = ["optic_MRD"];
_handgunSilencer = "muzzle_snds_acp";		//if silencer is added

//handgun ammo (if a handgun is given) - (integer)
_handgunAmmo = [2,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//weapons - launcher - (string)
_launcher = "";

//launcher ammo (if a launcher is given) - (integer) 
_launcherAmmo = [0,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//binocular - (string)
_binocular = "Rangefinder";

//throwables - (integer)
_grenadeSet = 1;		//contains 2 HE grenades, 1 white and one coloured smoke grenade and 1 red chemlight. Select 0 if you want to define your own grenades.
_grenades = [""];			//depending on the custom loadout the colours may be merged. add like this: ["HE","HE","WHITE"] (adds two HE and one white smoke grenade).
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
	"ItemGPS",
	"ItemMap",
	"NVGoggles_OPFOR"
];
		
//items added to any container - (array)
_items = [];

//MarksmenDLC-objects:
if (304400 in (getDLCs 1) || 332350 in (getDLCs 1)) then {
};

	//CustomMod items//
	
//ACRE radios
_acreBackpack = ["B_AssaultPack_blk"];
_ACREradios = ["ACRE_PRC343","ACRE_PRC148","ACRE_PRC117F"];		//_this select 0=shortrange radio;_this select 1=leader radio;_this select 2=backpackRadio;
//TFAR items
_givePersonalRadio = true;
_giveRiflemanRadio = false;
_tfar_microdagr = 0;		//adds the tfar microdagr to set the channels for a rifleman radio

//ACE items (if ACE is running on the server) - (integers)
_ACE_EarPlugs = 1;

_ace_FAK = 1;		//overwrites the values for bandages, morphine and tourniquet and adds a specified number of bandages and morphine. Defined in fn_aceFAK.sqf
_ACE_fieldDressing = 3;
_ACE_packingBandage = 6;
_ACE_elasticBandage = 6;
_ACE_quikclot = 6;
_ACE_atropine = 0;
_ACE_adenosine = 0;
_ACE_epinephrine = 0;
_ACE_morphine = 2;
_ACE_tourniquet = 2;
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
_ACE_personalAidKit = 0;
_ACE_surgicalKit = 0;

_ACE_SpareBarrel = 0;
_ACE_EntrenchingTool = 0;
_ACE_UAVBattery = 0;
_ACE_wirecutter = 0;
_ACE_Clacker = 0;
_ACE_M26_Clacker = 0;
_ACE_DeadManSwitch = 0;
_ACE_DefusalKit = 0;
_ACE_Cellphone = 0;
_ACE_MapTools = 1;
_ACE_CableTie = 2;
_ACE_sprayPaintColor = "RANDOM";

_ACE_key = 1;	//0 = no key, 1 = side dependant key, 2 = master key, 3 = lockpick
_ACE_flashlight = 1;
_ACE_kestrel = 0;
_ACE_altimeter = 0;
_ACE_ATragMX = 0;
_ACE_rangecard = 0;
_ACE_DAGR = 0;
_ACE_microDAGR = 1;
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
_ACE_isMedic = 0;	//0 = no medic; 1 = medic; 2 = doctor;
_ACE_isEngineer = 1;	//0 = no specialist; 1 = engineer; 2 = repair specialist;
_ACE_isEOD = false;
_ACE_isPilot = false;

//Tablet-Items
_tablet = false;
_androidDevice = true;
_microDAGR = false;
_helmetCam = true;

//scorch inv items
_scorchItems = ["sc_dogtag","sc_mre"];
_scorchItemsRandom = ["sc_cigarettepack","sc_chips","sc_charms","sc_candybar","","",""];

//Addon Content:
switch (ADV_par_customWeap) do {
	case 1: {
		//BWmod
		if (isClass(configFile >> "CfgPatches" >> "hlcweapons_g36")) then {
			_primaryWeapon = "hlc_rifle_G36A1AG36";
			_optic = ["HLC_Optic_G36dualoptic35x2d"];
			_attachments = [""];
			if (isClass(configFile >> "CfgPatches" >> "adv_hlcG36_bwmod")) then { _primaryweaponAmmo set [1,5]; _additionalAmmo set [1,4]; };
		} else {
			_primaryweapon = "BWA3_G36_AG";
			_optic = ["BWA3_optic_ZO4x30"];
			if ( ADV_par_NVGs > 0 ) then { _attachments = ["BWA3_acc_VarioRay_irlaser"]; };
		};
		_silencer = "BWA3_muzzle_snds_G36";		//if silencer is added
		_handgun = "BWA3_P8";
		if ( ADV_par_NVGs == 1 ) then {
			_40mmFlareYellow = 0;
			_handgun = "BWA3_P2A1";
			_handgunAmmo = [5,"BWA3_1Rnd_Flare_Illum"];
			_additionalAmmo1 = [2,"BWA3_1Rnd_Flare_Multistar_Green",false];
			_additionalAmmo2 = [2,"BWA3_1Rnd_Flare_Multistar_Red",false];
		};
		_itemsHandgun = [""];
		_handgunSilencer = "";		//if silencer is added
	};
	case 2: {
		//RHS ARMY
		_primaryweapon = ["rhs_weap_m4a1_carryhandle_m203S","rhs_weap_m4_m203S"];
		_optic = ["rhsusf_acc_ACOG","rhsusf_acc_ACOG3","rhsusf_acc_SpecterDR","rhsusf_acc_SpecterDR","rhsusf_acc_SpecterDR_OD"];
		if ( ADV_par_NVGs == 1 ) then { _attachments = ["rhsusf_acc_M952V"]; };
		if ( ADV_par_NVGs == 2 ) then { _attachments = ["rhsusf_acc_anpeq15side_bk"]; };
		_attachments pushBack (["","","","","rhsusf_acc_grip1","rhsusf_acc_grip2","rhsusf_acc_grip2_tan","rhsusf_acc_grip3"] call BIS_fnc_selectRandom);
		_silencer = "rhsusf_acc_rotex5_grey";
		_primaryweaponAmmo set [1,10];
		_additionalAmmo set [1,9];
		_handgun = "rhsusf_weap_m9";
		_itemsHandgun = [""];
		_handgunSilencer = "";
	};
	case 3: {
		//RHS Marines
		_primaryweapon = ["rhs_weap_m16a4_carryhandle_M203"];
		_optic = ["rhsusf_acc_ACOG","rhsusf_acc_ACOG3","rhsusf_acc_SpecterDR"];
		if ( ADV_par_NVGs == 1 ) then { _attachments = ["rhsusf_acc_M952V"]; };
		if ( ADV_par_NVGs == 2 ) then { _attachments = ["rhsusf_acc_anpeq15side_bk"]; };
		_silencer = "rhsusf_acc_rotex5_grey";
		_primaryweaponAmmo set [1,10];
		_additionalAmmo set [1,9];
		_handgun = "rhsusf_weap_m1911a1";
		_itemsHandgun = [""];
		_handgunSilencer = "";
	};
	case 4: {
		//RHS SOF
		_primaryweapon = ["rhs_weap_hk416d145_m320","rhs_weap_hk416d10_m320","rhs_weap_mk18_m320"];
		_optic = ["rhsusf_acc_SpecterDR","rhsusf_acc_SpecterDR","rhsusf_acc_SpecterDR_OD"];
		if ( ADV_par_NVGs == 1 ) then { _attachments = ["rhsusf_acc_M952V"]; };
		if ( ADV_par_NVGs == 2 ) then { _attachments = ["rhsusf_acc_anpeq15side_bk"]; };
		_attachments pushBack (["","","rhsusf_acc_grip2","rhsusf_acc_grip2_tan"] call BIS_fnc_selectRandom);
		_silencer = "rhsusf_acc_rotex5_grey";
		_primaryweaponAmmo set [1,10];
		_additionalAmmo set [1,9];
		_handgun = "rhsusf_weap_m9";
		_itemsHandgun = [""];
		_handgunSilencer = "";
	};
	case 5: {
		//SELmods CUP Mk16
		_primaryweapon = "CUP_arifle_Mk16_STD_EGLM";
		_optic = ["CUP_optic_ELCAN_SpecterDR"];
		if ( ADV_par_NVGs > 0 ) then { _attachments = ["CUP_acc_ANPEQ_15"]; };
		_silencer = "CUP_muzzle_snds_SCAR_L";		//if silencer is added
		_primaryweaponAmmo set [1,10];
		_additionalAmmo set [1,9];
		_handgun="CUP_hgun_M9";
		_itemsHandgun=[];
		_handgunSilencer = "CUP_muzzle_snds_M9";		//if silencer is added
	};
	case 6: {
		//SELmods CUP M4
		_primaryweapon = ["CUP_arifle_M4A1_BUIS_GL","CUP_arifle_M4A1_BUIS_camo_GL","CUP_arifle_M4A1_BUIS_desert_GL"];
		_optic = ["CUP_optic_RCO"];
		if ( ADV_par_NVGs > 0 ) then { _attachments = ["CUP_acc_ANPEQ_2"]; };
		_silencer = "CUP_muzzle_snds_M16";		//if silencer is added
		_primaryweaponAmmo set [1,10];
		_additionalAmmo set [1,9];
		_handgun="CUP_hgun_M9";
		_itemsHandgun=[""];
		_handgunSilencer = "CUP_muzzle_snds_M9";		//if silencer is added
	};
	case 7: {
		//BAF
		_primaryweapon = "CUP_arifle_L85A2_GL";
		_optic = ["CUP_optic_SUSAT","CUP_optic_ACOG"];
		_attachments = [""];
		_silencer = "CUP_muzzle_snds_L85";		//if silencer is added
		_primaryweaponAmmo set [1,10];
		_additionalAmmo set [1,9];
		_handgun="CUP_hgun_Glock17";
		_itemsHandgun=["CUP_acc_Glock17_Flashlight"];
		_handgunSilencer = "muzzle_snds_L";		//if silencer is added
	};
	case 8: {
		//UK3CB
		_primaryweapon = "UK3CB_BAF_L85A2_UGL";
		_optic = ["UK3CB_BAF_SUSAT_3D","UK3CB_BAF_TA31F_3D","UK3CB_BAF_SpecterLDS"];
		if ( ADV_par_NVGs > 0 ) then { _attachments = ["UK3CB_BAF_LLM_IR_Black"]; };
		_silencer = "UK3CB_BAF_Silencer_L85";
		_primaryweaponAmmo set [1,3];
		_handgun = "UK3CB_BAF_L131A1";
		_itemsHandgun=["UK3CB_BAF_Flashlight_L131A1"];
		_handgunSilencer = "muzzle_snds_L";
	};
	case 9: {
		_primaryWeapon = "HLC_Rifle_g3ka4_GL";
		_optic = [""];
		_attachments = [""];
		_silencer = "";
		_primaryweaponAmmo set [1,3];
		if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
			_handgun = ["RH_m1911"];
			_itemsHandgun = [""];
			_handgunSilencer = "";
		};
	};
	default {};
};
switch (ADV_par_customUni) do {
	case 1: {
		//BWmod Tropen
		_uniform = ["BWA3_Uniform_idz_Tropen"];
		if (isClass(configFile >> "CfgPatches" >> "German_feldbluse_patches")) then { _uniform = ["PBW_Uniform1_tropen","PBW_Uniform1H_tropen","PBW_Uniform3_tropen","PBW_Uniform3K_tropen"]; };
		_vest = ["BWA3_Vest_Leader_Tropen"];
		_headgear = ["BWA3_OpsCore_Schwarz"];
		if (isClass(configFile >> "CfgPatches" >> "example_german_headgear_config")) then {
			_items pushback "PBW_muetze1_tropen";
		};
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 2: {
		//BWmod Fleck
		_uniform = ["BWA3_Uniform_idz_Fleck"];
		if (isClass(configFile >> "CfgPatches" >> "German_feldbluse_patches")) then { _uniform = ["PBW_Uniform1_fleck","PBW_Uniform1H_fleck","PBW_Uniform3_fleck","PBW_Uniform3K_fleck"]; };
		_vest = ["BWA3_Vest_Leader_Fleck"];
		_headgear = ["BWA3_OpsCore_Schwarz"];
		if (isClass(configFile >> "CfgPatches" >> "example_german_headgear_config")) then {
			_items pushback "PBW_muetze1_fleck";
		};
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 3: {
		//TFA Mixed
		_uniform = ["TFA_BDU_MCAM_RS","TFA_BDU_MCAM","TFA_BDU_NWU2","TFA_BDU_NWU2_RS","TFA_MCAM_BDU","TFA_MCAM_BDU_RS","TFA_MCAM_NWU2","TFA_MCAM_NWU2_RS","TFA_MCAM_NWU3","TFA_MCAM_NWU3_RS",
			"TFA_NWU2_MCAM","TFA_NWU2_MCAM_RS","TFA_NWU2_BDU","TFA_NWU2_BDU_RS","TFA_NWU2_NWU3","TFA_NWU2_NWU3_RS","TFA_NWU3_MCAM","TFA_NWU3_MCAM_RS","TFA_NWU3_NWU2","TFA_NWU3_NWU2_RS"];
		_vest = ["TFA_PlateCarrierH_ACU"];
		_headgear = ["TFA_FAST_Black"];
	};
	case 4: {
		//TFA Woodland
		_uniform = ["TFA_nwu3","TFA_nwu3_rs"];
		_vest = ["TFA_PlateCarrierH_fol","TFA_PlateCarrierH_Grn","TFA_PlateCarrierH_Mix","TFA_PlateCarrierH_MCam"];
		_headgear = ["TFA_FAST_Black"];
	};
	case 5: {
		//TFA Desert
		_uniform = ["TFA_nwu2","TFA_nwu2_rs"];
		_vest = ["TFA_PlateCarrierH_Grn","TFA_PlateCarrierH_Mix","TFA_PlateCarrierH_NWU2","TFA_PlateCarrierH_MCam","TFA_PlateCarrierH_Tan"];
		_headgear = ["TFA_FAST_Black"];
	};
	case 6: {
		//TFA ACU
		_uniform = ["TFA_acu","TFA_acu_rs"];
		_vest = ["TFA_PlateCarrierH_ACU"];
		_headgear = ["TFA_FAST_Black"];
	};
	case 7: {
		//RHS OCP
		_uniform = ["rhs_uniform_cu_ocp"];
		_vest = ["rhsusf_iotv_ocp_Squadleader"];
		_items pushBack "rhsusf_patrolcap_ocp";
		_acreBackpack = ["rhsusf_assault_eagleaiii_ocp"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
	};
	case 8: {
		//RHS UCP:
		_uniform = ["rhs_uniform_cu_ucp"];
		_vest = ["rhsusf_iotv_ucp_Squadleader"];
		_items pushBack "rhsusf_patrolcap_ucp";
		_acreBackpack = ["rhsusf_assault_eagleaiii_ucp"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
	};
	case 10: {
		//RHS MARPAT Desert
		_uniform = ["rhs_uniform_FROG01_d"];
		_vest = ["rhsusf_spc_teamleader"];
		_headgear = ["rhsusf_lwh_helmet_marpatd_headset"];
		_acreBackpack = ["rhsusf_falconii_coy"];
		_items pushBack "rhs_Booniehat_marpatd";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
	};	
	case 11: {
		//RHS MARPAT Woodland
		_uniform = ["rhs_uniform_FROG01_wd"];
		_vest = ["rhsusf_spc_teamleader"];
		_headgear = ["rhsusf_lwh_helmet_marpatwd_headset"];
		_acreBackpack = ["rhsusf_falconii"];
		_items pushBack "rhs_Booniehat_marpatwd";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
	};
	case 9: {
		//Guerilla
		_uniform = ["U_I_G_Story_Protagonist_F"];
		_headgear = ["H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk","H_Cap_headphones","H_MilCap_mcamo","H_MilCap_gry","H_MilCap_blue","H_Cap_tan_specops_US",
			"H_Cap_usblack","H_Cap_oli_hs","H_Cap_blk","H_Booniehat_tan","H_Booniehat_oli","H_Booniehat_khk","H_Watchcap_khk","H_Watchcap_cbr","H_Watchcap_camo"];
		_binocular = "Binocular";
		_ACREradios = ["","ACRE_PRC343","ACRE_PRC77"];
	};
	case 12: {
		//UK3CB
		_uniform = ["UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve_RM","UK3CB_BAF_U_CombatUniform_MTP_TShirt","UK3CB_BAF_U_CombatUniform_MTP_TShirt_RM","UK3CB_BAF_U_CombatUniform_MTP_RM","UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve_RM"];
		_vest = ["UK3CB_BAF_V_Osprey_SL_A","UK3CB_BAF_V_Osprey_SL_B","UK3CB_BAF_V_Osprey_SL_C","UK3CB_BAF_V_Osprey_SL_D"];
		_headgear = ["UK3CB_BAF_H_Mk7_Camo_A","UK3CB_BAF_H_Mk7_Camo_B","UK3CB_BAF_H_Mk7_Camo_C","UK3CB_BAF_H_Mk7_Camo_D","UK3CB_BAF_H_Mk7_Camo_E","UK3CB_BAF_H_Mk7_Camo_F","UK3CB_BAF_H_Mk7_Net_A","UK3CB_BAF_H_Mk7_Net_B","UK3CB_BAF_H_Mk7_Net_C","UK3CB_BAF_H_Mk7_Net_D"];
		_acreBackpack = ["UK3CB_BAF_B_Bergen_MTP_Radio_H_A","UK3CB_BAF_B_Bergen_MTP_Radio_H_B"];
		_items pushBack "UK3CB_BAF_H_Beret_RM_Bootneck";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["UK3CB_BAF_HMNVS"];
	};
	case 13: {
		//TRYK SpecOps
		_uniform = ["TRYK_U_denim_hood_mc","TRYK_shirts_DENIM_od","TRYK_U_denim_hood_blk","TRYK_U_denim_hood_nc","TRYK_hoodie_FR","TRYK_U_pad_hood_odBK","TRYK_U_pad_hood_Cl",
			"TRYK_shirts_TAN_PAD_YEL","TRYK_U_B_PCUs"];
		_vest append ["TRYK_V_Sheriff_BA_TBL","TRYK_V_Sheriff_BA_TB3","TRYK_V_tacv1_BK","TRYK_V_tacv10LC_OD","TRYK_V_ArmorVest_Brown2",
			"TRYK_V_ArmorVest_Ranger2","TRYK_V_ArmorVest_rgr","TRYK_V_ArmorVest_khk","TRYK_V_ArmorVest_coyo","TRYK_V_IOTV_BLK"];
		_headgear = ["TRYK_R_CAP_BLK","H_Cap_blk","TRYK_H_PASGT_BLK"];
		_backpack = ["TRYK_B_Belt_BLK","TRYK_B_Belt_br","TRYK_B_Belt_CYT","TRYK_B_Belt","TRYK_B_Belt_GR"];
	};
	case 14: {
		//TRYK Snow
		_uniform = ["TRYK_U_B_PCUHsW6","TRYK_U_B_PCUHsW4"];
		_vest = ["TRYK_V_ArmorVest_Winter"];
		_headgear = ["TRYK_H_Helmet_Winter_2"];
		_backpack = ["TRYK_B_Belt_BLK"];
		_useProfileGoggles = 0;
		_goggles = ["TRYK_kio_balaclava_WH","",""];
	};
	default {};
};

//TFAR-manpacks
if ( isClass(configFile >> "CfgPatches" >> "task_force_radio") && (ADV_par_Radios == 1 || ADV_par_Radios == 3) ) then {
	_backpack = switch (ADV_par_CustomUni) do {
		case 1: {["tf_rt1523g_bwmod"]};
		case 2: {["tf_rt1523g_bwmod"]};
		case 9: {["tf_rt1523g_rhs"]};
		case 12: {["UK3CB_BAF_B_Bergen_MTP_Radio_H_A","UK3CB_BAF_B_Bergen_MTP_Radio_H_B"]};
		case 13: {["tf_rt1523g_bwmod"]};
		case 14: {["tf_rt1523g_bwmod"]};
		default {["tf_rt1523g_rhs"]};
	};
};
if ( isClass (configFile >> "CfgPatches" >> "acre_main") && (ADV_par_Radios == 1 || ADV_par_Radios == 3) ) then {
	_backpack = _acreBackpack;
};

switch (toUpper ([str (_this select 0),0,9] call BIS_fnc_trimString)) do {
	case "LEADER_LOG": {
		_ACE_isMedic = 2;
		_ACE_isEngineer = 2;
		_ACE_isEOD = true;
		_tablet = true;
		_androidDevice = false;
	};
	case "LEADER_COM": {
		_ACE_isMedic = 2;
		_tablet = true;
		_androidDevice = false;
		_40mmFlareYellow = 0;
		_ACE_HuntIR_monitor = 1;
		_ACE_HuntIR = 5;
	};
};

///// No editing necessary below this line /////
_player = _this select 0;
[_player] call ADV_fnc_gear;
CL_IE_Module_Enabled = true;

true;
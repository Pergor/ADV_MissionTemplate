/*
unit loadout script by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set _primaryweaponAmmo to 0 and add those
magazines one for one in _items.
*/

//clothing - (string)
_uniform = ["U_B_GhillieSuit"];
_vest = ["V_PlateCarrier1_rgr","V_PlateCarrier2_rgr"];
_headgear = ["H_Watchcap_blk"];
_backpack = ["B_AssaultPack_rgr"];
_insignium = "";
_useProfileGoggles = 1;		//If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "";
_unitTraits = [["medic",true],["engineer",true],["explosiveSpecialist",true],["UAVHacker",true],["camouflageCoef",1.5],["audibleCoef",0.5]];

//weapons - primary weapon - (string)
_primaryweapon = "arifle_MX_GL_Black_F";

//primary weapon items - (array)
_optic = ["optic_Holosight"];
_attachments = ["muzzle_snds_H"];
if ( ADV_par_NVGs == 1 ) then { _attachments pushback "acc_flashlight"; };
if ( ADV_par_NVGs == 2 ) then { _attachments pushback "acc_pointer_IR"; };
_silencer = "";		//if silencer is added

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
_primaryweaponAmmo = [7,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.
_additionalAmmo = [5,"7Rnd_408_Mag",true];

//40mm Grenades - (arrays)
_40mmHeGrenadesAmmo = 4;
_40mmSmokeGrenadesWhite = 1;
_40mmSmokeGrenadesYellow = 0;
_40mmSmokeGrenadesOrange = 0;
_40mmSmokeGrenadesRed = 1;
_40mmSmokeGrenadesPurple = 0;
_40mmSmokeGrenadesBlue = 0;
_40mmSmokeGrenadesGreen = 1;
_40mmFlareWhite = 0;
_40mmFlareYellow = 0;
_40mmFlareRed = 0;
_40mmFlareGreen = 0;
_40mmFlareIR = 0;

//weapons - handgun - (string)
_handgun = "hgun_Pistol_heavy_01_F";

//handgun items - (array)
_itemsHandgun = ["optic_MRD","muzzle_snds_acp"];
_handgunSilencer = "";		//if silencer is added

//handgun ammo (if a handgun is given) - (integer)
_handgunAmmo = [4,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//weapons - launcher - (string)
_launcher = "";

//launcher ammo (if a launcher is given) - (integer) 
_launcherAmmo = [0,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//binocular - (string)
_binocular = "Laserdesignator";

//throwables - (integer)
_grenadeSet = 0;		//contains 2 HE grenades, 1 white and one coloured smoke grenade and 1 red chemlight. Select 0 if you want to define your own grenades.
_grenades = ["HE","HE","WHITE","WHITE","GREEN","RED"];		//depending on the custom loadout the colours may be merged.
_chemlights = ["RED"];
_IRgrenade = 1;

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
	"ItemMap"
];
		
//items added to any container - (array)
_items = ["NVGoggles_OPFOR"];

//MarksmenDLC-objects:
if (304400 in (getDLCs 1) || 332350 in (getDLCs 1)) then {
	_uniform = switch (true) do {
		case ((toUpper worldname) == "ALTIS"): {["U_B_FullGhillie_ard","U_B_FullGhillie_sard"]};
		case ((toUpper worldname) in ADV_var_aridMaps): {["U_B_FullGhillie_ard"]};
		case ((toUpper worldname) in ADV_var_sAridMaps): {["U_B_FullGhillie_sard"]};
		case ((toUpper worldname) in ADV_var_lushMaps): {["U_B_FullGhillie_lsh"]};
		default {["U_B_FullGhillie_lsh","U_B_FullGhillie_sard"]};
	};
};

	//CustomMod items//
	
//ACRE radios
_ACREradios = ["ACRE_PRC343","ACRE_PRC148"];	//_this select 0=shortrange radio;_this select 1=leader radio;_this select 2=backpackRadio;
//TFAR items
_givePersonalRadio = true;
_giveRiflemanRadio = false;
_tfar_microdagr = 0;		//adds the tfar microdagr to set the channels for a rifleman radio

//ACE items (if ACE is running on the server) - (integers)
_ACE_EarPlugs = 1;

_ace_FAK = 0;		//overwrites the values for bandages, morphine and tourniquet and adds a specified number of bandages and morphine. Defined in fn_aceFAK.sqf
_ACE_fieldDressing = 4;
_ACE_packingBandage = 8;
_ACE_elasticBandage = 8;
_ACE_quikclot = 6;
_ACE_atropine = 0;
_ACE_adenosine = 0;
_ACE_epinephrine = 2;
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
_ACE_surgicalKit = 1;

_ACE_SpareBarrel = 0;
_ACE_EntrenchingTool = 0;
_ACE_UAVBattery = 0;
_ACE_wirecutter = 0;
_ACE_Clacker = 0;
_ACE_M26_Clacker = 0;
_ACE_DeadManSwitch = 0;
_ACE_DefusalKit = 1;
_ACE_Cellphone = 0;
_ACE_MapTools = 1;
_ACE_CableTie = 2;
_ACE_sprayPaintColor = "NONE";

_ACE_key = 3;	//0 = no key, 1 = side dependant key, 2 = master key, 3 = lockpick
_ACE_flashlight = 1;
_ACE_kestrel = 1;
_ACE_altimeter = 0;
_ACE_ATragMX = 0;
_ACE_rangecard = 1;
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

//ACE Variables (if ACE is running) - (bool)
_ACE_isMedic = 1;	//0 = no medic; 1 = medic; 2 = doctor;
_ACE_isEngineer = 1;	//0 = no specialist; 1 = engineer; 2 = repair specialist;
_ACE_isEOD = true;
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
			_primaryWeapon = ["hlc_rifle_g36KTac"];
			_40mmHeGrenadesAmmo = 0;
			_40mmSmokeGrenadesWhite = 0;
			_40mmSmokeGrenadesRed = 0;
			_40mmSmokeGrenadesGreen = 0;
			if (isClass(configFile >> "CfgPatches" >> "adv_hlcG36_bwmod")) then { _primaryweaponAmmo set [1,8] };
		} else {
			_primaryweapon = "BWA3_G36K_AG";
			_primaryweaponAmmo set [1,3];
		};
		_optic = ["BWA3_optic_EOTech_Mag_Off"];
		_attachments = ["BWA3_muzzle_snds_G36"];
		if ( ADV_par_NVGs > 0 ) then { _attachments pushBack "BWA3_acc_VarioRay_irlaser"; };
		_additionalAmmo = [5,"BWA3_10Rnd_127x99_G82",true];
		_handgun = "BWA3_P8";
		_itemsHandgun = [];
	};
	case 2: {
		//RHS ARMY
		_primaryweapon = ["rhs_weap_m4a1_blockII_M203","rhs_weap_m4a1_blockII_M203","rhs_weap_m4a1_m320"];
		_optic = ["rhsusf_acc_SpecterDR_CX_3D","rhsusf_acc_SpecterDR_3d","rhsusf_acc_SpecterDR_OD_3D","rhsusf_acc_SpecterDR_D_3D"];
		_attachments = ["rhsusf_acc_rotex5_grey"];
		if ( ADV_par_NVGs == 1 ) then { _attachments pushback "rhsusf_acc_M952V"; };
		if ( ADV_par_NVGs == 2 ) then { _attachments pushback "rhsusf_acc_anpeq15side_bk"; };
		_attachments pushBack (["","rhsusf_acc_grip2"] call BIS_fnc_selectRandom);
		_primaryweaponAmmo set [1,9];
		_handgun = "rhsusf_weap_m9";
		_itemsHandgun = [""];
		_handgunSilencer = "";
		if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
			_handgun = "RH_m9";
			_itemsHandgun = ["RH_x300","RH_m9qd"];
		};
		_additionalAmmo = [5,"rhsusf_5Rnd_300winmag_xm2010",true];
	};
	case 3: {
		//RHS Marines
		_primaryweapon = ["rhs_weap_mk18_m320","rhs_weap_mk18_m320","rhs_weap_m4a1_m320"];
		_optic = ["rhsusf_acc_SpecterDR_CX_3D","rhsusf_acc_SpecterDR_3d","rhsusf_acc_SpecterDR_OD_3D","rhsusf_acc_SpecterDR_D_3D"];
		_attachments = ["rhsusf_acc_rotex5_grey"];
		if ( ADV_par_NVGs == 1 ) then { _attachments pushback "rhsusf_acc_M952V"; };
		if ( ADV_par_NVGs == 2 ) then { _attachments pushback "rhsusf_acc_anpeq15side_bk"; };
		_attachments pushBack (["","rhsusf_acc_grip2"] call BIS_fnc_selectRandom);
		_primaryweaponAmmo set [1,9];
		_handgun = "rhsusf_weap_m1911a1";
		_itemsHandgun = [""];
		_handgunSilencer = "";
		if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
			_handgun = "RH_m9";
			_itemsHandgun = ["RH_x300","RH_m9qd"];
		};
		_additionalAmmo = [5,"rhsusf_mag_10Rnd_STD_50BMG_mk211",true];
	};
	case 4: {
		//RHS SOF
		_primaryweapon = ["rhs_weap_hk416d145_m320","rhs_weap_hk416d10_m320","rhs_weap_mk18_m320","rhs_weap_m4a1_m320"];
		_optic = ["rhsusf_acc_SpecterDR_CX_3D","rhsusf_acc_SpecterDR_3d","rhsusf_acc_SpecterDR_OD_3D","rhsusf_acc_SpecterDR_D_3D"];
		_attachments = ["rhsusf_acc_rotex5_grey"];
		if ( ADV_par_NVGs == 1 ) then { _attachments pushback "rhsusf_acc_M952V"; };
		if ( ADV_par_NVGs == 2 ) then { _attachments pushback "rhsusf_acc_anpeq15side_bk"; };
		_attachments pushBack (["","rhsusf_acc_grip2"] call BIS_fnc_selectRandom);
		_primaryweaponAmmo set [1,9];
		_handgun = "rhsusf_weap_m9";
		_itemsHandgun = [""];
		_handgunSilencer = "";
		if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
			_handgun = "RH_m9";
			_itemsHandgun = ["RH_x300","RH_m9qd"];
		};
		_additionalAmmo = [5,"rhsusf_mag_10Rnd_STD_50BMG_mk211",true];
	};
	case 5: {
		//SELmods CUP Mk16
		_primaryweapon = ["CUP_arifle_M4A1_BUIS_GL","CUP_arifle_M4A1_BUIS_camo_GL","CUP_arifle_M4A1_BUIS_desert_GL"];
		_optic = ["CUP_optic_CompM2_Desert"];
		_attachments = ["CUP_muzzle_snds_M16"];
		if ( ADV_par_NVGs > 0 ) then { _attachments pushBack "CUP_acc_ANPEQ_2_desert"; };
		_primaryweaponAmmo set [1,9];
		_additionalAmmo = [5,"CUP_5Rnd_762x51_M24",true];
		_handgun="CUP_hgun_Phantom";
		_itemsHandgun=["CUP_acc_CZ_M3X","muzzle_snds_L"];
		_binocular="CUP_SOFLAM";
	};
	case 6: {
		//SELmods CUP M4
		_primaryweapon = ["CUP_arifle_M4A1_BUIS_GL","CUP_arifle_M4A1_BUIS_camo_GL","CUP_arifle_M4A1_BUIS_desert_GL"];
		_optic = ["CUP_optic_CompM2_Woodland"];
		_attachments = ["CUP_muzzle_snds_M16"];
		if ( ADV_par_NVGs > 0 ) then { _attachments pushBack "CUP_acc_ANPEQ_2_camo"; };
		_primaryweaponAmmo set [1,9];
		_additionalAmmo = [5,"CUP_5Rnd_762x51_M24",true];
		_handgun="CUP_hgun_Phantom";
		_itemsHandgun=["CUP_acc_CZ_M3X","muzzle_snds_L"];
		_binocular="CUP_SOFLAM";
	};
	case 7: {
		//BAF
		_primaryweapon="CUP_arifle_L85A2_GL";
		_optic = ["CUP_optic_SUSAT"];
		_attachments = ["CUP_muzzle_snds_L85"];
		_primaryweaponAmmo set [1,9];
		_additionalAmmo = [5,"CUP_5Rnd_127x99_as50_M",true];
		_handgun="CUP_hgun_Phantom";
		_itemsHandgun=["CUP_acc_CZ_M3X","muzzle_snds_L"];
		_binocular="CUP_SOFLAM";
	};
	case 8: {
		//UK3CB
		_primaryweapon = ["UK3CB_BAF_L85A2_UGL_HWS"];
		_optic = ["UK3CB_BAF_SUSAT_3D"];
		_attachments = ["UK3CB_BAF_Silencer_L85"];
		if ( ADV_par_NVGs > 0 ) then { _attachments pushBack "UK3CB_BAF_LLM_IR_Black"; };
		_primaryweaponAmmo set [1,2];
		_additionalAmmo = [5,"UK3CB_BAF_L115A3_Mag",true];
		_handgun = "UK3CB_BAF_L131A1";
		_itemsHandgun=["UK3CB_BAF_Flashlight_L131A1","muzzle_snds_L"];
		_binocular="UK3CB_BAF_Soflam_Laserdesignator";
	};
	case 9: {
		_primaryWeapon = ["hlc_smg_9mmar"];
		_optic = [""];
		_attachments = [""];
		_silencer = "";
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
		_uniform = ["BWA3_Uniform_Ghillie_idz_Tropen"];
		_vest = ["BWA3_Vest_Marksman_Tropen"];
		_backpack = ["BWA3_PatrolPack_Tropen"];
		_headgear = ["BWA3_Booniehat_Tropen"];
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _items = _items-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 2: {
		//BWmod Fleck
		_uniform = ["BWA3_Uniform_Ghillie_idz_Fleck"];
		_vest = ["BWA3_Vest_Marksman_Fleck"];
		_backpack = ["BWA3_PatrolPack_Fleck"];
		_headgear = ["BWA3_Booniehat_Fleck"];
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _items = _items-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 3: {
		//TFA Mixed
		_vest = ["TFA_PlateCarrierH_MCam","TFA_PlateCarrierH_Tan","TFA_PlateCarrierH_Grn","TFA_PlateCarrierH_NWU2"];
	};
	case 4: {
		//TFA Woodland
		_vest = ["TFA_PlateCarrierH_fol","TFA_PlateCarrierH_Grn","TFA_PlateCarrierH_Mix"];
	};
	case 5: {
		//TFA Desert
		_vest = ["TFA_PlateCarrierH_NWU2","TFA_PlateCarrierH_MCam","TFA_PlateCarrierH_Tan","TFA_PlateCarrierH_Mix"];
	};
	case 6: {
		//TFA ACU
		_vest = ["TFA_PlateCarrierH_ACU"];
	};
	case 7: {
		//RHS OCP
		_vest = ["rhsusf_iotv_ocp_Teamleader"];
		_backpack = ["rhsusf_falconii"];
		_items = _items-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_14"];
	};
	case 8: {
		//RHS UCP
		_vest = ["rhsusf_iotv_ucp_Teamleader"];
		_backpack = ["rhsusf_falconii"];
		_items = _items-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_14"];
	};
	case 10: {
		//RHS MARPAT Desert
		_vest = ["rhsusf_spc_teamleader"];
		_backpack = ["rhsusf_falconii"];
		_headgear = ["rhs_Booniehat_marpatd"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
	};	
	case 11: {
		//RHS MARPAT Woodland
		_vest = ["rhsusf_spc_teamleader"];
		_backpack = ["rhsusf_falconii"];
		_headgear = ["rhs_Booniehat_marpatwd"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
	};
	case 9: {
		//Guerilla
		_headgear = ["H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk","H_Cap_headphones","H_MilCap_mcamo","H_MilCap_gry","H_MilCap_blue","H_Cap_tan_specops_US",
			"H_Cap_usblack","H_Cap_oli_hs","H_Cap_blk","H_Booniehat_tan","H_Booniehat_oli","H_Booniehat_khk","H_Watchcap_khk","H_Watchcap_cbr","H_Watchcap_camo"];
		_binocular = "Rangefinder";
	};
	case 12: {
		//UK3CB
		_uniform = ["UK3CB_BAF_U_CombatUniform_MTP_Ghillie_RM"];
		_vest = ["UK3CB_BAF_V_Osprey_Grenadier_A","UK3CB_BAF_V_Osprey_Grenadier_B"];
		_headgear = ["UK3CB_BAF_H_Beret_RM_Officer"];
		_backpack = ["UK3CB_BAF_B_Bergen_MTP_JTAC_L_A"];
		_items = _items-["NVGoggles_OPFOR"]+["UK3CB_BAF_HMNVS"];
	};
	case 13: {
		//TRYK SpecOps
		_uniform = ["TRYK_U_denim_hood_mc","TRYK_shirts_DENIM_od","TRYK_U_denim_hood_blk","TRYK_U_denim_hood_nc","TRYK_hoodie_FR","TRYK_U_pad_hood_odBK","TRYK_U_pad_hood_Cl",
			"TRYK_shirts_TAN_PAD_YEL","TRYK_U_B_PCUs","TRYK_U_B_fleece"];
		_vest append ["TRYK_V_Sheriff_BA_TBL","TRYK_V_Sheriff_BA_TB3","TRYK_V_tacv1_BK","TRYK_V_tacv10LC_OD","TRYK_V_ArmorVest_Brown2",
			"TRYK_V_ArmorVest_Ranger2","TRYK_V_ArmorVest_rgr","TRYK_V_ArmorVest_khk","TRYK_V_ArmorVest_coyo","TRYK_V_IOTV_BLK"];
		_headgear append ["TRYK_R_CAP_OD_US","TRYK_R_CAP_BLK","H_Cap_headphones","H_Cap_oli_hs","H_Cap_blk","TRYK_ESS_CAP_tan",
			"TRYK_H_PASGT_COYO","TRYK_H_PASGT_OD"];
	};
	case 14: {
		//TRYK Snow
		_uniform = ["TRYK_U_B_PCUHsW6","TRYK_U_B_PCUHsW4","TRYK_U_B_PCUHsW","TRYK_U_B_PCUHsW5"];
		_vest = ["TRYK_V_ArmorVest_Winter"];
		_headgear = ["TRYK_H_woolhat_WH"];
		_backpack = ["TRYK_Winter_pack"];
		_useProfileGoggles = 0;
		_goggles = ["TRYK_kio_balaclava_WH"];
	};
	default {};
};
if ( isClass(configFile >> "CfgPatches" >> "ace_spottingscope") ) then { _items pushBack "ACE_SpottingScope"; };

///// No editing necessary below this line /////

_player = _this select 0;
[_player] call ADV_fnc_gear;
CL_IE_Module_Enabled = true;

true;
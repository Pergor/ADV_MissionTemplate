/*
unit loadout script by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set _primaryweaponAmmo to 0 and add those
magazines one for one in _items.
*/

//clothing - (string)
_uniform = ["U_B_CombatUniform_mcam_worn","U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_vest"];
_vest = ["V_TacVest_blk"];
_headgear = ["H_HelmetB_sand"];
_backpack = ["B_Assaultpack_blk"];
_insignium = "";
_useProfileGoggles = 1;		//If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "G_Aviator";
_unitTraits = [["medic",false],["engineer",true],["explosiveSpecialist",false],["UAVHacker",false],["camouflageCoef",1.0],["audibleCoef",1.0]];

//weapons - primary weapon - (string)
_primaryweapon = "arifle_MXC_Black_F";

//primary weapon items - (array)
_optic = [""];
_attachments = [""];
if ( ADV_par_NVGs == 1 ) then { _attachments pushback "acc_flashlight"; };
if ( ADV_par_NVGs == 2 ) then { _attachments pushback "acc_pointer_IR"; };
_silencer = "";		//if silencer is added

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
_primaryweaponAmmo = [4,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

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
_itemsHandgun = [""];
_handgunSilencer = "";			//if silencer is added

//handgun ammo (if a handgun is given) - (integer)
_handgunAmmo = [3,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//weapons - launcher - (string)
_launcher = "";

//launcher ammo (if a launcher is given) - (integer) 
_launcherAmmo = [0,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//binocular - (string)
_binocular = "";

//throwables - (integer)
_grenadeSet = 0;		//contains 2 HE grenades, 1 white and one coloured smoke grenade and 1 red chemlight. Select 0 if you want to define your own grenades.
_grenades = ["RED","RED"];		//depending on the custom loadout the colours may be merged.
_chemlights = ["RED"];
_IRgrenade = 0;

//first aid kits and medi kits- (integer)
_FirstAidKits = 1;
_MediKit = 0;		//if set to 1, a MediKit and all FirstAidKits will be added to the backpack; if set to 0, FirstAidKits will be added to inventory in no specific order.

//items added specifically to uniform: - (array)
_itemsUniform = [];

//items added specifically to vest: - (array)
_itemsVest = [];

//items added specifically to Backpack: - (array)
_itemsBackpack = ["ToolKit"];

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
_ACREradios = ["ACRE_PRC343","ACRE_PRC148"];	//_this select 0=shortrange radio;_this select 1=leader radio;_this select 2=backpackRadio;
//TFAR items
_givePersonalRadio = true;
_giveRiflemanRadio = false;
_tfar_microdagr = 0;				//adds the tfar microdagr to set the channels for a rifleman radio

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
_ACE_sprayPaintColor = "NONE";

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
_ACE_isMedic = 1;	//0 = no medic; 1 = medic; 2 = doctor;
_ACE_isEngineer = 2;	//0 = no specialist; 1 = engineer; 2 = repair specialist;
_ACE_isEOD = false;
_ACE_isPilot = true;

//Tablet-Items
_tablet = false;
_androidDevice = true;
_microDAGR = false;
_helmetCam = false;

//scorch inv items
_scorchItems = ["sc_dogtag"];
_scorchItemsRandom = ["sc_cigarettepack","sc_chips","sc_charms","sc_candybar","","",""];

//Addon Content:
switch (true) do {
	case (ADV_par_customWeap == 1): {
		//BWmod
		_primaryweapon = [""];
		_optic = [""];
		_primaryweaponAmmo = [0,0];
		_handgun = "BWA3_MP7";
		if ( ADV_par_optics == 1 ) then { _itemsHandgun = ["BWA3_optic_RSAS"]; } else { _itemsHandgun = [""]; };
		_handgunAmmo = [5,0];
	};
	case (ADV_par_customWeap == 2 || ADV_par_customWeap == 3): {
		//RHS Army & Marines
		_primaryweapon = ["rhs_weap_m4_carryhandle"];
		_optic = [""];
		_attachments = [""];
		_silencer = "";
		if (isClass(configFile >> "CfgPatches" >> "hlcweapons_mp5")) then {
			if (ADV_par_Silencers == 1) then { _primaryweapon = "hlc_smg_mp5sd6"; _silencer = ""; _primaryweaponAmmo set [1,2];};
		} else {
			_primaryweaponAmmo set [1,9];
		};
		_handgun = "rhsusf_weap_m9";
		if (ADV_par_customWeap == 3) then { _handgun = "rhsusf_weap_m1911a1"; };
		_itemsHandgun = [""];
		_handgunSilencer = "";
	};
	case (ADV_par_customWeap == 4): {
		//RHS SOF
		_primaryweapon = ["rhs_weap_hk416d10_LMT","rhs_weap_m4a1_blockII_KAC","rhs_weap_m4_carryhandle"];
		_optic = [""];
		_primaryweaponAmmo set [1,9];
		_handgun = "rhsusf_weap_m9";
		_itemsHandgun = [""];
		_handgunSilencer = "";
	};
	case (ADV_par_customWeap == 5 || ADV_par_customWeap == 6): {
		//CUP
		_primaryweapon = "CUP_smg_MP5A5";
		_optic = [""];
		_handgun="CUP_hgun_M9";
		_itemsHandgun=[];
	};
	case (ADV_par_customWeap == 7): {
		//CUP BAF
		_primaryweapon = "CUP_smg_MP5A5";
		_optic = [""];
		_handgun="CUP_hgun_Glock17";
		_itemsHandgun=["CUP_acc_Glock17_Flashlight"];
	};
	case (ADV_par_customWeap == 8): {
		//UK3CB
		_primaryweapon = ["UK3CB_BAF_L85A2"];
		_optic = [""];
		_primaryweaponAmmo set [1,2];
		_handgun = "UK3CB_BAF_L131A1";
		_itemsHandgun=["UK3CB_BAF_Flashlight_L131A1"];
	};
	case (ADV_par_customWeap == 9): {
		//HLC
		if (isClass(configFile >> "CfgPatches" >> "hlcweapons_mp5")) then {
			_primaryweapon = ["hlc_smg_mp5a2","hlc_smg_mp510","hlc_smg_mp5a4"];
			_optic = [""];
			_attachments = [""];
			_silencer = "";			
		};
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
		_uniform = ["BWA3_Uniform_Crew_Tropen"];
		_vest = ["BWA3_Vest_Tropen"];
		_headgear = ["BWA3_CrewmanKSK_Tropen_Headset"];
		if (isClass(configFile >> "CfgPatches" >> "example_german_headgear_config")) then {
			_items pushback "PBW_muetze1_tropen";
		};
		_backpack = ["BWA3_Assaultpack_Tropen"];
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 2: {
		//BWmod Fleck
		_uniform = ["BWA3_Uniform_Crew_Fleck"];
		_vest = ["BWA3_Vest_Fleck"];
		_headgear = ["BWA3_CrewmanKSK_Fleck_Headset"];
		if (isClass(configFile >> "CfgPatches" >> "example_german_headgear_config")) then {
			_items pushback "PBW_muetze1_fleck";
		};
		_backpack = ["BWA3_Assaultpack_Fleck"];
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 3: {
		//TFA Mixed
		_uniform = ["TFA_BDU_MCAM_RS","TFA_BDU_MCAM","TFA_BDU_NWU2","TFA_BDU_NWU2_RS","TFA_MCAM_BDU","TFA_MCAM_BDU_RS","TFA_MCAM_NWU2","TFA_MCAM_NWU2_RS","TFA_MCAM_NWU3","TFA_MCAM_NWU3_RS",
			"TFA_NWU2_MCAM","TFA_NWU2_MCAM_RS","TFA_NWU2_BDU","TFA_NWU2_BDU_RS","TFA_NWU2_NWU3","TFA_NWU2_NWU3_RS","TFA_NWU3_MCAM","TFA_NWU3_MCAM_RS","TFA_NWU3_NWU2","TFA_NWU3_NWU2_RS"];
		_headgear = ["TFA_Mich_Tan","TFA_Mich_Green"];
		_backpack = ["TFA_Assaultpack_blk"];
	};
	case 4: {
		//TFA Woodland
		_uniform = ["TFA_nwu3","TFA_nwu3_rs"];
		_headgear = ["TFA_Mich_Green"];
		_backpack = ["TFA_Assaultpack_blk"];
	};
	case 5: {
		//TFA Desert
		_uniform = ["TFA_nwu2","TFA_nwu2_rs"];
		_headgear = ["TFA_Mich_Tan"];
		_backpack = ["TFA_Assaultpack_blk"];
	};
	case 6: {
		//TFA ACU
		_uniform = ["TFA_acu","TFA_acu_rs"];
		_headgear = ["TFA_Mich_Black"];
		_backpack = ["TFA_Assaultpack_blk"];
	};
	case 7: {
		//RHS OCP
		_uniform = ["rhs_uniform_cu_ocp"];
		_vest = ["rhsusf_iotv_ocp_Repair"];
		_headgear = ["rhsusf_mich_bare_tan_headset","rhsusf_ach_bare_tan_headset_ess"];
		_items pushBack "rhsusf_patrolcap_ocp";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
		_backpack = ["rhsusf_assault_eagleaiii_ocp"];
	};
	case 8: {
		//RHS UCP
		_uniform = ["rhs_uniform_cu_ucp"];
		_vest = ["rhsusf_iotv_ucp_Repair"];
		_headgear = ["rhsusf_ach_bare_headset_ess","rhsusf_mich_bare_headset"];
		_items pushBack "rhsusf_patrolcap_ucp";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
		_backpack = ["rhsusf_assault_eagleaiii_ucp"];
	};
	case 10: {
		//RHS MARPAT Desert
		_uniform = ["rhs_uniform_FROG01_d"];
		_vest = ["rhsusf_spc_crewman"];
		_headgear = ["rhsusf_bowman_cap"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
		_backpack = ["rhsusf_assault_eagleaiii_coy"];
	};	
	case 11: {
		//RHS MARPAT Woodland
		_uniform = ["rhs_uniform_FROG01_wd"];
		_vest = ["rhsusf_spc_crewman"];
		_headgear = ["rhsusf_bowman_cap"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
		_backpack = ["rhsusf_assault_eagleaiii_coy"];
	};
	case 9: {
		//Guerilla
		_uniform = ["U_BG_Guerrilla_6_1","U_BG_Guerilla2_2","U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_BG_Guerilla3_1"];
		_headgear = ["H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk","H_Cap_headphones","H_MilCap_mcamo","H_MilCap_gry","H_MilCap_blue","H_Cap_tan_specops_US",
			"H_Cap_usblack","H_Cap_oli_hs","H_Cap_blk","H_Booniehat_tan","H_Booniehat_oli","H_Booniehat_khk","H_Watchcap_khk","H_Watchcap_cbr","H_Watchcap_camo"];
		_ACREradios = ["ACRE_PRC343"];
	};
	case 12: {
		//UK3CB
		_uniform = ["UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve_RM","UK3CB_BAF_U_CombatUniform_MTP_RM","UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve_RM"];
		_vest = ["UK3CB_BAF_V_Pilot_A"];
		_headgear = ["UK3CB_BAF_H_Beret_RM_Bootneck"];
		_backpack = ["UK3CB_BAF_B_Bergen_MTP_Engineer_L_A"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["UK3CB_BAF_HMNVS"];
	};
	case 13: {
		//TRYK SpecOps
		_uniform = ["TRYK_U_denim_hood_mc","TRYK_shirts_DENIM_od","TRYK_U_denim_hood_blk","TRYK_U_denim_hood_nc","TRYK_hoodie_FR","TRYK_U_pad_hood_odBK","TRYK_U_pad_hood_Cl",
			"TRYK_shirts_TAN_PAD_YEL","TRYK_U_B_PCUs"];
		_vest append ["TRYK_V_Sheriff_BA_TBL","TRYK_V_Sheriff_BA_TB3","TRYK_V_tacv1_BK","TRYK_V_tacv10LC_OD","TRYK_V_ArmorVest_Brown2",
			"TRYK_V_ArmorVest_Ranger2","TRYK_V_ArmorVest_rgr","TRYK_V_ArmorVest_khk","TRYK_V_ArmorVest_coyo","TRYK_V_IOTV_BLK"];
		_headgear append ["TRYK_R_CAP_OD_US","TRYK_R_CAP_BLK","H_Cap_headphones","H_Cap_oli_hs","H_Cap_blk","TRYK_ESS_CAP_tan",
			"TRYK_H_PASGT_COYO","TRYK_H_PASGT_OD"];
	};
	case 14: {
		//TRYK Snow
		_uniform = ["TRYK_U_B_PCUHsW6","TRYK_U_B_PCUHsW4","TRYK_U_B_PCUHsW","TRYK_U_B_PCUHsW5"];
		_vest = ["TRYK_V_ArmorVest_Winter"];
		_headgear = ["TRYK_H_woolhat_WH","TRYK_H_woolhat_WH",""];
		_backpack = ["TRYK_B_Coyotebackpack_WH"];
		_useProfileGoggles = 0;
		_goggles = ["TRYK_kio_balaclava_WH","",""];
	};
	default {};
};


///// No editing necessary below this line /////

_player = _this select 0;
//TFAR-manpacks
switch (toUpper ([str (_this select 0),0,6] call BIS_fnc_trimString)) do {
	case "LOG_COM": {
		if ( isClass(configFile >> "CfgPatches" >> "task_force_radio") && (ADV_par_Radios == 1 || ADV_par_Radios == 3) ) then {
			_backpack = switch (ADV_par_CustomUni) do {
				case 1: {["tf_rt1523g_bwmod"]};
				case 2: {["tf_rt1523g_bwmod"]};
				case 9: {["tf_rt1523g_rhs"]};
				case 12: {["UK3CB_BAF_B_Bergen_MTP_Radio_H_A","UK3CB_BAF_B_Bergen_MTP_Radio_H_B"]};
				default {["tf_rt1523g_big_rhs"]};
			};
		};
	};
};
[_player] call ADV_fnc_gear;
CL_IE_Module_Enabled = true;

true;
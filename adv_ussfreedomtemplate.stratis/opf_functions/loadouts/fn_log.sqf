﻿//mission variables and parameters:
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
 * [player] call adv_opf_fnc_log;
 *
 * Public: No
 */

//clothing - (string)
_uniform = ["U_O_OfficerUniform_ocamo"];
_vest = ["V_TacVest_khk"];
_headgear = if (isClass(configFile >> "CfgPatches" >> "ace_hearing") && !isClass(configFile >> "CfgPatches" >> "adv_damnYouAceHearing")) then { ["H_MilCap_ocamo"] } else { ["H_HelmetCrew_O"] };
_backpack = ["B_assaultpack_blk"];
_insignium = "";
_useProfileGoggles = 1;		//If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "";
_unitTraits = [["medic",false],["engineer",true],["explosiveSpecialist",false],["UAVHacker",false],["camouflageCoef",1.0],["audibleCoef",1.0]];

//weapons - primary weapon - (string)
_primaryweapon = "arifle_Katiba_C_F";

//primary weapon items - (array)
_optic = [""];
_attachments = [""];
if ( _par_opfNVGs == 1 ) then { _attachments pushBack "acc_flashlight"; };
if ( _par_opfNVGs == 2 ) then { _attachments pushback "acc_pointer_IR"; };
_silencer = "";		//if silencer is added

if (worldName == "TANOA" || _par_opfWeap == 20) then {
	_primaryweapon = ["arifle_CTAR_blk_F"];
	_silencer = "";
};

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
_primaryweaponAmmo = [4,0];

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
_handgun = "hgun_Rook40_F";

//handgun items - (array)
_itemsHandgun = [];
_handgunSilencer = "muzzle_snds_L";		//if silencer is added

//handgun ammo (if a handgun is given) - (integer)
_handgunAmmo = [3,0];

//weapons - launcher - (string)
_launcher = "";

//launcher ammo (if a launcher is given) - (integer) 
_launcherAmmo = [0,0];

//binocular - (string)
_binocular = "";

//throwables - (integer)
_grenadeSet = 0;		//contains 2 HE grenades, 1 white and one coloured smoke grenade and 1 red chemlight. Select 0 if you want to define your own grenades.
_grenades = ["RED","RED"];		//depending on the custom loadout the colours may be merged.
_chemlights = ["RED"];
_IRgrenade = 0;

//first aid kits and medi kits- (integer)
_FirstAidKits = 2;
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
if ( (304400 in (getDLCs 1) || 332350 in (getDLCs 1)) && (missionNamespace getVariable ["adv_par_DLCContent",1]) > 0 ) then {
};

	//CustomMod items//
	
//TFAR or ACRE radios
_giveRiflemanRadio = true;
_givePersonalRadio = true;
_giveBackpackRadio = false;
_tfar_microdagr = 0;				//adds the tfar microdagr to set the channels for a rifleman radio

//ACE items (if ACE is running on the server) - (integers)
_ACE_EarPlugs = 1;

_ace_FAK = 1;		//Adds a standard amount of medical items. Defined in fn_aceFAK.sqf
_ACE_fieldDressing = 0;
_ACE_packingBandage = 0;
_ACE_elasticBandage = 0;
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
_ACE_personalAidKit = 0;
_ACE_surgicalKit = 0;

_ACE_SpareBarrel = 0;
_ACE_UAVBattery = 0;
_ACE_wirecutter = 0;
_ACE_Clacker = 0;
_ACE_M26_Clacker = 0;
_ACE_DeadManSwitch = 0;
_ACE_DefusalKit = 0;
_ACE_Cellphone = 0;
_ACE_FlareTripMine = 0;
_ACE_MapTools = 1;
_ACE_CableTie = 2;
_ACE_EntrenchingTool = 0;
_ACE_sprayPaintColor = "NONE";
_ACE_gunbag = 0;

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
_ACE_isMedic = 0;		//0 = no medic; 1 = medic; 2 = doctor;
_ACE_isEngineer = 2;	//0 = no specialist; 1 = engineer; 2 = repair specialist;
_ACE_isEOD = false;
_ACE_isPilot = true;

//Tablet-Items
_tablet = false;
_androidDevice = true;
_microDAGR = false;
_helmetCam = false;

//scorch inv items
_scorchItems = [""];
_scorchItemsRandom = ["sc_cigarettepack","sc_chips","sc_candybar","","",""];

//Addon Content:
switch (_par_opfWeap) do {
	case 1: {
		//RHS
		_primaryweapon = ["rhs_weap_ak74m_folded","rhs_weap_ak74m_plummag_folded","rhs_weap_ak74m_camo_folded","rhs_weap_ak74m_desert_folded"];
		_optic = [""];
		_attachments = [""];
		_silencer = "";		//if silencer is added
		_handgun = "rhs_weap_makarov_pmm";
		_itemsHandgun = [];
		_handgunSilencer = "";
	};
	case 2: {
		//RHS Guerilla
		_primaryweapon = ["rhs_weap_akms"];
		_optic = [""];
		_attachments = [""];
		_silencer = "";		//if silencer is added		
		_handgun = "";
		_itemsHandgun = [];
		_handgunSilencer = "";
	};
	case 3: {
		//CUP
		_primaryweapon = "CUP_arifle_AKS74U";
		_optic = [""];
		_attachments = [""];
		_silencer = "";		//if silencer is added
		_handgun = "CUP_hgun_PB6P9";
		_itemsHandgun = [];
		_handgunSilencer = "CUP_muzzle_PB6P9";
	};
	case 4: {
		//HLC AK
		_primaryweapon = ["hlc_rifle_aks74u"];
		_optic = [""];
		_attachments = [""];
		_silencer = "hlc_muzzle_545SUP_AK";		//if silencer is added		
		if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
			_handgun = "RH_mak";
			_itemsHandgun = [""];
			_handgunSilencer = "RH_pmsd";
		};
	};
	case 21: {
		//Apex AK12
		_primaryWeapon = "arifle_AK12_F";
	};
	default {};
};
switch (_par_opfUni) do {
	case 1: {
		//RHS EMR-Summer
		_uniform = ["rhs_uniform_emr_patchless"];
		_vest = ["rhs_6b23_digi_crewofficer","rhs_6b23_digi_crew","rhs_6b23_digi_engineer","rhs_6b23_crewofficer","rhs_6b23_crew","rhs_6b23_engineer"];
		_headgear = ["rhs_tsh4","rhs_tsh4_bala","rhs_tsh4_ess","rhs_tsh4_ess_bala"];
		_backpack = ["rhs_assault_umbts_engineer"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhs_1PN138"];
	};
	case 2: {
		//RHS Flora
		_uniform = ["rhs_uniform_flora_patchless"];
		_vest = ["rhs_6b23_digi_crewofficer","rhs_6b23_digi_crew","rhs_6b23_digi_engineer","rhs_6b23_crewofficer","rhs_6b23_crew","rhs_6b23_engineer"];
		_headgear = ["rhs_tsh4","rhs_tsh4_bala","rhs_tsh4_ess","rhs_tsh4_ess_bala"];
		_backpack = ["rhs_assault_umbts_engineer"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhs_1PN138"];
	};
	case 3: {
		//RHS Mountain Flora
		_uniform = ["rhs_uniform_m88_patchless"];
		_vest = ["rhs_6b23_ML_crewofficer","rhs_6b23_ML_crew","rhs_6b23_ML_engineer","rhs_6b23_crewofficer","rhs_6b23_crew","rhs_6b23_engineer"];
		_headgear = ["rhs_tsh4","rhs_tsh4_bala","rhs_tsh4_ess","rhs_tsh4_ess_bala"];
		_backpack = ["rhs_assault_umbts_engineer"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhs_1PN138"];
	};
	case 4: {
		//RHS EMR Desert
		_uniform = ["rhs_uniform_emr_des_patchless"];
		_vest = ["rhs_6b23_ML_crewofficer","rhs_6b23_ML_crew","rhs_6b23_ML_engineer","rhs_6b23_crewofficer","rhs_6b23_crew","rhs_6b23_engineer"];
		_headgear = ["rhs_tsh4","rhs_tsh4_bala","rhs_tsh4_ess","rhs_tsh4_ess_bala"];
		_backpack = ["rhs_assault_umbts_engineer"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhs_1PN138"];
	};
	case 5: {
		//Guerilla
		_uniform = ["U_OG_Guerrilla_6_1","U_OG_Guerilla2_2","U_OG_Guerilla2_1","U_OG_Guerilla2_3","U_OG_Guerilla3_1"];
		_headgear = ["H_Watchcap_cbr","H_Watchcap_camo","H_Booniehat_khk","H_Booniehat_oli","H_Cap_blk","H_Cap_oli","H_Cap_tan","H_Cap_brn_SPECOPS","H_MilCap_ocamo",
			"H_Cap_headphones","H_ShemagOpen_tan"];
		_giveRiflemanRadio = true;
		_givePersonalRadio = false;
	};
	case 6: {
		//CUP Taliban
		_uniform = ["CUP_O_TKI_Khet_Partug_01","CUP_O_TKI_Khet_Partug_02","CUP_O_TKI_Khet_Partug_03","CUP_O_TKI_Khet_Partug_04"
			,"CUP_O_TKI_Khet_Partug_05","CUP_O_TKI_Khet_Partug_06","CUP_O_TKI_Khet_Partug_07","CUP_O_TKI_Khet_Partug_08"];
		_vest = ["CUP_V_I_Guerilla_Jacket","CUP_V_OI_TKI_Jacket4_01","CUP_V_OI_TKI_Jacket4_02","CUP_V_OI_TKI_Jacket4_03","CUP_V_OI_TKI_Jacket4_04","CUP_V_OI_TKI_Jacket4_05","CUP_V_OI_TKI_Jacket4_06"
			,"CUP_V_OI_TKI_Jacket5_01","CUP_V_OI_TKI_Jacket5_02","CUP_V_OI_TKI_Jacket5_03","CUP_V_OI_TKI_Jacket5_04","CUP_V_OI_TKI_Jacket5_05","CUP_V_OI_TKI_Jacket5_06"
			,"CUP_V_OI_TKI_Jacket3_01","CUP_V_OI_TKI_Jacket3_02","CUP_V_OI_TKI_Jacket3_03","CUP_V_OI_TKI_Jacket3_04","CUP_V_OI_TKI_Jacket3_05","CUP_V_OI_TKI_Jacket3_06"
			,"CUP_V_OI_TKI_Jacket2_01","CUP_V_OI_TKI_Jacket2_02","CUP_V_OI_TKI_Jacket2_03","CUP_V_OI_TKI_Jacket2_04","CUP_V_OI_TKI_Jacket2_05","CUP_V_OI_TKI_Jacket2_06"
		];
		_backpack = ["CUP_B_HikingPack_Civ","CUP_B_AlicePack_Khaki","CUP_B_AlicePack_Bedroll","CUP_B_CivPack_WDL"];
		_headgear = ["CUP_H_TK_Lungee","CUP_H_TKI_Lungee_Open_02","CUP_H_TKI_Lungee_Open_05","CUP_H_TKI_Lungee_Open_06","CUP_H_TKI_Lungee_01","CUP_H_TKI_Lungee_04","CUP_H_TKI_Lungee_05","CUP_H_TKI_Lungee_06"
			,"CUP_H_TKI_Pakol_1_01","CUP_H_TKI_Pakol_1_02","CUP_H_TKI_Pakol_1_03","CUP_H_TKI_Pakol_1_04","CUP_H_TKI_Pakol_1_05","CUP_H_TKI_Pakol_1_06"
			,"CUP_H_TKI_Pakol_2_01","CUP_H_TKI_Pakol_2_02","CUP_H_TKI_Pakol_2_03","CUP_H_TKI_Pakol_2_04","CUP_H_TKI_Pakol_2_05","CUP_H_TKI_Pakol_2_06"
		];
		_goggles = "";
		_useProfileGoggles = 0;
		_giveRiflemanRadio = false;
		_givePersonalRadio = false;
		_giveBackpackRadio = false;
	};
	case 20: {
		//Apex Green Hex
		_uniform = ["U_O_T_Officer_F"];
		_vest = ["V_TacVest_oli"];
		_headgear = ["H_HelmetO_ghex_F","H_HelmetSpecO_ghex_F"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["NVGoggles_tna_F"];
	};
	default {};
};

switch (toUpper ([str (_this select 0),3,10] call BIS_fnc_trimString)) do {
	case "LOG_COM": {
		if !( _par_opfUni in [6,5] ) then {
			_giveBackpackRadio = true;
		};
	};
	case "LOG_LEA": {
		_tablet = false;
		if !( _par_opfUni in [6,5] ) then {
			_giveBackpackRadio = true;
		};
	};
};

//LRRadios
if (missionNamespace getVariable ["_par_noLRRadios",false]) then { _giveBackpackRadio = false };
if ( isClass(configFile >> "CfgPatches" >> "task_force_radio") && (_par_Radios == 1 || _par_Radios == 3) && _giveBackpackRadio ) then {
	_backpack = switch (_par_opfUni) do {
		case 1: {["tfar_mr3000_rhs"]};
		case 2: {["tfar_mr3000_rhs"]};
		case 3: {["tfar_mr3000_rhs"]};
		case 4: {["tfar_mr3000_rhs"]};
		case 5: {[""]};
		default {["tfar_mr3000"]};
	};
};
if ( isClass (configFile >> "CfgPatches" >> "acre_main") && (_par_Radios == 1 || _par_Radios == 3) && _giveBackpackRadio ) then {
	_backpack = switch (_par_opfUni) do {
		case 1: {"rhs_assault_umbts"};
		case 2: {"rhs_assault_umbts"};
		case 3: {"rhs_assault_umbts"};
		case 4: {"rhs_assault_umbts"};
		case 5: {"B_AssaultPack_blk"};
		case 6: {"rhs_sidor"};
		case 20: {"B_AssaultPack_tna_F"};
		default {"B_AssaultPack_blk"};
	};
};

///// No editing necessary below this line /////

[_player] call ADV_fnc_gear;
CL_IE_Module_Enabled = true;

true;
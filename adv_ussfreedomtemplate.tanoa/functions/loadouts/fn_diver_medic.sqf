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
 * [player] call adv_fnc_diver_medic;
 *
 * Public: No
 */

//clothing - (string)
_uniform = ["U_B_Wetsuit"];
_vest = ["V_RebreatherB"];
_headgear = [""];
_backpack = ["B_FieldPack_blk"];
_insignium = "";
_useProfileGoggles = 0;		//If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "G_B_Diving";
_unitTraits = [["medic",true],["engineer",true],["explosiveSpecialist",true],["UAVHacker",true],["camouflageCoef",1.2],["audibleCoef",0.5]];

//weapons - primary weapon - (string)
_primaryweapon = "arifle_SDAR_F";

//primary weapon items - (array)
_optic = [""];
_attachments = [""];
_silencer = "";		//if silencer is added

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
_primaryweaponAmmo = [3,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.
_additionalAmmo = [6,"30Rnd_556x45_Stanag",true];

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
_itemsHandgun = ["optic_MRD","muzzle_snds_acp"];
_handgunSilencer = "";		//if silencer is added

//handgun ammo (if a handgun is given) - (integer)
_handgunAmmo = [2,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//weapons - launcher - (string)
_launcher = "";

//launcher ammo (if a launcher is given) - (integer) 
_launcherAmmo = [0,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//binocular - (string)
_binocular = "Rangefinder";

//throwables - (integer)
_grenadeSet = 0;		//contains 2 HE grenades, 1 white and one coloured smoke grenade and 1 red chemlight. Select 0 if you want to define your own grenades.
_grenades = ["WHITE","WHITE","RED"];		//depending on the custom loadout the colours may be merged.
_chemlights = ["RED"];
_IRgrenade = 1;

//first aid kits and medi kits- (integer)
_FirstAidKits = 8;
_MediKit = 1;		//if set to 1, a MediKit and all FirstAidKits will be added to the backpack; if set to 0, FirstAidKits will be added to inventory in no specific order.

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

_ace_FAK = 2;		//Adds a standard amount of medical items. Defined in fn_aceFAK.sqf
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
_ACE_surgicalKit = 1;
_ACE_personalAidKit = 1;

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
_ACE_MapTools = 1;
_ACE_CableTie = 2;
_ACE_sprayPaintColor = "NONE";
_ACE_gunbag = 0;

_ACE_key = 0;	//0 = no key, 1 = side dependant key, 2 = master key, 3 = lockpick
_ACE_flashlight = 1;
_ACE_kestrel = 0;
_ACE_altimeter = 1;
_ACE_ATragMX = 0;
_ACE_rangecard = 0;
_ACE_microDAGR = 1;
_ACE_DAGR = 0;
_ACE_RangeTable_82mm = 0;
_ACE_MX2A = 0;
_ACE_HuntIR_monitor = 0;
_ACE_HuntIR = 0;
_ACE_m84 = 0;
_ACE_HandFlare_Green = 0;
_ACE_HandFlare_Red = 1;
_ACE_HandFlare_White = 0;
_ACE_HandFlare_Yellow = 0;

//AGM Variables (if AGM is running) - (bool)
_ACE_isMedic = 2;		//0 = no medic; 1 = medic; 2 = doctor;
_ACE_isEngineer = 0;	//0 = no specialist; 1 = engineer; 2 = repair specialist;
_ACE_isEOD = false;
_ACE_isPilot = false;

//Tablet-Items
_tablet = false;
_androidDevice = true;
_microDAGR = false;
_helmetCam = false;

//scorch inv items
_scorchItems = ["sc_dogtag"];
_scorchItemsRandom = [""];

//Addon Content:
switch (_par_customWeap) do {
	case 1: {
		//BWmod
		call {
			if (isClass(configFile >> "CfgPatches" >> "hlcweapons_g36")) exitWith {
				_primaryWeapon = ["hlc_rifle_g36KTac"];
				if (isClass(configFile >> "CfgPatches" >> "adv_hlcG36_bwmod")) then { _primaryweaponAmmo = [7,4] };
				_attachments = ["BWA3_acc_VarioRay_irlaser","hlc_muzzle_556NATO_KAC"];
			};
			_primaryweapon = "BWA3_G36K";
			_primaryweaponAmmo = [8,4];
			_attachments = ["BWA3_acc_VarioRay_irlaser","BWA3_muzzle_snds_G36"];
		};
		_additionalAmmo = nil;
		_optic = ["BWA3_optic_EOTech_Mag_Off"];
		_handgun = "BWA3_P8";
		_itemsHandgun = [""];
	};
	case 2: {
		//RHS Army
		_primaryweapon = ["rhs_weap_m4a1_blockII_KAC","rhs_weap_m4a1_blockII"];
		_optic = ["rhsusf_acc_eotech_552"];
		_attachments = ["rhsusf_acc_anpeq15","rhsusf_acc_rotex5_grey"];
		_attachments pushBack (["","rhsusf_acc_grip2"] call BIS_fnc_selectRandom);
		_primaryweaponAmmo = [8,9];
		_additionalAmmo = nil;
		_handgun = "rhsusf_weap_m9";
		_itemsHandgun = [""];
		_handgunSilencer = "";
		if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
			_handgun = "RH_m9";
			_itemsHandgun = ["RH_x300","RH_m9qd"];
		};
	};
	case 3: {
		//RHS Marines
		_primaryweapon = ["rhs_weap_mk18_grip2","rhs_weap_mk18_grip2_KAC","rhs_weap_mk18_KAC"];
		_optic = ["rhsusf_acc_eotech_552"];
		_attachments = ["rhsusf_acc_anpeq15","rhsusf_acc_rotex5_grey"];
		if (isClass(configFile >> "CfgPatches" >> "hlcweapons_mp5") && _par_Silencers == 1) then {
			_primaryweapon = "hlc_smg_mp5sd6"; _silencer = "";
			_attachments = [""];
			_primaryweaponAmmo = [8,2];
			_additionalAmmo = nil;
		} else {
			_primaryweaponAmmo = [8,9];
			_additionalAmmo = nil;
			_attachments pushBack (["","rhsusf_acc_grip2"] call BIS_fnc_selectRandom);
		};
		_handgun = "rhsusf_weap_m1911a1";
		_itemsHandgun = [""];
		_handgunSilencer = "";
		if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
			_handgun = "RH_m9";
			_itemsHandgun = ["RH_x300","RH_m9qd"];
		};
	};
	case 4: {
		//RHS SOF
		_primaryweapon = ["rhs_weap_hk416d10","rhs_weap_hk416d10_LMT"];
		_optic = ["rhsusf_acc_eotech_552"];
		_attachments = ["rhsusf_acc_anpeq15","rhsusf_acc_rotex5_grey"];
		_attachments pushBack (["","rhsusf_acc_grip2"] call BIS_fnc_selectRandom);
		_primaryweaponAmmo = [8,9];
		_additionalAmmo = nil;
		_handgun = "rhsusf_weap_m9";
		_itemsHandgun = [""];
		_handgunSilencer = "";
		if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
			_handgun = "RH_m9";
			_itemsHandgun = ["RH_x300","RH_m9qd"];
		};
	};
	case 5: {
		//SELmods CUP Mk16
		_primaryweapon = "CUP_arifle_M4A3_desert";
		_optic = ["CUP_optic_CompM4"];
		_attachments = ["CUP_acc_ANPEQ_2_camo","CUP_muzzle_snds_M16_camo"];
		_primaryweaponAmmo = [8,0];
		_additionalAmmo = nil;
		_handgun="CUP_hgun_M9";
		_itemsHandgun=["CUP_muzzle_snds_M9"];
	};
	case 6: {
		//SELmods CUP M4
		_primaryweapon = "CUP_arifle_M4A1_camo";
		_optic = ["CUP_optic_CompM4"];
		_attachments = ["CUP_acc_ANPEQ_2_camo","CUP_muzzle_snds_M16_camo"];
		_primaryweaponAmmo = [8,0];
		_additionalAmmo = nil;
		_handgun="CUP_hgun_M9";
		_itemsHandgun=["CUP_muzzle_snds_M9"];
	};
	case 7: {
		//BAF
		_primaryweapon = "CUP_arifle_M4A1_camo";
		_optic = ["CUP_optic_CompM4"];
		_attachments = ["CUP_acc_ANPEQ_2_camo","CUP_muzzle_snds_M16_camo"];
		_primaryweaponAmmo = [8,0];
		_additionalAmmo = nil;
		_handgun="CUP_hgun_Glock17";
		_itemsHandgun=["CUP_acc_Glock17_Flashlight","muzzle_snds_L"];
	};
	case 8: {
		//UK3CB
		_primaryweapon = ["UK3CB_BAF_L85A2_RIS_AFG","UK3CB_BAF_L85A2_EMAG","UK3CB_BAF_L85A2_RIS"];
		_optic = ["UK3CB_BAF_SUSAT_3D"];
		_attachments = ["UK3CB_BAF_LLM_IR_Black","UK3CB_BAF_Silencer_L85"];
		_primaryweaponAmmo = [8,2];
		_additionalAmmo = nil;
		_handgun = "UK3CB_BAF_L131A1";
		_itemsHandgun=["UK3CB_BAF_Flashlight_L131A1","muzzle_snds_L"];
	};
	default {};
};
switch (_par_customUni) do {
	case 1: {
		//BWmod Tropen
		_backpack = ["BWA3_Kitbag_Fleck_Medic"];
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _items = _items-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 2: {
		//BWmod Fleck
		_backpack = ["BWA3_Kitbag_Fleck_Medic"];
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _items = _items-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 9: {
		_giveRiflemanRadio = true;
		_givePersonalRadio = false;
	};
	case 20: {
		//APEX NATO
		_headgear = ["H_Helmet_Skate"];
		_items = _items-["NVGoggles_OPFOR"]+["NVGoggles_tna_F"];
	};
	default {};
};

///// No editing necessary below this line /////

[_player] call ADV_fnc_gear;

true;
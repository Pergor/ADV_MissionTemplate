/*
unit loadout script by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set _primaryweaponAmmo to 0 and add those
magazines one for one in _items.
*/

//clothing - (string)
_uniform = ["U_B_Wetsuit"];
_vest = ["V_RebreatherB"];
_headgear = [""];
_backpack = ["B_AssaultPack_blk"];
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
_handgunAmmo = [4,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

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
};

if (missionNamespace getVariable ["ADV_par_isTvT",false]) then {
};

//ACRE radios
_ACREradios = ["ACRE_PRC343","ACRE_PRC148"];	//_this select 0=shortrange radio;_this select 1=leader radio;_this select 2=backpackRadio;
//TFAR items
_givePersonalRadio = true;
_giveRiflemanRadio = false;
_tfar_microdagr = 0;				//adds the tfar microdagr to set the channels for a rifleman radio

//ACE items (if ACE is running on the server) - (integers)
_ACE_EarPlugs = 1;

_ace_FAK = 0;		//overwrites the values for bandages, morphine and tourniquet and adds a specified number of bandages and morphine. Defined in fn_aceFAK.sqf
_ACE_fieldDressing = 3;
_ACE_packingBandage = 8;
_ACE_elasticBandage = 8;
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

_ACE_key = 3;	//0 = no key, 1 = side dependant key, 2 = master key, 3 = lockpick
_ACE_flashlight = 1;
_ACE_kestrel = 0;
_ACE_altimeter = 1;
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
_ACE_HandFlare_Red = 1;
_ACE_HandFlare_White = 0;
_ACE_HandFlare_Yellow = 0;

//AGM Variables (if AGM is running) - (bool)
_ACE_isMedic = 1;	//0 = no medic; 1 = medic; 2 = doctor;
_ACE_isEngineer = 0;	//0 = no specialist; 1 = engineer; 2 = repair specialist;
_ACE_isEOD = true;
_ACE_isPilot = false;

//Tablet-Items
_tablet = false;
_androidDevice = true;
_microDAGR = false;
_helmetCam = true;

//scorch inv items
_scorchItems = ["sc_dogtag"];
_scorchItemsRandom = [""];

//Addon Content:
switch (ADV_par_customWeap) do {
	case 1: {
		//BWmod
		if (isClass(configFile >> "CfgPatches" >> "hlcweapons_g36")) then {
			_primaryWeapon = ["hlc_rifle_g36KTac"];
			if (isClass(configFile >> "CfgPatches" >> "adv_hlcG36_bwmod")) then { _primaryweaponAmmo = [7,8] };
		} else {
			_primaryweapon = "BWA3_G36K";
			_primaryweaponAmmo = [7,3];
		};
		_additionalAmmo = nil;
		_optic = ["BWA3_optic_EOTech_Mag_Off"];
		_attachments = ["BWA3_acc_VarioRay_irlaser","BWA3_muzzle_snds_G36"];
		_handgun = "BWA3_P8";
		_itemsHandgun = [""];
	};
	case 2: {
		//RHS Army
		_primaryweapon = ["rhs_weap_m4a1_blockII_KAC","rhs_weap_m4a1_blockII"];
		_optic = ["rhsusf_acc_eotech_552"];
		_attachments = ["rhsusf_acc_anpeq15","rhsusf_acc_rotex5_grey"];
		_attachments pushBack (["","rhsusf_acc_grip2"] call BIS_fnc_selectRandom);
		_primaryweaponAmmo = [7,9];
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
		if (isClass(configFile >> "CfgPatches" >> "hlcweapons_mp5") && ADV_par_Silencers == 1) then {
			_primaryweapon = "hlc_smg_mp5sd6"; _silencer = "";
			_attachments = [""];
			_primaryweaponAmmo set [1,2];
			_additionalAmmo = nil;
		} else {
			_primaryweaponAmmo = [7,9];
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
		_primaryweaponAmmo = [7,9];
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
		_primaryweaponAmmo = [7,9];
		_additionalAmmo = nil;
		_handgun="CUP_hgun_M9";
		_itemsHandgun=["CUP_muzzle_snds_M9"];
	};
	case 6: {
		//SELmods CUP M4
		_primaryweapon = "CUP_arifle_M4A3_desert";
		_optic = ["CUP_optic_CompM4"];
		_attachments = ["CUP_acc_ANPEQ_2_camo","CUP_muzzle_snds_M16_camo"];
		_primaryweaponAmmo = [7,9];
		_additionalAmmo = nil;
		_handgun="CUP_hgun_M9";
		_itemsHandgun=["CUP_muzzle_snds_M9"];
	};
	case 7: {
		//BAF
		_primaryweapon = "CUP_arifle_M4A3_desert";
		_optic = ["CUP_optic_CompM4"];
		_attachments = ["CUP_acc_ANPEQ_2_camo","CUP_muzzle_snds_M16_camo"];
		_primaryweaponAmmo = [7,9];
		_additionalAmmo = nil;
		_handgun="CUP_hgun_Glock17";
		_itemsHandgun=["CUP_acc_Glock17_Flashlight","muzzle_snds_L"];
	};
	case 8: {
		//UK3CB
		_primaryweapon = ["UK3CB_BAF_L85A2_RIS_AFG","UK3CB_BAF_L85A2_EMAG","UK3CB_BAF_L85A2_RIS"];
		_optic = ["UK3CB_BAF_SUSAT_3D"];
		_attachments = ["UK3CB_BAF_LLM_IR_Black","UK3CB_BAF_Silencer_L85"];
		_primaryweaponAmmo = [7,2];
		_additionalAmmo = nil;
		_handgun = "UK3CB_BAF_L131A1";
		_itemsHandgun=["UK3CB_BAF_Flashlight_L131A1","muzzle_snds_L"];
	};
	default {};
};
switch (ADV_par_customUni) do {
	case 1: {
		//BWmod Tropen
		_backpack = ["BWA3_AssaultPack_Fleck"];
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _items = _items-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 2: {
		//BWmod Fleck
		_backpack = ["BWA3_AssaultPack_Fleck"];
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _items = _items-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 3: {
		//TFA Mixed
		_backpack = ["TFA_assault_Blk"];
	};
	case 4: {
		//TFA Woodland
		_backpack = ["TFA_assault_Blk"];
	};
	case 5: {
		//TFA Desert
		_backpack = ["TFA_assault_Blk"];
	};
	case 6: {
		//TFA ACU
		_backpack = ["TFA_assault_Blk"];
	};
	default {};
};

///// No editing necessary below this line /////

_player = _this select 0;
[_player] call ADV_fnc_gear;

true;
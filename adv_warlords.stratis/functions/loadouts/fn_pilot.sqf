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
 * [player] call adv_fnc_pilot;
 *
 * Public: No
 */

//clothing - (string)
_uniform = ["U_B_HeliPilotCoveralls"];
_vest = ["V_TacVest_blk"];
_headgear = ["H_CrewHelmetHeli_B","H_PilotHelmetHeli_B"];
_backpack = ["B_Parachute"];
_insignium = "";
_useProfileGoggles = 0;		//If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "G_Aviator";
_unitTraits = [["medic",false],["engineer",false],["explosiveSpecialist",false],["UAVHacker",false],["camouflageCoef",1.0],["audibleCoef",1.0]];

//weapons - primary weapon - (string)
_primaryweapon = "SMG_01_F";

//primary weapon items - (array)
_optic = [""];
_attachments = [""];
_silencer = "muzzle_snds_acp";		//if silencer is added

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
_itemsHandgun = ["optic_MRD"];
_handgunSilencer = "muzzle_snds_acp";		//if silencer is added

//handgun ammo (if a handgun is given) - (integer)
_handgunAmmo = [4,0];

//weapons - launcher - (string)
_launcher = "";

//launcher ammo (if a launcher is given) - (integer) 
_launcherAmmo = [0,0];

//binocular - (string)
_binocular = "Binocular";

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
if ( (304400 in (getDLCs 1) || 332350 in (getDLCs 1)) && (missionNamespace getVariable ["adv_par_DLCContent",1]) > 0 ) then {
};

	//CustomMod items//
	
//TFAR or ACRE radios
_giveRiflemanRadio = true;
_givePersonalRadio = true;
_giveBackpackRadio = false;
_tfar_microdagr = 0;		//adds the tfar microdagr to set the channels for a rifleman radio

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
_ACE_FlareTripMine = 1;
_ACE_MapTools = 1;
_ACE_CableTie = 0;
_ACE_sprayPaintColor = "NONE";
_ACE_gunbag = 0;

_ACE_key = 1;	//0 = no key, 1 = side dependant key, 2 = master key, 3 = lockpick
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
_ACE_HandFlare_Red = 0;
_ACE_HandFlare_White = 0;
_ACE_HandFlare_Yellow = 0;

//AGM Variables (if AGM is running) - (bool)
_ACE_isMedic = 1;	//0 = no medic; 1 = medic; 2 = doctor;
_ACE_isEngineer = 0;	//0 = no specialist; 1 = engineer; 2 = repair specialist;
_ACE_isEOD = false;
_ACE_isPilot = true;

//Tablet-Items
_tablet = false;
_androidDevice = true;
_microDAGR = false;
_helmetCam = false;

//scorch inv items
_scorchItems = ["sc_dogtag"];
_scorchItemsRandom = ["sc_cigarettepack","sc_candybar",""];

//Addon Content:
switch (true) do {
	case (_par_customWeap == 1): {
		//BWmod
		_primaryweapon = "";
		_optic = [""];
		_attachments = [""];
		_silencer = "";		//if silencer is added
		_primaryweaponAmmo = [0,0];
		_handgun = "BWA3_MP7";
		if ( _par_optics == 1 ) then { _itemsHandgun = ["BWA3_optic_RSAS"]; } else { _itemsHandgun = [""]; };
		_handgunSilencer = "BWA3_muzzle_snds_MP7";		//if silencer is added
		_handgunAmmo set [0,5];
	};
	case (_par_customWeap == 2 || _par_customWeap == 3): {
		//SELmods
		_primaryweapon = "";
		_optic = [""];
		_attachments = [""];
		_silencer = "";		//if silencer is added
		if (isClass(configFile >> "CfgPatches" >> "hlcweapons_mp5")) then {
			_primaryweapon = ["hlc_smg_MP5N","hlc_smg_mp5k_PDW","hlc_smg_mp5a3"];
			_silencer = "hlc_muzzle_Tundra";
			if (_par_Silencers == 1) then { _primaryweapon = "hlc_smg_mp5sd6"; _silencer = ""; _primaryweaponAmmo set [1,2]; };
		} else {
			_handgunAmmo = [5,0]
		};
		_handgun = "rhsusf_weap_m9";
		if (_par_customWeap == 3) then { _handgun = "rhsusf_weap_m1911a1"; };
		_itemsHandgun = [""];
		_handgunSilencer = "";
	};
	case (_par_customWeap == 4): {
		//SELmods
		_primaryweapon = "";
		_optic = [""];
		_attachments = [""];
		_silencer = "";		//if silencer is added
		if (isClass(configFile >> "CfgPatches" >> "hlcweapons_mp5")) then {
			_primaryweapon = ["hlc_smg_MP5N","hlc_smg_mp5k_PDW","hlc_smg_mp5a3"];
			_silencer = "hlc_muzzle_Tundra";
			if (_par_Silencers == 1) then { _primaryweapon = "hlc_smg_mp5sd6"; _silencer = ""; _primaryweaponAmmo set [1,2]; };
		} else {
			_handgunAmmo = [5,0]
		};
		_handgun = "rhsusf_weap_m9";
		_itemsHandgun = [""];
		_handgunSilencer = "";
	};
	case (_par_customWeap == 5 || _par_customWeap == 6): {
		//CUP
		_primaryweapon = "CUP_smg_MP5A5";
		_optic = [""];
		_attachments = [""];
		_silencer = "";		//if silencer is added
		if (_par_Silencers == 1) then {_primaryweapon="CUP_smg_MP5SD6"};
		_handgun="CUP_hgun_M9";
		_itemsHandgun=[];
		_handgunSilencer = "CUP_muzzle_snds_M9";		//if silencer is added
	};
	case (_par_customWeap == 7): {
		//CUP BAF
		_primaryweapon = "CUP_smg_MP5A5";
		_optic = [""];
		_attachments = [""];
		_silencer = "";		//if silencer is added
		if (_par_Silencers == 1) then { _primaryweapon="CUP_smg_MP5SD6"; };
		_handgun="CUP_hgun_Glock17";
		_itemsHandgun=["CUP_acc_Glock17_Flashlight"];
		_handgunSilencer = "muzzle_snds_L";		//if silencer is added
	};
	case (_par_customWeap == 8): {
		//UK3CB
		_primaryweapon = "UK3CB_BAF_L91A1";
		if (_par_Silencers == 1) then { _primaryweapon = "UK3CB_BAF_L92A1" };
		_optic = [""];
		_attachments = [""];
		_silencer = "";
		_handgun = "UK3CB_BAF_L131A1";
		_itemsHandgun=["UK3CB_BAF_Flashlight_L131A1"];
		_handgunSilencer = "muzzle_snds_L";
	};
	case (_par_customWeap == 9): {
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
	case (_par_customWeap == 20): {
		_primaryweapon = "SMG_05_F";
		_silencer = "muzzle_snds_L";
	};
	default {};
};
switch (true) do {
	case (_par_customUni == 1) : {
		//BWmod Tropen
		_uniform = ["BWA3_Uniform_Helipilot"];
		_vest = ["BWA3_Vest_Tropen"];
		_headgear = ["BWA3_Knighthelm"];
		if (isClass(configFile >> "CfgPatches" >> "PBW_German_Common")) then {
			_items pushback "PBW_muetze1_tropen";
		};
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case (_par_customUni == 2): {
		//BWmod Fleck
		_uniform = ["BWA3_Uniform_Helipilot"];
		_vest = ["BWA3_Vest_Fleck"];
		_headgear = ["BWA3_Knighthelm"];
		if (isClass(configFile >> "CfgPatches" >> "PBW_German_Common")) then {
			_items pushback "PBW_muetze1_fleck";
		};
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};	
	case (_par_customUni in [7,8,10]): {
		_headgear = ["rhsusf_hgu56p_black","rhsusf_hgu56p_visor_black","rhsusf_hgu56p_green","rhsusf_hgu56p_visor_green","rhsusf_hgu56p","rhsusf_hgu56p_visor","rhsusf_hgu56p_saf","rhsusf_hgu56p_visor_saf"];
	};
	case (_par_customUni == 9): {
		_giveRiflemanRadio = true;
		_givePersonalRadio = false;
	};
	case (_par_customUni == 12): {
		_uniform = ["UK3CB_BAF_U_HeliPilotCoveralls_RN"];
		_vest = ["UK3CB_BAF_V_Pilot_A"];
		_headgear = ["UK3CB_BAF_H_PilotHelmetHeli_A"];
	};
	case (_par_customUni isEqualTo 13): {
		_uniform = ["CUP_U_B_USMC_PilotOverall","CUP_U_I_RACS_PilotOverall"];
		_vest = ["CUP_V_B_PilotVest"];
		_headgear = ["CUP_H_USMC_Helmet_Pilot","CUP_H_TK_PilotHelmet","CUP_H_BAF_Helmet_Pilot"];
	};
	case (_par_customUni == 14): {
		//Tryks
		_uniform = ["TRYK_HRP_USMC"];
		_vest = ["TRYK_Hrp_vest_od"];
	};
	default {};
};

///// No editing necessary below this line /////

[_player] call ADV_fnc_gear;
CL_IE_Module_Enabled = true;

true;
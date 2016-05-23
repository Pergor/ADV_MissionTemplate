/*
unit loadout script by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set _primaryweaponAmmo to 0 and add those
magazines one for one in _items.
*/

//clothing - (string)
_uniform = ["U_I_GhillieSuit"];
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
if ( ADV_par_NVGs == 1 ) then { _attachments pushBack "acc_flashlight"; };
if ( ADV_par_NVGs == 2 ) then { _attachments pushback "acc_pointer_IR"; };
_silencer = "";		//if silencer is added

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
_primaryweaponAmmo = [7,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.
_additionalAmmo = [5,"7Rnd_408_Mag",true];

//40mm Grenades - (integer)
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
		case ((toUpper worldname) == "ALTIS"): {["U_I_FullGhillie_ard","U_I_FullGhillie_sard"]};
		case ((toUpper worldname) in ADV_var_aridMaps): {["U_I_FullGhillie_ard"]};
		case ((toUpper worldname) in ADV_var_sAridMaps): {["U_I_FullGhillie_sard"]};
		case ((toUpper worldname) in ADV_var_lushMaps): {["U_I_FullGhillie_lsh"]};
		default {["U_I_FullGhillie_lsh","U_I_FullGhillie_sard"]};
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

_ace_FAK = 0;		//overwrites the values for bandages, morphine and tourniquet and adds a specified number of bandages and morphine. Defined in fn_aceFAK.sqfs
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
_ACE_surgicalKit = 0;

_ACE_SpareBarrel = 0;
_ACE_UAVBattery = 0;
_ACE_wirecutter = 0;
_ACE_Clacker = 0;
_ACE_M26_Clacker = 0;
_ACE_DeadManSwitch = 0;
_ACE_DefusalKit = 1;
_ACE_Cellphone = 0;
_ACE_MapTools = 1;
_ACE_CableTie = 2;
_ACE_EntrenchingTool = 0;
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

//AGM Variables (if AGM is running) - (bool)
_ACE_isMedic = 1;		//0 = no medic; 1 = medic; 2 = doctor;
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
switch (ADV_par_indWeap) do {
	case 1: {
		//Vanilla Mk20
		_primaryWeapon = ["arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F"];
		_attachments pushback "muzzle_snds_M";
		_handgun = ["hgun_ACPC2_F"];
		_itemsHandgun = [""];
		_handgunSilencer = [""];
	};
	case 2: {
		//SELmods
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
			_handgun="RH_fnp45";
			_itemsHandgun=["RH_x300","RH_gemtech45"];
		};
		_additionalAmmo = [5,"rhsusf_5Rnd_300winmag_xm2010",true];
	};
	case 3: {
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

switch (ADV_par_indUni) do {
	case 1: {
	//AAF uniforms
		_vest = ["V_PlateCarrierIA2_dgtl","V_PlateCarrierIA1_dgtl"];
		_headgear = ["H_HelmetIA"];
	};
	case 2: {
	//TFA uniforms
		_uniform = ["TFA_Instructor_BW","TFA_Instructor_BT","TFA_Instructor2_BW","TFA_Instructor_BlT","TFA_green_blk_rs","TFA_green_blk","TFA_green_KHK","TFA_green_KHK_rs","TFA_black_KHK_rs","TFA_black_KHK","TFA_black_grn_rs","TFA_black_grn"];
		_vest = ["TFA_PlateCarrierH_Black","TFA_PlateCarrierH_fol","TFA_PlateCarrierH_Grn","TFA_PlateCarrierH_Mix","TFA_PlateCarrierH_Tan"];
		_headgear = ["TFA_Cap_Inst","TFA_Cap_bears","TFA_Cap_lad","TFA_Cap_oak","TFA_Cap_HS_blk","TFA_Cap_HS_grn","TFA_Cap_HS_tan"];
	};
};
if ( isClass(configFile >> "CfgPatches" >> "ace_spottingscope") ) then { _items pushBack "ACE_SpottingScope"; };

///// No editing necessary below this line /////

_player = _this select 0;
[_player] call ADV_fnc_gear;
CL_IE_Module_Enabled = true;

true;
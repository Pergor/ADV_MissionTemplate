/*
unit loadout script by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified.
*/

//clothing - (string)
_uniform = switch (true) do {
	//case ((toUpper worldname) in ADV_var_aridMaps): {};
	default {["U_O_GhillieSuit"];};
};
_vest = ["V_HarnessOSpec_brn"];
_headgear = ["H_ShemagOpen_tan"];
_backpack = ["B_AssaultPack_ocamo","B_AssaultPack_cbr"];
_insignium = "";
_useProfileGoggles = 1;		//If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "";
_unitTraits = [["medic",true],["engineer",true],["explosiveSpecialist",true],["UAVHacker",true],["camouflageCoef",1.5],["audibleCoef",0.5],["loadCoef",0.9]];

//weapons - primary weapon - (string)
_primaryweapon = ["srifle_GM6_camo_F","srifle_GM6_F"];

//primary weapon items - (array)
_optic = [""];
_attachments = ["optic_LRPS"];
_silencer = "";		//if silencer is added

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
_primaryweaponAmmo = [7,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

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
_itemsHandgun = ["muzzle_snds_L"];
_handgunSilencer = "";		//if silencer is added

//handgun ammo (if a handgun is given) - (integer)
_handgunAmmo = [5,0];

//weapons - launcher - (string)
_launcher = "";

//launcher ammo (if a launcher is given) - (integer) 
_launcherAmmo = [0,0];

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
		case ((toUpper worldname) == "ALTIS"): {["U_O_FullGhillie_ard","U_O_FullGhillie_sard"]};
		case ((toUpper worldname) in ADV_var_aridMaps): {["U_O_FullGhillie_ard"]};
		case ((toUpper worldname) in ADV_var_sAridMaps): {["U_O_FullGhillie_sard"]};
		case ((toUpper worldname) in ADV_var_lushMaps): {["U_O_FullGhillie_lsh"]};
		default {["U_O_FullGhillie_lsh","U_O_FullGhillie_sard"]};
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
_scorchItems = [""];
_scorchItemsRandom = ["sc_cigarettepack","sc_chips","sc_candybar","","",""];

//Addon Content:
switch (true) do {
	case (ADV_par_opfWeap == 1): {
		//RHS
		_primaryweapon = ["rhs_weap_svdp"];
		_optic = [""];
		_attachments = ["rhs_acc_pso1m2"];
		_handgun = "rhs_weap_pya";
		_itemsHandgun = [];
		_handgunSilencer = "";
	};
	case (ADV_par_opfWeap == 2): {
		//RHS Guerilla
		_primaryweapon = ["rhs_weap_svdp"];
		_optic = [""];
		_attachments = ["rhs_acc_pso1m2"];
		_silencer = "";		//if silencer is added		
		_handgun = "";
		_itemsHandgun = [];
		_handgunSilencer = "";
	};
	case (ADV_par_opfWeap == 3): {
		//CUP
		_primaryweapon = "CUP_srifle_ksvk";
		_optic = [""];
		_attachments = ["rhs_acc_pso1m2"];
		_handgun = "CUP_hgun_PB6P9";
		_itemsHandgun = ["CUP_muzzle_PB6P9"];
		_handgunSilencer = "";
	};
	case (ADV_par_opfWeap == 4): {
		//HLC weapons
		if ( isClass (configFile >> "CfgPatches" >> "rhs_main") ) then {
			_primaryweapon = ["rhs_weap_svdp"];
			_optic = [""];
			_attachments = ["rhs_acc_pso1m2"];
			_silencer = "";		//if silencer is added
		};
		if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
			_handgun = "RH_mak";
			_itemsHandgun = ["RH_pmsd"];
			_handgunSilencer = "";
		};
	};
	default {};
};
switch (ADV_par_opfUni) do {
	case 1: {
		//RHS EMR-Summer
		_vest = ["rhs_6b23_digi_sniper","rhs_6b23_sniper"];
		_backpack = ["rhs_sidor","rhs_assault_umbts","B_AssaultPack_sgg"];
		_items = _items-["NVGoggles_OPFOR"]+["rhs_1PN138"];
	};
	case 2: {
		//RHS Flora
		_vest = ["rhs_6b23_digi_sniper","rhs_6b23_sniper"];
		_backpack = ["rhs_sidor","rhs_assault_umbts","B_AssaultPack_sgg"];
		_items = _items-["NVGoggles_OPFOR"]+["rhs_1PN138"];
	};
	case 3: {
		//RHS Mountain Flora
		_vest = ["rhs_6b23_ML_sniper","rhs_6b23_sniper"];
		_backpack = ["rhs_sidor","rhs_assault_umbts","B_AssaultPack_sgg"];
		_items = _items-["NVGoggles_OPFOR"]+["rhs_1PN138"];
	};
	case 4: {
		//RHS EMR Desert
		_vest = ["rhs_6b23_ML_sniper","rhs_6b23_sniper"];
		_backpack = ["rhs_sidor","rhs_assault_umbts","B_AssaultPack_sgg"];
		_items = _items-["NVGoggles_OPFOR"]+["rhs_1PN138"];
	};
	case 5: {
		//Guerilla
		_headgear = ["H_Watchcap_cbr","H_Watchcap_camo","H_Booniehat_khk","H_Booniehat_oli","H_Cap_blk","H_Cap_oli","H_Cap_tan","H_Cap_brn_SPECOPS","H_MilCap_ocamo",
			"H_Cap_headphones","H_ShemagOpen_tan"];
		_binocular = "Rangefinder";
	};
	case 6: {
		//Afghan Militia (EricJ's Taliban)
		_uniform = ["U_Afghan01NH","U_Afghan02NH","U_Afghan03NH"];
		if (isClass(configFile >> "CfgPatches" >> "maa_Uniform")) then {_uniform append ["TRYK_U_taki_BL","TRYK_U_taki_COY","TRYK_U_taki_wh","TRYK_U_taki_G_BL","TRYK_U_taki_G_COY","TRYK_U_taki_G_WH","TRYK_ZARATAKI","TRYK_ZARATAKI2","TRYK_ZARATAKI3"]};
		_vest = ["V_HarnessOGL_brn","V_HarnessOGL_gry","rhs_vest_commander","V_BandollierB_cbr","V_BandollierB_khk"];
		_headgear = ["H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_tan","H_ShemagOpen_khk"];
		_binocular = "Binocular";
		_goggles = "";
		_useProfileGoggles = 0;
	};
	default {};
};

if (ADV_par_opfScopes < 1)  then { _optic = [""]; };

///// No editing necessary below this line /////
_player = _this select 0;
[_player] call ADV_fnc_gear;
CL_IE_Module_Enabled = true;

true;
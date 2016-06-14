/*
unit loadout script by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set _primaryweaponAmmo to 0 and add those
magazines one for one in _items.
*/

//clothing - (string)
_uniform = ["U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest","U_B_CombatUniform_mcam","U_B_CombatUniform_mcam"];
_vest = ["V_PlateCarrier2_rgr","V_PlateCarrier1_rgr"];
_headgear = ["H_HelmetSpecB_paint1","H_HelmetSpecB_paint2","H_HelmetB_black","H_HelmetB","H_HelmetB_desert","H_HelmetB_grass","H_HelmetB_paint"];
_backpack = [""];
_insignium = "";
_useProfileGoggles = 1;		//If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "G_Combat";
_unitTraits = [["medic",false],["engineer",false],["explosiveSpecialist",false],["UAVHacker",false],["camouflageCoef",1.0],["audibleCoef",1.0]];

//weapons - primary weapon - (string)
_primaryweapon = ["arifle_MX_Black_F","arifle_MX_F"];

//primary weapon items - (array)
_optic = ["optic_Hamr","optic_MRCO"];
_attachments = [""];
if ( ADV_par_NVGs == 1 ) then { _attachments pushback "acc_flashlight"; };
if ( ADV_par_NVGs == 2 ) then { _attachments pushback "acc_pointer_IR"; };
_silencer = "muzzle_snds_H";

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
_handgun = "hgun_Pistol_heavy_01_F";

//handgun items - (array)
_itemsHandgun = [];
_handgunSilencer = "muzzle_snds_acp";

//handgun ammo (if a handgun is given) - (integer)
_handgunAmmo = [2,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//weapons - launcher - (string)
_launcher = "";

//launcher ammo (if a launcher is given) - (integer) 
_launcherAmmo = [0,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//binocular - (string)
_binocular = "Binocular";

//throwables - (integer)
_grenadeHE = 2;
_grenadeSmokeWhite = 1;
_grenadeSmokeYellow = 0;
_grenadeSmokeOrange = 0;
_grenadeSmokeRed = 0;
_grenadeSmokePurple = 0;
_grenadeSmokeBlue = 0;
_grenadeSmokeGreen = 1;
_chemlightYellow = 0;
_chemlightRed = 1;
_chemlightGreen = 0;
_chemlightBlue = 0;
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
_ACREradios = ["ACRE_PRC343"];	//_this select 0=shortrange radio;_this select 1=leader radio;_this select 2=backpackRadio;
//TFAR items
_givePersonalRadio = false;
_giveRiflemanRadio = true;
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
_ACE_MapTools = 0;
_ACE_CableTie = 0;
_ACE_sprayPaintColor = "NONE";

_ACE_key = 0;	//0 = no key, 1 = side dependant key, 2 = master key, 3 = lockpick
_ACE_flashlight = 1;
_ACE_kestrel = 0;
_ACE_altimeter = 0;
_ACE_ATragMX = 0;
_ACE_rangecard = 0;
_ACE_DAGR = 1;
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

//ACEVariables (if ACE is running) - (bool)
_ACE_isMedic = 0;	//0 = no medic; 1 = medic; 2 = doctor;
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
_scorchItemsRandom = ["sc_cigarettepack","sc_chips","sc_charms","sc_candybar","","",""];

///// No editing necessary below this line /////

_player = _this select 0;
_prefix = [(str _player),0,-2] call BIS_fnc_trimString;
if (_prefix == "ASSCSW" || _prefix == "ASSCSW_") then { _binocular = "Rangefinder"; };
[_player] call ADV_fnc_gear;
switch true do {
	case (toUpper (_prefix) == "CSW" || toUpper (_prefix) == "CSW_"): { [_player,1] call ADV_fnc_CSW; };
	case (toUpper (_prefix) == "ASSCSW" || toUpper (_prefix) == "ASSCSW_"): { [_player,2] call ADV_fnc_CSW; };
	case (toUpper (_prefix) == "MORTAR" || toUpper (_prefix) == "MORTAR_"): { [_player,3] call ADV_fnc_CSW; };
	case (toUpper (_prefix) == "ASSMORTAR" || toUpper (_prefix) == "ASSMORTAR_"): { [_player,4] call ADV_fnc_CSW; };
	case (toUpper (_prefix) == "TOW" || toUpper (_prefix) == "TOW_"): { [_player,5] call ADV_fnc_CSW; };
	case (toUpper (_prefix) == "ASSTOW" || toUpper (_prefix) == "ASSTOW_"): { [_player,6] call ADV_fnc_CSW; };
	default {};
};

true;
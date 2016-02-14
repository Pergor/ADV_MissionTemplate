/*
gear-adding function by belbo
adds the loadouts from ADV_Setup\gear\west\*.sqf to the units
If custom content is added to the units, they possibly have to be added to _glrfls (if there are rifles with grenade launchers).
define per cfgFunctions or from init.sqf or initPlayerLocal.sqf as early as possible via
ADV_fnc_gear = compile preprocessFileLineNumbers "ADV_Setup\gear\ADV_fnc_gear.sqf";
*/

params [
	["_unit", player, [objNull]],
	"_IR_GrenType","_ACE_key_type","_NVGoggles","_muzzles","_muzzle","_disposableLaunchers","_medicBackPacks","_manPacks","_removeBackpackAfterWeapons","_personalRadioType","_riflemanRadioType"
];

//a lot of arrays and variables
_medicBackPacks = [
	"B_AssaultPack_rgr_Medic","B_FieldPack_ocamo_Medic","B_FieldPack_oucamo_Medic","B_AssaultPack_rgr_ReconMedic",
	"BWA3_AssaultPack_Medic","B_mas_AssaultPack_mul_Medic","B_mas_AssaultPack_des_Medic","B_mas_AssaultPack_black_Medic",
	"B_mas_AssaultPack_wint_Medic","B_mas_AssaultPack_rng_Medic","O_mas_AssaultPack_flo_Medic","O_mas_AssaultPack_blk_Medic"
];
_manPacks = ["tf_mr3000","tf_anprc155","tf_rt1523g","clf_prc117g_ap_multi","clf_nicecomm2_multi","clf_nicecomm2_coy","clf_nicecomm2_prc117g_multi",
	"clf_nicecomm2_prc117g_coy","ACRE_PRC117F","ACRE_PRC77"
];
_NVGoggles = ["NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP"];
if ( isClass(configFile >> "CfgPatches" >> "tfa_units") ) then { _NVGoggles append ["TFA_NVGoggles","TFA_NVGoggles2"]; };
if ( isClass(configFile >> "CfgPatches" >> "rhsusf_main") ) then { _NVGoggles append ["rhsusf_ANPVS_14","rhsusf_ANPVS_15"]; };
if ( isClass(configFile >> "CfgPatches" >> "UK3CB_BAF_Equipment") ) then { _NVGoggles append ["UK3CB_BAF_HMNVS"]; };
if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _NVGoggles append ["dsk_nsv"]; };
_disposableLaunchers = ["BWA3_Pzf3","BWA3_RGW90","STI_M136","CUP_launch_M136","rhs_weap_M136","rhs_weap_M136_hedp","rhs_weap_M136_hp","RHS_WEAP_RPG26","RHS_WEAP_RSHG2","RHS_WEAP_RPG18"];
if ( isClass(configFile >> "CfgPatches" >> "ACE_disposable") ) then { _disposableLaunchers append ["launch_NLAW_F"]; };
if (isNil "ADV_params_defined") then {
	ADV_par_customWeap = 0; ADV_par_opfWeap = 0; ADV_par_indWeap = 0;
	ADV_par_customUni = 0; ADV_par_opfUni = 0; ADV_par_indUni = 0;
	ADV_par_NVGs = 1; ADV_par_opfNVGs = 1;
	ADV_par_Silencers = 0; ADV_par_opfSilencers = 0;
	ADV_par_optics = 1; ADV_par_opfOptics = 1;
	ADV_par_Tablets = 1; ADV_par_TIEquipment = 0; ADV_par_Radios = 1;
};

//removals:
removeAllAssignedItems _unit;
removeUniform _unit;
removeallItems _unit;
removeAllAssignedItems _unit;
removeallWeapons _unit;
removeHeadgear _unit;
removeBackpack _unit;
removeVest _unit;
{ _unit removeMagazine _x } forEach magazines _unit;
//...and readding. Clothing:
if ( (typeName (_uniform)) == "ARRAY" ) then { _uniform = _uniform call BIS_fnc_selectRandom; };
_unit forceAddUniform _uniform;
if ( (typeName (_vest)) == "ARRAY" ) then { _vest = _vest call BIS_fnc_selectRandom;};
_unit addVest _vest;
if ( (typeName (_backpack)) == "ARRAY" ) then { _backpack = _backpack call BIS_fnc_selectRandom; };
_removeBackpackAfterWeapons = false;
if ( _backpack == "backpackdummy" ) then { _backpack = "B_Carryall_oli"; _removeBackpackAfterWeapons = true; };
_unit addBackpack _backpack;
clearMagazineCargoGlobal (unitBackpack _unit);
clearItemCargoGlobal (unitBackpack _unit);
clearWeaponCargoGlobal (unitBackpack _unit);
if ( (typeName (_headgear)) == "ARRAY" ) then { _headgear = _headgear call BIS_fnc_selectRandom; };
_unit addHeadgear _headgear;
if ( _useProfileGoggles == 0 ) then {
	removeGoggles _unit;
	if ( (typeName (_goggles) ) == "ARRAY" ) then { _goggles = _goggles call BIS_fnc_selectRandom; };
	_unit addGoggles _goggles;
};

//removing FAKs/MediKits/AGM medic stuff again and adding FAKs/MediKits
if ( _backpack in _medicBackPacks || isClass (configFile >> "CfgPatches" >> "ACE_Medical") ) then {
	_unit removeItems "MediKit";
	_unit removeItems "FirstAidKit";
	if ( isClass (configFile >> "CfgPatches" >> "ACE_Medical") ) then {
		_ACE_Items = ["ACE_atropine","ACE_fieldDressing","ACE_elasticBandage","ACE_quikclot","ACE_bloodIV","ACE_bloodIV_500","ACE_bloodIV_250","ACE_bodyBag","ACE_epinephrine","ACE_morphine","ACE_packingBandage","ACE_personalAidKit","ACE_plasmaIV","ACE_plasmaIV_500","ACE_plasmaIV_250","ACE_salineIV","ACE_salineIV_500","ACE_salineIV_250","ACE_surgicalKit","ACE_tourniquet"];
		{ _unit removeItems _x } forEach _ACE_Items;
	};
};
if !( isClass (configFile >> "CfgPatches" >> "ACE_Medical") ) then {
	if ( !(_backpack == "") && (_mediKit > 0 || _FirstAidKits > 4) ) then {
		if (_mediKit > 0) then { _unit addItemToBackpack "MediKit"; };
		for "_i" from 1 to _FirstAidKits do	{
			_unit addItemToBackpack "FirstAidKit";
		};
	} else {
		for "_i" from 1 to _FirstAidKits do	{
			_unit addItem "FirstAidKit";
		};
	};
};

//scorch items
if (isClass(configFile >> "CfgPatches" >> "scorch_invitems")) then {
	if ( !isNil "_scorchItems" ) then { { _unit addItem _x; } forEach _scorchItems; };
	if ( !isNil "_scorchItemsRandom" ) then { _unit addItem (_scorchItemsRandom call BIS_fnc_selectRandom); };
};

//'nades:
switch ( true ) do {
	case ( ADV_par_customWeap == 1 && ( side ( group _unit ) == west ) ): {
		_unit addMagazines ["BWA3_DM51A1", _grenadeHE];
		_unit addMagazines ["BWA3_DM25", _grenadeSmokeWhite];
		_unit addMagazines ["BWA3_DM32_Orange", _grenadeSmokeOrange+_grenadeSmokePurple+_grenadeSmokeRed];
		_unit addMagazines ["BWA3_DM32_Yellow", _grenadeSmokeYellow+_grenadeSmokeGreen+_grenadeSmokeBlue];
	};
	case ( (ADV_par_customWeap == 2 && ( side ( group _unit ) == west )) || (ADV_par_indWeap == 2 && ( side ( group _unit ) == independent )) ): {
		_unit addMagazines ["rhs_mag_m67", _grenadeHE];
		_unit addMagazines ["rhs_mag_an_m8hc", _grenadeSmokeWhite];
		_unit addMagazines ["rhs_mag_m18_yellow", _grenadeSmokeYellow];
		_unit addMagazines ["rhs_mag_m18_purple", _grenadeSmokePurple];
		_unit addMagazines ["rhs_mag_m18_green", _grenadeSmokeGreen+_grenadeSmokeBlue];
		_unit addMagazines ["rhs_mag_m18_red", _grenadeSmokeRed+_grenadeSmokeOrange];
	};
	case ( (ADV_par_opfWeap == 1 || ADV_par_opfWeap == 2) && ( side ( group _unit ) == east ) ): {
		_unit addMagazines ["rhs_mag_rgd5", _grenadeHE];
		_unit addMagazines ["SmokeShell", _grenadeSmokeWhite];
		_unit addMagazines ["rhs_mag_rdg2_black", _grenadeSmokeGreen+_grenadeSmokeBlue+_grenadeSmokePurple];
		_unit addMagazines ["rhs_mag_nspd", _grenadeSmokeYellow+_grenadeSmokeRed+_grenadeSmokeOrange];
	};
	default {
		if ( ADV_par_opfWeap == 3 && ( side ( group _unit ) == east ) ) then {
			_unit addMagazines ["CUP_HandGrenade_RGD5", _grenadeHE];
		} else {
			_unit addMagazines ["HandGrenade", _grenadeHE];
		};
		_unit addMagazines ["SmokeShell", _grenadeSmokeWhite];
		_unit addMagazines ["SmokeShellBlue", _grenadeSmokeBlue];
		_unit addMagazines ["SmokeShellGreen", _grenadeSmokeGreen];
		_unit addMagazines ["SmokeShellOrange", _grenadeSmokeOrange];
		_unit addMagazines ["SmokeShellPurple", _grenadeSmokePurple];
		_unit addMagazines ["SmokeShellRed", _grenadeSmokeRed];
		_unit addMagazines ["SmokeShellYellow", _grenadeSmokeYellow];
	};
};
//50mm
switch ( true ) do {
	case ( (ADV_par_opfWeap == 1 || ADV_par_opfWeap == 2) && ( side ( group _unit ) == east ) ): {
		_unit addMagazines ["rhs_VOG25", _40mmHeGrenadesAmmo];
		_unit addMagazines ["rhs_GRD40_White", _40mmSmokeGrenadesWhite];
		_unit addMagazines ["rhs_GRD40_Green", _40mmSmokeGrenadesGreen+_40mmSmokeGrenadesYellow+_40mmSmokeGrenadesBlue];
		_unit addMagazines ["rhs_GRD40_Red", _40mmSmokeGrenadesRed+_40mmSmokeGrenadesOrange+_40mmSmokeGrenadesPurple];
		if (ADV_par_opfNVGs == 1) then {
			_unit addMagazines ["rhs_VG40OP_white", _40mmFlareWhite+_40mmFlareYellow];
			_unit addMagazines ["rhs_VG40OP_green", _40mmFlareGreen];
			_unit addMagazines ["rhs_VG40OP_red", _40mmFlareRed];
		};
	};
	case ( ADV_par_opfWeap == 3 && ( side ( group _unit ) == east ) ): {
		_unit addMagazines ["CUP_1Rnd_HE_GP25_M", _40mmHeGrenadesAmmo];
		_unit addMagazines ["CUP_1Rnd_SMOKE_GP25_M", _40mmSmokeGrenadesWhite];
		_unit addMagazines ["CUP_1Rnd_SmokeRed_GP25_M", _40mmSmokeGrenadesRed+_40mmSmokeGrenadesOrange+_40mmSmokeGrenadesPurple];
		_unit addMagazines ["CUP_1Rnd_SmokeGreen_GP25_M", _40mmSmokeGrenadesGreen+_40mmSmokeGrenadesBlue];
		_unit addMagazines ["CUP_1Rnd_SmokeYellow_GP25_M", _40mmSmokeGrenadesYellow];
		if (ADV_par_opfNVGs == 1) then {
			_unit addMagazines ["CUP_FlareWhite_GP25_M", _40mmFlareWhite];
			_unit addMagazines ["CUP_FlareGreen_GP25_M", _40mmFlareGreen];
			_unit addMagazines ["CUP_FlareRed_GP25_M", _40mmFlareRed];
			_unit addMagazines ["CUP_FlareYellow_GP25_M", _40mmFlareYellow];
		};
	};
	case ( ADV_par_opfWeap == 4 && ( side ( group _unit ) == east ) ): {
		_unit addMagazines ["hlc_VOG25_AK", _40mmHeGrenadesAmmo];
		_unit addMagazines ["hlc_GRD_White", _40mmSmokeGrenadesWhite+_40mmSmokeGrenadesYellow];
		_unit addMagazines ["hlc_GRD_red", _40mmSmokeGrenadesRed];
		_unit addMagazines ["hlc_GRD_orange", _40mmSmokeGrenadesOrange];
		_unit addMagazines ["hlc_GRD_purple", _40mmSmokeGrenadesPurple];
		_unit addMagazines ["hlc_GRD_green", _40mmSmokeGrenadesGreen];
		_unit addMagazines ["hlc_GRD_blue", _40mmSmokeGrenadesBlue];
	};
	default {
		_unit addMagazines ["1Rnd_HE_Grenade_shell", _40mmHeGrenadesAmmo];
		_unit addMagazines ["1Rnd_Smoke_Grenade_shell", _40mmSmokeGrenadesWhite];
		_unit addMagazines ["1Rnd_SmokeYellow_Grenade_shell", _40mmSmokeGrenadesYellow];
		_unit addMagazines ["1Rnd_SmokeOrange_Grenade_shell", _40mmSmokeGrenadesOrange];
		_unit addMagazines ["1Rnd_SmokeRed_Grenade_shell", _40mmSmokeGrenadesRed];
		_unit addMagazines ["1Rnd_SmokePurple_Grenade_shell", _40mmSmokeGrenadesPurple];
		_unit addMagazines ["1Rnd_SmokeBlue_Grenade_shell", _40mmSmokeGrenadesBlue];
		_unit addMagazines ["1Rnd_SmokeGreen_Grenade_shell", _40mmSmokeGrenadesGreen];
		if ( ( !(side (group _unit) == east) && ADV_par_NVGs == 1 ) || (side (group _unit) == east && ADV_par_opfNVGs == 1) ) then {
			_unit addMagazines ["UGL_FlareWhite_F", _40mmFlareWhite];
			_unit addMagazines ["UGL_FlareYellow_F", _40mmFlareYellow];
			_unit addMagazines ["UGL_FlareRed_F", _40mmFlareRed];
			_unit addMagazines ["UGL_FlareGreen_F", _40mmFlareGreen];
		};
	};
};
if ( ( !(side (group _unit) == east) && ADV_par_NVGs > 0 ) || (side (group _unit) == east && ADV_par_opfNVGs > 0) ) then {
	_unit addMagazines ["Chemlight_Yellow", _chemlightYellow];
	_unit addMagazines ["Chemlight_Red", _chemlightRed];
	_unit addMagazines ["Chemlight_Green", _chemlightGreen];
	_unit addMagazines ["Chemlight_Blue", _chemlightBlue];
};
if ( ( !(side (group _unit) == east) && ADV_par_NVGs == 2 ) || (side (group _unit) == east && ADV_par_opfNVGs == 2) ) then {
	if !( isClass (configFile >> "CfgPatches" >> "ACE_attach") ) then {
		_IR_GrenType = switch (side (group _unit)) do {
			case west: {"B_IR_Grenade"};
			case east: {"O_IR_Grenade"};
			case independent: {"I_IR_Grenade"};
			default {"I_IR_Grenade"};
		};
		_unit addMagazines [_IR_GrenType, _IRgrenade];
	};
	_unit addMagazines ["UGL_FlareCIR_F", _40mmFlareIR];
};
_unit selectWeapon "SmokeShellMuzzle";

//items:
{ _unit linkitem _x } forEach _itemslink;
if (_insignium == "") then {
	[_unit] call ADV_fnc_insignia;
} else {
	//[[_unit,_insignium], "BIS_fnc_setUnitInsignia",nil,true,true] call BIS_fnc_MP;
	[_unit,_insignium] remoteExec ["BIS_fnc_setUnitInsignia",0];
};
//weapons
[_unit,_binocular,1] call BIS_fnc_addWeapon;
if (( typeName (_handgun)) == "ARRAY" ) then { _handgun = _handgun call BIS_fnc_selectRandom; };
[_unit,_handgun,_handgunAmmo select 0,_handgunAmmo select 1] call BIS_fnc_addWeapon;
if ( (side (group _unit) == west && ADV_par_Silencers == 1) || (side (group _unit) == east && ADV_par_opfSilencers == 1) ) then { _itemsHandgun pushback _handgunSilencer; };
{ _unit addHandgunItem _x } forEach _itemsHandgun;
if ( _launcher in _disposableLaunchers ) then {
	_launcherAmmo set [0,1];
};
[_unit,_launcher,_launcherAmmo select 0,_launcherAmmo select 1] call BIS_fnc_addWeapon;
if ( (typeName (_primaryWeapon)) == "ARRAY" ) then { _primaryWeapon = _primaryWeapon call BIS_fnc_selectRandom; };
if (_primaryweaponAmmo select 0 > 0) then {
	[_unit,_primaryWeapon,1,_primaryweaponAmmo select 1] call BIS_fnc_addWeapon;
	[_unit,(_primaryweaponAmmo select 0)-1,0,_primaryweaponAmmo select 1] call ADV_fnc_addMagazine;
} else {
	[_unit,_primaryWeapon,_primaryweaponAmmo select 0,_primaryweaponAmmo select 1] call BIS_fnc_addWeapon;
};
if ( (typeName (_optic) ) == "ARRAY" ) then { _optic = _optic call BIS_fnc_selectRandom; };
/*
if ( isClass(configFile >> "CfgPatches" >> "ACE_optics") ) then {
	if (_optic == "optic_Hamr") then { _optic = "ACE_optic_Hamr_PIP" };
	if (_optic == "optic_ARCO") then { _optic = "ACE_optic_ARCO_PIP" };
};
*/
if ( ( !(side (group _unit) == east) && ADV_par_optics == 1) || (side (group _unit) == east && ADV_par_opfOptics == 1) ) then { _attachments pushBack _optic; };
if ( ( !(side (group _unit) == east) && ADV_par_Silencers == 1) || (side (group _unit) == east && ADV_par_opfSilencers == 1) ) then { _attachments pushback _silencer; };
if ( ( !(side (group _unit) == east) && ADV_par_Silencers == 2) || (side (group _unit) == east && ADV_par_opfSilencers == 2) ) then { _unit addItem _silencer; _unit addItem _handgunSilencer; };

{ _unit addPrimaryWeaponItem _x; } forEach _attachments;

if ( _primaryWeapon != "" ) then {
	_muzzles = getArray (configFile / "CfgWeapons" / _primaryWeapon / "muzzles");
	_muzzle = if ( _muzzles select 0 == "this" ) then { primaryWeapon _unit } else { _muzzles select 0; };
	_unit selectWeapon _muzzle;
};
if ( _removeBackpackAfterWeapons ) then {
	removeBackpack _unit;
};

//container items
{ (uniformContainer _unit) addItemCargoGlobal [_x,1] } forEach _itemsUniform;
{ (vestContainer _unit) addItemCargoGlobal [_x,1] } forEach _itemsVest;
{ (backpackContainer _unit) addItemCargoGlobal [_x,1] } forEach _itemsBackpack;
{_unit addItem _x} forEach _items;

//NVG-Removal:
if ( ( !(side (group _unit) == east) && ADV_par_NVGs < 2 ) || (side (group _unit) == east && ADV_par_opfNVGs < 2) ) then {
	{
		_unit unlinkItem _x;
		_unit removeItems _x;
	} forEach _NVGoggles;
};
//tablets & GPS:
if !( ADV_par_Tablets == 99 ) then {
	if ( "ItemGPS" in _items || "ItemGPS" in _itemsLink  || "ItemGPS" in _itemsUniform || "ItemGPS" in _itemsVest || "ItemGPS" in _itemsBackpack ) then {
		_unit unlinkItem "ItemGPS";_unit removeItems "ItemGPS";
	};
};
//BWmod-specials:
if ( isClass(configFile >> "CfgPatches" >> "bwa3_kestrel") && (ADV_par_CustomUni == 1 || ADV_par_CustomUni == 2 || ADV_par_CustomWeap == 1) && ( side _unit == west ) ) then {
	if ( "ItemGPS" in _itemsLink ) then {
		_unit linkItem "BWA3_ItemNaviPad";
	};
};
//cTab-specials:
if ( ADV_par_Tablets == 1 ) then {
	if ( isClass (configFile >> "CfgPatches" >> "cTab") ) then {
		if ( _microDagr && !( isClass(configFile >> "CfgPatches" >> "bwa3_kestrel") && ( (ADV_par_CustomUni == 1 || ADV_par_CustomUni == 2 || ADV_par_CustomWeap == 1) && side (group _unit) == west) ) ) then { _unit addItem "ItemMicroDAGR"; };
		if ( _androidDevice ) then { _unit addItem "ItemAndroid"; };
		if ( _tablet ) then {
			if ( "B_UavTerminal" in _itemsLink || "O_UavTerminal" in _itemsLink || "I_UavTerminal" in _itemsLink ) then {
				_unit addItem "ItemcTab"; 
			} else {
				_unit linkItem "ItemcTab";
			};
		};
		if ( _helmetCam ) then { _unit addItem "ItemcTabHCam" };
	};
};
if (ADV_par_Tablets == 2) then {
	if ( isClass(configFile >> "CfgPatches" >> "ACE_DAGR") && _ACE_DAGR > 0 ) then {
		_unit addItem "ACE_DAGR";
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_microdagr") && _ACE_microDAGR > 0 ) then {
		_unit addItem "ACE_microDAGR";
	};
};
//ACE-Items:
if ( isClass(configFile >> "CfgPatches" >> "ACE_common") ) then {
	if ( isClass(configFile >> "CfgPatches" >> "ACE_hearing") ) then {
		for "_i" from 1 to _ACE_EarPlugs do { _unit addItem "ACE_EarPlugs"; };
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_maptools") && _ACE_MapTools > 0 ) then {
		_unit addItem "ACE_MapTools";
	};
	if ( isClass (configFile >> "CfgPatches" >> "ACE_rangecard") && _ACE_rangecard > 0 ) then {
		_unit addItem "ACE_RangeCard";
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_medical") ) then {
		if ( _ace_FAK > 0 ) then {
			[_unit,_ace_FAK] call ADV_fnc_aceFAK;
		} else {
			if ( (missionnamespace getVariable ["ace_medical_level",2]) > 1 || ( (missionnamespace getVariable ["ace_medical_medicSetting",2]) > 1 && _ACE_isMedic > 0 ) ) then {
				if ( !(_backpack == "") && (_mediKit >= 1 || _FirstAidKits >= 5) ) then {
					_mediBack = unitBackpack _unit;
					_mediBack addItemCargoGlobal ["ACE_fieldDressing", _ACE_fieldDressing];
					_mediBack addItemCargoGlobal ["ACE_elasticBandage", _ACE_elasticBandage];
					_mediBack addItemCargoGlobal ["ACE_packingBandage", _ACE_packingBandage];
					_mediBack addItemCargoGlobal ["ACE_quikclot", _ACE_quikclot];
					
					_mediBack addItemCargoGlobal ["ACE_morphine", _ACE_morphine];
					_mediBack addItemCargoGlobal ["ACE_epinephrine", _ACE_epinephrine];
					_mediBack addItemCargoGlobal ["ACE_atropine", _ACE_atropine];
					_mediBack addItemCargoGlobal ["ACE_tourniquet", _ACE_tourniquet];
					
					_mediBack addItemCargoGlobal ["ACE_bloodIV", _ACE_bloodIV];
					_mediBack addItemCargoGlobal ["ACE_bloodIV_500", _ACE_bloodIV_500];
					_mediBack addItemCargoGlobal ["ACE_bloodIV_250", _ACE_bloodIV_250];
					_mediBack addItemCargoGlobal ["ACE_plasmaIV", _ACE_plasmaIV];
					_mediBack addItemCargoGlobal ["ACE_plasmaIV_500", _ACE_plasmaIV_500];
					_mediBack addItemCargoGlobal ["ACE_plasmaIV_250", _ACE_plasmaIV_250];
					_mediBack addItemCargoGlobal ["ACE_salineIV", _ACE_salineIV];
					_mediBack addItemCargoGlobal ["ACE_salineIV_500", _ACE_salineIV_500];
					_mediBack addItemCargoGlobal ["ACE_salineIV_250", _ACE_salineIV_250];
					
					for "_i" from 1 to _ACE_surgicalKit do { _unit addItem "ACE_surgicalKit"; };
					for "_i" from 1 to _ACE_personalAidKit do { _unit addItem "ACE_personalAidKit"; };
					_mediBack addItemCargoGlobal ["ACE_bodyBag", _ACE_bodyBag];
				} else {
					for "_i" from 1 to _ACE_fieldDressing do { _unit addItem "ACE_fieldDressing"; };
					for "_i" from 1 to _ACE_elasticBandage do { _unit addItem "ACE_elasticBandage"; };
					for "_i" from 1 to _ACE_packingBandage do { _unit addItem "ACE_packingBandage"; };
					for "_i" from 1 to _ACE_quikclot do { _unit addItem "ACE_quikclot"; };
					for "_i" from 1 to _ACE_morphine do { _unit addItem "ACE_morphine";};
					for "_i" from 1 to _ACE_tourniquet do { _unit addItem "ACE_tourniquet"; };
					
					for "_i" from 1 to _ACE_epinephrine do { _unit addItem "ACE_epinephrine"; };
					for "_i" from 1 to _ACE_atropine do { _unit addItem "ACE_atropine"; };
					
					for "_i" from 1 to _ACE_bloodIV do { _unit addItem "ACE_bloodIV"; };
					for "_i" from 1 to _ACE_bloodIV_500 do { _unit addItem "ACE_bloodIV_500"; };
					for "_i" from 1 to _ACE_bloodIV_250 do { _unit addItem "ACE_bloodIV_250"; };
					for "_i" from 1 to _ACE_plasmaIV do { _unit addItem "ACE_plasmaIV"; };
					for "_i" from 1 to _ACE_plasmaIV_500 do { _unit addItem "ACE_plasmaIV_500"; };
					for "_i" from 1 to _ACE_plasmaIV_250 do { _unit addItem "ACE_plasmaIV_250"; };
					for "_i" from 1 to _ACE_salineIV do { _unit addItem "ACE_salineIV"; };
					for "_i" from 1 to _ACE_salineIV_500 do { _unit addItem "ACE_salineIV_500"; };
					for "_i" from 1 to _ACE_salineIV_250 do { _unit addItem "ACE_salineIV_250"; };
					
					for "_i" from 1 to _ACE_surgicalKit do { _unit addItem "ACE_surgicalKit"; };
					for "_i" from 1 to _ACE_personalAidKit do { _unit addItem "ACE_personalAidKit"; };
				};
				//_mediBack addItemCargoGlobal ["ACE_surgicalKit", _ACE_surgicalKit];
				//_mediBack addItemCargoGlobal ["ACE_personalAidKit", _ACE_personalAidKit];
			} else {
				if ( !(_backpack == "") && (_mediKit >= 1 || _FirstAidKits >= 5) ) then {
					_mediBack = unitBackpack _unit;
					_mediBack addItemCargoGlobal ["ACE_fieldDressing", _ACE_elasticBandage+_ACE_packingBandage];
					_mediBack addItemCargoGlobal ["ACE_morphine", _ACE_morphine];
					_mediBack addItemCargoGlobal ["ACE_epinephrine", _ACE_epinephrine];
					
					_mediBack addItemCargoGlobal ["ACE_bloodIV", _ACE_bloodIV+_ACE_plasmaIV+_ACE_salineIV];
					_mediBack addItemCargoGlobal ["ACE_bloodIV_500", _ACE_bloodIV_500+_ACE_plasmaIV_500+_ACE_salineIV_500];
					_mediBack addItemCargoGlobal ["ACE_bloodIV_250", _ACE_bloodIV_250+_ACE_plasmaIV_250+_ACE_salineIV_250];
					
					_mediBack addItemCargoGlobal ["ACE_bodyBag", _ACE_bodyBag];
				} else {
					for "_i" from 1 to _ACE_elasticBandage+_ACE_elasticBandage do { _unit addItem "ACE_fieldDressing"; };
					for "_i" from 1 to _ACE_morphine do { _unit addItem "ACE_morphine";};
					for "_i" from 1 to _ACE_epinephrine do { _unit addItem "ACE_epinephrine"; };
					
					for "_i" from 1 to _ACE_bloodIV+_ACE_plasmaIV+_ACE_salineIV do { _unit addItem "ACE_bloodIV"; };
					for "_i" from 1 to _ACE_bloodIV_500+_ACE_plasmaIV_500+_ACE_salineIV_500 do { _unit addItem "ACE_bloodIV_500"; };
					for "_i" from 1 to _ACE_bloodIV_250+_ACE_plasmaIV_250+_ACE_salineIV_250 do { _unit addItem "ACE_bloodIV_250"; };
					for "_i" from 1 to _ACE_bodyBag do { _unit addItem "ACE_bodyBag"; };
				};
			};
		};
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_captives") ) then {
		for "_i" from 1 to _ACE_CableTie do { _unit addItem "ACE_CableTie"; };
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_overheating") ) then {
		for "_i" from 1 to _ACE_SpareBarrel do { _unit addItem "ACE_SpareBarrel"; };
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_logistics_uavbattery") ) then {
		for "_i" from 1 to _ACE_UAVBattery do { _unit addItem "ACE_UAVBattery"; };
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_logistics_wirecutter") ) then {
		for "_i" from 1 to _ACE_wirecutter do { _unit addItem "ACE_wirecutter"; };
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_explosives") ) then {
		for "_i" from 1 to _ACE_Clacker do { _unit addItem "ACE_Clacker"; };
		for "_i" from 1 to _ACE_M26_Clacker do { _unit addItem "ACE_M26_Clacker"; };
		for "_i" from 1 to _ACE_DeadManSwitch do { _unit addItem "ACE_DeadManSwitch"; };
		for "_i" from 1 to _ACE_DefusalKit do { _unit addItem "ACE_DefusalKit"; };
		for "_i" from 1 to _ACE_Cellphone do { _unit addItem "ACE_Cellphone"; };
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_kestrel4500") && _ACE_Kestrel > 0 ) then {
		_unit addItem "ACE_Kestrel4500";
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_ATragMX") && _ACE_ATragMX > 0 ) then {
		_unit addItem "ACE_ATragMX";
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_mk6mortar") && _ACE_RangeTable_82mm > 0 ) then {
		_unit addItem "ACE_RangeTable_82mm";
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_Parachute") && _ACE_Altimeter > 0 ) then {
		_unit linkItem "ACE_Altimeter";
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_Grenades") ) then {
		if (ADV_par_NVGs == 1) then {
			_unit addMagazines ["ACE_HandFlare_Green", _ACE_HandFlare_Green];
			_unit addMagazines ["ACE_HandFlare_Red", _ACE_HandFlare_Red];
			_unit addMagazines ["ACE_HandFlare_White", _ACE_HandFlare_White];
			_unit addMagazines ["ACE_HandFlare_Yellow", _ACE_HandFlare_Yellow];
		};
		_unit addMagazines ["ACE_M84", _ACE_M84];
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_vehiclelock") ) then {
		_ACE_key_type = switch ( _ACE_key ) do {
			case 2: {"ACE_key_master"};
			case 3: {"ACE_key_lockpick"};
			default {""};
		};
		if ( _ACE_key == 1 ) then {
			_ACE_key_type = switch (side (group _unit)) do {
				case west: {"ACE_key_west"};
				case east: {"ACE_key_east"};
				case independent: {"ACE_key_indp"};
				case civilian: {"ACE_key_civ"};
			};
		};
		_unit addItem _ACE_key_type;
	};
	if ( isClass (configFile >> "CfgPatches" >> "ACE_huntir") ) then {
		if (_ACE_HuntIR_monitor > 0) then {
			_unit addItem "ACE_HuntIR_monitor";
		};
		if (_ACE_HuntIR > 0) then {
			_unit addMagazines ["ACE_HuntIR_M203",_ACE_HuntIR];
		};
	};
	if ( ( !(side (group _unit) == east) && ADV_par_NVGs == 2) || (side (group _unit) == east && ADV_par_opfNVGs == 2) ) then {
		if ( isClass (configFile >> "CfgPatches" >> "ACE_attach") ) then {
			for "_i" from 1 to _IRgrenade do {_unit addItem "ACE_IR_Strobe_Item";};
		};
		if ( isClass (configFile >> "CfgPatches" >> "ACE_nightvision") ) then {
			ppEffectDestroy ace_nightvision_ppEffectFilmGrain;
			{
				if ( _x in ["NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP"] ) then {
					_unit unlinkItem _x;
					_unit removeItems _x;
					if ( _x in _itemsLink ) then { _unit linkItem "ACE_NVG_Wide"; };
					if ( _x in _items ) then { _unit addItem "ACE_NVG_Wide"; };
					if ( _x in _itemsUniform ) then { _unit addItemToBackpack "ACE_NVG_Wide"; };
					if ( _x in _itemsVest ) then { _unit addItemToVest "ACE_NVG_Wide"; };
					if ( _x in _itemsBackpack ) then { _unit addItemToUniform "ACE_NVG_Wide"; };
				};
			} forEach _NVGoggles;
		};
		if ( isClass(configFile >> "CfgPatches" >> "ACE_Vector") && _binocular == "Rangefinder" ) then {
			[_unit,"ACE_Vector",1] call BIS_fnc_addWeapon;
		};
	} else {
		if ( isClass(configFile >> "CfgPatches" >> "ACE_yardage450") && _binocular == "Rangefinder" ) then {
			[_unit,"ACE_yardage450",1] call BIS_fnc_addWeapon;
		};
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_mx2a") && ADV_par_TIEquipment == 0 && _ACE_MX2A > 0) then {
		[_unit,"ACE_MX2A",1] call BIS_fnc_addWeapon;
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_flashlights") && !isNil "_ACE_flashlight") then {
		if ( _ACE_flashlight > 0 && ( (!(side (group _unit) == east) && ADV_par_NVGs > 0 ) || (side (group _unit) == east && ADV_par_opfNVGs > 0) ) ) then {
			_flashlight = ["ACE_Flashlight_MX991","ACE_Flashlight_KSF1","ACE_Flashlight_XL50"] call BIS_fnc_selectRandom;
			_unit addItem _flashlight;
		};
	};
	//ACE variables:
	if (  str _unit in ["z1","z2","z3","z4","z5","opf_z1","opf_z2","opf_z3","opf_z4","opf_z5","ind_z1","ind_z2","ind_z3","ind_z4","ind_z5"] ) then { _ACE_isMedic = 2; _ACE_isEnginer = true; _ACE_isEOD = true; _ACE_isPilot = true; };
	_unit setVariable ["ACE_medical_medicClass", _ACE_isMedic, true];
	_unit setVariable ["ACE_isEngineer", _ACE_isEngineer, true];
	_unit setVariable ["ACE_isEOD", _ACE_isEOD, true];
	if ( _ACE_isPilot ) then {
		_unit setVariable ["ACE_GForceCoef", 0.3];
	} else {
		_unit setVariable ["ACE_GForceCoef", 0.7];
	};
};

//radios
if ( ADV_par_Radios > 0 ) then {
	switch ( true ) do {
		case ( isClass (configFile >> "CfgPatches" >> "task_force_radio") ): {
			if ( isClass(configFile >> "CfgPatches" >> "Falke_task_force_radio") && (ADV_par_customUni == 1 || ADV_par_customUni == 2 || ADV_par_customWeap == 3 || ADV_par_customUni == 9) ) then {
				TF_defaultWestPersonalRadio = "tf_ex8550";
			};
			_personalRadioType = switch ( side (group _unit) ) do {
				case east: { TF_defaultEastPersonalRadio };
				case independent: { TF_defaultGuerPersonalRadio };
				default { TF_defaultWestPersonalRadio };
			};
			_riflemanRadioType = switch ( side (group _unit) ) do {
				case east: { TF_defaultEastRiflemanRadio };
				case independent: { TF_defaultGuerRiflemanRadio };
				default { TF_defaultWestRiflemanRadio };
			};
			switch ADV_par_Radios do {
				//everyone gets role specific radio
				default {
					if ( _givePersonalRadio ) then { _unit linkItem _personalRadioType; };
					if ( _giveRiflemanRadio && _givePersonalRadio ) then { _unit addItem _riflemanRadioType; };
					if ( _giveRiflemanRadio && !_givePersonalRadio ) then { _unit linkItem _riflemanRadioType; };
					if ( _tfar_microdagr > 0 ) then { _unit addItem "tf_microdagr"; };
				};
				//only leaders get Radio
				case 2: {
					if ( _givePersonalRadio ) then { _unit linkItem _personalRadioType; };
				};
				//everyone gets personal radio
				case 3: {
					if ( _givePersonalRadio || _giveRiflemanRadio ) then { _unit linkItem _personalRadioType; };
				};
			};
		};
		case ( isClass (configFile >> "CfgPatches" >> "acre_main") ): {
			switch ADV_par_Radios do {
				//everyone gets role specific radio
				default {
					{ _unit addItem _x; } forEach _ACREradios;
				};
				//only leaders get Radio
				case 2: {
					_ACREradios deleteAt 0; _ACREradios deleteAt 2;
					{ _unit addItem _x; } forEach _ACREradios;
				};
				//everyone gets personal radio
				case 3: {
					if ( count _ACREradios > 0 ) then { _unit addItem "ACRE_PRC148"; };
				};
			};
		};
		default {
			_unit linkItem "ItemRadio";
		};
	};
};

if !(_backpack == "") then {
	if ( !isNil "_additionalAmmo" ) then { [_unit,_additionalAmmo select 0,0,_additionalAmmo select 1,_additionalAmmo select 2] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo2" ) then { [_unit,_additionalAmmo2 select 0,0,_additionalAmmo2 select 1,_additionalAmmo2 select 2] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo3" ) then { [_unit,_additionalAmmo3 select 0,0,_additionalAmmo3 select 1,_additionalAmmo3 select 2] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo4" ) then { [_unit,_additionalAmmo4 select 0,0,_additionalAmmo4 select 1,_additionalAmmo4 select 2] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo5" ) then { [_unit,_additionalAmmo5 select 0,0,_additionalAmmo5 select 1,_additionalAmmo5 select 2] call ADV_fnc_addMagazine; };
} else {
	if ( !isNil "_additionalAmmo" ) then { [_unit,_additionalAmmo select 0,0,_additionalAmmo select 1,false] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo2" ) then { [_unit,_additionalAmmo2 select 0,0,_additionalAmmo2 select 1,false] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo3" ) then { [_unit,_additionalAmmo3 select 0,0,_additionalAmmo3 select 1,false] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo4" ) then { [_unit,_additionalAmmo4 select 0,0,_additionalAmmo4 select 1,false] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo5" ) then { [_unit,_additionalAmmo5 select 0,0,_additionalAmmo5 select 1,false] call ADV_fnc_addMagazine; };
};

_unit setVariable ["ADV_var_hasLoadout",true];
	
if ( true ) exitWith {};
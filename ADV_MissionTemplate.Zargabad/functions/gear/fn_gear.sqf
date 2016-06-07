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
_disposableLaunchers = ["BWA3_Pzf3","BWA3_RGW90","STI_M136","CUP_launch_M136","rhs_weap_M136","rhs_weap_M136_hedp","rhs_weap_M136_hp","RHS_WEAP_M72A7","RHS_WEAP_RPG26","RHS_WEAP_RSHG2","RHS_WEAP_RPG18"];
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

//removing FAKs/MediKits/ACE medic stuff again and adding FAKs/MediKits
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
/*
if (isClass(configFile >> "CfgPatches" >> "scorch_invitems")) then {
	if ( !isNil "_scorchItems" ) then { { _unit addItem _x; } forEach _scorchItems; };
	if ( !isNil "_scorchItemsRandom" ) then { _unit addItem (_scorchItemsRandom call BIS_fnc_selectRandom); };
};
*/

//'nades:
[_unit,_grenadeSet,_grenades,_chemlights,_IRgrenade] call ADV_fnc_addGrenades;
//40mm
[_unit] call ADV_fnc_add40mm;

//items:
{ _unit linkitem _x } forEach _itemslink;
if (_insignium == "") then {
	[_unit] call ADV_fnc_insignia;
} else {
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
if ( (typeName (_launcher)) == "ARRAY" ) then { _launcher = _launcher call BIS_fnc_selectRandom; };
[_unit,_launcher,_launcherAmmo select 0,_launcherAmmo select 1] call BIS_fnc_addWeapon;
if ( (typeName (_primaryWeapon)) == "ARRAY" ) then { _primaryWeapon = _primaryWeapon call BIS_fnc_selectRandom; };
if (_primaryweaponAmmo select 0 > 0) then {
	[_unit,_primaryWeapon,1,_primaryweaponAmmo select 1] call BIS_fnc_addWeapon;
	[_unit,(_primaryweaponAmmo select 0)-1,0,_primaryweaponAmmo select 1] call ADV_fnc_addMagazine;
} else {
	[_unit,_primaryWeapon,_primaryweaponAmmo select 0,_primaryweaponAmmo select 1] call BIS_fnc_addWeapon;
};
if ( (typeName (_optic) ) == "ARRAY" ) then { _optic = _optic call BIS_fnc_selectRandom; };
//silencers and attachments
if ( ( !(side (group _unit) == east) && ADV_par_optics == 1) || (side (group _unit) == east && ADV_par_opfOptics == 1) ) then { _attachments pushBack _optic; };
if ( ( !(side (group _unit) == east) && ADV_par_Silencers == 1) || (side (group _unit) == east && ADV_par_opfSilencers == 1) ) then { _attachments pushback _silencer; };
if ( ( !(side (group _unit) == east) && ADV_par_Silencers == 2) || (side (group _unit) == east && ADV_par_opfSilencers == 2) ) then { _unit addItem _silencer; _unit addItem _handgunSilencer; };
{ _unit addPrimaryWeaponItem _x; } forEach _attachments;

if ( _primaryWeapon != "" ) then {
	_muzzles = getArray (configFile / "CfgWeapons" / _primaryWeapon / "muzzles");
	_muzzle = if ( _muzzles select 0 == "this" ) then { primaryWeapon _unit } else { _muzzles select 0 };
	_unit selectWeapon _muzzle;
};
if ( _removeBackpackAfterWeapons ) then {
	removeBackpack _unit;
};
_unit selectWeapon "SmokeShellMuzzle";

//container items
{ (uniformContainer _unit) addItemCargoGlobal [_x,1] } forEach _itemsUniform;
{ (vestContainer _unit) addItemCargoGlobal [_x,1] } forEach _itemsVest;
{ (backpackContainer _unit) addItemCargoGlobal [_x,1] } forEach _itemsBackpack;
{_unit addItem _x} forEach _items;

//unitTraits:
if (!isNil "_unitTraits") then {
	{ _unit setUnitTrait [_x select 0, _x select 1, true] } forEach _unitTraits;
};

//NVG-Removal:
if !(["diver",_unit getVariable ["ADV_var_playerUnit","ADV_fnc_nil"]] call BIS_fnc_inString) then {
	if ( ( !(side (group _unit) == east) && ADV_par_NVGs < 2 ) || (side (group _unit) == east && ADV_par_opfNVGs < 2) ) then {
		{
			_unit unlinkItem _x;
			_unit removeItems _x;
		} forEach _NVGoggles;
	};
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

//ACE-Items:
if ( isClass(configFile >> "CfgPatches" >> "ACE_common") ) then {
	[_unit] call ADV_fnc_aceGear;
};

//radios
if ( ADV_par_Radios > 0 ) then {
	[_unit] call ADV_fnc_addRadios;
};

if !(_backpack == "") then {
	if ( !isNil "_additionalAmmo" ) then { [_unit,_additionalAmmo select 0,0,_additionalAmmo select 1,_additionalAmmo select 2] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo1" ) then { [_unit,_additionalAmmo1 select 0,0,_additionalAmmo1 select 1,_additionalAmmo1 select 2] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo2" ) then { [_unit,_additionalAmmo2 select 0,0,_additionalAmmo2 select 1,_additionalAmmo2 select 2] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo3" ) then { [_unit,_additionalAmmo3 select 0,0,_additionalAmmo3 select 1,_additionalAmmo3 select 2] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo4" ) then { [_unit,_additionalAmmo4 select 0,0,_additionalAmmo4 select 1,_additionalAmmo4 select 2] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo5" ) then { [_unit,_additionalAmmo5 select 0,0,_additionalAmmo5 select 1,_additionalAmmo5 select 2] call ADV_fnc_addMagazine; };
} else {
	if ( !isNil "_additionalAmmo" ) then { [_unit,_additionalAmmo select 0,0,_additionalAmmo select 1,false] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo1" ) then { [_unit,_additionalAmmo1 select 0,0,_additionalAmmo1 select 1,false] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo2" ) then { [_unit,_additionalAmmo2 select 0,0,_additionalAmmo2 select 1,false] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo3" ) then { [_unit,_additionalAmmo3 select 0,0,_additionalAmmo3 select 1,false] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo4" ) then { [_unit,_additionalAmmo4 select 0,0,_additionalAmmo4 select 1,false] call ADV_fnc_addMagazine; };
	if ( !isNil "_additionalAmmo5" ) then { [_unit,_additionalAmmo5 select 0,0,_additionalAmmo5 select 1,false] call ADV_fnc_addMagazine; };
};

_unit setVariable ["ADV_var_hasLoadout",true];
	
if ( true ) exitWith {};
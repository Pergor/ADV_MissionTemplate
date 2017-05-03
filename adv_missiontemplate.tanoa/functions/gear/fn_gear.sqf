/*
 * Author: Belbo
 *
 * The core of adv_missiontemplate's loadout system. Adds the items defined in the loadout function to the unit and calls the necessary functions.
 * Should only be called by loadout function.
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [player] call adv_fnc_gear;
 *
 * Public: No
 */

 params [
	["_unit", player, [objNull]]
];

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

//a lot of arrays and variables:
private _uavTisGiven = if ( { ["UAVTERMINAL",_x] call BIS_fnc_inString } count _itemsLink > 0 ) then {true} else {false};
private _allItems = _items+_itemsLink+_itemsUniform+_itemsVest+_itemsBackpack;
private _medicBackPacks = [
	"B_ASSAULTPACK_RGR_MEDIC","B_FIELDPACK_OCAMO_MEDIC","B_FIELDPACK_OUCAMO_MEDIC","B_ASSAULTPACK_RGR_RECONMEDIC",
	"BWA3_ASSAULTPACK_MEDIC","B_MAS_ASSAULTPACK_MUL_MEDIC","B_MAS_ASSAULTPACK_DES_MEDIC","B_MAS_ASSAULTPACK_BLACK_MEDIC",
	"B_MAS_ASSAULTPACK_WINT_MEDIC","B_MAS_ASSAULTPACK_RNG_MEDIC","O_MAS_ASSAULTPACK_FLO_MEDIC","O_MAS_ASSAULTPACK_BLK_MEDIC"
];
private _manPacks = ["TF_MR3000","TF_ANPRC155","TF_RT1523G","CLF_PRC117G_AP_MULTI","CLF_NICECOMM2_MULTI","CLF_NICECOMM2_COY","CLF_NICECOMM2_PRC117G_MULTI",
	"CLF_NICECOMM2_PRC117G_COY","ACRE_PRC117F","ACRE_PRC77"
];
private _bwmodG36 = ["BWA3_G36","BWA3_G36_LMG","BWA3_G36_AG","BWA3_G36K","BWA3_G36K_AG"];
private _NVGoggles = ["NVGOGGLES","NVGOGGLES_OPFOR","NVGOGGLES_INDEP"];//"NVGOGGLES_TNA_F","O_NVGOGGLES_GHEX_F","O_NVGOGGLES_HEX_F","O_NVGOGGLES_URB_F","NVGOGGLESB_BLK_F","NVGOGGLESB_GRN_F","NVGOGGLESB_GRY_F"
if ( isClass(configFile >> "CfgPatches" >> "tfa_units") ) then { _NVGoggles append ["TFA_NVGOGGLES","TFA_NVGOGGLES2"]; };
if ( isClass(configFile >> "CfgPatches" >> "rhsusf_main") ) then { _NVGoggles append ["RHSUSF_ANPVS_14","RHSUSF_ANPVS_15"]; };
if ( isClass(configFile >> "CfgPatches" >> "rhs_main") ) then { _NVGoggles append ["RHS_1PN138"]; };
if ( isClass(configFile >> "CfgPatches" >> "UK3CB_BAF_Equipment") ) then { _NVGoggles append ["UK3CB_BAF_HMNVS"]; };
if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _NVGoggles append ["DSK_NSV"]; };
if ( isClass(configFile >> "CfgPatches" >> "CUP_Weapons_NVG") ) then { _NVGoggles append ["CUP_NVG_HMNVS","CUP_NVG_PVS7"]; };
//if ( isClass (configFile >> "CfgPatches" >> "task_force_radio") ) then { [] call adv_fnc_tfarSettings };
private _disposableLaunchers = [];
if ( isClass(configFile >> "CfgPatches" >> "ACE_disposable") ) then { _disposableLaunchers pushBack "LAUNCH_NLAW_F"; };
_disposableLaunchers append ["BWA3_PZF3","BWA3_RGW90","STI_M136","CUP_LAUNCH_M136","RHS_WEAP_M136","RHS_WEAP_M136_HEDP","RHS_WEAP_M136_HP","RHS_WEAP_M72A7","RHS_WEAP_RPG26","RHS_WEAP_RSHG2","RHS_WEAP_RPG18"];

if ( toUpper ([(str _unit),(count str _unit)-5] call BIS_fnc_trimString) isEqualTo "RECON" ) then {
	_unitTraits = [["medic",true],["engineer",true],["explosiveSpecialist",true],["UAVHacker",true],["camouflageCoef",1.5],["audibleCoef",0.5],["loadCoef",0.9]];
	_par_Silencers = 2;
	_par_opfSilencers = 2;
	_giveRiflemanRadio = true;
	_givePersonalRadio = true;
	_ACE_m84 = 2;
	_ACE_isMedic = 1;
	_ACE_isEngineer = 1;
	_ACE_isEOD = true;
	_ACE_isPilot = false;
	_androidDevice = true;
	_microDAGR = false;
};

//removals:
removeAllAssignedItems _unit;
player unlinkItem "ItemRadio";
removeAllContainers _unit:
removeallItems _unit;
removeallWeapons _unit;
removeHeadgear _unit;
{ _unit removeMagazine _x } count magazines _unit;
removeAllAssignedItems _unit;
//...and readding. Clothing:
if ( _uniform isEqualType [] ) then { _uniform = selectRandom _uniform; };
_unit forceAddUniform _uniform;
if ( _vest isEqualType [] ) then { _vest = selectRandom _vest;};
_unit addVest _vest;
if ( _backpack isEqualType [] ) then { _backpack = selectRandom _backpack; };
private _removeBackpackAfterWeapons = false;
if ( toUpper _backpack isEqualTo "BACKPACKDUMMY" ) then { _backpack = "B_Carryall_oli"; _removeBackpackAfterWeapons = true; };
_unit addBackpackGlobal _backpack;
//adding the ace_gunbag if necessary:
if ( isClass(configFile >> "CfgPatches" >> "ACE_gunbag") && !isNil "_ace_gunbag") then {
	if ( _ace_gunbag > 0 && (backpack _unit) isEqualTo "" ) then {
		private _ace_gunbag_gunbag = switch (true) do {
			case ( (toUpper worldname) in _var_aridMaps ): {["ace_gunbag_Tan"]};
			case ( (toUpper worldname) in _var_lushMaps ): {["ace_gunbag"]};
			default {["ace_gunbag","ace_gunbag_Tan"]};
		};
		_unit addBackpackGlobal (selectRandom _ace_gunbag_gunbag);
	};
};
clearMagazineCargoGlobal (unitBackpack _unit);
clearItemCargoGlobal (unitBackpack _unit);
clearWeaponCargoGlobal (unitBackpack _unit);
if ( _headgear isEqualType [] ) then { _headgear = selectRandom _headgear; };
_unit addHeadgear _headgear;
if ( (toUpper (goggles _unit)) in ["G_B_DIVING","G_O_DIVING","G_I_DIVING"] ) then { removeGoggles _unit; };
if ( _useProfileGoggles isEqualTo 0 ) then {
	removeGoggles _unit;
	if ( _goggles isEqualType [] ) then { _goggles = selectRandom _goggles; };
	_unit addGoggles _goggles;
};

//removing FAKs/MediKits/ACE medic stuff again and adding FAKs/MediKits
if ( _backpack in _medicBackPacks || isClass (configFile >> "CfgPatches" >> "ACE_Medical") ) then {
	_unit removeItems "MediKit";
	_unit removeItems "FirstAidKit";
	if ( isClass (configFile >> "CfgPatches" >> "ACE_Medical") ) then {
		private _ACE_Items = ["ACE_adenosine","ACE_atropine","ACE_fieldDressing","ACE_elasticBandage","ACE_quikclot","ACE_bloodIV","ACE_bloodIV_500","ACE_bloodIV_250","ACE_bodyBag","ACE_epinephrine","ACE_morphine","ACE_packingBandage","ACE_personalAidKit","ACE_plasmaIV","ACE_plasmaIV_500","ACE_plasmaIV_250","ACE_salineIV","ACE_salineIV_500","ACE_salineIV_250","ACE_surgicalKit","ACE_tourniquet"];
		{ _unit removeItems _x } count _ACE_Items;
	};
};
if !( isClass (configFile >> "CfgPatches" >> "ACE_Medical") ) then {
	if ( !(_backpack isEqualTo "") && (_mediKit > 0 || _FirstAidKits > 4) ) then {
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

/*
//scorch items
if (isClass(configFile >> "CfgPatches" >> "scorch_invitems")) then {
	if ( !isNil "_scorchItems" ) then { { _unit addItem _x; } count _scorchItems; };
	if ( !isNil "_scorchItemsRandom" ) then { _unit addItem (selectRandom  _scorchItemsRandom); };
};
*/
/*
//Murshun cigs
if (isClass(configFile >> "CfgPatches" >> "murshun_cigs")) then {
	if ((floor random 9) > 7) then {
		_unit addMagazine (selectRandom ["murshun_cigs_lighter","murshun_cigs_matches","murshun_cigs_matches","murshun_cigs_matches"]);
		_unit addMagazine "murshun_cigs_cigpack";
	};
};
*/

//'nades:
[_unit,_grenadeSet,_grenades,_chemlights,_IRgrenade] call ADV_fnc_addGrenades;
//40mm
[_unit] call ADV_fnc_add40mm;

//items:
{
	_unit linkitem _x;
} count _itemslink;
if (_insignium isEqualTo "") then {
	[_unit] call ADV_fnc_insignia;
} else {
	[_unit,_insignium] remoteExec ["BIS_fnc_setUnitInsignia",0];
};
//weapons
if ( _binocular isEqualType [] ) then { _binocular = selectRandom _binocular; };
[_unit,_binocular,1] call BIS_fnc_addWeapon;
if ( _handgun isEqualType [] ) then { _handgun = selectRandom _handgun; };
[_unit,_handgun,_handgunAmmo select 0,_handgunAmmo select 1] call BIS_fnc_addWeapon;
if ( (side (group _unit) isEqualTo west && _par_Silencers > 0) || (side (group _unit) isEqualTo east && _par_opfSilencers > 0) ) then { _itemsHandgun pushback _handgunSilencer; };
{ _unit addHandgunItem _x } count _itemsHandgun;
if ( _launcher isEqualType [] ) then { _launcher = selectRandom _launcher; };
if ( (toUpper _launcher) in _disposableLaunchers ) then {
	_launcherAmmo set [0,1];
};
[_unit,_launcher,_launcherAmmo select 0,_launcherAmmo select 1] call BIS_fnc_addWeapon;
if ( _primaryWeapon isEqualType [] ) then { _primaryWeapon = selectRandom _primaryWeapon; };
if (_primaryweaponAmmo select 0 > 0) then {
	[_unit,_primaryWeapon,1,_primaryweaponAmmo select 1] call BIS_fnc_addWeapon;
	[_unit,(_primaryweaponAmmo select 0)-1,0,_primaryweaponAmmo select 1] call ADV_fnc_addMagazine;
} else {
	[_unit,_primaryWeapon,_primaryweaponAmmo select 0,_primaryweaponAmmo select 1] call BIS_fnc_addWeapon;
};
if ( _optic isEqualType [] ) then { _optic = selectRandom _optic; };
if ( (!(side (group _unit) isEqualTo east) && _par_optics isEqualTo 2) || ((side (group _unit) isEqualTo east) && _par_opfOptics isEqualTo 2) ) then {
	if (!(leader _unit isEqualTo _unit) || (count units group _unit isEqualTo 1)) then {
		_optic = selectRandom [_optic,""];
	};
};
//silencers and attachments
if ( (!(side (group _unit) isEqualTo east) && _par_optics > 0) || (side (group _unit) isEqualTo east && _par_opfOptics > 0) ) then {
	_attachments pushBack _optic;
	if ( (toUpper _primaryWeapon) in _bwmodG36 ) then { _attachments pushBack "BWA3_optic_G36C_Ironsight_100"; };
};
if ( (!(side (group _unit) isEqualTo east) && _par_Silencers isEqualTo 1) || (side (group _unit) isEqualTo east && _par_opfSilencers isEqualTo 1) ) then { _attachments pushback _silencer; };
if ( (!(side (group _unit) isEqualTo east) && _par_Silencers isEqualTo 2) || (side (group _unit) isEqualTo east && _par_opfSilencers isEqualTo 2) ) then {
	_unit addItem _silencer;
	//_unit addItem _handgunSilencer;
};
{ _unit addPrimaryWeaponItem _x; } count _attachments;

//ace gunbag weapon handling:
if ( isClass(configFile >> "CfgPatches" >> "ACE_gunbag") && !isNil "_ace_gunbag") then {
	if (_ace_gunbag > 0) then {
		private _ace_gunbag_items = _unit weaponAccessories (primaryWeapon _unit);
		[_unit,_primaryWeapon, _ace_gunbag_items, [(currentMagazine _unit),1]] call adv_fnc_acegunbag;
		_unit removeWeapon _primaryWeapon;
		private _ace_gunbag_newWeaponAmmo = if ((_primaryweaponAmmo select 0) > 8) then { 4 } else { ceil ( (_primaryweaponAmmo select 0)/2 ) };
		private _ace_gunbag_newWeapon = [ (side (group _unit)) ] call adv_fnc_standardWeapon;
		[_unit, (_ace_gunbag_newWeapon select 0), _ace_gunbag_newWeaponAmmo, (_ace_gunbag_newWeapon select 1)] call BIS_fnc_addWeapon;
		if ( (!(side (group _unit) isEqualTo east) && _par_Silencers isEqualTo 1) || (side (group _unit) isEqualTo east && _par_opfSilencers isEqualTo 1) ) then {
			_unit addPrimaryWeaponItem (_ace_gunbag_newWeapon select 2);
		};
		if ( (!(side (group _unit) isEqualTo east) && _par_Silencers isEqualTo 2) || (side (group _unit) isEqualTo east && _par_opfSilencers isEqualTo 2) ) then {
			_unit addItem (_ace_gunbag_newWeapon select 2);
		};
		if ( (!(side (group _unit) isEqualTo east) && _par_optics > 0) || (side (group _unit) isEqualTo east && _par_opfOptics > 0) ) then {
			_unit addPrimaryWeaponItem (_ace_gunbag_newWeapon select 3);
		};
	};
};
if !( _primaryWeapon isEqualTo "" ) then {
	private _muzzles = getArray (configFile / "CfgWeapons" / _primaryWeapon / "muzzles");
	private _muzzle = if ( _muzzles select 0 isEqualTo "this" ) then { primaryWeapon _unit } else { _muzzles select 0 };
	_unit selectWeapon _muzzle;
};
if ( _removeBackpackAfterWeapons ) then {
	removeBackpack _unit;
};
_unit selectWeapon "SmokeShellMuzzle";

//container items
{ (uniformContainer _unit) addItemCargoGlobal [_x,1] } count _itemsUniform;
{ (vestContainer _unit) addItemCargoGlobal [_x,1] } count _itemsVest;
{ (backpackContainer _unit) addItemCargoGlobal [_x,1] } count _itemsBackpack;
{_unit addItem _x} count _items;

//unitTraits:
if (!isNil "_unitTraits") then {
	{ _unit setUnitTrait [_x select 0, _x select 1, true] } count _unitTraits;
};

//NVG-Removal:
if !(["diver",_unit getVariable ["ADV_var_playerUnit","ADV_fnc_nil"]] call BIS_fnc_inString) then {
	if ( ( !(side (group _unit) isEqualTo east) && _par_NVGs < 2 ) || ( side (group _unit) isEqualTo east && _par_opfNVGs < 2 ) ) then {
		_unit unlinkItem (hmd _unit);
		{ _unit removeItems _x; } count _NVGoggles;
	};
};

//tablets & GPS:
if ( {(toUpper _x) isEqualTo "ITEMGPS"} count _allItems > 0 ) then {
	[_unit] call ADV_fnc_addGPS;
};
//ACE-Items:
if ( isClass(configFile >> "CfgPatches" >> "ACE_common") ) then {
	[_unit] call ADV_fnc_aceGear;
};

//radios
if ( _par_Radios > 0 ) then {
	[_unit] call ADV_fnc_addRadios;
};

[_unit] call adv_fnc_setFaction;

if !(_backpack isEqualTo "") then {
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

if ( str _unit in ["z1","z2","z3","z4","z5","opf_z1","opf_z2","opf_z3","opf_z4","opf_z5","ind_z1","ind_z2","ind_z3","ind_z4","ind_z5"] ) then {
	if ( isClass (configFile >> "CfgPatches" >> "acre_main") ) then {
		["en","ru","gr"] call acre_api_fnc_babelSetSpokenLanguages;
	};
};

if ( toUpper ([(str _unit),(count str _unit)-5] call BIS_fnc_trimString) isEqualTo "RECON" ) then {
};

_unit setVariable ["ADV_var_hasLoadout",true];
	
true;
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
private _uavTisGiven = ( { ["UAVTERMINAL",_x] call BIS_fnc_inString } count _itemsLink+_items > 0 );
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

if ( [_unit,"command"] call adv_fnc_findInGroup ) then {
	if ( isClass(configFile >> "CfgPatches" >> "task_force_radio") ) then {
		_giveRiflemanRadio = false;
		if !(_givePersonalRadio) then { _givePersonalRadio = true; };
	};
	if !(_androidDevice) then { _androidDevice = true; };
	if (_microDAGR) then { _microDAGR = false; };
	if (_ACE_key isEqualTo 0) then {_ACE_key = 1;};
};
call {
	if ( {[_unit,_x] call adv_fnc_inGroup} count ["ZEUS"] > 0 || !isNull getAssignedCuratorLogic _unit || serverCommandAvailable "#kick" ) exitWith {  };
	if ( [_unit,"command"] call adv_fnc_findInGroup ) exitWith {
		[[0],false] call adv_fnc_enableChannels;
		[[1,2],true] call adv_fnc_enableChannels;
	};
	if ( ["LEADER", (str _unit) ] call BIS_fnc_inString || ["LEADER", _fnc_scriptNameParent ] call BIS_fnc_inString || ["PILOT", _fnc_scriptNameParent ] call BIS_fnc_inString  || ["SNIPER", _fnc_scriptNameParent ] call BIS_fnc_inString  || ["SPOTTER", _fnc_scriptNameParent ] call BIS_fnc_inString ) exitWith {
		[[0,1],false] call adv_fnc_enableChannels;
		[[2],true] call adv_fnc_enableChannels;
	};
	[[0,1,2],false] call adv_fnc_enableChannels;
};

if ( ["recon",str _unit] call BIS_fnc_inString ) then {
	_unitTraits = [["medic",true],["engineer",true],["explosiveSpecialist",true],["UAVHacker",true],["camouflageCoef",1.5],["audibleCoef",0.5],["loadCoef",0.9]];
	_par_Silencers = 2;
	_par_opfSilencers = 2;
	_giveRiflemanRadio = true;
	_givePersonalRadio = true;
	_ACE_m84 = 2;
	_ACE_isMedic = 1;
	_ACE_isEngineer = 1;
	_ACE_isEOD = true;
	_androidDevice = true;
	_microDAGR = false;
	[[0,1],false] call adv_fnc_enableChannels;
	[[2],true] call adv_fnc_enableChannels;
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
//weapons
//binoculars
if ( _binocular isEqualType [] ) then { _binocular = selectRandom _binocular; };
[_unit,_binocular,1] call BIS_fnc_addWeapon;
//handgun
if ( _handgun isEqualType [] ) then { _handgun = selectRandom _handgun; };
_handgunAmmo params ["_hgC","_hgI"];
[_unit,_handgun,_hgC,_hgI] call BIS_fnc_addWeapon;
//handgunItems
if ( (side (group _unit) isEqualTo west && _par_Silencers > 0) || (side (group _unit) isEqualTo east && _par_opfSilencers > 0) ) then { _itemsHandgun pushback _handgunSilencer; };
{ _unit addHandgunItem _x } count _itemsHandgun;
//launcher
if ( _launcher isEqualType [] ) then { _launcher = selectRandom _launcher; };
_launcherAmmo params ["_laC","_laI"];
if ( (toUpper _launcher) in _disposableLaunchers ) then {
	_laI = 1;
};
[_unit,_launcher,_laC,_laI] call BIS_fnc_addWeapon;
//primaryWeapon
if ( _primaryWeapon isEqualType [] ) then { _primaryWeapon = selectRandom _primaryWeapon; };
_primaryWeaponAmmo params ["_pwC","_pwI"];
[_unit,_primaryWeapon,_pwC,_pwI] call BIS_fnc_addWeapon;
//optics
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
if ( _silencer isEqualType [] ) then { _silencer = selectRandom _silencer; };
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
{ _unit addItem _x } count _items;
{ (uniformContainer _unit) addItemCargoGlobal [_x,1] } count _itemsUniform;
{ (vestContainer _unit) addItemCargoGlobal [_x,1] } count _itemsVest;
{ (backpackContainer _unit) addItemCargoGlobal [_x,1] } count _itemsBackpack;

//unitTraits:
if (!isNil "_unitTraits") then {
	{ _unit setUnitTrait [_x select 0, _x select 1, true] } count _unitTraits;
};

//NVG-Removal/headlamps:
if !( ["diver",_fnc_scriptNameParent] call BIS_fnc_inString || ["pilot",_fnc_scriptNameParent] call BIS_fnc_inString ) then {
	if ( ( !(side (group _unit) isEqualTo east) && _par_NVGs < 2 ) || ( side (group _unit) isEqualTo east && _par_opfNVGs < 2 ) ) then {
		_unit unlinkItem (hmd _unit);
		{ _unit removeItems _x; } count _NVGoggles;
	};
	if ( isClass(configFile >> "CfgPatches" >> "SAN_Headlamp") ) then {
		if ( ( !(side (group _unit) isEqualTo east) && _par_NVGs isEqualTo 1 ) || ( side (group _unit) isEqualTo east && _par_opfNVGs isEqualTo 1 ) ) then {
			private _lampHelmets = (missionNamespace getVariable ["SAN_Headlamp_Helmets",[]]) apply {toUpper _x};
			private _headlamp = call {
				if ( toUpper (headgear _unit) in _lampHelmets ) exitWith {""};
				if ( side (group _unit) isEqualTo civilian ) exitWith {""};
				if ( side (group _unit) isEqualTo independent && _par_indUni isEqualTo 20 ) exitWith {"SAN_Headlamp_v1"};
				if ( side (group _unit) isEqualTo east && _par_opfUni isEqualTo 6 ) exitWith {""};
				if ( side (group _unit) isEqualTo east && _par_opfWeap isEqualTo 2 ) exitWith {"SAN_Headlamp_v1"};
				"SAN_Headlamp_v2"
			};
			{
				_unit unlinkItem _x;
				_unit removeItems _x;
				if ( _x in (_itemsLink apply {toUpper _x;}) ) then { _unit linkItem _headlamp; };
				if ( _x in (_items apply {toUpper _x;}) ) then { _unit addItem _headlamp; };
				if ( _x in (_itemsUniform apply {toUpper _x;}) ) then { _unit addItemToUniform _headlamp; };
				if ( _x in (_itemsVest apply {toUpper _x;}) ) then { _unit addItemToVest _headlamp; };
				if ( _x in (_itemsBackpack apply {toUpper _x;}) ) then { _unit addItemToBackpack _headlamp; };
				nil;
			} count _NVGoggles;			
		};
	};
} else {
	if ( ( !(side (group _unit) isEqualTo east) && _par_NVGs isEqualTo 0 ) || ( side (group _unit) isEqualTo east && _par_opfNVGs isEqualTo 0 ) ) then {
		_unit unlinkItem (hmd _unit);
		{ _unit removeItems _x; } count _NVGoggles;
	};
};

//tablets & GPS:
[_unit] call ADV_fnc_addGPS;

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

if ( !isNull getAssignedCuratorLogic _unit ) then {
	if ( ["command",_fnc_scriptNameParent] call BIS_fnc_inString ) then {
		if ( isClass (configFile >> "CfgPatches" >> "ace_medical") ) then { _unit addItem "ACE_personalAidKit"; };
		if ( isClass(configFile >> "CfgPatches" >> "ACE_explosives") ) then { _unit addItem "ACE_DefusalKit"; };
	};
	if ( isClass(configFile >> "CfgWeapons" >> "alive_tablet") && count (entities "ALiVE_require") > 0 ) then { _unit addItem "alive_tablet"; };
	
	if ( isClass (configFile >> "CfgPatches" >> "acre_main") ) then {
		["en","ru","gr"] call acre_api_fnc_babelSetSpokenLanguages;
	};
	[[0,1,2,3,4,5],true] call adv_fnc_enableChannels;	
};

if ( ["recon",str _unit] call BIS_fnc_inString ) then {
};

//gasmasks:
if !( ["diver",_fnc_scriptNameParent] call BIS_fnc_inString || ["pilot",_fnc_scriptNameParent] call BIS_fnc_inString ) then {
	private _par_gasmasks = missionNamespace getVariable ["adv_par_gasmasks",["param_gasmasks",0] call BIS_fnc_getParamValue];
	private _maskType = if ( side (group _unit) isEqualTo east ) then {"MASK_M50"} else {"Mask_M40"};
	call {
		if ( _par_gasmasks isEqualTo 0 ) exitWith {
			if ( (toUpper (goggles _unit)) in ["MASK_M40","MASK_M40_OD","MASK_M50"] ) then { removeGoggles _unit; };
		};
		if ( _par_gasmasks isEqualTo 1 ) exitWith {
				_unit addGoggles _maskType;
		};
		if ( _par_gasmasks isEqualTo 2 ) exitWith {
			(vestContainer _unit) addItemCargoGlobal [_maskType,1];
		};
	};
};

//insignia
if (_insignium isEqualTo "") then {
	[_unit] call ADV_fnc_insignia;
} else {
	[_unit,""] call BIS_fnc_setUnitInsignia;
	[_unit,_insignium] call BIS_fnc_setUnitInsignia;
};
if (toLower (uniform _unit) isEqualTo "rhs_uniform_acu_ucp" && isClass (configFile >> "CfgPatches" >> "adv_insignia")) then {
	[_unit] call adv_fnc_rhsNametag;
};

//headgear:
if ( _headgear isEqualType [] ) then { _headgear = selectRandom _headgear; };
if ( isClass(configFile >> "CfgWeapons" >> "H_PilotHelmetHeli_B_NVG") ) then {
	if ( ["HELMETHELI",_headgear] call BIS_fnc_inString && (( !(side (group _unit) isEqualTo east) && _par_NVGs isEqualTo 2 ) || ( side (group _unit) isEqualTo east && _par_opfNVGs isEqualTo 2 )) ) then {
		_headgear = format ["%1_NVG",_headgear];
	};
};
_unit addHeadgear _headgear;

_unit setVariable ["ADV_var_hasLoadout",true];
	
true;
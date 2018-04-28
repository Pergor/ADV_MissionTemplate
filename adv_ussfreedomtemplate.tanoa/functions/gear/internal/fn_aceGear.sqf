/*
 * Author: Belbo
 *
 * Adds a ace gear to unit depending on adv_missiontemplate-variables. Has to be called by adv_fnc_gear.
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [player] call adv_fnc_aceGear;
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

//ACE-Items:
if (!isClass(configFile >> "CfgPatches" >> "ACE_common")) exitWith {};

if ( isClass(configFile >> "CfgPatches" >> "ACE_hearing") && !isNil "_ACE_EarPlugs" ) then {
	for "_i" from 1 to _ACE_EarPlugs do { _unit addItem "ACE_EarPlugs"; };
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_maptools") && !isNil "_ACE_MapTools" ) then {
	if (_ACE_MapTools > 0) then { _unit addItem "ACE_MapTools"; };
};
if ( isClass (configFile >> "CfgPatches" >> "ACE_rangecard") && !isNil "_ACE_rangecard" ) then {
	if (_ACE_rangecard > 0) then { _unit addItem "ACE_RangeCard"; };
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_medical") ) then {
	if ( _ace_FAK > 0 ) then {
		[_unit,_ace_FAK] call ADV_fnc_aceFAK;
	};
	[_unit] call adv_fnc_aceMedicalItems;
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_tagging") && !isNil "_ACE_sprayPaintColor" ) then {
	_ACE_sprayPaint_type = switch ( toUpper (_ACE_sprayPaintColor) ) do {
		case "BLACK": {"ACE_sprayPaintBlack"};
		case "BLUE": {"ACE_sprayPaintBlue"};
		case "GREEN": {"ACE_sprayPaintGreen"};
		case "RED": {"ACE_sprayPaintRed"};
		case "RANDOM": { selectRandom ["ACE_sprayPaintBlack","ACE_sprayPaintBlue","ACE_sprayPaintGreen","ACE_sprayPaintRed"] };
		default {""};
	};
	if !(_ACE_sprayPaint_type isEqualTo "") then { _unit addItem _ACE_sprayPaint_type; };
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_captives") && !isNil "_ACE_CableTie" ) then {
	for "_i" from 1 to _ACE_CableTie do { _unit addItem "ACE_CableTie"; };
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_overheating") && !isNil "_ACE_SpareBarrel" ) then {
	for "_i" from 1 to _ACE_SpareBarrel do { _unit addItem "ACE_SpareBarrel"; };
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_logistics_uavbattery") && !isNil "_ACE_UAVBattery" ) then {
	for "_i" from 1 to _ACE_UAVBattery do { _unit addItem "ACE_UAVBattery"; };
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_logistics_wirecutter") && !isNil "_ACE_wirecutter" ) then {
	for "_i" from 1 to _ACE_wirecutter do { _unit addItem "ACE_wirecutter"; };
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_explosives") ) then {
	for "_i" from 1 to _ACE_Clacker do { _unit addItem "ACE_Clacker"; };
	for "_i" from 1 to _ACE_M26_Clacker do { _unit addItem "ACE_M26_Clacker"; };
	for "_i" from 1 to _ACE_DeadManSwitch do { _unit addItem "ACE_DeadManSwitch"; };
	for "_i" from 1 to _ACE_DefusalKit do { _unit addItem "ACE_DefusalKit"; };
	for "_i" from 1 to _ACE_Cellphone do { _unit addItem "ACE_Cellphone"; };
	for "_i" from 1 to _ACE_FlareTripMine do { _unit addMagazine "ACE_FlareTripMine_Mag"; };
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_kestrel4500") && !isNil "_ACE_Kestrel" ) then {
	if (_ACE_Kestrel > 0) then { _unit addItem "ACE_Kestrel4500"; };
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_ATragMX") && !isNil "_ACE_ATragMX" ) then {
	if (_ACE_ATragMX > 0) then { _unit addItem "ACE_ATragMX"; };
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_mk6mortar") && !isNil "_ACE_RangeTable_82mm" ) then {
	if (_ACE_RangeTable_82mm > 0) then { _unit addItem "ACE_RangeTable_82mm"; };
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_Parachute") && !isNil "_ACE_Altimeter" ) then {
	if (_ACE_Altimeter > 0) then { _unit linkItem "ACE_Altimeter"; };
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_Grenades") ) then {
	if ( ( !(side (group _unit) isEqualTo east) && _par_NVGs isEqualTo 1 ) || (side (group _unit) isEqualTo east && _par_opfNVGs isEqualTo 1) ) then {
		_unit addMagazines ["ACE_HandFlare_Green", _ACE_HandFlare_Green];
		_unit addMagazines ["ACE_HandFlare_Red", _ACE_HandFlare_Red];
		_unit addMagazines ["ACE_HandFlare_White", _ACE_HandFlare_White];
		_unit addMagazines ["ACE_HandFlare_Yellow", _ACE_HandFlare_Yellow];
	};
	_unit addMagazines ["ACE_M84", _ACE_M84];
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_vehiclelock") && !isNil "_ACE_key" ) then {
	_ACE_key_type = switch ( _ACE_key ) do {
		case 2: {"ACE_key_master"};
		case 3: {"ACE_key_lockpick"};
		default {""};
	};
	if ( _ACE_key isEqualTo 1 ) then {
		_ACE_key_type = switch (side (group _unit)) do {
			case west: {"ACE_key_west"};
			case east: {"ACE_key_east"};
			case independent: {"ACE_key_indp"};
			case civilian: {"ACE_key_civ"};
		};
	};
	_unit addItem _ACE_key_type;
};
if ( isClass (configFile >> "CfgPatches" >> "ACE_huntir") && !isNil "_ACE_HuntIR_monitor" ) then {
	if (_ACE_HuntIR_monitor > 0) then {
		_unit addItem "ACE_HuntIR_monitor";
	};
	if (_ACE_HuntIR > 0) then {
		_unit addMagazines ["ACE_HuntIR_M203",_ACE_HuntIR];
	};
};
if ( ( !(side (group _unit) isEqualTo east) && _par_NVGs isEqualTo 2) || (side (group _unit) isEqualTo east && _par_opfNVGs isEqualTo 2) ) then {
	if ( isClass (configFile >> "CfgPatches" >> "ACE_attach") && !isNil "_IRgrenade" ) then {
		for "_i" from 1 to _IRgrenade do {_unit addItem "ACE_IR_Strobe_Item";};
	};
	if ( isClass (configFile >> "CfgPatches" >> "ACE_nightvision") ) then {
		{
			_unit unlinkItem _x;
			_unit removeItems _x;
			if ( _x in (_itemsLink apply {toUpper _x;}) ) then { _unit linkItem "ACE_NVG_Wide"; };
			if ( _x in (_items apply {toUpper _x;}) ) then { _unit addItem "ACE_NVG_Wide"; };
			if ( _x in (_itemsUniform apply {toUpper _x;}) ) then { _unit addItemToUniform "ACE_NVG_Wide"; };
			if ( _x in (_itemsVest apply {toUpper _x;}) ) then { _unit addItemToVest "ACE_NVG_Wide"; };
			if ( _x in (_itemsBackpack apply {toUpper _x;}) ) then { _unit addItemToBackpack "ACE_NVG_Wide"; };
			nil;
		} count _NVGoggles;
		if (!isNil "ace_nightvision_ppEffectFilmGrain") then {
			ppEffectDestroy ace_nightvision_ppEffectFilmGrain;
		};
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_Vector") && (toUpper _binocular) isEqualTo "RANGEFINDER" ) then {
		[_unit,"ACE_Vector",1] call BIS_fnc_addWeapon;
	};
} else {
	if ( isClass(configFile >> "CfgPatches" >> "ACE_Vector") && (toUpper _binocular) isEqualTo "RANGEFINDER" ) then {
		[_unit,"ACE_VectorDay",1] call BIS_fnc_addWeapon;
	};
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_mx2a") && _par_TIEquipment isEqualTo 0 && !isNil "_ACE_MX2A") then {
	if (_ACE_MX2A > 0) then { [_unit,"ACE_MX2A",1] call BIS_fnc_addWeapon; };
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_flashlights") && !isNil "_ACE_flashlight") then {
	if ( _ACE_flashlight > 0 && ( (!(side (group _unit) isEqualTo east) && _par_NVGs > 0 ) || (side (group _unit) isEqualTo east && _par_opfNVGs > 0) ) ) then {
		_flashlight = ["ACE_Flashlight_MX991","ACE_Flashlight_KSF1","ACE_Flashlight_XL50"] call BIS_fnc_selectRandom;
		_unit addItem _flashlight;
	};
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_trenches") && !isNil "_ACE_EntrenchingTool" ) then {
	if ( _ACE_EntrenchingTool > 0 ) then { _unit addItem "ACE_EntrenchingTool"; };
};
if ( isClass(configFile >> "CfgPatches" >> "ACE_minedetector") ) then {
	if ( "MineDetector" in _itemsLink+_items+_itemsUniform+_itemsVest+_itemsBackpack ) then {
		_unit removeItems "MineDetector";
		{_unit removeMagazines _x} count (handgunMagazine _unit);
		_unit removeWeapon (handgunWeapon _unit);
		[_unit,"ACE_VMH3"] call BIS_fnc_addWeapon;
	};
};
//ACE variables:
if ( !isNull getAssignedCuratorLogic _unit ) then {
//if (  str _unit in ["z1","z2","z3","z4","z5","opf_z1","opf_z2","opf_z3","opf_z4","opf_z5","ind_z1","ind_z2","ind_z3","ind_z4","ind_z5"] ) then {
	_ACE_isMedic = 2; _ACE_isEnginer = true; _ACE_isEOD = true; _ACE_isPilot = true;
};
_unit setVariable ["ACE_medical_medicClass", _ACE_isMedic, true];
_unit setVariable ["ACE_isEngineer", _ACE_isEngineer, true];
_unit setVariable ["ACE_isEOD", _ACE_isEOD, true];
if ( _ACE_isPilot ) then {
	_unit setVariable ["ACE_GForceCoef", 0.3];
} else {
	_unit setVariable ["ACE_GForceCoef", 0.7];
};
	
true;
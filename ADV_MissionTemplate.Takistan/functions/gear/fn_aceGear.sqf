/*
fn_aceGear: adds ACE³ gear to a unit.
call like this:
[_unit] call ADV_fnc_aceGear;
*/

params [
	["_unit", player, [objNull]]
];
//ACE-Items:
if (!isClass(configFile >> "CfgPatches" >> "ACE_common")) exitWith {};

if (ADV_par_Tablets == 2) then {
	if ( isClass(configFile >> "CfgPatches" >> "ACE_DAGR") && _ACE_DAGR > 0 ) then {
		_unit addItem "ACE_DAGR";
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_microdagr") && _ACE_microDAGR > 0 ) then {
		_unit addItem "ACE_microDAGR";
	};
};

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
				_mediBack addItemCargoGlobal ["ACE_adenosine", _ACE_adenosine];
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
				
				if (missionnamespace getVariable ["ace_medical_enableAdvancedWounds",true]) then {
					for "_i" from 1 to _ACE_surgicalKit do { _unit addItem "ACE_surgicalKit"; };
				};
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
				for "_i" from 1 to _ACE_adenosine do { _unit addItem "ACE_adenosine"; };
				
				for "_i" from 1 to _ACE_bloodIV do { _unit addItem "ACE_bloodIV"; };
				for "_i" from 1 to _ACE_bloodIV_500 do { _unit addItem "ACE_bloodIV_500"; };
				for "_i" from 1 to _ACE_bloodIV_250 do { _unit addItem "ACE_bloodIV_250"; };
				for "_i" from 1 to _ACE_plasmaIV do { _unit addItem "ACE_plasmaIV"; };
				for "_i" from 1 to _ACE_plasmaIV_500 do { _unit addItem "ACE_plasmaIV_500"; };
				for "_i" from 1 to _ACE_plasmaIV_250 do { _unit addItem "ACE_plasmaIV_250"; };
				for "_i" from 1 to _ACE_salineIV do { _unit addItem "ACE_salineIV"; };
				for "_i" from 1 to _ACE_salineIV_500 do { _unit addItem "ACE_salineIV_500"; };
				for "_i" from 1 to _ACE_salineIV_250 do { _unit addItem "ACE_salineIV_250"; };
				
				if (missionnamespace getVariable ["ace_medical_enableAdvancedWounds",true]) then {
					for "_i" from 1 to _ACE_surgicalKit do { _unit addItem "ACE_surgicalKit"; };
				};
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
if ( isClass(configFile >> "CfgPatches" >> "ACE_tagging") && !isNil "_ACE_sprayPaintColor" ) then {
	_ACE_sprayPaint_type = switch ( toUpper (_ACE_sprayPaintColor) ) do {
		case "BLACK": {"ACE_sprayPaintBlack"};
		case "BLUE": {"ACE_sprayPaintBlue"};
		case "GREEN": {"ACE_sprayPaintGreen"};
		case "RED": {"ACE_sprayPaintRed"};
		case "RANDOM": { ["ACE_sprayPaintBlack","ACE_sprayPaintBlue","ACE_sprayPaintGreen","ACE_sprayPaintRed"] call BIS_fnc_selectRandom };
		default {""};
	};
	if !(_ACE_sprayPaint_type == "") then { _unit addItem _ACE_sprayPaint_type; };
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
	if ( ( !(side (group _unit) == east) && ADV_par_NVGs == 1 ) || (side (group _unit) == east && ADV_par_opfNVGs == 1) ) then {
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
if ( isClass(configFile >> "CfgPatches" >> "ACE_trenches") ) then {
	if (!isNil "_ACE_EntrenchingTool") then { if ( _ACE_EntrenchingTool > 0 ) then { _unit addItem "ACE_EntrenchingTool"; }; };
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
	
true;
if (!isServer) exitWith {};

private ["_target","_weapons","_ammo","_ammoCount","_grenades","_grenadeCount","_items""_isMedic"];

/*
_target = _this select 0;
_isMedic = [_this, 1, false, [true]] call BIS_fnc_param;
_withWeapons = [_this, 2, false, [true]] call BIS_fnc_param;
_amountOfSpareParts = [_this, 3, 1, [0]] call BIS_fnc_param;
_isRepairVehicle = [_this, 4, false, [0,true]] call BIS_fnc_param;
*/
params [
	["_target", objNull, [objNull]], 
	["_isMedic", false, [true]], 
	["_withWeapons", false, [true]], 
	["_amountOfSpareParts", 1, [0]],
	["_isRepairVehicle", false, [0,true]]
];

if (_target isEqualTo objNull) exitWith {};

_backpacks = [];
//weapons and ammo
if (_withWeapons) then {
	_target addWeaponCargoGlobal ["LIB_PzFaust_30m",1];
	_target addMagazineCargoGlobal ["LIB_1Rnd_PzFaust_30m",1];
	
	_target addMagazineCargoGlobal ["LIB_50Rnd_792x57",10];
	_target addMagazineCargoGlobal ["LIB_5Rnd_792x57",30];
	_target addMagazineCargoGlobal ["LIB_32Rnd_9x19",10];
	
	_target addMagazineCargoGlobal ["LIB_shg24",12];
	_target addMagazineCargoGlobal ["LIB_rpg6",2];
};

_target addItemCargoGlobal ["ToolKit",1];
if (_isRepairVehicle) then { (firstBackpack _target) addItemCargoGlobal ["Toolkit",1] ; };

call {
	if (missionnamespace getVariable ["ace_medical_enableAdvancedWounds",false]) exitWith {
		_ACE_fieldDressing = 10;
		_ACE_packingBandage = 10;
		_ACE_elasticBandage = 10;
		_ACE_quikclot = 10;
	};
	_ACE_fieldDressing = 30;
	_ACE_packingBandage = 0;
	_ACE_elasticBandage = 0;
	_ACE_quikclot = 0;
};
_ACE_atropine = 0;
_ACE_epinephrine = 4;
_ACE_morphine = 4;
_ACE_tourniquet = 3;
_ACE_bloodIV = 0;
_ACE_bloodIV_500 = 0;
_ACE_bloodIV_250 = 0;
_ACE_plasmaIV = 0;
_ACE_plasmaIV_500 = 0;
_ACE_plasmaIV_250 = 0;
_ACE_salineIV = 0;
_ACE_salineIV_500 = 5;
_ACE_salineIV_250 = 0;
_ACE_bodyBag = 2;
if ( (missionnamespace getVariable ["ace_medical_consumeItem_PAK",0]) == 0 ) then {
	_ACE_personalAidKit = 0;
} else {
	_ACE_personalAidKit = 2;
};
if ( (missionnamespace getVariable ["ace_medical_consumeItem_SurgicalKit",0]) == 0 ) then {
	_ACE_surgicalKit = 1;
} else {
	_ACE_surgicalKit = 10;
};

_FAKs = 5;
_mediKit = 0;
	
//medical items:
if (_isMedic) then {
	_ACE_fieldDressing = 30;
	_ACE_packingBandage = 30;
	_ACE_elasticBandage = 30;
	_ACE_quikclot = 30;
	_ACE_morphine = 20;
	_ACE_epinephrine = 20;
	_ACE_atropine = 10;
	_ACE_tourniquet = 20;
	_ACE_bloodIV = 5;
	_ACE_bloodIV_500 = 10;
	_ACE_bloodIV_250 = 15;
	_ACE_plasmaIV = 5;
	_ACE_plasmaIV_500 = 10;
	_ACE_plasmaIV_250 = 15;
	_ACE_salineIV = 10;
	_ACE_salineIV_500 = 15;
	_ACE_salineIV_250 = 20;
	_ACE_bodyBag = 10;
	if (missionNamespace getVariable ["ACE_medical_consumeItem_PAK",0] == 0) then {
		_ACE_personalAidKit = 1;
	} else {
		_ACE_personalAidKit = 10;
	};
	if ( (missionnamespace getVariable ["ace_medical_consumeItem_SurgicalKit",0]) == 0 ) then {
		_ACE_surgicalKit = 1;
	} else {
		_ACE_surgicalKit = 10;
	};
	_FAKs = 30;
	_mediKit = 2;
	
	_target setVariable ["ACE_medical_medicClass", 2, true];
};

if !(isClass (configFile >> "CfgPatches" >> "ACE_medical")) then {
	_target addItemCargoGlobal ["FirstAidKit",_FAKs];
	_target addItemCargoGlobal ["MediKit",_mediKit];
};

//ACE items (if ACE is running on the server) - (integers)
if (isClass (configFile >> "CfgPatches" >> "ACE_common")) then {
	_ACE_EarPlugs = 5;

	_ACE_SpareBarrel = 0;
	_ACE_tacticalLadder = 0;
	_ACE_UAVBattery = 0;
	_ACE_wirecutter = 1;
	_ACE_sandbag = 20;
	_ACE_Clacker = 0;
	_ACE_M26_Clacker = 0;
	_ACE_DeadManSwitch = 0;
	_ACE_DefusalKit = 0;
	_ACE_Cellphone = 0;
	_ACE_MapTools = 0;
	_ACE_CableTie = 0;
	_ACE_NonSteerableParachute = 0;

	_ACE_key_west = 0;
	_ACE_key_east = 0;
	_ACE_key_indp = 0;
	_ACE_key_civ = 0;
	_ACE_key_master = 0;
	_ACE_key_lockpick = 0;
	_ACE_kestrel = 0;
	_ACE_ATragMX = 0;
	_ACE_rangecard = 0;
	_ACE_altimeter = 0;
	_ACE_microDAGR = 0;
	_ACE_DAGR = 0;
	_ACE_RangeTable_82mm = 0;
	_ACE_rangefinder = 0;
	_ACE_NonSteerableParachute = 0;
	_ACE_IR_Strobe = 2;
	_ACE_M84 = 0;
	_ACE_HandFlare_Green = 0;
	_ACE_HandFlare_Red = 0;
	_ACE_HandFlare_White = 0;
	_ACE_HandFlare_Yellow = 0;
	[_target] call ADV_fnc_addACEItems;
	if ( isClass (configFile >> "CfgPatches" >> "ACE_repair") && isClass (configFile >> "CfgPatches" >> "ACE_cargo") ) then {
		if (_isRepairVehicle) then {
			_target setVariable ["ACE_isRepairVehicle", 1, true];
			[_target,_amountOfSpareParts-1,"ACE_Track",true] call ACE_repair_fnc_addSpareParts;
			[_target,_amountOfSpareParts-1,"ACE_Wheel",true] call ACE_repair_fnc_addSpareParts;
		} else {
			[_target,_amountOfSpareParts-1,"",true] call ACE_repair_fnc_addSpareParts;
		};
	};
	if ( (_target isKindOf "Helicopter") && isClass (configFile >> "CfgPatches" >> "ACE_fastroping") ) then {
		[_target] call ace_fastroping_fnc_equipFRIES;
	};
};

//backpacks & parachutes
if (_target isKindOf "Air") then {
	_parachutes = ["B_Parachute"];
	_freeSpaces = _target emptyPositions "cargo";
	_freeSpaces = _freeSpaces + (_target emptyPositions "Gunner");
	_freeSpaces = _freeSpaces + (_target emptyPositions "Driver");
	_freeSpaces = _freeSpaces + (_target emptyPositions "Commander");
	if (_freeSpaces > 8) then {_freespaces = 8};
	{_target addBackpackCargoGlobal [_x, _freeSpaces];} count _parachutes;
};
{_target addBackpackCargoGlobal [_x, 1];} count _backpacks;

if (true) exitWith {true;};
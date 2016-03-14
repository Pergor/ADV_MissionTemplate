/*
[vehiclename,false,true,2,false] call ADV_opf_fnc_vehicleLoad;
*/

if (!isServer) exitWith {};

private ["_target","_weapons","_ammo","_ammoCount","_grenades","_grenadeCount","_items","_bandages","_morphine","_epipen","_bloodbag","_isMedic","_AGM_items","_jerryCan","_sparewheel"];

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

_backpacks = [];

//weapons and ammo
if (_withWeapons) then {
	switch (true) do {
		case (ADV_par_opfWeap == 1 && ADV_par_opfWeap == 2): {
			_target addWeaponCargoGlobal ["rhs_weap_ak74m_folded",1];
			_target addWeaponCargoGlobal ["rhs_weap_rpg7",1];

			_target addMagazineCargoGlobal ["rhs_30Rnd_545x39_AK",20];
			_target addMagazineCargoGlobal ["rhs_30Rnd_545x39_AK_green",10];
			_target addMagazineCargoGlobal ["rhs_100Rnd_762x54mmR",5];
			_target addMagazineCargoGlobal ["rhs_rpg7_PG7VL_mag",2];
			
			_target addMagazineCargoGlobal ["rhs_mag_rgd5",5];
			_target addMagazineCargoGlobal ["rhs_mag_rdg2_white",10];
			_target addMagazineCargoGlobal ["rhs_mag_rdg2_black",10];
			
			_target addMagazineCargoGlobal ["rhs_VOG25",5];
			_target addMagazineCargoGlobal ["rhs_GRD40_White",10];
		};
		case (ADV_par_opfWeap == 3): {
			_target addWeaponCargoGlobal ["CUP_arifle_AKS74U",1];
			_target addWeaponCargoGlobal ["CUP_launch_RPG18",2];

			_target addMagazineCargoGlobal ["CUP_RPG18_M",2];
			_target addMagazineCargoGlobal ["CUP_30Rnd_545x39_AK_M",20];
			_target addMagazineCargoGlobal ["CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",10];
			_target addMagazineCargoGlobal ["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M",5];
			
			_target addMagazineCargoGlobal ["CUP_HandGrenade_RGD5",5];
			_target addMagazineCargoGlobal ["SmokeShell",10];
			_target addMagazineCargoGlobal ["SmokeShellRed",10];

			_target addMagazineCargoGlobal ["CUP_1Rnd_HE_GP25_M",5];
			_target addMagazineCargoGlobal ["CUP_1Rnd_SMOKE_GP25_M",10];
		};
		case (ADV_par_opfWeap == 4): { };
		default {
			_target addWeaponCargoGlobal ["arifle_Katiba_C_F",1];
			_target addWeaponCargoGlobal ["launch_RPG32_F",2];
			_target addMagazineCargoGlobal ["RPG32_F",2];

			_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_green",20];
			_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_green_mag_Tracer",10];
			_target addMagazineCargoGlobal ["200Rnd_65x39_cased_Box",2];
			_target addMagazineCargoGlobal ["150Rnd_93x64_Mag",2];
			_target addMagazineCargoGlobal ["150Rnd_762x51_Box",1];
			_target addMagazineCargoGlobal ["150Rnd_762x51_Box_Tracer",1];
			
			_target addMagazineCargoGlobal ["HandGrenade",5];
			_target addMagazineCargoGlobal ["SmokeShell",10];
			_target addMagazineCargoGlobal ["SmokeShellRed",5];
			_target addMagazineCargoGlobal ["SmokeShellBlue",5];
			
			_target addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",5];
			_target addMagazineCargoGlobal ["1Rnd_SmokeRed_Grenade_shell",10];
		};
	};
};

//helmets and vests
switch (true) do {
	case (ADV_par_opfUni == 1 || ADV_par_opfUni == 2 || ADV_par_opfUni == 3): {
		_target addItemCargoGlobal ["rhs_6b27m",1];
		_target addItemCargoGlobal ["rhs_6b23_6sh92",1];
		_target addBackpackCargoGlobal ["rhs_6b23_6sh92",1];
	};
	case (ADV_par_opfUni == 4): {
		_target addItemCargoGlobal ["V_TacVest_khk",1];
		_target addBackpackCargoGlobal ["rhs_sidor",1];
	};
	case (ADV_par_opfUni == 5): {
		_target addItemCargoGlobal ["V_TacVest_khk",1];
		_target addBackpackCargoGlobal ["B_AssaultPack_rgr",1];
	};
	default {
		_target addItemCargoGlobal ["H_HelmetB_sand",1];
		_target addItemCargoGlobal ["V_TacVest_khk",1];
		_target addBackpackCargoGlobal ["B_AssaultPack_ocamo",1];
	};
};

_target addMagazineCargoGlobal ["Chemlight_red",5];
_target addItemCargoGlobal ["ToolKit",1];

//radios
if (ADV_par_Radios == 1 || ADV_par_Radios == 3) then {
	_target addItemCargoGlobal ["ItemRadio",2];
};

_ACE_fieldDressing = 10;
_ACE_elasticBandage = 10;
_ACE_packingBandage = 10;
_ACE_quikclot = 10;
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
	_ACE_personalAidKit = 5;
};
if ( (missionnamespace getVariable ["ace_medical_consumeItem_SurgicalKit",0]) == 0 ) then {
	_ACE_surgicalKit = 1;
} else {
	_ACE_surgicalKit = 5;
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
	_ACE_MapTools = 1;
	_ACE_CableTie = 5;
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
	_ACE_HandFlare_Red = 4;
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
	{_target addBackpackCargoGlobal [_x, _freeSpaces];} forEach _parachutes;
};
{_target addBackpackCargoGlobal [_x, 1];} forEach _backpacks;

if (true) exitWith {true;};
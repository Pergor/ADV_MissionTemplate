if (!isServer) exitWith {};

private ["_car","_weapons","_ammo","_ammoCount","_grenades","_grenadeCount","_items""_isMedic"];

/*
_car = _this select 0;
_isMedic = [_this, 1, false, [true]] call BIS_fnc_param;
_withWeapons = [_this, 2, false, [true]] call BIS_fnc_param;
_amountOfSpareParts = [_this, 3, 1, [0]] call BIS_fnc_param;
_isRepairVehicle = [_this, 4, false, [0,true]] call BIS_fnc_param;
*/
params [
	["_car", objNull, [objNull]], 
	["_isMedic", false, [true]], 
	["_withWeapons", false, [true]], 
	["_amountOfSpareParts", 1, [0]],
	["_isRepairVehicle", false, [0,true]]
];

_backpacks = [];

//weapons and ammo
if (_withWeapons) then {
	switch (true) do {
		case (ADV_par_indWeap == 2): {
			_car addWeaponCargoGlobal ["rhs_weap_mk18",1];
			_car addWeaponCargoGlobal ["rhs_weap_M136",2];
			
			if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _car addMagazineCargoGlobal ["rhs_m136_mag",2]; };
			_car addMagazineCargoGlobal ["30Rnd_556x45_Stanag",20];
			_car addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_red",10];
			_car addMagazineCargoGlobal ["rhsusf_200Rnd_556x45_soft_pouch",2];
			_car addMagazineCargoGlobal ["rhsusf_100Rnd_762x51",2];
			
			_car addMagazineCargoGlobal ["rhs_mag_m67",5];
			_car addMagazineCargoGlobal ["rhs_mag_an_m8hc",10];
			_car addMagazineCargoGlobal ["rhs_mag_m18_red",5];
			_car addMagazineCargoGlobal ["rhs_mag_m18_green",5];
		};
		case (ADV_par_indWeap == 3): {
			_car addWeaponCargoGlobal ["hlc_smg_mp5a2",1];
			
			if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {
				_car addWeaponCargoGlobal ["rhs_weap_M136",2];
				if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _car addMagazineCargoGlobal ["rhs_m136_mag",2]; };
			} else {
				if (isClass(configFile >> "CfgPatches" >> "ace_disposable")) then {  
					_car addWeaponCargoGlobal ["launch_NLAW_F",2];
				} else {
					_car addWeaponCargoGlobal ["launch_NLAW_F",1];
					_car addMagazineCargoGlobal ["NLAW_F",2];
				};
			};

			_car addMagazineCargoGlobal ["hlc_20rnd_762x51_b_G3",15];
			_car addMagazineCargoGlobal ["hlc_20Rnd_762x51_B_fal",15];
			_car addMagazineCargoGlobal ["hlc_20rnd_762x51_T_G3",5];
			_car addMagazineCargoGlobal ["hlc_20Rnd_762x51_T_fal",5];
			_car addMagazineCargoGlobal ["hlc_100Rnd_762x51_M_M60E4",2];
			_car addMagazineCargoGlobal ["hlc_50rnd_762x51_M_FAL",2];
			
			_car addMagazineCargoGlobal ["HandGrenade",5];
			_car addMagazineCargoGlobal ["SmokeShell",10];
			_car addMagazineCargoGlobal ["SmokeShellRed",5];
			_car addMagazineCargoGlobal ["SmokeShellBlue",5];
		};
		default {
			if (isClass(configFile >> "CfgPatches" >> "ace_disposable")) then {  
				_car addWeaponCargoGlobal ["launch_NLAW_F",2];
			} else {
				_car addWeaponCargoGlobal ["launch_NLAW_F",1];
				_car addMagazineCargoGlobal ["NLAW_F",2];
			};
			if (ADV_par_indWeap == 1) then {
				_car addWeaponCargoGlobal ["arifle_Mk20C_plain_F",1];
				_car addMagazineCargoGlobal ["30Rnd_556x45_Stanag",20];
				_car addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_yellow",10];
			} else {
				_car addWeaponCargoGlobal ["arifle_MXC_F",1];
				_car addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag",20];
				_car addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer",10];
			};
			_car addMagazineCargoGlobal ["200Rnd_65x39_cased_Box",2];
			_car addMagazineCargoGlobal ["130Rnd_338_Mag",2];
			_car addMagazineCargoGlobal ["150Rnd_762x54_Box",1];
			_car addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer",1];
			
			_car addMagazineCargoGlobal ["HandGrenade",5];
			_car addMagazineCargoGlobal ["SmokeShell",10];
			_car addMagazineCargoGlobal ["SmokeShellRed",5];
			_car addMagazineCargoGlobal ["SmokeShellBlue",5];
		};
	};
	_car addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",5];
	_car addMagazineCargoGlobal ["1Rnd_SmokeRed_Grenade_shell",10];
};

//helmets and vests
switch (true) do {
	case (ADV_par_indUni == 1): {
		_car addItemCargoGlobal ["H_HelmetIA",1];
		_car addItemCargoGlobal ["V_PlateCarrierIA1_dgtl",1];
		_car addBackpackCargoGlobal ["B_AssaultPack_dgtl",1];
	};
	default {
		_car addItemCargoGlobal ["H_HelmetB_sand",1];
		_car addItemCargoGlobal ["V_TacVest_blk",1];
		_car addBackpackCargoGlobal ["B_AssaultPack_rgr",1];
	};
};
		
_car addMagazineCargoGlobal ["Chemlight_red",5];
_car addItemCargoGlobal ["ToolKit",1];
if (_isRepairVehicle) then { (firstBackpack _car) addItemCargoGlobal ["Toolkit",1] ; };

//radios
if (ADV_par_Radios == 1 || ADV_par_Radios == 3) then {
	_car addItemCargoGlobal ["ItemRadio",2];
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
	_ACE_personalAidKit = 2;
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

	_FAKs = 30;
	_mediKit = 2;
	
	_car setVariable ["ACE_medical_medicClass", 2, true];
};

if !(isClass (configFile >> "CfgPatches" >> "ACE_medical")) then {
	_car addItemCargoGlobal ["FirstAidKit",_FAKs];
	_car addItemCargoGlobal ["MediKit",_mediKit];
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
	[_car] call ADV_fnc_addACEItems;
	if ( isClass (configFile >> "CfgPatches" >> "ACE_repair") && isClass (configFile >> "CfgPatches" >> "ACE_cargo")) then {
		if (_isRepairVehicle) then { _car setVariable ["ACE_isRepairVehicle", 1, true]; };
		[_car,_amountOfSpareParts-1,"",true] call ACE_repair_fnc_addSpareParts;
	};
};

//backpacks & parachutes
if (_car isKindOf "Air") then {
	_parachutes = ["B_Parachute"];
	_freeSpaces = _car emptyPositions "cargo";
	_freeSpaces = _freeSpaces + (_car emptyPositions "Gunner");
	_freeSpaces = _freeSpaces + (_car emptyPositions "Driver");
	_freeSpaces = _freeSpaces + (_car emptyPositions "Commander");
	if (_freeSpaces > 8) then {_freespaces = 8};
	{_car addBackpackCargoGlobal [_x, _freeSpaces];} forEach _parachutes;
};
{_car addBackpackCargoGlobal [_x, 1];} forEach _backpacks;

if (true) exitWith {true;};
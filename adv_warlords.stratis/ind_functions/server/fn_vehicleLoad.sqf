/*
 * Author: Belbo
 *
 * Adds items to vehicle for INDFOR.
 *
 * Arguments:
 * 0: vehicle - <OBJECT>
 * 1: should the vehicle be a medical vehicle? (optional) - <BOOL>
 * 2: should the vehicle carry weapons and ammunition (optional) - <BOOL>
 * 3: amount of ace-spare parts for the vehicle (optional) - <NUMBER>
 * 5: should the vehicle be a repair vehicle? (optional) - <BOOL>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [MRAP_1, false, true, 2, false] call adv_ind_fnc_vehicleLoad;
 *
 * Public: Yes
 */

params [
	["_target", objNull, [objNull]], 
	["_isMedic", false, [true]], 
	["_withWeapons", false, [true]], 
	["_amountOfSpareParts", 1, [0]],
	["_isRepairVehicle", false, [0,true]]
];

if (_target isEqualTo objNull) exitWith {};

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

_backpacks = [];

//weapons and ammo
if (_withWeapons) then {
	switch (true) do {
		case (_par_indWeap == 2): {
			_target addWeaponCargoGlobal ["rhs_weap_mk18",1];
			_target addWeaponCargoGlobal ["rhs_weap_M136",2];
			
			if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _target addMagazineCargoGlobal ["rhs_m136_mag",2]; };
			_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag",20];
			_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_red",10];
			_target addMagazineCargoGlobal ["rhsusf_200Rnd_556x45_soft_pouch",2];
			_target addMagazineCargoGlobal ["rhsusf_100Rnd_762x51",2];
			_target addMagazineCargoGlobal ["rhsusf_20Rnd_762x51_m118_special_Mag",4];
			
			_target addMagazineCargoGlobal ["rhs_mag_m67",5];
			_target addMagazineCargoGlobal ["rhs_mag_an_m8hc",10];
			_target addMagazineCargoGlobal ["rhs_mag_m18_red",5];
			_target addMagazineCargoGlobal ["rhs_mag_m18_green",5];
		};
		case (_par_indWeap == 3): {
			_target addWeaponCargoGlobal ["hlc_smg_mp5a2",1];
			
			if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {
				_target addWeaponCargoGlobal ["rhs_weap_M136",2];
				if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _target addMagazineCargoGlobal ["rhs_m136_mag",2]; };
			} else {
				if (isClass(configFile >> "CfgPatches" >> "ace_disposable")) then {  
					_target addWeaponCargoGlobal ["launch_NLAW_F",2];
				} else {
					_target addWeaponCargoGlobal ["launch_NLAW_F",1];
					_target addMagazineCargoGlobal ["NLAW_F",2];
				};
			};

			_target addMagazineCargoGlobal ["hlc_20rnd_762x51_b_G3",15];
			_target addMagazineCargoGlobal ["hlc_20Rnd_762x51_B_fal",15];
			_target addMagazineCargoGlobal ["hlc_20rnd_762x51_T_G3",5];
			_target addMagazineCargoGlobal ["hlc_20Rnd_762x51_T_fal",5];
			_target addMagazineCargoGlobal ["hlc_100Rnd_762x51_M_M60E4",2];
			_target addMagazineCargoGlobal ["hlc_50rnd_762x51_M_FAL",2];
			
			_target addMagazineCargoGlobal ["HandGrenade",5];
			_target addMagazineCargoGlobal ["SmokeShell",10];
			_target addMagazineCargoGlobal ["SmokeShellRed",5];
			_target addMagazineCargoGlobal ["SmokeShellBlue",5];
		};
		case (_par_indWeap == 21): {
			_target addWeaponCargoGlobal ["launch_RPG7_F",1];
			_target addMagazineCargoGlobal ["RPG7_F",2];
			_target addWeaponCargoGlobal ["arifle_AKS_F",1];
			_target addMagazineCargoGlobal ["30Rnd_762x39_Mag_F",20];
			_target addMagazineCargoGlobal ["30Rnd_762x39_Mag_Tracer_F",10];
			_target addMagazineCargoGlobal ["30Rnd_545x39_Mag_F",5];
			_target addMagazineCargoGlobal ["200Rnd_556x45_Box_F",2];

			_target addMagazineCargoGlobal ["150Rnd_762x54_Box",1];
			_target addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer",1];
			_target addMagazineCargoGlobal ["20Rnd_762x51_Mag",4];
			
			_target addMagazineCargoGlobal ["MiniGrenade",5];
			_target addMagazineCargoGlobal ["SmokeShell",10];
			_target addMagazineCargoGlobal ["SmokeShellRed",5];
			_target addMagazineCargoGlobal ["SmokeShellBlue",5];		
		};
		default {
			call {
				if (isClass(configFile >> "CfgPatches" >> "ace_disposable")) exitWith {  
					_target addWeaponCargoGlobal ["launch_NLAW_F",2];
				};
				_target addWeaponCargoGlobal ["launch_NLAW_F",1];
				_target addMagazineCargoGlobal ["NLAW_F",2];
			};
			call {
				if (_par_indWeap==20) exitWith {
					_target addWeaponCargoGlobal ["arifle_SPAR_01_blk_F",1];
					_target addMagazineCargoGlobal ["200Rnd_556x45_Box_Tracer_F",2];
				};
				_target addWeaponCargoGlobal ["arifle_Mk20C_plain_F",1];
				_target addMagazineCargoGlobal ["200Rnd_65x39_cased_Box",2];
			};
			_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag",20];
			_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_yellow",10];
			_target addMagazineCargoGlobal ["130Rnd_338_Mag",2];
			_target addMagazineCargoGlobal ["20Rnd_762x51_Mag",4];
			
			_target addMagazineCargoGlobal ["MiniGrenade",5];
			_target addMagazineCargoGlobal ["SmokeShell",10];
			_target addMagazineCargoGlobal ["SmokeShellRed",5];
			_target addMagazineCargoGlobal ["SmokeShellBlue",5];
		};
	};
	_target addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",5];
	_target addMagazineCargoGlobal ["1Rnd_SmokeRed_Grenade_shell",10];
	
	/*
	if ( isClass (configFile >> "CfgPatches" >> "ACE_cargo") && _par_logisticAmount > 2 ) then {
		if ( ([_target] call ace_cargo_fnc_getCargoSpaceLeft) > 2) then {
			_crate = ["ADV_LOGISTIC_CRATENORMAL",true,independent,getPosASL _target] call adv_fnc_dialogLogistic;
			[_crate,_target] call ace_cargo_fnc_loadItem;
		};
	};
	*/
};

//helmets and vests
switch (true) do {
	case (_par_indUni == 1): {
		_target addItemCargoGlobal ["H_HelmetB",1];
		_target addItemCargoGlobal ["V_TacVest_blk",1];
		_target addBackpackCargoGlobal ["B_AssaultPack_rgr",1];
	};
	default {
		_target addItemCargoGlobal ["H_HelmetIA",1];
		_target addItemCargoGlobal ["V_PlateCarrierIA1_dgtl",1];
		_target addBackpackCargoGlobal ["B_AssaultPack_dgtl",1];
	};
};
		
_target addMagazineCargoGlobal ["Chemlight_red",5];
_target addItemCargoGlobal ["ToolKit",1];
if (_isRepairVehicle) then { (firstBackpack _target) addItemCargoGlobal ["Toolkit",1] ; };

//radios
if (_par_Radios == 1 || _par_Radios == 3) then {
	_target addItemCargoGlobal ["ItemRadio",2];
};

_ACE_fieldDressing = 30;
_ACE_packingBandage = 0;
_ACE_elasticBandage = 0;
_ACE_quikclot = 0;
if (missionnamespace getVariable ["ace_medical_enableAdvancedWounds",false]) then {
	_ACE_fieldDressing = 10;
	_ACE_packingBandage = 10;
	_ACE_elasticBandage = 10;
	_ACE_quikclot = 10;
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
_ACE_personalAidKit = 0;
if ( (missionnamespace getVariable ["ace_medical_consumeItem_PAK",0]) > 0 ) then {
	_ACE_personalAidKit = 1;
};
_ACE_surgicalKit = 1;
if ( (missionnamespace getVariable ["ace_medical_consumeItem_SurgicalKit",0]) > 0 ) then {
	_ACE_surgicalKit = 10;
};
_adv_aceCPR_AED = 0;
_ACE_advACEsplint_splint = 4;

_FAKs = 5;
_mediKit = 0;

if (isClass(configFile >> "CfgPatches" >> "adv_aceRefill")) then {
	_target addItemCargoGlobal ["adv_aceRefill_FAK",5];
	_ACE_fieldDressing = 10;
	_ACE_morphine = 2;
};
	
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
	_ACE_personalAidKit = 1;
	if (isClass(configFile >> "CfgPatches" >> "adv_aceCPR")) then {
		_ACE_personalAidKit = 0;
	};
	if (missionNamespace getVariable ["ACE_medical_consumeItem_PAK",0] > 0) then {
		_ACE_personalAidKit = 5;
	};
	_ACE_surgicalKit = 1;
	if ( (missionnamespace getVariable ["ace_medical_consumeItem_SurgicalKit",0]) > 0 ) then {
		_ACE_surgicalKit = 10;
	};
	_adv_aceCPR_AED = 2;
	_ACE_advACEsplint_splint = 24;
	
	_FAKs = 30;
	_mediKit = 2;
	
	if (isClass(configFile >> "CfgPatches" >> "adv_aceRefill")) then {
		_target addItemCargoGlobal ["adv_aceRefill_manualKit",2];
		_target addItemCargoGlobal ["adv_aceRefill_FAK",15];
	};
	
	_target setVariable ["ACE_medical_medicClass", 2, true];
	
	if ( isClass (configFile >> "CfgPatches" >> "ACE_cargo") && _par_logisticAmount > 2 ) then {
		if ( ([_target] call ace_cargo_fnc_getCargoSpaceLeft) > 2) then {
			_crate = ["ADV_LOGISTIC_CRATEMEDIC",true,independent,getPosASL _target] call adv_fnc_dialogLogistic;
			[_crate,_target] call ace_cargo_fnc_loadItem;
		};
	};
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
		call {
			if (_isRepairVehicle) exitWith {
				_target setVariable ["ACE_isRepairVehicle", 1, true];
				call {
					if (_target isKindOf "TANK") exitWith {
						["ACE_Track", _target, _amountOfSpareParts-1] call ace_cargo_fnc_addCargoItem;
						["ACE_Wheel", _target, _amountOfSpareParts] call ace_cargo_fnc_addCargoItem;
					};
				["ACE_Track", _target, _amountOfSpareParts] call ace_cargo_fnc_addCargoItem;
				["ACE_Wheel", _target, _amountOfSpareParts-1] call ace_cargo_fnc_addCargoItem;
				};
				//[_target,_amountOfSpareParts-1,"ACE_Track",true] call ACE_repair_fnc_addSpareParts;
				//[_target,_amountOfSpareParts-1,"ACE_Wheel",true] call ACE_repair_fnc_addSpareParts;
			};
			call {
				if (_target isKindOf "CAR") exitWith {
					["ACE_Wheel", _target, _amountOfSpareParts-1] call ace_cargo_fnc_addCargoItem;
				};
				if (_target isKindOf "TANK") exitWith {
					["ACE_Track", _target, _amountOfSpareParts-1] call ace_cargo_fnc_addCargoItem;
				};
			};
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
	if (_freeSpaces > 8) then {_freespaces = 8};
	if (_target isKindOf "Helicopter") then { _freespaces = 2 };
	{_target addBackpackCargoGlobal [_x, _freeSpaces];} count _parachutes;
};
{_target addBackpackCargoGlobal [_x, 1];} count _backpacks;

true;
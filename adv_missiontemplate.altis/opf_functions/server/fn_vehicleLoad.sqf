/*
 * Author: Belbo
 *
 * Adds items to vehicle for OPFOR.
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
 * [MRAP_1, false, true, 2, false] call adv_opf_fnc_vehicleLoad;
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
		case (_par_opfWeap == 1 || _par_opfWeap == 2): {
			_target addWeaponCargoGlobal ["rhs_weap_ak74m_folded",1];
			_target addWeaponCargoGlobal ["rhs_weap_rpg7",1];

			_target addMagazineCargoGlobal ["rhs_30Rnd_545x39_AK",20];
			_target addMagazineCargoGlobal ["rhs_30Rnd_545x39_AK_green",10];
			call {
				if (isClass(configFile >> "CfgPatches" >> "CUP_weapons_AK")) exitWith {
					call {
						if (_par_opfWeap == 1) then {
							_target addMagazineCargoGlobal ["CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",5];
						};
						_target addMagazineCargoGlobal ["CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",5];
					};
				};
				_target addMagazineCargoGlobal ["rhs_100Rnd_762x54mmR_green",5];
			};
			_target addMagazineCargoGlobal ["rhs_rpg7_PG7VL_mag",2];
			_target addMagazineCargoGlobal ["rhs_10Rnd_762x54mmR_7N1",4];
			
			_target addMagazineCargoGlobal ["rhs_mag_rgd5",5];
			_target addMagazineCargoGlobal ["rhs_mag_rdg2_white",10];
			_target addMagazineCargoGlobal ["rhs_mag_rdg2_black",10];
			
			_target addMagazineCargoGlobal ["rhs_VOG25",5];
			_target addMagazineCargoGlobal ["rhs_GRD40_White",10];
		};
		case (_par_opfWeap == 3): {
			_target addWeaponCargoGlobal ["CUP_arifle_AKS74U",1];
			_target addWeaponCargoGlobal ["CUP_launch_RPG18",2];

			_target addMagazineCargoGlobal ["CUP_RPG18_M",2];
			_target addMagazineCargoGlobal ["CUP_30Rnd_545x39_AK_M",20];
			_target addMagazineCargoGlobal ["CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",10];
			_target addMagazineCargoGlobal ["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M",5];
			_target addMagazineCargoGlobal ["CUP_10Rnd_762x54_SVD_M",4];
			
			_target addMagazineCargoGlobal ["CUP_HandGrenade_RGD5",5];
			_target addMagazineCargoGlobal ["SmokeShell",10];
			_target addMagazineCargoGlobal ["SmokeShellRed",10];

			_target addMagazineCargoGlobal ["CUP_1Rnd_HE_GP25_M",5];
			_target addMagazineCargoGlobal ["CUP_1Rnd_SMOKE_GP25_M",10];
		};
		case (_par_opfWeap == 4): { };
		default {
			switch (true) do {
				case (_par_opfWeap == 21): {
					_target addWeaponCargoGlobal ["arifle_AK12_F",1];
					_target addWeaponCargoGlobal ["launch_RPG32_ghex_F",2];
					_target addMagazineCargoGlobal ["30Rnd_762x39_Mag_F",20];
					_target addMagazineCargoGlobal ["30Rnd_762x39_Mag_Tracer_F",10];
					_target addMagazineCargoGlobal ["100Rnd_580x42_Mag_F",4];
				};
				case (worldName == "TANOA" || _par_opfWeap == 20): {
					_target addWeaponCargoGlobal ["arifle_CTAR_blk_F",1];
					_target addWeaponCargoGlobal ["launch_RPG32_ghex_F",2];
					_target addMagazineCargoGlobal ["30Rnd_580x42_Mag_F",20];
					_target addMagazineCargoGlobal ["30Rnd_580x42_Mag_Tracer_F",10];
					_target addMagazineCargoGlobal ["100Rnd_580x42_Mag_F",4];
				};
				default {
					_target addWeaponCargoGlobal ["arifle_Katiba_C_F",1];
					_target addWeaponCargoGlobal ["launch_RPG32_F",2];
					_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_green",20];
					_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_green_mag_Tracer",10];
					_target addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer",2];
				};
			};
			_target addMagazineCargoGlobal ["RPG32_F",2];

			_target addMagazineCargoGlobal ["150Rnd_93x64_Mag",2];
			_target addMagazineCargoGlobal ["10Rnd_762x51_Mag",4];
			_target addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag",4];
			//_target addMagazineCargoGlobal ["150Rnd_762x51_Box",1];
			//_target addMagazineCargoGlobal ["150Rnd_762x51_Box_Tracer",1];
			
			_target addMagazineCargoGlobal ["MiniGrenade",5];
			_target addMagazineCargoGlobal ["SmokeShell",10];
			_target addMagazineCargoGlobal ["SmokeShellRed",5];
			_target addMagazineCargoGlobal ["SmokeShellBlue",5];
			
			_target addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",5];
			_target addMagazineCargoGlobal ["1Rnd_SmokeRed_Grenade_shell",10];
		};
	};
	
	/*
	if ( isClass (configFile >> "CfgPatches" >> "ACE_cargo") && _par_logisticAmount > 2 ) then {
		if ( ([_target] call ace_cargo_fnc_getCargoSpaceLeft) > 2) then {
			_crate = ["ADV_LOGISTIC_CRATENORMAL",true,east,getPosASL _target] call adv_fnc_dialogLogistic;
			[_crate,_target] call ace_cargo_fnc_loadItem;
		};
	};
	*/
};

//helmets and vests
switch (true) do {
	case (_par_opfUni == 1 || _par_opfUni == 2 || _par_opfUni == 3): {
		_target addItemCargoGlobal ["rhs_6b27m",1];
		_target addItemCargoGlobal ["rhs_6b23_6sh92",1];
		_target addBackpackCargoGlobal ["rhs_6b23_6sh92",1];
	};
	case (_par_opfUni == 4): {
		_target addItemCargoGlobal ["V_TacVest_khk",1];
		_target addBackpackCargoGlobal ["rhs_sidor",1];
	};
	case (_par_opfUni == 5): {
		_target addItemCargoGlobal ["V_TacVest_khk",1];
		_target addBackpackCargoGlobal ["B_AssaultPack_rgr",1];
	};
	case (_par_opfUni == 20): {
		_target addItemCargoGlobal ["H_HelmetSpecO_ghex_F",1];
		_target addItemCargoGlobal ["V_TacVest_oli",1];
		_target addBackpackCargoGlobal ["B_AssaultPack_rgr",1];
	};
	default {
		_target addItemCargoGlobal ["H_HelmetO_ocamo",1];
		_target addItemCargoGlobal ["V_TacVest_khk",1];
		_target addBackpackCargoGlobal ["B_AssaultPack_ocamo",1];
	};
};

_target addMagazineCargoGlobal ["Chemlight_red",5];
_target addItemCargoGlobal ["ToolKit",1];

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
			_crate = ["ADV_LOGISTIC_CRATEMEDIC",true,east,getPosASL _target] call adv_fnc_dialogLogistic;
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
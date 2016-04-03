/*
ADV_fnc_CSW by Belbo:

Adds crew served weapon packs to a unit.

Possible call - has to be executed on the client the unit is local to.
[player,1] call ADV_fnc_CSW

_this select 0 = unit the weapon will be added to.
_this select 1 = kind of weapon pack (1 = HMG weapon backpack; 2 = HMG tripod; 3 = Mortar tube; 4 = Mortar base plate;)
*/

params [
	["_target", player, [objNull]],
	["_type", 1, [0]],
	"_backpack"
];

if !(side (group _target) == east) then {
	_backpack = switch ( _type ) do {
		case 1: {"B_HMG_01_weapon_F"};
		case 2: {"B_HMG_01_support_F"};
		case 3: {"I_Mortar_01_weapon_F"};
		case 4: {"I_Mortar_01_support_F"};
		case 5: {"B_AT_01_weapon_F"};
		case 6: {"B_HMG_01_support_F"};
		default {""};
	};
} else {
	_backpack = switch ( _type ) do {
		case 1: {"O_HMG_01_weapon_F"};
		case 2: {"O_HMG_01_support_F"};
		case 3: {"O_Mortar_01_weapon_F"};
		case 4: {"O_Mortar_01_support_F"};
		case 5: {"O_AT_01_weapon_F"};
		case 6: {"O_HMG_01_support_F"};
		default {""};
};

if (!isNil "ADV_par_customWeap") then {
	if ( ADV_par_customWeap > 0 ) then {
		if !(side (group _target) == east) then {
			if ( isClass(configFile >> "CfgPatches" >> "rhsusf_main") then {
				_backpack = switch ( _type ) do {
					case 1: {"RHS_M2_Gun_Bag"};
					case 2: {"RHS_M2_MiniTripod_Bag"};
					case 3: {"rhs_M252_Gun_Bag"};
					case 4: {"rhs_M252_Bipod_Bag"};
					case 5: {"rhs_Tow_Gun_Bag"};
					case 6: {"rhs_TOW_Tripod_Bag"};
				};
			};
		} else {
			if ( isClass(configFile >> "CfgPatches" >> "rhs_main") then {
				_backpack = switch ( _type ) do {
					case 1: {"RHS_Kord_Gun_Bag"};
					case 2: {"RHS_Kord_Tripod_Bag"};
					case 3: {"RHS_Podnos_Gun_Bag"};
					case 4: {"RHS_Podnos_Bipod_Bag"};
					case 5: {"RHS_SPG9_Gun_Bag"};
					case 6: {"RHS_SPG9_Tripod_Bag"};
				};
			};
		};
	};
} else {
	if !(side (group _target) == east) then {
		if ( isClass(configFile >> "CfgPatches" >> "rhsusf_main") then {
			_backpack = switch ( _type ) do {
				case 1: {"RHS_M2_Gun_Bag"};
				case 2: {"RHS_M2_MiniTripod_Bag"};
				case 3: {"rhs_M252_Gun_Bag"};
				case 4: {"rhs_M252_Bipod_Bag"};
				case 5: {"rhs_Tow_Gun_Bag"};
				case 6: {"rhs_TOW_Tripod_Bag"};
			};
		};
	} else {
		if ( isClass(configFile >> "CfgPatches" >> "rhs_main") then {
			_backpack = switch ( _type ) do {
				case 1: {"RHS_Kord_Gun_Bag"};
				case 2: {"RHS_Kord_Tripod_Bag"};
				case 3: {"RHS_Podnos_Gun_Bag"};
				case 4: {"RHS_Podnos_Bipod_Bag"};
				case 5: {"RHS_SPG9_Gun_Bag"};
				case 6: {"RHS_SPG9_Tripod_Bag"};
			};
		};
	};
};

if !(backpack _target == "") then { removeBackpack _target; };
if ( isClass(configFile >> "CfgPatches" >> "ace_mk6mortar") && (_type == 2 || _type == 3) ) then {
	_target addItem "ACE_RangeTable_82mm";
};
_target addBackpack _backpack;

true;
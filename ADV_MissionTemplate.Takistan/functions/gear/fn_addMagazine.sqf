/*
ADV_fnc_addMagazine - by Belbo:

Adds given amount of magazines for the provided weapon of a unit to it's inventory.

Possible call - has to be executed on client the unit is local to:
[player,6,0,1,false] call ADV_fnc_addMagazine; //adds 6 magazine with the index of 1 for the primary weapon to the player at any free space in inventory.

_this select 0 = unit that should receive the magazines
_this select 1 = amount of magazines to be added. (When _this select 1 is empty, only one magazine will be added for each call.)
_this select 2 = weapon slot for which the magazines should be selected. (0 = primary Weapon, 1 = handgun, 2 = secondary weapon; Primary Weapon is selected if _this select 2 is empty.)
_this select 3 = magazine index number. (Depending on the weapon. If _this select 3 is nil, the same magazine as the current magazine will be added. If no magazine is currently loaded into the weapon, 
the index will be 0 and a standard magazine will be added.)
_this select 4 = Boolean if magazines should be added to backpack of unit or not, if backpack is present.
*/

params [
	["_unit", objNull, [objNull]],
	["_magazineCount", 1, [0]],
	["_weaponSlot", 0, [0]],
	["_magazineClassType", 99, [0,""]],
	["_addToBackpack", false, [true]],
	"_weapon","_magazine","_magazines","_magazineClass"
];

_weapon = switch _weaponSlot do {
	case 1: {handgunWeapon _unit;};
	case 2: {secondaryWeapon _unit;};
	default {primaryWeapon _unit;};
};
_magazine = switch _weaponSlot do {
	case 1: {handgunMagazine _unit};
	case 2: {secondaryWeaponMagazine _unit};
	default {primaryWeaponMagazine _unit};
};

if (typeName (_magazineClassType) == "STRING") then {
	if (_addToBackpack && !(backpack _unit == "")) then {
		(unitBackpack _unit) addItemCargoGlobal [_magazineClassType,_magazineCount];
	} else {
		_unit addMagazines [_magazineClassType,_magazineCount];
	};
} else {
	if (_weapon in weapons _unit) then {
		_magazines = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
		if (count _magazines > 0) then {
			_magazineClass = _magazines select (_magazineClassType min (count _magazines - 1));
		} else {
			_magazineClass = "";
		};
		if (isClass (configFile / "CfgMagazines" / _magazineClass)) then {
			if (count _magazine == 0) then {
				if (_magazineClassType == 99) then {
					_magazineClass = _magazines select (0 min (count _magazines - 1));
				};
				if (_addToBackpack && !(backpack _unit == "")) then {
					(unitBackpack _unit) addItemCargoGlobal [_magazineClass,_magazineCount];
				} else {
					for "_i" from 1 to _magazineCount do {
						_unit addMagazine _magazineClass;
					};
				};
			} else {
				if (_magazineClassType == 99) then {
					if (_addToBackpack && !(backpack _unit == "")) then {
						(unitBackpack _unit) addItemCargoGlobal [_magazine,_magazineCount];
					} else {
						_unit addMagazines [_magazine] + [_magazineCount];
					};
				} else {
					if (_addToBackpack && !(backpack _unit == "")) then {
						(unitBackpack _unit) addItemCargoGlobal [_magazineClass,_magazineCount];
					} else {
						_unit addMagazines [_magazineClass] + [_magazineCount];
					};
				};
			};
		};
	};
};

if (true) exitWith {};
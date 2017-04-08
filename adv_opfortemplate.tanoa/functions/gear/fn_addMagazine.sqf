/*
 * Author: Belbo
 *
 * Adds given amount of magazines for the provided weapon of a unit to it's inventory.
 *
 * Arguments:
 * 0: target - <OBJECT>
 * 1: Amount of magazines to be added (optional) - <NUMBER>
 * 2: Weapon slot (0 = primaryWeapon, 1 = handgun, 2 = secondary wepaon) (optional) - <NUMBER>
 * 3: Magazine index number  (depending on the weapons config) or classname (optional) - <NUMBER> or <STRING>
 * 4: Should magazines be added to backpack if the unit has one? (optional) - <BOOL>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [player] call adv_fnc_addMagazine;
 *
 * Public: No
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

true;
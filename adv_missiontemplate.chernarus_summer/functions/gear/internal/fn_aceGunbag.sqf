/*
 * Author: BlauBaer, Belbo
 *
 * Adds a weapon to the ace_gunbag backpack of target.
 *
 * Arguments:
 * 0: target - <OBJECT>
 * 1: classname of weapon to add to ace_gunbag - <STRING>
 * 2: weaponItems to be added to the weapon in the bag - <ARRAY> of <STRINGS>
 * 3: Magazines to be added to the weapon in the bag - <ARRAY> in format of [<STRING>,<NUMBER>]
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [player] call adv_fnc_aceGunbag;
 *
 * Public: Yes
 */

params [
	["_unit", player, [objNull]],
	["_weapon", "", [""]],
	["_items", [""], [[]]],
	["_magazines", ["",0], [[]]],
	"_gunbag","_mass","_gunbagItems"
];

if !( toUpper (backpack _unit) in ["ACE_GUNBAG","ACE_GUNBAG_TAN"] ) exitWith {false};

_gunbag = backpackContainer _unit;
_mass = getNumber (configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "mass");
[_unit, _gunbag, _mass] call ace_movement_fnc_addLoadToUnitContainer;
_gunbag setVariable ["ace_gunbag_gunbagWeapon", [_weapon, _items, [_magazines]], true];

true;
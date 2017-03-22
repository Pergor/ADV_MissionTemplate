/*
adv_fnc_aceGunbag by BlauBaer/Belbo

_this select 0 = unit that will have the weapon in its gunbag.
_this select 1 = weapon to be put in the gunbag

Return: Nothing
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

nil;
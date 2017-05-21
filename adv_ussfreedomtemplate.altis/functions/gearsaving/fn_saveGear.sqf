/*
 * Author: Belbo
 *
 * Saves loadout of unit in adv_missiontemplate-variable.
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [player] call adv_fnc_saveGear;
 *
 * Public: No
 */

params [
	["_unit", player, [objNull]]
];

adv_saveGear_loadout = getUnitLoadout _unit;

true;
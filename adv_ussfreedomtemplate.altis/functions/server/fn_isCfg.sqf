/*
 * Author: Belbo
 *
 * Returns true if provided cfg-entry is present
 *
 * Arguments:
 * 1: tested entry - <STRING>
 * 2: cfg to be checked (optional) - <STRING>
 *
 * Return Value:
 * Is cfg-entry present? - <BOOL>
 *
 * Example:
 * ["ace_medical"] call adv_fnc_getCfg;		//will return true if (isClass(configFile >> "cfgPatches" >> "ace_medical"))
 *
 * Public: No
 */

params [
	["_entry","",[""]]
	,["_cfg","cfgPatches",[""]]
];

isClass (configFile >> _cfg >> _entry)
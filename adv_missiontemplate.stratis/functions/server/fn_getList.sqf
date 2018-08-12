/*
 * Author: Belbo
 *
 * Takes a string and returns an array containing the single entries as strings, divided by commas
 *
 * Arguments:
 * 0: string - <STRING>
 * 1: cfg-Name to check. If value is provided, only those entries will be added to the array that are found in the cfg. (optional) - <STRING>
 *
 * Return Value:
 * List of single entries. <ARRAY> of <STRINGS>
 *
 * Example:
 * _array = ["B_MRAP_01_F, 'B_MRAP_01_F', 'O_MRAP_02_F', ""B_MRAP_01_hmg_F"", blipblup","CfgVehicles"] call adv_fnc_getList; // ["B_MRAP_01_F", "O_MRAP_02_F", "B_MRAP_01_hmg_F"]
 * _array = ["B_MRAP_01_F, 'B_MRAP_01_F', 'O_MRAP_02_F', ""B_MRAP_01_hmg_F"", blipblup"] call adv_fnc_getList; // ["B_MRAP_01_F", "O_MRAP_02_F", "B_MRAP_01_hmg_F", "blipblup"]
 *
 * Public: No
 */

params [
	"_str"
	,["_cfg","",[""]]
];

private _clipString = _str splitString ",""[]()'";
private _array = [];
{
	if (isClass(configFile >> _cfg >> _x) || _cfg isEqualTo "") then {
		_array pushBackUnique _x
	};
	nil
} count _clipString;

_array

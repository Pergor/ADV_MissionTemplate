/*
 * Author: Belbo
 *
 * Adds standard eventhandler to curators.
 *
 * Arguments:
 * 0: name of curator module (optional) - <OBJECT>
 *
 * Return Value:
 * Script handle - <HANDLE>
 *
 * Example:
 * _handle = [curator_1] call adv_fnc_zeusEVH;
 *
 * Public: Yes
 */

params ["_target"];

private _handle = _target addEventHandler [
	"CuratorObjectPlaced"
	,{
		params ["_curator","_unit"];
		(crew _unit) call adv_fnc_setSkill;
	}
];

_handle;
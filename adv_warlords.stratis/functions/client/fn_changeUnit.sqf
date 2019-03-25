/*
 * Author: Belbo
 *
 * Changes the vehicleVarName of a unit
 *
 * Arguments:
 * 0: target - <OBJECT>
 * 1: new vehicleVarName - <STRING>
 *
 * Return Value:
 * new vehicleVarName - <STRING>
 *
 * Example:
 * [cursorTarget, "player_2"] call adv_fnc_changeUnit;
 *
 * Public: Yes
 */

params [
	["_target", objNull, [objNull]],
	["_newName", "", [""]]
];

if !(local _target) exitWith {false};

//private _oldName = str _target;
//_target call compile format ["%1 = _this; publicVariable '%1'", _newName];
_target call compile format ["missionNamespace setVariable ['%1',_this,true]", _newName];
[_target,_newName] remoteExec ["setVehicleVarName",0];

private _return = vehicleVarName _target;
_return
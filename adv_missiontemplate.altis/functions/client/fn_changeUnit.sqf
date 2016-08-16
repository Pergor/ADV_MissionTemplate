/*
adv_fnc_changeUnit by Belbo

Changes the vehicleVarName of a unit.

Possible call - has to be executed on server or client locally:
[TARGET,"NEWVARNAME"] call ADV_fnc_changeName;

_this select 0 = unit that has to be renamed (object).
_this select 1 = new varName (string)

Returns new unit varName.
*/

params [
	["_target", objNull, [objNull]],
	["_newName", "", [""]]
];

private _oldName = str _target;
[_target,_newName] remoteExec ["setVehicleVarName",0];
_target call compile format ["%1 = _this; publicVariable '%1'", _newName];

private _return = vehicleVarName _target;
_return;
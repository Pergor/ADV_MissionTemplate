/*
 * Author: Belbo
 *
 * Creats CAS run on target
 *
 * Arguments:
 * 0: target position, can be position, object or marker - <ARRAY>, <OBJECT>, <STRING>
 * 1: direction of attack, can be string if you want a random direction (optional) - <NUMBER>, <STRING>
 * 2: class of attack plane (optional) - <STRING>
 * 3: type of attack run - 0 = gun only, 1 = rockets only, 2 = gun and rockets (optional) - <NUMBER>
 *
 * Return Value:
 * Function executed <BOOL>
 *
 * Example:
 * [attackLogic,0,"B_Plane_CAS_01_F",0] call ADV_fnc_CASRun;
 *
 * Public: Yes
 */

if (!isServer && hasInterface) exitWith {};

params [
	["_position", [0,0,0], [[],"",objNull]],
	["_direction", "RANDOM", [0,""]],
	["_class", "B_Plane_CAS_01_F", [""]],
	["_type", 0, [0]],
	"_pos","_dummy"
];

private _pos = [_position] call adv_fnc_getPos;

private _dummy = "LaserTargetCBase" createVehicle _pos;
_dummy enableSimulation false; _dummy hideObject true;
_dummy setVariable ["vehicle",_class];
_dummy setVariable ["type",_type];
private _dir = if (_direction isEqualType "") then { random 360 } else { _dir };
_dummy setDir _dir;

[_dummy,nil,true] spawn BIS_fnc_moduleCAS;

[_dummy] spawn {
    sleep 45;
    deleteVehicle (_this select 0);
};

true;
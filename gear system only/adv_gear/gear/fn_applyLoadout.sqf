/*
loadout script by Belbo
adds the loadouts to the specific playable units for the side West
Call from initPlayerLocal.sqf via:
[object,true] call ADV_fnc_applyLoadout;
	with
	_this select 0 = object - target the loadout is applied to.
	_this select 1 = boolean - whether or not the target in _zeus is supposed to be invincible.
*/

///// No editing necessary below this line /////
private ["_object","_target","_invinciZeus"];
_target = [_this, 0, player] call BIS_fnc_param;
_playerUnit = _target getVariable "ADV_var_playerUnit";

//actual call
//[_target] call _loadoutScript;
call compile format ["[%1] call %2;", _target, _playerUnit];
if (!isNil "ADV_respawn_EVH") then { _target removeEventhandler ["Respawn",ADV_respawn_EVH]; };
ADV_respawn_EVH = _target addEventhandler ["Respawn", {[(_this select 0)] call ADV_fnc_applyLoadout;deleteVehicle (_this select 1);systemChat "starting gear applied.";}];

if (true) exitWith {};
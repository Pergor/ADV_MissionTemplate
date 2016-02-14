/*
ADV_fnc_undercover
Makes unit civilian if it has no weapon equipped.

possible call - has to be executed locally on each client the unit is local to:
[player] spawn ADV_fnc_undercover

_this select 0 = unit;
*/

params [
	["_unit", player, [objNull]]
];

ADV_var_undercover = true;

while {ADV_var_undercover} do {
	if (currentWeapon _unit == "" ) then {
		_unit setCaptive true;
		waitUntil {sleep 1; !(currentWeapon _unit == "")};
		if !( currentWeapon _unit == binocular _unit) then {
			_unit setCaptive false;
		};
	};
	sleep 5;
};
_unit setCaptive false;

if (true) exitWith {};
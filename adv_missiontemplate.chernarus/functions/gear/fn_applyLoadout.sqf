/*
ADV_fnc_applyLoadout by Belbo:

Adds a predefined loadout from ADV_MissionTemplate to the units that are named according to adv_fnc_playerUnit.

Possible call - has to be executed on the client locally:
[object] call ADV_fnc_applyLoadout;

_this select 0 = object - target the loadout is applied to.
*/

///// No editing necessary below this line /////

params [
	["_target", player, [objNull]],
	"_playerUnit"
];
if (side _target == sideLogic) exitWith {};
_playerUnit = _target getVariable ["ADV_var_playerUnit","ADV_fnc_nil"];
if ( _playerUnit == "ADV_fnc_nil") exitWith {};

//special stuff for zeus
if (_playerUnit == "ADV_fnc_zeus") then {
	_playerUnit = switch (side _target) do {
		case west: {"ADV_fnc_command"};
		case east: {"ADV_opf_fnc_command"};
		case independent: {"ADV_ind_fnc_command"};
	};
	//makes the playable zeus unit always immortal.
	if (!isNil "ADV_par_invinciZeus") then {
		if (ADV_par_invinciZeus == 1) then {
			_target allowDamage false;
			if (isNil "ADV_invinciZeus_EVH") then {
				ADV_invinciZeus_EVH = _target addEventhandler ["Respawn", {(_this select 0) allowDamage false;}];
			};
		};
	};
};

//respawn gear switch
if (!isNil "ADV_par_CustomLoad") then {
	if (ADV_par_CustomLoad > 0) then {
		call compile format ["[%1] call %2;", _target, _playerUnit];

		[_target] spawn {
			_target = _this select 0;
			sleep 1;
			if (!isNil "ADV_respawn_EVH") then { _target removeEventhandler ["Respawn",ADV_respawn_EVH]; };
			switch (ADV_par_customLoad) do {
				case 0: {
					//No respawn with gear
					ADV_respawn_EVH = _target addEventhandler ["Respawn", {systemChat "no respawn loadout.";}];
				};
				case 1: {
					//respawn with saved gear
					sleep 2;
					aeroson_loadout = [player] call aeroson_fnc_getLoadout;
					ADV_respawn_EVH = _target addEventhandler ["Respawn",{[(_this select 0), aeroson_loadout] spawn aeroson_fnc_setLoadout;systemChat "saved loadout applied.";}];
				};
				case 2: {
					//respawn with starting gear
					ADV_respawn_EVH = _target addEventhandler ["Respawn", {[(_this select 0)] call ADV_fnc_applyLoadout;systemChat "starting gear applied.";}];
				};
				default {};
			};
		};
	};
} else {
	call compile format ["[%1] call %2;", _target, _playerUnit];
	if (!isNil "ADV_respawn_EVH") then { _target removeEventhandler ["Respawn",ADV_respawn_EVH]; };
	ADV_respawn_EVH = _target addEventhandler ["Respawn", {[(_this select 0)] call ADV_fnc_applyLoadout;systemChat "starting gear applied.";}];
};

if (true) exitWith {};
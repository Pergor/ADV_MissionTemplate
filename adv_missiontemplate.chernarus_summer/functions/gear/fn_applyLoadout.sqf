/*
 * Author: Belbo
 *
 * Adds a predefined loadout from ADV_MissionTemplate to the units that are named according to adv_fnc_playerUnit.
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [player] call adv_fnc_applyLoadout;
 *
 * Public: No
 */

params [
	["_target", player, [objNull]],
	"_playerUnit"
];
if (side _target == sideLogic) exitWith {};
_playerUnit = _target getVariable ["ADV_var_playerUnit","ADV_fnc_nil"];
if ( _playerUnit == "ADV_fnc_nil") exitWith {};

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

//special stuff for zeus
if (_playerUnit == "ADV_fnc_zeus") then {
	_playerUnit = switch (side _target) do {
		case west: {"ADV_fnc_command"};
		case east: {"ADV_opf_fnc_command"};
		case independent: {"ADV_ind_fnc_command"};
	};
	//makes the playable zeus unit always immortal.
	if (_par_invinciZeus == 1) then {
		_target allowDamage false;
		if (isNil "ADV_invinciZeus_EVH") then {
			ADV_invinciZeus_EVH = _target addEventhandler ["Respawn", {(_this select 0) allowDamage false;}];
		};
	};
};

//respawn gear switch
if (!isNil "ADV_par_CustomLoad") then {
	if (ADV_par_customLoad > 0) then {
		_target call compile format ["[_this] call %1",_playerUnit];

		[_target] spawn {
			params ["_target"];
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
					adv_saveGear_loadout = getUnitLoadout _target;
					ADV_respawn_EVH = _target addEventhandler ["Respawn",{[(_this select 0), adv_saveGear_loadout] call adv_fnc_readdGear;systemChat "saved loadout applied.";}];
				};
				case 2: {
					//respawn with starting gear
					ADV_respawn_EVH = _target addEventhandler ["Respawn", {[(_this select 0)] call ADV_fnc_applyLoadout;systemChat "starting gear applied.";}];
				};
				default {};
			};
			if (isPlayer _target && (isClass(configFile >> "CfgPatches" >> "task_force_radio")) ) then {
				sleep 2;
				[_target] spawn adv_fnc_setChannels;
			};
		};
	};
} else {
	_target call compile format ["[_this] call %1",_playerUnit];
	if (!isNil "ADV_respawn_EVH") then { _target removeEventhandler ["Respawn",ADV_respawn_EVH]; };
	ADV_respawn_EVH = _target addEventhandler ["Respawn", {[(_this select 0)] call ADV_fnc_applyLoadout;systemChat "starting gear applied.";}];
};

true;
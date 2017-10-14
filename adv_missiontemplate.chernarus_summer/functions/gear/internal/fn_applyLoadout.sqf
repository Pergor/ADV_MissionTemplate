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
	["_target", player, [objNull]]
];
if (side _target isEqualTo sideLogic) exitWith {};

private _playerUnit = (_target getVariable ["ADV_var_playerUnit",["ADV_fnc_nil",""]]) apply {toUpper _x};
_playerUnit params ["_function","_special"];

if ( _function isEqualTo "ADV_FNC_NIL" ) exitWith {};

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

//special stuff for zeus
if (_function isEqualTo "ADV_FNC_ZEUS") then {
	_function = switch ( side (group _target) ) do {
		case west: {"ADV_FNC_COMMAND"};
		case east: {"ADV_OPF_FNC_COMMAND"};
		case independent: {"ADV_IND_FNC_COMMAND"};
		case civilian: {"ADV_FNC_CIVPOLICE"};
	};
	//makes the playable zeus unit always immortal.
	if (_par_invinciZeus isEqualTo 1) then {
		_target allowDamage false;
		if (isNil "ADV_invinciZeus_EVH") then {
			ADV_invinciZeus_EVH = _target addEventhandler ["Respawn", {(_this select 0) allowDamage false;}];
		};
	};
};

//respawn gear switch
if (_par_customLoad > 0) then {
	[_target,_special] call compile format ["_this call %1",_function];

	[_target] spawn {
		params ["_target"];
		sleep 1;
		if (!isNil "ADV_respawn_EVH") then { _target removeEventhandler ["Respawn",ADV_respawn_EVH]; };
		switch (missionNamespace getVariable ["ADV_par_customLoad",2]) do {
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

true;
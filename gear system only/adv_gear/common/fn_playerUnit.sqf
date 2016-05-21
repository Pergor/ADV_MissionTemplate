/*
loadout script by Belbo
adds the loadouts to the specific playable units for the side West
Call from initPlayerLocal.sqf via:
[object,true] call ADV_fnc_applyLoadout;
	with
	_this select 0 = object - target the loadout is applied to.
	_this select 1 = boolean - whether or not the target in _zeus is supposed to be invincible.
*/

private ["_target","_object","_playerUnit","_newGuy","_assAR","_assAT","_soldier","_soldierAT","_diver","_diver_medic","_diver_spec","_zeus"];
// insert names of new units here in their correspondent classes:

///// No editing necessary below this line /////
_target = [_this, 0, player] call BIS_fnc_param;
_object = str _target;

if (side _target == west) then {
	//_soldier = [];for "_x" from 1 to 20 do {_newGuy = format ["%1%2","soldier_",_x];_soldier pushback _newGuy};
	_zeus = ["z1","z2","z3","z4","z5"];
	
	_prefix = [_object,0,2] call BIS_fnc_trimString;
	_playerUnit = switch (toUpper (_prefix)) do {
		case "FT_": {"ADV_fnc_ftLeader"};
		case "LEA": {"ADV_fnc_leader"};
		case "LMG": {"ADV_fnc_LMG"};
		case "AR_": {"ADV_fnc_AR"};
		case "MMG": {"ADV_fnc_AR"};
		case "GRE": {"ADV_fnc_gren"};
		case "AT_": {"ADV_fnc_AT"};
		case "AA_": {"ADV_fnc_AA"};
		case "COM": {"ADV_fnc_command"};
		case "MED": {"ADV_fnc_medic"};
		case "SPE": {"ADV_fnc_spec"};
		case "MAR": {"ADV_fnc_marksman"};
		case "UAV": {"ADV_fnc_uavOP"};
		case "CLS": {"ADV_fnc_cls"};
		case "DRI": {"ADV_fnc_driver"};
		case "LOG": {"ADV_fnc_log"};
		case "PIL": {"ADV_fnc_pilot"};
		case "SNI": {"ADV_fnc_sniper"};
		case "ABE": {"ADV_fnc_ABearer"};
		case "SPO": {"ADV_fnc_spotter"};
		case "CSW": {"ADV_fnc_soldier"};	//crew served weapon
		case "MOR": {"ADV_fnc_soldier"};	//mortar gunner
		default {
			_prefix = [_object,0,-2] call BIS_fnc_trimString;
			switch true do {
				case (toUpper (_prefix) == "SOLDIER" || toUpper (_prefix) == "SOLDIER_"): {"ADV_fnc_soldier"};
				case (toUpper (_prefix) == "SOLDIERAT" || toUpper (_prefix) == "SOLDIERAT_"): {"ADV_fnc_soldierAT"};
				case (toUpper (_prefix) == "ASSAR" || toUpper (_prefix) == "ASSAR_" || toUpper (_prefix) == "ASSMMG" || toUpper (_prefix) == "ASSMMG_"): {"ADV_fnc_assAR"};
				case (toUpper (_prefix) == "ASSAT" || toUpper (_prefix) == "ASSAT_"): {"ADV_fnc_assAT"};
				case (toUpper (_prefix) == "ASSAA" || toUpper (_prefix) == "ASSAA_"): {"ADV_fnc_assAA"};
				case (toUpper (_prefix) == "DIVER" || toUpper (_prefix) == "DIVER_"): {"ADV_fnc_diver"};
				case (toUpper (_prefix) == "DIVER_MEDIC" || toUpper (_prefix) == "DIVER_MEDIC_"): {"ADV_fnc_diver_medic"};
				case (toUpper (_prefix) == "DIVER_SPEC" || toUpper (_prefix) == "DIVER_SPEC_"): {"ADV_fnc_diver_spec"};
				case (toUpper (_prefix) == "ASSCSW" || toUpper (_prefix) == "ASSCSW_"): { "ADV_fnc_soldier" };		//asst. crew served weapon
				case (toUpper (_prefix) == "ASSMORTAR" || toUpper (_prefix) == "ASSMORTAR_"): { "ADV_fnc_soldier" };	//asst. mortar gunner
				case (_object in _zeus): {"ADV_fnc_zeus"};
				default {"ADV_fnc_nil"};
			};
		};	
	};
};

_target setVariable ["ADV_var_playerUnit",_playerUnit];
_playerUnit;

//if (true) exitWith {};
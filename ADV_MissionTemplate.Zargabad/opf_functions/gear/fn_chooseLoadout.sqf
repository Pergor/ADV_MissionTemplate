/*

function for choosing loadouts

*/

private ["_chosenLoadout"];

_chosenLoadout = switch (toUpper (_this select 0)) do {
	case "COMMAND" : {ADV_opf_fnc_command};
	case "LEADER" : {ADV_opf_fnc_leader};
	case "FTLEADER" : {ADV_opf_fnc_ftLeader};
	case "MEDIC" : {ADV_opf_fnc_medic};
	case "AR" : {ADV_opf_fnc_AR};
	case "LMG" : {ADV_opf_fnc_lmg};
	case "ASSAR" : {ADV_opf_fnc_assAR};
	case "AT" : {ADV_opf_fnc_AT};
	case "ASSAT" : {ADV_opf_fnc_assAT};
	case "GREN" : {ADV_opf_fnc_gren};
	case "CLS" : {ADV_opf_fnc_cls};
	case "SOLDIER" : {ADV_opf_fnc_soldier};
	case "SOLDIERAT" : {ADV_opf_fnc_soldierAT};
	case "MARKSMAN" : {ADV_opf_fnc_marksman};
	case "SPEC" : {ADV_opf_fnc_spec};
	case "UAVOP" : {ADV_opf_fnc_uavOP};
	case "SPOTTER" : {ADV_opf_fnc_spotter};
	case "SNIPER" : {ADV_opf_fnc_sniper};
	case "DRIVER" : {ADV_opf_fnc_driver};
	case "PILOT" : {ADV_opf_fnc_pilot};
	case "DIVER" : {ADV_opf_fnc_diver};
	case "DIVER_MEDIC" : {ADV_opf_fnc_diver_medic};
	case "DIVER_SPEC" : {ADV_opf_fnc_diver_spec};
	default {ADV_opf_fnc_soldier};
};

player setVariable ["ADV_unitCategory",_chosenLoadout];

if (ADV_par_respWithGear == 2) then {
	ADV_chosenLoadout = nil;
	ADV_chosenLoadout = _chosenLoadout;
	player removeEventHandler ["Respawn",ADV_respawn_EVH];
	loadout = player getVariable "ADV_unitCategory";
	ADV_respawn_EVH = player addEventhandler ["Respawn", {[loadout] call ADV_opf_fnc_chooseLoadout;}];
};

[player] call _chosenLoadout;

[] spawn {
	if (ADV_par_respWithGear == 1) then {
		player removeEventHandler ["respawn",ADV_respawn_EVH];
		sleep 1;
		loadout = [player] call aeroson_fnc_getLoadout;
		ADV_respawn_EVH = player addEventhandler ["Respawn",{[player, loadout] spawn aeroson_fnc_setLoadout;}];
	};
};

if (count _this > 1) then {
	removeAllActions (_this select 1);
	ADV_loadoutActionToAddBasic = true;
};

if (true) ExitWith {};
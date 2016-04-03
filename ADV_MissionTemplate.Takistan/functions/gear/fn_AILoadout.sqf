/*
Currently not implemented!
*/

// insert names of new units here in their correspondent classes:
_command = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_command_",_x];_command pushback _newGuy};
_leader = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_leader_",_x];_leader pushback _newGuy};
_ftLeader = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_ft_",_x];_ftLeader pushback _newGuy};
_medic = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_medic_",_x];_medic pushback _newGuy};
_AR = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_AR_",_x];_AR pushback _newGuy};
_assAR = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_assAR_",_x];_assAR pushback _newGuy};
_AT = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_AT_",_x];_AT pushback _newGuy};
_assAT = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_assAT_",_x];_assAT pushback _newGuy};
_lmg = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_lmg_",_x];_lmg pushback _newGuy};
_gren = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_gren_",_x];_gren pushback _newGuy};
_cls = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_cls_",_x];_cls pushback _newGuy};
_soldier = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_soldier_",_x];_soldier pushback _newGuy};
_soldierAT = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_soldier_",_x];_soldierAT pushback _newGuy};
_marksman = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_marksman_",_x];_marksman pushback _newGuy};
_spec = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_spec_",_x];_spec pushback _newGuy};
_uavOp = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_uavOp_",_x];_uavOp pushback _newGuy};
_spotter = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_spotter_",_x];_spotter pushback _newGuy};
_sniper = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_sniper_",_x];_sniper pushback _newGuy};
_driver = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_driver_",_x];_driver pushback _newGuy};
_pilot = [];for "_x" from 1 to 40 do {_newGuy = format ["%1%2","ai_pilot_",_x];_pilot pushback _newGuy};

///// No editing necessary below this line /////
private ["_loadoutscript","_AIunits","_object"];

_AIunits = _command+_leader+_ftLeader+_medic+_AR+_assAR+_AT+_assAT+_lmg+_gren+_cls+_soldier+_soldierAT+_marksman+_spec+_uavOp+_spotter+_sniper+_driver+_pilot;
{
	_object = str _x;
	_isAIunit = _object in _AIunits;
	if (_isAIunit) then {
		//switch to select the applicable loadout function
		_loadoutscript = switch true do {
			case (_object in _command): {ADV_fnc_command};
			case (_object in _leader): {ADV_fnc_leader};
			case (_object in _ftLeader): {ADV_fnc_ftLeader};
			case (_object in _medic): {ADV_fnc_medic};
			case (_object in _AR): {ADV_fnc_AR};
			case (_object in _lmg): {ADV_fnc_lmg};
			case (_object in _assAR): {ADV_fnc_assAR};
			case (_object in _AT): {ADV_fnc_AT};
			case (_object in _assAT): {ADV_fnc_assAT};
			case (_object in _gren): {ADV_fnc_gren};
			case (_object in _cls): {ADV_fnc_cls};
			case (_object in _soldier): {ADV_fnc_soldier};
			case (_object in _soldierAT): {ADV_fnc_soldierAT};
			case (_object in _marksman): {ADV_fnc_marksman};
			case (_object in _spec): {ADV_fnc_spec};
			case (_object in _uavOP): {ADV_fnc_uavOP};
			case (_object in _spotter): {ADV_fnc_spotter};
			case (_object in _sniper): {ADV_fnc_sniper};
			case (_object in _driver): {ADV_fnc_driver};
			case (_object in _pilot): {ADV_fnc_pilot};
			default {ADV_fnc_soldier};
		};
		//actual call
		[_x] call _loadoutscript;
	};
} forEach allUnits;

if (true) exitWith {};
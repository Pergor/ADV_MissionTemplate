/*
 * Author: Belbo
 *
 * Combines the target if it as a certain vehicleVarName with a certain adv_fnc_-loadout function which can be applied by adv_fnc_applyloadout.
 * Sets _target setVariable ["ADV_var_playerUnit","loadout function from adv_fnc_playerUnit"];
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * targets new loadout function - <STRING>
 *
 * Example:
 * [player] call adv_fnc_playerUnit;
 *
 * Public: No
 */

 params [
	["_target", player, [objNull]]
];
private _object = toUpper (str _target);
private _prefix = "";

private _zeus = [];
private _playerUnit = ["ADV_FNC_NIL",""];

if (side (group _target) isEqualTo sideLogic) exitWith {};
private _isCivLoadout = if ( (_object select [0,3]) isEqualTo "CIV" ) then {true} else {false};

if ( side (group _target) isEqualTo west && !_isCivLoadout ) then {
	_zeus = ["Z1","Z2","Z3","Z4","Z5"];
	
	_prefix = _object select [0,3];
	//_prefix = [_object,0,2] call BIS_fnc_trimString;
	_playerUnit = switch (_prefix) do {
		case "FT_": {["ADV_FNC_FTLEADER",""]};
		case "LEA": {["ADV_FNC_LEADER",""]};
		case "LMG": {["ADV_FNC_LMG",""]};
		case "AR_": {["ADV_FNC_AR",""]};
		case "MMG": {["ADV_FNC_AR",""]};
		case "GRE": {["ADV_FNC_GREN",""]};
		case "AT_": {["ADV_FNC_AT","AT"]};
		case "AA_": {["ADV_FNC_AT","AA"]};
		case "COM": {["ADV_FNC_COMMAND",""]};
		case "MED": {["ADV_FNC_MEDIC",""]};
		case "SPE": {["ADV_FNC_SPEC",""]};
		case "EOD": {["ADV_FNC_SPEC","EOD"]};
		case "REP": {["ADV_FNC_SPEC","REPAIR"]};
		case "MAR": {["ADV_FNC_MARKSMAN",""]};
		case "UAV": {["ADV_FNC_UAVOP",""]};
		case "CLS": {["ADV_FNC_CLS",""]};
		case "DRI": {["ADV_FNC_DRIVER",""]};
		case "LOG": {["ADV_FNC_LOG",""]};
		case "JET": {["ADV_FNC_JETPILOT",""]};
		case "PIL": {["ADV_FNC_PILOT",""]};
		case "SNI": {["ADV_FNC_SNIPER",""]};
		case "SPO": {["ADV_FNC_SPOTTER",""]};
		case "ABE": {["ADV_FNC_ABEARER",""]};
		case "CSW": {["ADV_FNC_FTLEADER","CSW"]};	//CREW SERVED WEAPON
		case "ACS": {["ADV_FNC_FTLEADER","ACSW"]};	//CREW SERVED WEAPON
		case "MOR": {["ADV_FNC_FTLEADER","MORTAR"]};	//MORTAR GUNNER
		case "AMO": {["ADV_FNC_FTLEADER","AMORTAR"]};	//MORTAR GUNNER
		case "TOW": {["ADV_FNC_FTLEADER","TOW"]};	//TOW GUNNER
		case "ATO": {["ADV_FNC_FTLEADER","ATOW"]};	//TOW GUNNER
		default {
			switch true do {
				case ( (_object select [0,3]) isEqualTo "FTL" ): {["ADV_FNC_FTLEADER",""]};
				case ( (_object select [0,9]) isEqualTo "SOLDIERAT" ): {["ADV_FNC_SOLDIER","AT"]};
				case ( (_object select [0,7]) isEqualTo "SOLDIER" ): {["ADV_FNC_SOLDIER",""]};
				case ( (_object select [0,5]) isEqualTo "ASSAR" ): {["ADV_FNC_ASSAR",""]};
				case ( (_object select [0,6]) isEqualTo "ASSMMG" ): {["ADV_FNC_ASSAR",""]};
				case ( (_object select [0,5]) isEqualTo "ASSAT" ): {["ADV_FNC_ASSAT",""]};
				case ( (_object select [0,5]) isEqualTo "ASSAA" ): {["ADV_FNC_ASSAA",""]};
				case ( (_object select [0,11]) isEqualTo "DIVER_MEDIC" ): {["ADV_FNC_DIVER_MEDIC",""]};
				case ( (_object select [0,10]) isEqualTo "DIVER_SPEC" ): {["ADV_FNC_DIVER_SPEC",""]};
				case ( (_object select [0,5]) isEqualTo "DIVER" ): {["ADV_FNC_DIVER",""]};
				case ( (_object select [0,6]) isEqualTo "ASSCSW" ): {["ADV_FNC_FTLEADER","ACSW"]};			//ASST. CREW SERVED WEAPON
				case ( (_object select [0,9]) isEqualTo "ASSMORTAR" ): {["ADV_FNC_FTLEADER","AMORTAR"]};		//ASST. MORTAR GUNNER
				case ( (_object select [0,6]) isEqualTo "ASSTOW" ): {["ADV_FNC_FTLEADER","ATOW"]};		//ASST. MORTAR GUNNER
				case ( (_object) in _ZEUS || !isNull getAssignedCuratorLogic _target ): {["ADV_FNC_ZEUS",""]};
				default {["ADV_FNC_NIL",""]};
			};
		};	
	};
};

if ( side (group _target) isEqualTo east && !_isCivLoadout ) then {
	_zeus = ["OPF_Z1","OPF_Z2","OPF_Z3","OPF_Z4","OPF_Z5"];
	
	_prefix = _object select [0,7];
	_playerUnit = switch (_prefix) do {
		case "OPF_FT_": {["ADV_OPF_FNC_FTLEADER",""]};
		case "OPF_LEA": {["ADV_OPF_FNC_LEADER",""]};
		case "OPF_LMG": {["ADV_OPF_FNC_LMG",""]};
		case "OPF_AR_": {["ADV_OPF_FNC_AR",""]};
		case "OPF_MMG": {["ADV_OPF_FNC_AR",""]};
		case "OPF_GRE": {["ADV_OPF_FNC_GREN",""]};
		case "OPF_AT_": {["ADV_OPF_FNC_AT","AT"]};
		case "OPF_AA_": {["ADV_OPF_FNC_AT","AA"]};
		case "OPF_COM": {["ADV_OPF_FNC_COMMAND",""]};
		case "OPF_MED": {["ADV_OPF_FNC_MEDIC",""]};
		case "OPF_SPE": {["ADV_OPF_FNC_SPEC",""]};
		case "OPF_EOD": {["ADV_OPF_FNC_SPEC","EOD"]};
		case "OPF_REP": {["ADV_OPF_FNC_SPEC","REPAIR"]};
		case "OPF_MAR": {["ADV_OPF_FNC_MARKSMAN",""]};
		case "OPF_UAV": {["ADV_OPF_FNC_UAVOP",""]};
		case "OPF_CLS": {["ADV_OPF_FNC_CLS",""]};
		case "OPF_DRI": {["ADV_OPF_FNC_DRIVER",""]};
		case "OPF_LOG": {["ADV_OPF_FNC_LOG",""]};
		case "OPF_JET": {["ADV_OPF_FNC_JETPILOT",""]};
		case "OPF_PIL": {["ADV_OPF_FNC_PILOT",""]};
		case "OPF_SNI": {["ADV_OPF_FNC_SNIPER",""]};
		case "OPF_SPO": {["ADV_OPF_FNC_SPOTTER",""]};
		case "OPF_ABE": {["ADV_OPF_FNC_ABEARER",""]};
		case "OPF_CSW": {["ADV_OPF_FNC_FTLEADER","CSW"]};	//CREW SERVED WEAPON
		case "OPF_ACS": {["ADV_OPF_FNC_FTLEADER","ACSW"]};	//ASST. CREW SERVED WEAPON
		case "OPF_MOR": {["ADV_OPF_FNC_FTLEADER","MORTAR"]};	//MORTAR GUNNER
		case "OPF_AMO": {["ADV_OPF_FNC_FTLEADER","AMORTAR"]};	//ASST. MORTAR GUNNER
		case "OPF_TOW": {["ADV_OPF_FNC_FTLEADER","TOW"]};	//TOW GUNNER
		case "OPF_ATO": {["ADV_OPF_FNC_FTLEADER","ATOW"]};	//ASST. TOW GUNNER
		default {
			_prefix = [_object,0,-2] call BIS_fnc_trimString;
			switch true do {
				case ( (_object select [0,7]) isEqualTo "OPF_FTL" ): {["ADV_OPF_FNC_FTLEADER",""]};
				case ( (_object select [0,13]) isEqualTo "OPF_SOLDIERAT" ): {["ADV_OPF_FNC_SOLDIER","AT"]};
				case ( (_object select [0,11]) isEqualTo "OPF_SOLDIER" ): {["ADV_OPF_FNC_SOLDIER",""]};
				case ( (_object select [0,9]) isEqualTo "OPF_ASSAR" ): {["ADV_OPF_FNC_ASSAR",""]};
				case ( (_object select [0,10]) isEqualTo "OPF_ASSMMG" ): {["ADV_OPF_FNC_ASSAR",""]};
				case ( (_object select [0,9]) isEqualTo "OPF_ASSAT" ): {["ADV_OPF_FNC_ASSAT",""]};
				case ( (_object select [0,9]) isEqualTo "OPF_ASSAA" ): {["ADV_OPF_FNC_ASSAA",""]};
				case ( (_object select [0,15]) isEqualTo "OPF_DIVER_MEDIC" ): {["ADV_OPF_FNC_DIVER_MEDIC",""]};
				case ( (_object select [0,14]) isEqualTo "OPF_DIVER_SPEC" ): {["ADV_OPF_FNC_DIVER_SPEC",""]};
				case ( (_object select [0,9]) isEqualTo "OPF_DIVER" ): {["ADV_OPF_FNC_DIVER",""]};
				case ( (_object select [0,10]) isEqualTo "OPF_ASSCSW" ): {["ADV_OPF_FNC_FTLEADER","ACSW"]};			//ASST. CREW SERVED WEAPON
				case ( (_object select [0,13]) isEqualTo "OPF_ASSMORTAR" ): {["ADV_OPF_FNC_FTLEADER","AMORTAR"]};		//ASST. MORTAR GUNNER
				case ( (_object select [0,10]) isEqualTo "OPF_ASSTOW" ): {["ADV_OPF_FNC_FTLEADER","ATOW"]};		//ASST. MORTAR GUNNER
				case ( (_object) in _ZEUS || !isNull getAssignedCuratorLogic _target ): {["ADV_FNC_ZEUS",""]};
				default {["ADV_FNC_NIL",""]};
			};
		};	
	};
};

if ( side (group _target) isEqualTo independent && !_isCivLoadout ) then {
	_zeus = ["IND_Z1","IND_Z2","IND_Z3","IND_Z4","IND_Z5"];
	
	_prefix = _object select [0,7];
	_playerUnit = switch (_prefix) do {
		case "IND_FT_": {["ADV_IND_FNC_FTLEADER",""]};
		case "IND_LEA": {["ADV_IND_FNC_LEADER",""]};
		case "IND_LMG": {["ADV_IND_FNC_LMG",""]};
		case "IND_AR_": {["ADV_IND_FNC_AR",""]};
		case "IND_MMG": {["ADV_IND_FNC_AR",""]};
		case "IND_GRE": {["ADV_IND_FNC_GREN",""]};
		case "IND_AT_": {["ADV_IND_FNC_AT","AT"]};
		case "IND_AA_": {["ADV_IND_FNC_AT","AA"]};
		case "IND_COM": {["ADV_IND_FNC_COMMAND",""]};
		case "IND_MED": {["ADV_IND_FNC_MEDIC",""]};
		case "IND_SPE": {["ADV_IND_FNC_SPEC",""]};
		case "IND_EOD": {["ADV_IND_FNC_SPEC","EOD"]};
		case "IND_REP": {["ADV_IND_FNC_SPEC","REPAIR"]};
		case "IND_MAR": {["ADV_IND_FNC_MARKSMAN",""]};
		case "IND_UAV": {["ADV_IND_FNC_UAVOP",""]};
		case "IND_CLS": {["ADV_IND_FNC_CLS",""]};
		case "IND_LOG": {["ADV_IND_FNC_LOG",""]};
		case "IND_DRI": {["ADV_IND_FNC_DRIVER",""]};
		case "IND_JET": {["ADV_IND_FNC_JETPILOT",""]};
		case "IND_PIL": {["ADV_IND_FNC_PILOT",""]};
		case "IND_SNI": {["ADV_IND_FNC_SNIPER",""]};
		case "IND_SPO": {["ADV_IND_FNC_SPOTTER",""]};
		case "IND_ABE": {["ADV_IND_FNC_ABEARER",""]};
		case "IND_CSW": {["ADV_IND_FNC_FTLEADER","CSW"]};	//CREW SERVED WEAPON
		case "IND_ACS": {["ADV_IND_FNC_FTLEADER","ACSW"]};	//ASST. CREW SERVED WEAPON
		case "IND_MOR": {["ADV_IND_FNC_FTLEADER","MORTAR"]};	//MORTAR GUNNER
		case "IND_AMO": {["ADV_IND_FNC_FTLEADER","AMORTAR"]};	//ASST. MORTAR GUNNER
		case "IND_TOW": {["ADV_IND_FNC_FTLEADER","TOW"]};	//TOW GUNNER
		case "IND_ATO": {["ADV_IND_FNC_FTLEADER","ATOW"]};	//ASST. TOW GUNNER
		default {
			_prefix = [_object,0,-2] call BIS_fnc_trimString;
			switch true do {
				case ( (_object select [0,7]) isEqualTo "IND_FTL" ): {["ADV_IND_FNC_FTLEADER",""]};
				case ( (_object select [0,13]) isEqualTo "IND_SOLDIERAT" ): {["ADV_IND_FNC_SOLDIER","AT"]};
				case ( (_object select [0,11]) isEqualTo "IND_SOLDIER" ): {["ADV_IND_FNC_SOLDIER",""]};
				case ( (_object select [0,9]) isEqualTo "IND_ASSAR" ): {["ADV_IND_FNC_ASSAR",""]};
				case ( (_object select [0,10]) isEqualTo "IND_ASSMMG" ): {["ADV_IND_FNC_ASSAR",""]};
				case ( (_object select [0,9]) isEqualTo "IND_ASSAT" ): {["ADV_IND_FNC_ASSAT",""]};
				case ( (_object select [0,9]) isEqualTo "IND_ASSAA" ): {["ADV_IND_FNC_ASSAA",""]};
				case ( (_object select [0,15]) isEqualTo "IND_DIVER_MEDIC" ): {["ADV_IND_FNC_DIVER_MEDIC",""]};
				case ( (_object select [0,14]) isEqualTo "IND_DIVER_SPEC" ): {["ADV_IND_FNC_DIVER_SPEC",""]};
				case ( (_object select [0,9]) isEqualTo "IND_DIVER" ): {["ADV_IND_FNC_DIVER",""]};
				case ( (_object select [0,10]) isEqualTo "IND_ASSCSW" ): {["ADV_IND_FNC_FTLEADER","ACSW"]};			//ASST. CREW SERVED WEAPON
				case ( (_object select [0,13]) isEqualTo "IND_ASSMORTAR" ): {["ADV_IND_FNC_FTLEADER","AMORTAR"]};		//ASST. MORTAR GUNNER
				case ( (_object select [0,10]) isEqualTo "IND_ASSTOW" ): {["ADV_IND_FNC_FTLEADER","ATOW"]};		//ASST. MORTAR GUNNER
				case ( (_object) in _ZEUS || !isNull getAssignedCuratorLogic _target ): {["ADV_FNC_ZEUS",""]};
				default {["ADV_FNC_NIL",""]};
			};
		};	
	};
};

if ( _isCivLoadout ) then {
	_zeus = ["civ_z1","civ_z2","civ_z3","civ_z4","civ_z5"];
	
	_prefix = [_object,0,-2] call BIS_fnc_trimString;
	_playerUnit = switch true do {
		case ( (_object select [0,12]) isEqualTo "CIV_ENGINEER" ): {["ADV_FNC_CIVENGINEER",""]};
		case ( (_object select [0,9]) isEqualTo "CIV_PILOT" ): {["ADV_FNC_CIVPILOT",""]};
		case ( (_object select [0,9]) isEqualTo "CIV_DIVER" ): {["ADV_FNC_CIVDIVER",""]};
		case ( (_object select [0,7]) isEqualTo "CIV_DOC" ): {["ADV_FNC_CIVDOC",""]};
		case ( (_object select [0,7]) isEqualTo "CIV_POL" ): {["ADV_FNC_CIVPOLICE",""]};
		case ( (_object select [0,9]) isEqualTo "CIV_PRESS" ): {["ADV_FNC_CIVPRESS",""]};
		case ( (_object select [0,3]) isEqualTo "CIV" ): {["ADV_FNC_CIV",""]};
		default {["ADV_fnc_nil",""]};
	};
};

_target setVariable ["ADV_var_playerUnit",_playerUnit];
_playerUnit;
/*
private ["_target","_insigniumArray","_insignium"];
_target = [_this, 0, player] call BIS_fnc_param;
*/

params [
	["_target", player, [objNull]],
	"_insigniumArray","_insignium"
];

//BWmod-Insignia
if ( side (group _target) == west && (isClass (configFile >> "CfgPatches" >> "bwa3_common")) && (ADV_par_customUni == 1 || ADV_par_customUni == 2) ) exitWith {
	_insigniumArray = switch (rank _target) do {
		case "PRIVATE": {["BWA3_insignia_01_gefreiter","BWA3_insignia_02_obergefreiter","BWA3_insignia_03_hauptgefreiter"];};
		case "CORPORAL": {["BWA3_insignia_04_stabsgefreiter","BWA3_insignia_05_oberstabsgefreiter","BWA3_insignia_06_unteroffizier","BWA3_insignia_07_stabsunteroffizier"];};
		case "SERGEANT": {["BWA3_insignia_08_feldwebel","BWA3_insignia_09_oberfeldwebel"];};
		case "LIEUTENANT": {["BWA3_insignia_10_hauptfeldwebel","BWA3_insignia_13_leutnant","BWA3_insignia_14_oberleutnant"];};
		case "CAPTAIN": {["BWA3_insignia_15_hauptmann"];};
		case "MAJOR": {["BWA3_insignia_17_major"];};
		case "COLONEL": {["BWA3_insignia_18_oberstleutnant","BWA3_insignia_19_oberst"];};
	};
	_insignium = _insigniumArray call BIS_fnc_selectRandom;
	[_target,_insignium] remoteExecCall ["BIS_fnc_setUnitInsignia",0,true];
};

//simple rank patches insignia
if ( side (group _target) == west && (isClass (configFile >> "CfgPatches" >> "simple_rp")) && !(ADV_par_customUni == 1 || ADV_par_customUni == 2) ) exitWith {
	_insignium = switch (rank _target) do {
		case "PRIVATE": {"PRIVATE_SimpleRP";};
		case "CORPORAL": {"CORPORAL_SimpleRP";};
		case "SERGEANT": {"SERGEANT_SimpleRP";};
		case "LIEUTENANT": {"LIEUTENANT_SimpleRP";};
		case "CAPTAIN": {"CAPTAIN_SimpleRP";};
		case "MAJOR": {"MAJOR_SimpleRP";};
		case "COLONEL": {"COLONEL_SimpleRP";};
	};
	[_target,_insignium] remoteExecCall ["BIS_fnc_setUnitInsignia",0,true];
};

//adv insignia
if (isClass (configFile >> "CfgPatches" >> "adv_insignia")) then {
	if ( ( side (group _target) == west && !(ADV_par_customUni == 1 || ADV_par_customUni == 2 || ADV_par_customUni == 9) ) || ( (side (group _target) == independent) && ADV_par_indUni == 1 ) ) exitWith {
		_insigniumArray = switch (rank _target) do {
			case "PRIVATE": {["ADV_insignia_usarmy_00","ADV_insignia_usarmy_01","ADV_insignia_usarmy_02","ADV_insignia_usarmy_02"];};
			case "CORPORAL": {["ADV_insignia_usarmy_03"];};
			case "SERGEANT": {["ADV_insignia_usarmy_04","ADV_insignia_usarmy_04","ADV_insignia_usarmy_05","ADV_insignia_usarmy_06","ADV_insignia_usarmy_07"];};
			case "LIEUTENANT": {["ADV_insignia_usarmy_08","ADV_insignia_usarmy_09","ADV_insignia_usarmy_09"];};
			case "CAPTAIN": {["ADV_insignia_usarmy_10"];};
			case "MAJOR": {["ADV_insignia_usarmy_11","ADV_insignia_usarmy_11","ADV_insignia_usarmy_12"];};
			case "COLONEL": {["ADV_insignia_usarmy_13"];};
		};
		_insignium = _insigniumArray call BIS_fnc_selectRandom;
		[_target,_insignium] remoteExecCall ["BIS_fnc_setUnitInsignia",0,true];
	};
	if ( side (group _target) == east && !(ADV_par_opfUni == 4 || ADV_par_opfUni == 5) ) exitWith {
		_insigniumArray = switch (rank _target) do {
			case "PRIVATE": {["ADV_insignia_rus_00"];};
			case "CORPORAL": {["ADV_insignia_rus_01"];};
			case "SERGEANT": {["ADV_insignia_rus_02","ADV_insignia_rus_03","ADV_insignia_rus_04","ADV_insignia_rus_05"];};
			case "LIEUTENANT": {["ADV_insignia_rus_06","ADV_insignia_rus_07","ADV_insignia_rus_08"];};
			case "CAPTAIN": {["ADV_insignia_rus_09"];};
			case "MAJOR": {["ADV_insignia_rus_10","ADV_insignia_rus_10","ADV_insignia_rus_11"];};
			case "COLONEL": {["ADV_insignia_rus_12"];};
		};
		_insignium = _insigniumArray call BIS_fnc_selectRandom;
		[_target,_insignium] remoteExecCall ["BIS_fnc_setUnitInsignia",0,true];
	};
};

true;
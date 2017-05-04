/*
 * Author: Belbo
 *
 * Adds insignium to the unit depending on adv_missiontemplate-variables, side and rank of unit.
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * Insignium applied? - <BOOL>
 *
 * Example:
 * [player] call adv_fnc_insignia;
 *
 * Public: Yes
 */

params [
	["_target", player, [objNull]],
	"_insigniumArray","_insignium"
];

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

//BWmod-Insignia
if ( side (group _target) isEqualTo west && (isClass (configFile >> "CfgPatches" >> "bwa3_common")) && (_par_customUni isEqualTo 1 || _par_customUni isEqualTo 2) ) exitWith {
	_insigniumArray = switch (rank _target) do {
		case "PRIVATE": {["BWA3_insignia_01_gefreiter","BWA3_insignia_02_obergefreiter","BWA3_insignia_03_hauptgefreiter"];};
		case "CORPORAL": {["BWA3_insignia_04_stabsgefreiter","BWA3_insignia_05_oberstabsgefreiter","BWA3_insignia_06_unteroffizier","BWA3_insignia_07_stabsunteroffizier"];};
		case "SERGEANT": {["BWA3_insignia_08_feldwebel","BWA3_insignia_09_oberfeldwebel"];};
		case "LIEUTENANT": {["BWA3_insignia_10_hauptfeldwebel","BWA3_insignia_13_leutnant","BWA3_insignia_14_oberleutnant"];};
		case "CAPTAIN": {["BWA3_insignia_15_hauptmann"];};
		case "MAJOR": {["BWA3_insignia_17_major"];};
		case "COLONEL": {["BWA3_insignia_18_oberstleutnant","BWA3_insignia_19_oberst"];};
	};
	_insignium = selectRandom _insigniumArray;
	[_target,_insignium] remoteExecCall ["BIS_fnc_setUnitInsignia",0,true];
	true;
};

//simple rank patches insignia
if ( side (group _target) isEqualTo west && (isClass (configFile >> "CfgPatches" >> "simple_rp")) && !(_par_customUni isEqualTo 1 || _par_customUni isEqualTo 2) ) exitWith {
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
	true;
};

//adv insignia
if (isClass (configFile >> "CfgPatches" >> "adv_insignia")) then {
	if ( ( side (group _target) isEqualTo west && !(_par_customUni isEqualTo 1 || _par_customUni isEqualTo 2 || _par_customUni isEqualTo 9) ) || ( (side (group _target) isEqualTo independent) && _par_indUni isEqualTo 1 ) ) exitWith {
		_insigniumArray = switch (rank _target) do {
			case "PRIVATE": {["ADV_insignia_usarmy_00","ADV_insignia_usarmy_01","ADV_insignia_usarmy_02","ADV_insignia_usarmy_02"];};
			case "CORPORAL": {["ADV_insignia_usarmy_03"];};
			case "SERGEANT": {["ADV_insignia_usarmy_04","ADV_insignia_usarmy_04","ADV_insignia_usarmy_05","ADV_insignia_usarmy_06","ADV_insignia_usarmy_07"];};
			case "LIEUTENANT": {["ADV_insignia_usarmy_08","ADV_insignia_usarmy_09","ADV_insignia_usarmy_09"];};
			case "CAPTAIN": {["ADV_insignia_usarmy_10"];};
			case "MAJOR": {["ADV_insignia_usarmy_11","ADV_insignia_usarmy_11","ADV_insignia_usarmy_12"];};
			case "COLONEL": {["ADV_insignia_usarmy_13"];};
		};
		_insignium = selectRandom _insigniumArray;
		[_target,_insignium] remoteExecCall ["BIS_fnc_setUnitInsignia",0,true];
		true;
	};
	if ( side (group _target) isEqualTo east && !(_par_opfUni isEqualTo 4 || _par_opfUni isEqualTo 5) ) exitWith {
		_insigniumArray = switch (rank _target) do {
			case "PRIVATE": {["ADV_insignia_rus_00"];};
			case "CORPORAL": {["ADV_insignia_rus_01"];};
			case "SERGEANT": {["ADV_insignia_rus_02","ADV_insignia_rus_03","ADV_insignia_rus_04","ADV_insignia_rus_05"];};
			case "LIEUTENANT": {["ADV_insignia_rus_06","ADV_insignia_rus_07","ADV_insignia_rus_08"];};
			case "CAPTAIN": {["ADV_insignia_rus_09"];};
			case "MAJOR": {["ADV_insignia_rus_10","ADV_insignia_rus_10","ADV_insignia_rus_11"];};
			case "COLONEL": {["ADV_insignia_rus_12"];};
		};
		_insignium = selectRandom _insigniumArray;
		[_target,_insignium] remoteExecCall ["BIS_fnc_setUnitInsignia",0,true];
		true;
	};
};

false;
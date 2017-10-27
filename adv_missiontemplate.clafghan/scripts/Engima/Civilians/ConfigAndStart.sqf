/* 
 * This file contains config parameters and a function call to start the civilian script.
 * The parameters in this file may be edited by the mission developer.
 *
 * See file Engima\Civilians\Documentation.txt for documentation and a full reference of 
 * how to customize and use Engima's Civilians.
 */
 
// Set civilian parameters.

private _blacklistMarkers = [];

private _unitConfig = call {
	/*
	if ( toUpper worldname in ADV_var_aridMaps && isClass(configfile >> "CfgPatches" >> "adv_civilians_cup") ) exitWith {
		[
			["adv_civ_tk_1","adv_civ_tk_1_j","adv_civ_tk_2","adv_civ_tk_2_j","adv_civ_tk_3","adv_civ_tk_3_j","adv_civ_tk_4","adv_civ_tk_4_j","adv_civ_tk_5","adv_civ_tk_5_j","adv_civ_tk_6","adv_civ_tk_6_j","adv_civ_tk_7","adv_civ_tk_7_j","adv_civ_tk_8","adv_civ_tk_8_j","adv_civ_tk_9","adv_civ_tk_9_j","adv_civ_tk_10"]
			, {}
		]
	};
	*/
	if ( toUpper worldname in ADV_var_aridMaps && isClass(configfile >> "CfgPatches" >> "CUP_Creatures_People_Core") ) exitWith {
		[
			["CUP_C_TK_Man_04","CUP_C_TK_Man_04_Jack","CUP_C_TK_Man_04_Waist","CUP_C_TK_Man_07","CUP_C_TK_Man_07_Coat","CUP_C_TK_Man_07_Waist","CUP_C_TK_Man_08","CUP_C_TK_Man_08_Jack","CUP_C_TK_Man_08_Waist","CUP_C_TK_Man_05_Coat","CUP_C_TK_Man_05_Jack","CUP_C_TK_Man_05_Waist","CUP_C_TK_Man_06_Coat","CUP_C_TK_Man_06_Jack","CUP_C_TK_Man_06_Waist","CUP_C_TK_Man_02","CUP_C_TK_Man_02_Jack","CUP_C_TK_Man_02_Waist","CUP_C_TK_Man_01_Waist","CUP_C_TK_Man_01_Coat","CUP_C_TK_Man_01_Jack","CUP_C_TK_Man_03_Coat","CUP_C_TK_Man_03_Jack","CUP_C_TK_Man_03_Waist"]
			, {}
		]
	};
	if ( toUpper worldname in ADV_var_europeMaps && !(toUpper worldname in ADV_var_vanillaMaps) && isClass(configfile >> "CfgPatches" >> "CUP_Creatures_People_Core") ) exitWith {
		[
			["C_Man_casual_1_F","C_Man_casual_2_F","C_Man_casual_3_F","C_man_p_beggar_F","C_Man_UtilityWorker_01_F","CUP_C_C_Citizen_01","CUP_C_C_Citizen_02","CUP_C_C_Citizen_03","CUP_C_C_Citizen_04","CUP_C_C_Worker_01","CUP_C_C_Worker_02","CUP_C_C_Worker_03","CUP_C_C_Worker_04","CUP_C_C_Profiteer_01","CUP_C_C_Profiteer_02","CUP_C_C_Profiteer_03","CUP_C_C_Profiteer_04","CUP_C_C_Woodlander_01","CUP_C_C_Woodlander_02","CUP_C_C_Woodlander_03","CUP_C_C_Woodlander_04","CUP_C_C_Villager_01","CUP_C_C_Villager_02","CUP_C_C_Villager_03","CUP_C_C_Villager_04","CUP_C_C_Priest_01","CUP_C_C_Functionary_01","CUP_C_C_Functionary_02","CUP_C_C_Doctor_01","CUP_C_C_Schoolteacher_01","CUP_C_C_Assistant_01","CUP_C_C_Rocker_01","CUP_C_C_Rocker_02","CUP_C_C_Rocker_03","CUP_C_C_Rocker_04","CUP_C_C_Mechanic_01","CUP_C_C_Mechanic_02","CUP_C_C_Mechanic_03","CUP_C_C_Worker_05"]
			, {}
		]
	};
	if ( toUpper worldname in ["TANOA"] ) exitWith {
		[
			["C_Man_ConstructionWorker_01_Blue_F","C_Man_Fisherman_01_F","C_Man_UtilityWorker_01_F","C_man_w_worker_F","C_Story_Mechanic_01_F","C_Nikos_aged","C_Orestes","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_AidWorker_02_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_04_F","C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_man_sport_1_F_tanoan","C_man_sport_2_F_tanoan","C_man_sport_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan","C_man_p_beggar_F_afro","C_man_polo_1_F_afro","C_man_polo_2_F_afro","C_man_polo_3_F_afro","C_man_polo_4_F_afro","C_man_polo_5_F_afro","C_man_polo_6_F_afro"]
			, {}
		]
	};
	[
		["C_man_p_beggar_F","C_Man_casual_1_F","C_Man_casual_2_F","C_Man_casual_3_F","C_Man_casual_4_F","C_Man_casual_5_F","C_Man_casual_6_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_Man_ConstructionWorker_01_Blue_F","C_Man_Fisherman_01_F","C_Man_UtilityWorker_01_F","C_man_w_worker_F","C_Story_Mechanic_01_F","C_Nikos","C_Nikos_aged","C_Orestes","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_AidWorker_02_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_04_F"]
		, {}
	]
};

private _respawnWest = if !(isNil "respawn_west") then {getPos respawn_west} else {getMarkerPos "respawn_west"};
private _respawnEast = if !(isNil "respawn_east") then {getPos respawn_east} else {getMarkerPos "respawn_east"};
private _respawnGuerrila = if !(isNil "respawn_guerrila") then {getPos respawn_guerrila} else {getMarkerPos "respawn_guerrila"};

_blackListMarkers append [[_respawnWest, 300, 300, 0, false],[_respawnEast, 300, 300, 0, false],[_respawnGuerrila, 300, 300, 0, false]];

_unitConfig params ["_unitClasses","_spawnedCallback"];

private _parameters = [
	["UNIT_CLASSES", _unitClasses],
	["UNITS_PER_BUILDING", 0.08],
	["MAX_GROUPS_COUNT", 110],
	["MIN_SPAWN_DISTANCE", 60],
	["MAX_SPAWN_DISTANCE", 400],
	["BLACKLIST_MARKERS", _blacklistMarkers],
	["HIDE_BLACKLIST_MARKERS", true],
	["ON_UNIT_SPAWNED_CALLBACK", _spawnedCallback],
	["ON_UNIT_REMOVE_CALLBACK", { true }],
	["DEBUG", false]
];

// Start the script
_parameters spawn ENGIMA_CIVILIANS_StartCivilians;

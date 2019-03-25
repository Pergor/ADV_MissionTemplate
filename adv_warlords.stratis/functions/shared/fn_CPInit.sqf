/*
 * Author: Josef Zemanek & Belbo
 *
 * Combat Patrol init & general handle
 *
 * Arguments:
 * None.
 *
 * Return Value:
 * None.
 *
 * Example:
 * [] call adv_fnc_CPInit;
 *
 * Public: No
 */

cheat1 = FALSE;
cheat2 = FALSE;

params [
	["_objective",-1,[0]]
];

// --- parameters input init

if (count (missionNamespace getVariable ["paramsArray", []]) == 0) then {
	paramsArray = [1, 1, 0, 0, 0, 10, 2, 0, -1];
};
_parent = missionConfigFile >> "Params";
_paramsClasses = "TRUE" configClasses _parent;
_defaults = [
	"BIS_CP_startingDaytime", 	1,
	"BIS_CP_weather", 		1,
	"BIS_CP_garrison", 		0,
	"BIS_CP_reinforcements", 	0,
	"BIS_CP_showInsertion", 	0,
	"BIS_CP_tickets", 		20,
	"BIS_CP_enemyFaction", 		2,
	"BIS_CP_locationSelection", 	0,
	"BIS_CP_objective", 		_objective
];
{
	if (_forEachIndex % 2 == 0) then {
		_class = (_parent >> _x); _i = _paramsClasses find _class; missionNamespace setVariable [_x, if (_i >= 0) then {paramsArray select _i} else {_defaults select (_forEachIndex + 1)}];
	};
} forEach _defaults;
/*
_i = BIS_CP_startingDaytime;
if (_i < 0) then {_i = floor random 5};
BIS_CP_preset_startingDaytime = [
	if (toLower worldName != "tanoa") then {
		[4, 15, 0.15]
	} else {
		[6, 30, 0.1]
	},
	[9, 0, 0],
	[16, 30, 0],
	if (toLower worldName != "tanoa") then {
		[19, 0, 0.1]
	} else {
		[17, 45, 0.05]
	},
	[23, 0, 0]
] select _i;
_i = BIS_CP_weather;
if (_i < 0) then {_i = floor random 4};
BIS_CP_preset_weather = [
	[0, 0],
	[0.4, 0],
	[0.7, 0.05],
	[1, 0.3]
] select _i;
*/
BIS_CP_preset_garrison = BIS_CP_garrison;
BIS_CP_preset_reinforcements = BIS_CP_reinforcements;
BIS_CP_preset_showInsertion = BIS_CP_showInsertion;
BIS_CP_preset_tickets = BIS_CP_tickets;
BIS_CP_preset_enemyFaction = BIS_CP_enemyFaction;
BIS_CP_preset_locationSelection = BIS_CP_locationSelection;
if (isServer) then {
	BIS_CP_preset_objective = if (BIS_CP_objective > 0) then {BIS_CP_objective} else {selectRandom [1, 2, 3]};
	publicVariable "BIS_CP_preset_objective";
} else {
	waitUntil {!isNil "BIS_CP_preset_objective"};
};

// --- variables init (static)

BIS_CP_initModule = allPlayers select 0;
BIS_CP_votingTimer = 10;
BIS_CP_playerSide = WEST;
if (BIS_CP_preset_enemyFaction == 2) then {BIS_CP_preset_enemyFaction = selectRandom [0, 1]};
BIS_CP_enemySide = if (BIS_CP_preset_enemyFaction == 0) then {EAST} else {RESISTANCE};
BIS_CP_moreReinforcements = if (BIS_CP_preset_reinforcements == 2) then {TRUE} else {FALSE};
BIS_CP_lessReinforcements = if (BIS_CP_preset_reinforcements == 0) then {TRUE} else {FALSE};
BIS_lateJIP = FALSE;

// --- register proper objective-related functions
	
BIS_fnc_CPObjSetup = compile preprocessFileLineNumbers format ["\A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj%1Setup.sqf", BIS_CP_preset_objective];
BIS_fnc_CPObjSetupClient = compile preprocessFileLineNumbers format ["\A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj%1SetupClient.sqf", BIS_CP_preset_objective];
BIS_fnc_CPObjTasksSetup = compile preprocessFileLineNumbers format ["\A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj%1TasksSetup.sqf", BIS_CP_preset_objective];
BIS_fnc_CPObjBriefingSetup = compile preprocessFileLineNumbers format ["\A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj%1BriefingSetup.sqf", BIS_CP_preset_objective];
BIS_fnc_CPObjHandle = compile preprocessFileLineNumbers format ["A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj%1Handle.sqf", BIS_CP_preset_objective];
BIS_fnc_CPObjHeavyLosses = compile preprocessFileLineNumbers format ["A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj%1HeavyLosses.sqf", BIS_CP_preset_objective];

if (isServer) then {
	
	// --- standard initial server settings

	{createCenter _x} forEach [WEST, EAST, RESISTANCE, CIVILIAN];
	EAST setFriend [RESISTANCE, 0];
	RESISTANCE setFriend [EAST, 0];
	WEST setFriend [RESISTANCE, 0];
	RESISTANCE setFriend [WEST, 0];
	enableSaving [FALSE, FALSE];	// --- TODO: remove(?)
	
	// --- variables init (server-shared)
	
	missionNamespace setVariable ["BIS_CP_targetLocationID", -1, TRUE];
	
	// --- register enemy group configs
	
	_tanoaCamo = toLower worldName == "tanoa";
	_rhsafrf = isClass(configFile >> "CfgPatches" >> "rhs_main");
	_cup = isClass(configFile >> "CfgPatches" >> "CUP_Creatures_People_Core");
	
	BIS_CP_enemyGrp_sentry = call {
		if (BIS_CP_enemySide == EAST) exitWith {
			if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith {
				configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_MANEUVER"
			};
			if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith {
				configfile >> "CfgGroups" >> "East" >> "CUP_O_TK_MILITIA" >> "Infantry" >> "CUP_O_TK_MILITIA_Patrol"
			};
			if (_tanoaCamo) exitWith {
				configFile >> "cfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfSentry"
			};
			configFile >> "cfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry"
		};
		if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith {
			configfile >> "CfgGroups" >> "Indep" >> "rhsgref_faction_chdkz_g" >> "rhsgref_group_chdkz_ins_gurgents_infantry" >> "rhsgref_group_chdkz_infantry_at"
		};
		if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith {
			configfile >> "CfgGroups" >> "Indep" >> "CUP_I_TK_GUE" >> "Infantry" >> "CUP_I_TK_GUE_Patrol"
		};
		configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry"
	};
	BIS_CP_enemyGrp_fireTeam = call {
		if (BIS_CP_enemySide == EAST) exitWith {
			if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith {
				configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_fireteam"
			};
			if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith {
				configfile >> "CfgGroups" >> "East" >> "CUP_O_TK_MILITIA" >> "Infantry" >> "CUP_O_TK_MILITIA_Patrol"
			};
			if (_tanoaCamo) exitWith {
				configFile >> "cfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfTeam"
			};
			configFile >> "cfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam"
		};
		if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith {
			configfile >> "CfgGroups" >> "Indep" >> "rhsgref_faction_chdkz_g" >> "rhsgref_group_chdkz_ins_gurgents_infantry" >> "rhsgref_group_chdkz_infantry_patrol"
		};
		if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith {
			configfile >> "CfgGroups" >> "Indep" >> "CUP_I_TK_GUE" >> "Infantry" >> "CUP_I_TK_GUE_Patrol"
		};
		configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam"
	};
	BIS_CP_enemyGrp_rifleSquad = call {
		if (BIS_CP_enemySide == EAST) exitWith {
			if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith {
				configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_squad"
			};
			if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith {
				configfile >> "CfgGroups" >> "East" >> "CUP_O_TK_MILITIA" >> "Infantry" >> "CUP_O_TK_MILITIA_Patrol"
			};
			if (_tanoaCamo) exitWith {
				configFile >> "cfgGroups" >> "East" >> "OPF_T_F" >> "SpecOps" >> "O_T_ViperTeam"
			};
			configFile >> "cfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad"
		};
		if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith {
			configfile >> "CfgGroups" >> "Indep" >> "rhsgref_faction_chdkz_g" >> "rhsgref_group_chdkz_ins_gurgents_infantry" >> "rhsgref_group_chdkz_infantry_patrol"
		};
		if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith {
			configfile >> "CfgGroups" >> "Indep" >> "CUP_I_TK_GUE" >> "Infantry" >> "CUP_I_TK_GUE_Patrol"
		};
		configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad"
	};
	
	// --- register enemy unit classnames to be used in buildings
	
	BIS_CP_enemyTroops = [];
	{
		BIS_CP_enemyTroops pushBack getText (_x >> "vehicle");
	} forEach ("TRUE" configClasses BIS_CP_enemyGrp_rifleSquad);
	
	// --- register enemy reinforcement types
	
	BIS_CP_enemyVeh_MRAP = call {
		if (BIS_CP_enemySide == EAST) exitWith {
			if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith {"rhs_tigr_m_msv"};
			if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith {"CUP_O_LR_Transport_TKM"};
			if (_tanoaCamo) then {"O_T_LSV_02_unarmed_F"} else {"O_MRAP_02_F"};
		};
		if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith {"rhsgref_ins_g_uaz"};
		if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith {"CUP_I_BTR40_TKG"};
		"I_MRAP_03_F"
	};

	BIS_CP_enemyVeh_Truck = call {
		if (BIS_CP_enemySide == EAST) exitWith {
			if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith { configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad" };
			if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith { configfile >> "CfgGroups" >> "East" >> "CUP_O_TK_MILITIA" >> "Motorized" >> "CUP_O_TK_MILITIA_MotorizedPatrolBTR40" };
			if (_tanoaCamo) then {configFile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Motorized_MTP" >> "O_T_MotInf_Reinforcements"} else {configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Motorized_MTP" >> "OIA_MotInf_Reinforce"};
		};
		if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith { configfile >> "CfgGroups" >> "Indep" >> "rhsgref_faction_chdkz_g" >> "rhs_group_indp_ins_g_ural" >> "rhs_group_chdkz_ural_squad" };
		if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith { configfile >> "CfgGroups" >> "Indep" >> "CUP_I_TK_GUE" >> "Motorized" >> "CUP_I_TK_GUE_MotorizedPatrol" };
		configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Motorized" >> "HAF_MotInf_Reinforce"
	};

	BIS_CP_enemyVeh_UAV_big = if (BIS_CP_enemySide == EAST) then {"O_UAV_02_F"} else {"I_UAV_02_F"};
	BIS_CP_enemyVeh_UAV_small = if (BIS_CP_enemySide == EAST) then {"O_UAV_01_F"} else {"I_UAV_01_F"};
	BIS_CP_enemyVeh_UAV_big = if (_cup && (toUpper worldname) in ADV_var_aridMaps) then {""} else {BIS_CP_enemyVeh_UAV_big};
	BIS_CP_enemyVeh_UAV_small = if (_cup && (toUpper worldname) in ADV_var_aridMaps) then {""} else {BIS_CP_enemyVeh_UAV_small};
	
	BIS_CP_enemyVeh_reinf1 = call {
		if (BIS_CP_enemySide == EAST) exitWith {
			if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith { "rhs_btr80a_msv" };
			if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith { "cup_o_lr_mg_tkm" };
			if (_tanoaCamo) then {"O_T_APC_Wheeled_02_rcws_ghex_F"} else {"O_APC_Wheeled_02_rcws_F"};
		};
		if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith { "rhs_gref_ins_g_btr70" };
		if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith { "cup_i_brdm2_tk_gue" };
		"I_APC_Wheeled_03_cannon_F"
	};

	BIS_CP_enemyVeh_reinf2 = call {
		if (BIS_CP_enemySide == EAST) exitWith {
			if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith { "rhs_bmp2d_msv" };
			if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith { "cup_o_btr40_mg_tkm" };
			if (_tanoaCamo) then {"O_T_APC_Tracked_02_cannon_ghex_F"} else {"O_APC_Tracked_02_cannon_F"};
		};
		if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith { "rhs_gref_ins_g_bmp2d" };
		if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith { "cup_i_bmp1_tk_gue" };
		"I_APC_tracked_03_cannon_F"
	};
	
	BIS_CP_enemyVeh_reinfAir = call {
		if (BIS_CP_enemySide == EAST) exitWith {
			if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith { "rhs_mi8mt_vdv" };
			if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith { "cup_o_mi17_tk" };
			if (_tanoaCamo) then {"O_Heli_Transport_04_covered_F"};
		};
		if (_rhsafrf && (toUpper worldname) in ADV_var_europeMaps) exitWith { "rhsgref_ins_g_mi8amt" };
		if (_cup && (toUpper worldname) in ADV_var_aridMaps) exitWith { "cup_i_uh1h_tk_gue" };
		"I_Heli_Transport_02_F"
	};
	
	// --- hold until a group with at least one player is present
	
	_groupFound = FALSE;
	while {!_groupFound} do {
		_players = (playableUnits + switchableUnits) select {isPlayer _x};
		if (count _players > 0) then {
			_groupFound = TRUE;
			_player = _players select 0;
			_grp = group _player;
			missionNamespace setVariable ["BIS_CP_grpMain", _grp, TRUE];
			["System initializing for group %1", _grp] call BIS_fnc_CPLog;
		} else {
			sleep 0.5;
		};
	};
	
	// --- respawn position setup (group leader)
	/*
	_mrkr = createMarker ["respawn_leader", position leader BIS_CP_grpMain];
	_null = [BIS_CP_grpMain, "respawn_leader", groupId BIS_CP_grpMain] call BIS_fnc_addRespawnPosition;
	
	// --- keep respawn on the leader
	
	_null = [] spawn {
		_oldPos = [0,0,0];
		while {TRUE} do {
			_pos = position leader BIS_CP_grpMain;
			if (_pos distance _oldPos > 5) then {
				"respawn_leader" setMarkerPos _pos;
				_oldPos = _pos;
			};
			sleep 5;
		};
	};
	*/
	
	// --- apply selected daytime & weather
	
	/*
	setDate [date select 0, date select 1, date select 2, BIS_CP_preset_startingDaytime select 0, BIS_CP_preset_startingDaytime select 1];
	_fogTime = BIS_CP_preset_startingDaytime select 2;
	0 setOvercast (BIS_CP_preset_weather select 0);
	_fogWeather = BIS_CP_preset_weather select 1;
	forceWeatherChange;
	10e5 setOvercast (BIS_CP_preset_weather select 0);
	0 setFog (_fogTime max _fogWeather);
	if ((BIS_CP_preset_weather select 0) < 0 || (BIS_CP_preset_startingDaytime select 0) >= 20) then {
		0 setRain 0;
		10e5 setRain 0;
	};
	*/
	
	// --- spawn a copy of the playable group to calculate insertion positions (uneven terrain etc.)
	
	_slots = playableSlotsNumber WEST;
	BIS_copyGrp = createGroup CIVILIAN;
	for [{_i = 1}, {_i <= _slots}, {_i = _i + 1}] do {
		_newUnit = BIS_copyGrp createUnit ["B_Soldier_F", [100,100,0], [], 0, "FORM"];
		_newUnit stop TRUE;
		_newUnit allowDamage FALSE;
	};
	
	// --- create and delete player icons for minimap upon connect / disconnedct
	
	addMissionEventHandler ["PlayerConnected", {
		(_this select 2) spawn {
			_name = _this;
			sleep 0.5;
			_newPlayerArr = (allMissionObjects "Man") select {isPlayer _x && name _x == _name};
			if (count _newPlayerArr > 0) then {
				_newPlayer = _newPlayerArr select 0;
				_playerIcon = createMarker [format ["playerMarker_%1", _name], position _newPlayer];
			};
		};
	}];
	
	addMissionEventHandler ["PlayerDisconnected", {
		_name = _this select 2;
		deleteMarker format ["playerMarker_%1", _name];
	}];
} else {
	if (didJIP) then {
		if (BIS_CP_targetLocationID >= 0) then {BIS_lateJIP = TRUE};
	};
	
	// --- sync client weather
	
	/*
	_timeSkip = daytime + 0.1;
	_null = _timeSkip spawn {
		_timeSkip = _this;
		_timeBackup = time + 1;
		waitUntil {daytime > _timeSkip || time > _timeBackup};
		skipTime 4;
	};
	*/
	
	// --- hold until client catches up with server-shared variables
	
	waitUntil {
		{isNil _x} count [
			"BIS_CP_targetLocationID",
			"BIS_CP_grpMain"
		] == 0
	};
};

_terminate = FALSE;

if !(isDedicated) then {
	
	// --- make sure player is initialized at this point
	
	waitUntil {!isNull player && isPlayer player};
	
	// --- no need to run the system for players outside of intended patrol group
	
	if !(player in units BIS_CP_grpMain) exitWith {
		_terminate = TRUE;
	};
	
	["System initializing for player %1 (%2)", name player, player] call BIS_fnc_CPLog;
	
	// --- move player to his group in case of JIP
	
	if (didJIP) then {
		_null = [] spawn {
			_pos = formationPosition player;
			if (leader player == player) then {
				_pos = markerPos "insertion_pos";
			};
			if (player distance _pos > 10) then {
				player setPosATL _pos;
			};
			sleep 0.5;
			if (player distance _pos > 10) then {
				player setPosATL _pos;
			};
			sleep 0.5;
			if (player distance _pos > 10) then {
				player setPosATL _pos;
			};
			sleep 0.5;
			if (player distance _pos > 10) then {
				player setPosATL _pos;
			};
		};
	};
	
	// --- automatically open map for objective selection if it's still possible
	
	if (!BIS_lateJIP && BIS_CP_preset_locationSelection != 1) then {
		player enableSimulation FALSE;
		player setAmmo [currentWeapon player, 0];
		_null = [] spawn {
			sleep 0.01;
			while {!visibleMap} do {
				openMap [TRUE, FALSE];
			};
			BIS_blackoutHandle = [] spawn {
				while {TRUE} do {
					waitUntil {!visibleMap};
					titleCut ["", "BLACK FADED", 9999];
					waitUntil {visibleMap};
					titleCut ["", "BLACK IN", 0.25];
				};
			};
			mapAnimAdd [0, 1, [worldSize / 2, worldSize / 2]];
			mapAnimCommit;
		};
	};
};

if (_terminate) exitWith {
	["System terminated for %1 (%2) - player not in patrol group", name player, player] call BIS_fnc_CPLog;
};

// --- script scope && event handler handles for termination in different scopes

_sampleTimerScope = scriptNull;
_clickEH = -1;
_hoverEH = -1;
_leaveEH = -1;

// --- location selection

// --- location types registered as objectives

BIS_CP_usableLocationTypes = ["NameVillage", "NameCity", "NameCityCapital"];

// --- register locations removed by modules

_blacklisedCoords = [];
_locationsRemoveModules = +allMissionObjects "ModuleCombatPatrol_LocationRemove_F";
{
	_locations = nearestLocations [_x, BIS_CP_usableLocationTypes, 1000];
	if (count _locations > 0) then {
		_coords = locationPosition ((nearestLocations [_x, BIS_CP_usableLocationTypes, 1000]) select 0);
		_coords resize 2;
		_blacklisedCoords pushBack _coords;
	} else {
		["No locations in 1000m radius around Location Remove module at %1", position _x] call BIS_fnc_error;
	};
} forEach _locationsRemoveModules;

// --- register location moved by modules

_movedCoords = [];
_newCoords = [];
_locationsMoveModules = +allMissionObjects "ModuleCombatPatrol_LocationMove_F";
{
	_locations = nearestLocations [_x, BIS_CP_usableLocationTypes, 1000];
	if (count _locations > 0) then {
		_coords = locationPosition ((nearestLocations [_x, BIS_CP_usableLocationTypes, 1000]) select 0);
		_coords resize 2;
		_newPos = position _x;
		_newPos resize 2;
		_movedCoords pushBack _coords;
		_newCoords pushBack _newPos;
	} else {
		["No locations in 1000m radius around Location Move module at %1", position _x] call BIS_fnc_error;
	};
} forEach _locationsMoveModules;

// --- register locations added by modules

_addedLocations = +allMissionObjects "ModuleCombatPatrol_LocationAdd_F";

// --- register all suitable locations on the map

_grabbedLocations = "getText (_x >> 'type') in BIS_CP_usableLocationTypes" configClasses (configFile >> "CfgWorlds" >> worldName >> "Names");

// --- compose final locations list

BIS_CP_locationArrFinal = [];

// --- fill list with locations grabbed from config

// --- remove the blacklisted ones

// ---change the center of locaitons moved by modules

{
	_location = _x;
	_coords = getArray (_location >> "position");
	if ({(_coords distance2D _x) == 0} count _blacklisedCoords == 0) then {
		_i = -1;
		{if (_coords distance2D _x == 0) then {_i = _forEachIndex}} forEach _movedCoords;
		if (_i >= 0) then {_coords = _newCoords select _i};
		BIS_CP_locationArrFinal pushBack [_coords, getText (_x >> "name"), [0.75, 1, 1.5] select (BIS_CP_usableLocationTypes find getText (_x >> "type"))];
	};
} forEach _grabbedLocations;

// --- add locations placed via modules

// --- use standardized names for unnamed locations

_locationNameID = 1;
{
	_locationName = _x getVariable ["BIS_CP_param_locationName", ""];
	if (_locationName == "") then {
		_locationName = format [localize "STR_A3_combatpatrol_mission_40", _locationNameID];	// --- TODO: localize
		_locationNameID = _locationNameID + 1;
	} else {
		_nameArr = toArray _locationName;
		if (count _nameArr > 6) then {
			_nameArr resize 6;
			_prefix = toString _nameArr;
			if (toLower _prefix == "str_a3") then {
				_locationName = localize _locationName;
			};
		};
	};
	_pos = position _x;
	_pos resize 2;
	BIS_CP_locationArrFinal pushBack [_pos, _locationName, _x getVariable ["BIS_CP_param_locationSize", 1]];
} forEach _addedLocations;

// --- skip if already selected (JIP) or random selection is enabled

if (BIS_CP_targetLocationID == -1) then {
	
	// --- spawn dummy entities on locations to be used as targets for group icons
	
	// --- register blacklisted azimuths
	
	if (isServer) then {
		BIS_CP_dummyGrps = [];
		["Final locations list:"] call BIS_fnc_CPLog;
		{
			_dummy = (createGroup CIVILIAN) createUnit ["Logic", _x select 0, [], 0, "CAN_COLLIDE"];
			_azimuthBlacklistModulesArr = _dummy nearObjects ["ModuleCombatPatrol_LocationAzimuthBlacklist_F", 1000];
			if (count _azimuthBlacklistModulesArr > 0) then {
				_module = _azimuthBlacklistModulesArr select 0;
				_blacklistArr = call compile (_module getVariable "BIS_CP_param_locationAzimuthBlacklist");
				if (typeName _blacklistArr == typeName []) then {
					_dummy setVariable ["BIS_azimuthBlacklistArr", _blacklistArr];
				};
			};
			BIS_CP_dummyGrps pushBack group _dummy;
			["        %1 at %2", _x select 1, _x select 0] call BIS_fnc_CPLog;
		} forEach BIS_CP_locationArrFinal;
	};

	if (BIS_CP_preset_locationSelection == 1) exitWith {
		if !(isDedicated) then {
			_null = [] spawn {
				sleep 0.001;
				debuglog format ["DEBUG :: #1 (%1)", name player];
				titleCut ["", "BLACK FADED", 100];
				
				// --- center map on target location
				
				waitUntil {visibleMap && !isNil "BIS_CP_targetLocationPos"};
				mapAnimAdd [0, 0.05, BIS_CP_targetLocationPos];
				mapAnimCommit;
			};
		};
		
		//sleep 1;
		
		if (isServer) then {
			missionNamespace setVariable ["BIS_CP_targetLocationID", floor random count BIS_CP_locationArrFinal, TRUE];
		} else {
			waitUntil {BIS_CP_targetLocationID > -1};
		};
	};
	
	if !(isDedicated) then {
		
		// --- add clickable icons on locations
		
		
		{
			_pos = _x select 0;
			waitUntil {count ((_pos nearObjects ["Logic", 10]) select {typeOf _x == "Logic"}) > 0};
			_dummyGrp = group (((_pos nearObjects ["Logic", 10]) select {typeOf _x == "Logic"}) select 0);
			_dummyGrp setVariable ["BIS_CP_locationName", _x select 1];
			_dummyGrp setVariable ["BIS_CP_locationID", _forEachIndex];
			_dummyGrp addGroupIcon ["selector_selectable", [0,0]];
			_dummyGrp setGroupIconParams [[0,0.8,0,1], "", 1, TRUE];
		} forEach BIS_CP_locationArrFinal;
		
		setGroupIconsVisible [TRUE, FALSE];
		setGroupIconsSelectable TRUE;
		
		// --- sound effect on icon hover
	
		BIS_CP_currentIconID = -1;
		_sampleTimerScope = [] spawn {
			scriptName "Hover sample timer";
			while {BIS_CP_targetLocationID == -1} do {
				waitUntil {BIS_CP_currentIconID != -1};
				playSound "clickSoft";
				waitUntil {BIS_CP_currentIconID == -1};
			};
		};
		
		// --- location selection UI handle
		
		_null = [] spawn {
			_locationsCnt = count BIS_CP_locationArrFinal;
			while {BIS_CP_targetLocationID == -1} do {
				_text = localize "STR_A3_combatpatrol_mission_34";
				if ((missionNamespace getVariable ["BIS_CP_voting_countdown_end", 0]) > 0) then {
					_votesArr = [];
					{
						_votesArr pushBack (_x getVariable ["BIS_CP_votedFor", -1]);
					} forEach units BIS_CP_grpMain;
					_mostVoted = 0;
					_mostVotes = 0;
					for [{_i = 0}, {_i < _locationsCnt}, {_i = _i + 1}] do {
						_votes = {_x == _i} count _votesArr;
						if (_votes > _mostVotes) then {
							_mostVotes = _votes;
							_mostVoted = _i;
						};
					};
					_text = _text + "<br/><br/>";
					if ((player getVariable ["BIS_CP_votedFor", -1]) >= 0) then {
						_text = _text + format [(localize "STR_A3_combatpatrol_mission_35") + ":<br/>%1<br/><br/>", toUpper ((BIS_CP_locationArrFinal select (player getVariable "BIS_CP_votedFor")) select 1)];	
					};
					_text = _text + format [(localize "STR_A3_combatpatrol_mission_36") + ":<br/>%1", toUpper ((BIS_CP_locationArrFinal select _mostVoted) select 1)];
					_timeLeft = ((BIS_CP_voting_countdown_end - daytime) * 3600);
					if (_timeLeft < 0) then {_timeLeft = 0};
					_timeLeft = ceil _timeLeft;
					_text = _text + format ["<br/><br/>" + (localize "STR_A3_combatpatrol_mission_37") + ":<br/>%1", _timeLeft];
				};
				hintSilent parseText _text;
				sleep 0.1;
			};
			hintSilent "";
		};
		
		// --- set up the click action to vote for the assigned location
	
		_clickEH = addMissionEventHandler ["GroupIconClick", {
			player setVariable ["BIS_CP_votedFor", (_this select 1) getVariable ["BIS_CP_locationID", -1], TRUE];
			if ((missionNamespace getVariable ["BIS_CP_voting_countdown_end", 0]) == 0) then {
				missionNamespace setVariable ["BIS_CP_voting_countdown_end", daytime + (BIS_CP_votingTimer / 3600), TRUE];
			};
			(_this select 1) setGroupIconParams [[0.8,0,0,1], "", 1, TRUE];
			playSound "AddItemOK";
			_null = (_this select 1) spawn {
				scriptName "Group icon recolor upon deselecting";
				waitUntil {(player getVariable ["BIS_CP_votedFor", -1]) != (_this getVariable ["BIS_CP_locationID", -1]) || isNull _this};
				if !(isNull _this) then {
					_this setGroupIconParams [[0,0.8,0,1], "", 1, TRUE];
				};
			};
		}];
		
		// --- set up the icon hover action
		
		_hoverEH = addMissionEventHandler ["GroupIconOverEnter", {
			BIS_CP_currentIconID = (_this select 1) getVariable ["BIS_CP_locationID", -1];
			if ((player getVariable ["BIS_CP_votedFor", -1]) != BIS_CP_currentIconID) then {
				(_this select 1) setGroupIconParams [[0,0,0.8,1], "", 1, TRUE];
			};
		}];
		
		// --- set up the icon leave action
		
		_leaveEH = addMissionEventHandler ["GroupIconOverLeave", {
			BIS_CP_currentIconID = -1;
			if ((player getVariable ["BIS_CP_votedFor", -1]) != ((_this select 1) getVariable ["BIS_CP_locationID", -1])) then {
				(_this select 1) setGroupIconParams [[0,0.8,0,1], "", 1, TRUE];
			};
		}];
	};
	
	// --- evaluate the most voted for location

	if (isServer) then {
		waitUntil {missionNamespace getVariable ["BIS_CP_voting_countdown_end", 0] > 0};
		if (((BIS_CP_voting_countdown_end - daytime) * 3600) > BIS_CP_votingTimer) then {
			missionNamespace setVariable ["BIS_CP_voting_countdown_end", daytime + (BIS_CP_votingTimer / 3600), TRUE];
		};
		waitUntil {daytime >= BIS_CP_voting_countdown_end};
		_votesArr = [];
		{
			_votesArr pushBack (_x getVariable ["BIS_CP_votedFor", -1]);
		} forEach units BIS_CP_grpMain;
		_mostVoted = 0;
		_mostVotes = 0;
		_locationsCnt = count BIS_CP_locationArrFinal;
		for [{_i = 0}, {_i < _locationsCnt}, {_i = _i + 1}] do {
			_votes = {_x == _i} count _votesArr;
			if (_votes > _mostVotes) then {
				_mostVotes = _votes;
				_mostVoted = _i;
			};
		};
		missionNamespace setVariable ["BIS_CP_targetLocationID", _mostVoted, TRUE];
	} else {
		waitUntil {BIS_CP_targetLocationID >= 0};
	};
};

// --- location selected

BIS_CP_targetLocationPos = (BIS_CP_locationArrFinal select BIS_CP_targetLocationID) select 0;
BIS_CP_targetLocationName = (BIS_CP_locationArrFinal select BIS_CP_targetLocationID) select 1;
BIS_CP_targetLocationSize = (BIS_CP_locationArrFinal select BIS_CP_targetLocationID) select 2;

if !(BIS_lateJIP) then {
	{terminate _x} forEach [_sampleTimerScope];
	removeMissionEventHandler ["GroupIconClick", _clickEH];
	removeMissionEventHandler ["GroupIconOverEnter", _hoverEH];
	removeMissionEventHandler ["GroupIconOverLeave", _leaveEH];
};

if (isServer) then {
	waitUntil {(missionNamespace getVariable ["BIS_CP_targetLocationID", -1] != -1)};
	BIS_CP_targetLocationAzimuthBlacklistArr = (leader (BIS_CP_dummyGrps select BIS_CP_targetLocationID)) getVariable ["BIS_azimuthBlacklistArr", []];
	["Location selected: %1", BIS_CP_targetLocationName] call BIS_fnc_CPLog;
};

// --- black out

if !(BIS_lateJIP) then {
	if !(isDedicated) then {
		if (BIS_CP_preset_locationSelection != 1) then {
			debuglog format ["DEBUG :: #2 (%1)", name player];
			titleCut ["", "BLACK OUT", 1];
		};
	};

	sleep 1;

	if !(isDedicated) then {
		
		// --- close map
		
		openMap [FALSE, FALSE];
		if !(isNil "BIS_blackoutHandle") then {
			terminate BIS_blackoutHandle;
		};
		
		// --- location name pop up
		
		_null = [format [(localize "STR_A3_combatpatrol_mission_38") + "<br/>%1<br/><br/>" + (localize "STR_A3_combatpatrol_mission_39"), toUpper BIS_CP_targetLocationName], 0, 0.5, 5, 0.5, 0] spawn BIS_fnc_dynamicText;	//TODO: localize
		playSound "RscDisplayCurator_ping05";
	};

	sleep 0.5;
} else {
	if (BIS_CP_preset_locationSelection != 1) then {
		debuglog format ["DEBUG :: #3 (%1)", name player];
		titleCut ["", "BLACK FADED", 100];
	};
};

_tLoading = time + 5;

if (isServer) then {

	// --- location areas are scaled based on their config properties

	BIS_CP_radius_insertion = 400 * BIS_CP_targetLocationSize;
	BIS_CP_radius_core = 200 * BIS_CP_targetLocationSize;
	BIS_CP_radius_reinforcements = BIS_CP_radius_insertion * 1.5;

	// --- identify land (get rid of angles leading into water)

	BIS_CP_landDirsArr = [800, FALSE] call BIS_fnc_CPSafeAzimuths;

	["Land angles found:"] call BIS_fnc_CPLog;
	{
		["        %1", _x] call BIS_fnc_CPLog;
	} forEach BIS_CP_landDirsArr;
	
	// --- filter usable insertin angles
	
	BIS_CP_landDirsArr_insertion = [BIS_CP_radius_insertion, TRUE] call BIS_fnc_CPSafeAzimuths;

	["Insertion angles found:"] call BIS_fnc_CPLog;
	{
		["        %1", _x] call BIS_fnc_CPLog;
	} forEach BIS_CP_landDirsArr_insertion;
	
	// --- filter usable exfil angles
	
	BIS_CP_landDirsArr_exfil = [BIS_CP_radius_insertion * 1.5, TRUE] call BIS_fnc_CPSafeAzimuths;

	["Exfil angles found:"] call BIS_fnc_CPLog;
	{
		["        %1", _x] call BIS_fnc_CPLog;
	} forEach BIS_CP_landDirsArr_exfil;

	// --- find approach roads

	BIS_CP_reinf_approach_roads = [];
	for [{_i = 0}, {_i <= 360}, {_i = _i + 1}] do {
		private ["_pos"];
		_pos = [BIS_CP_targetLocationPos, BIS_CP_radius_reinforcements, _i] call BIS_fnc_relPos;
		_roads = (_pos nearRoads 50) select {((boundingBoxReal _x) select 0) distance2D ((boundingBoxReal _x) select 1) >= 25};
		if (count _roads > 0) then {
			_road = _roads select 0;
			if ({_x distance _road < 100} count BIS_CP_reinf_approach_roads == 0) then {
				BIS_CP_reinf_approach_roads pushBackUnique _road;
				//_mrkr = createMarker [format ["fdfds%1", _i], position _road];
				//(format ["fdfds%1", _i]) setMarkerType "mil_dot";
				//(format ["fdfds%1", _i]) setMarkerText str count BIS_CP_reinf_approach_roads;
			};
		};
	};

	["Reinforcements approach roads found: %1", count BIS_CP_reinf_approach_roads] call BIS_fnc_CPLog;
	
	// --- pick insertion & exfiltration positions

	_insDir = missionNamespace getVariable ["BIS_forcerInsertionDir", [1] call BIS_fnc_CPPickSafeDir];
	BIS_CP_insertionPos = [BIS_CP_targetLocationPos, BIS_CP_radius_insertion, _insDir] call BIS_fnc_relPos;
	_extDir = [2] call BIS_fnc_CPPickSafeDir;
	BIS_CP_exfilPos = [BIS_CP_targetLocationPos, 600 min (BIS_CP_radius_insertion * 1.5), _extDir] call BIS_fnc_relPos;
	_exfilBuilding = nearestBuilding BIS_CP_exfilPos;
	if !(isNull _exfilBuilding && _exfilBuilding distance BIS_CP_exfilPos < 200 && _exfilBuilding distance BIS_CP_targetLocationPos <= ((BIS_CP_exfilPos distance BIS_CP_targetLocationPos) + 50) && _exfilBuilding distance BIS_CP_targetLocationPos > ((BIS_CP_exfilPos distance BIS_CP_targetLocationPos) - 50)) then {
		if (_exfilBuilding distance BIS_CP_exfilPos < 200) then {
			BIS_CP_exfilPos = position _exfilBuilding;
		};
	};
	
	// --- insertion marker
	
	_mrkr = createMarker ["insertion_pos", BIS_CP_insertionPos];
	if (BIS_CP_preset_showInsertion == 1) then {
		"insertion_pos" setMarkerType "mil_start";
		"insertion_pos" setMarkerColor (switch (BIS_CP_playerSide) do {
			case WEST: {"colorBLUFOR"};
			case EAST: {"colorOPFOR"};
			case RESISTANCE: {"colorIndependent"};
		});
	};
	
	// --- AO marker
	
	_mrkr = createMarker ["ao_marker", BIS_CP_targetLocationPos];
	
	"ao_marker" setMarkerShape "ELLIPSE";
	"ao_marker" setMarkerSize [BIS_CP_radius_core, BIS_CP_radius_core];
	"ao_marker" setMarkerBrush "SolidBorder";
	"ao_marker" setMarkerColor (switch (BIS_CP_enemySide) do {
		case WEST: {"colorBLUFOR"};
		case EAST: {"colorOPFOR"};
		case RESISTANCE: {"colorIndependent"};
	});
	"ao_marker" setMarkerAlpha 0.25;
	
	// --- prepare insertion position array
	
	BIS_finalInsertionPosArr = [];
	BIS_copyGrp setFormDir (BIS_CP_insertionPos getDir BIS_CP_targetLocationPos);
	{
		_pos = if (leader _x == _x) then {BIS_CP_insertionPos} else {formationPosition _x};
		_pos set [2, 0];
		_x setPos (_pos vectorAdd [0,0,100]);
		_zDiff = ((getPosATL _x) select 2) - ((position _x) select 2);
		_pos set [2, abs _zDiff];
		BIS_finalInsertionPosArr pushBack _pos;
	} forEach units BIS_copyGrp;
	{
		deleteVehicle _x;
	} forEach units BIS_copyGrp;
	deleteGroup BIS_copyGrp;
	
	// --- move the squad to the insertion

	/*
	{
		_x allowDamage FALSE;
		_pos = BIS_finalInsertionPosArr select _forEachIndex;
		_null = [_x, _pos] spawn {
			_unit = _this select 0;
			_pos = _this select 1;
			_unit setPosATL _pos;
			sleep 0.5;
			if (_unit distance _pos > 10) then {
				_unit setPosATL _pos;
			};
			sleep 0.5;
			if (_unit distance _pos > 10) then {
				_unit setPosATL _pos;
			};
			sleep 0.5;
			if (_unit distance _pos > 10) then {
				_unit setPosATL _pos;
			};
			sleep 0.5;
			if (_unit distance _pos > 10) then {
				_unit setPosATL _pos;
			};
			_unit allowDamage TRUE;
		};
	} forEach units BIS_CP_grpMain;
	*/
	
	// --- respawn tickets
	
	[BIS_CP_grpMain, BIS_CP_preset_tickets] call BIS_fnc_respawnTickets;
	
	// --- check respawn tickets for mission failure
	
	_null = [] spawn {
		[{([BIS_CP_grpMain] call BIS_fnc_respawnTickets) > 0}, 2] call BIS_fnc_CPWaitUntil;
		[{([BIS_CP_grpMain] call BIS_fnc_respawnTickets) == 0}, 2] call BIS_fnc_CPWaitUntil;
		sleep 2;
		[{{alive _x} count units BIS_CP_grpMain == 0}, 2] call BIS_fnc_CPWaitUntil;
		missionNamespace setVariable ["BIS_CP_missionFail_death", TRUE];
	};
	
	//sleep 2;
	
	// --- spawn enemy garrison based on no. of players
	
	_playersNo = count units BIS_CP_grpMain;
	
	["Spawning garrison groups:"] call BIS_fnc_CPLog;
	
	if (_playersNo >= 8) then {
		[BIS_CP_enemyGrp_sentry, {random 600}, 8] call BIS_fnc_CPSpawnGarrisonGrp;
		if (BIS_CP_preset_garrison == 0) then {
			[BIS_CP_enemyGrp_sentry, {random 400}, 4] call BIS_fnc_CPSpawnGarrisonGrp;
		} else {
			[BIS_CP_enemyGrp_fireTeam, {random 400}, 4] call BIS_fnc_CPSpawnGarrisonGrp;
		};
		if (BIS_CP_preset_garrison == 2) then {
			[BIS_CP_enemyGrp_rifleSquad, {random 200}, 2] call BIS_fnc_CPSpawnGarrisonGrp;
		};
	} else {
		if (_playersNo >= 4) then {
			[BIS_CP_enemyGrp_sentry, {random 600}, 6] call BIS_fnc_CPSpawnGarrisonGrp;
			if (BIS_CP_preset_garrison == 0) then {
				[BIS_CP_enemyGrp_sentry, {random 400}, 3] call BIS_fnc_CPSpawnGarrisonGrp;
			} else {
				[BIS_CP_enemyGrp_fireTeam, {random 400}, 3] call BIS_fnc_CPSpawnGarrisonGrp;
			};
			if (BIS_CP_preset_garrison == 2) then {
				[BIS_CP_enemyGrp_rifleSquad, {random 200}, 1] call BIS_fnc_CPSpawnGarrisonGrp;
			};
		} else {
			[BIS_CP_enemyGrp_sentry, {random 600}, 5] call BIS_fnc_CPSpawnGarrisonGrp;
			if (BIS_CP_preset_garrison == 0) then {
				[BIS_CP_enemyGrp_sentry, {random 400}, 3] call BIS_fnc_CPSpawnGarrisonGrp;
			} else {
				[BIS_CP_enemyGrp_fireTeam, {random 400}, 3] call BIS_fnc_CPSpawnGarrisonGrp;
			};
			if (BIS_CP_preset_garrison == 2) then {
				//[BIS_CP_enemyGrp_rifleSquad, {random 200}, 0] call BIS_fnc_CPSpawnGarrisonGrp;
			};
		};
	};
	
	// --- spawn enemies in buldings
	
	["Spawning garrison in buildings:"] call BIS_fnc_CPLog;
	
	_allBuildings = BIS_CP_targetLocationPos nearObjects ["Building", BIS_CP_radius_insertion];
	_allUsableBuildings = _allBuildings select {count (_x buildingPos -1) > 4};
	_allUsableBuildings_cnt = count _allUsableBuildings;
	_unusedBuildings = +_allUsableBuildings;
	_cntIndex = if (_playersNo >= 8) then {10} else {if (_playersNo >= 4) then {7} else {4}};
	for [{_i = 1}, {_i <= ceil (_allUsableBuildings_cnt / 2) && _i <= (_cntIndex * BIS_CP_targetLocationSize)}, {_i = _i + 1}] do {
		_building = selectRandom _unusedBuildings;
		_unusedBuildings = _unusedBuildings - [_building];
		if (_building distance BIS_CP_insertionPos > 250) then {
			_building setVariable ["BIS_occupied", TRUE];
			_buldingPosArr = _building buildingPos -1;
			_newGrp = createGroup BIS_CP_enemySide;
			_unitsCnt = ceil random 4;
			_emptyBuildingPosArr = [];
			{_emptyBuildingPosArr pushBack _forEachIndex} forEach _buldingPosArr;
			for [{_j = 1}, {_j <= _unitsCnt}, {_j = _j + 1}] do {
				_buildingPosID = selectRandom _emptyBuildingPosArr;
				_emptyBuildingPosArr = _emptyBuildingPosArr - [_buildingPosID];
				_buildingPos = _buldingPosArr select _buildingPosID;
				_newUnit = _newGrp createUnit [selectRandom BIS_CP_enemyTroops, _buildingPos, [], 0, "NONE"];
				_newUnit setPosATL _buildingPos;
				_newUnit setUnitPos "UP";
				_newUnit allowFleeing 0;
				doStop _newUnit;
			};
			["        %1 occupied by %2", getText (configFile >> "CfgVehicles" >> typeOf _building >> "displayName"), groupId _newGrp] call BIS_fnc_CPLog;
		};
	};
	
	// --- objective server setup
	
	call BIS_fnc_CPObjSetup;
	
	// --- trigger for players being detected by enemy
	
	BIS_CP_detectedTrg = createTrigger ["EmptyDetector", BIS_CP_targetLocationPos, FALSE];
	BIS_CP_detectedTrg setTriggerArea [BIS_CP_radius_insertion, BIS_CP_radius_insertion, 0, FALSE];
	BIS_CP_detectedTrg setTriggerActivation [str BIS_CP_playerSide, if (BIS_CP_enemySide == EAST) then {"EAST D"} else {"GUER D"}, FALSE];
	BIS_CP_detectedTrg setTriggerTimeout [5, 5, 5, TRUE];
	BIS_CP_detectedTrg setTriggerStatements ["this", "", ""];
	
	// --- delete dummy entities
	
	{
		deleteVehicle leader _x;
		deleteGroup _x;
	} forEach BIS_CP_dummyGrps;
	
	// --- location prepared, stop loading
	
	missionNamespace setVariable ["BIS_CP_initDone", TRUE, TRUE];
	BIS_missionStartT = time;
};

waitUntil {time > _tLoading && !isNil "BIS_CP_initDone"};

debuglog format ["DEBUG :: #4 (%1)", name player];

if !(isDedicated) then {
	
	player setDir (player getDir BIS_CP_targetLocationPos);
	
	// --- objective client setup
	
	call BIS_fnc_CPObjSetupClient;
	
	debuglog format ["DEBUG :: #5 (%1)", name player];
	
	// --- scene ready, fade from black
	
	player enableSimulation TRUE;
	player setAmmo [currentWeapon player, 1000];
	debuglog format ["DEBUG :: #6 (%1)", name player];
	titleCut ["", "BLACK IN", 1];
	0 fadeSound 0;
	1 fadeSound 1;
	
	// --- mark player's team on map
	
	/*_null = [] spawn {
		waitUntil {!isNull (findDisplay 12 displayCtrl 51)};
		BIS_teamIconColor = getArray (configFile >> "CfgMarkerColors" >> "colorCLOUDS" >> "color");
		BIS_teamIconColorFaded = +BIS_teamIconColor;
		BIS_teamIconColorFaded set [3, 0.65];
		(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw", {
			{
				if (alive _x) then {
					if (_x == player) then {
						(_this select 0) drawIcon ["\ARGO\UI_ARGO\Data\CfgIngameUI\player_map_ca.paa", BIS_teamIconColor, position _x, 21, 21, direction _x, "", 0, 0.03, "PuristaLight", "center"];
					} else {
						(_this select 0) drawIcon ["\ARGO\UI_ARGO\Data\CfgIngameUI\player_map_ca.paa", BIS_teamIconColorFaded, position _x, 18, 18, direction _x, "", 0, 0.03, "PuristaLight", "center"];
					};
				};
			} forEach units group player;
		}];
		
		_alphaFaded = BIS_teamIconColorFaded select 3;
		_color = if (side group player == WEST) then {"colorCLOUDS"} else {"colorFLAMES"};
		
		while {TRUE} do {
			sleep 0.1;
			_drawFor = (units group player) - [player];
			if (visibleGPS && !visibleMap) then {
				{
					_mrkrName = format ["playerMarker_%1", name _x];
					if (toLower markerType _mrkrName != "playericon") then {_mrkrName setMarkerTypeLocal "PlayerIcon"};
					if (markerAlpha _mrkrName == 0) then {_mrkrName setMarkerAlphaLocal _alphaFaded};
					if (markerColor _mrkrName != _color) then {_mrkrName setMarkerColorLocal _color};
					_mrkrName setMarkerSizeLocal [0.65,0.65];
					_mrkrName setMarkerDirLocal direction _x;
					_mrkrName setMarkerPosLocal position _x;
				} forEach _drawFor;
			} else {
				{
					_mrkrName = format ["playerMarker_%1", name _x];
					if (markerAlpha _mrkrName > 0) then {_mrkrName setMarkerAlphaLocal 0};
				} forEach _drawFor;
			};
		};
	};*/
};

if (isServer) then {
	
	// --- tasks setup
	
	call BIS_fnc_CPObjTasksSetup;
	
	// --- players revealed - send reinforcements based on no. of players
	
	_null = [] spawn {
		scriptName "reinforcements handle";
		[{triggerActivated BIS_CP_detectedTrg || (missionNamespace getVariable ["BIS_CP_alarm", FALSE]) || cheat1}, 1] call BIS_fnc_CPWaitUntil;
		deleteVehicle BIS_CP_detectedTrg;
		
		{_x setBehaviour "COMBAT"; _x setSpeedMode "NORMAL"} forEach (allGroups select {side _x == BIS_CP_enemySide && (leader _x) distance BIS_CP_targetLocationPos <= BIS_CP_radius_insertion});
		
		// --- timeout if the objective hasn't been destroyed yet
		
		if !(missionNamespace getVariable ["BIS_CP_alarm", FALSE]) then {
			_t = time + 300;
			[{(missionNamespace getVariable ["BIS_CP_alarm", FALSE]) || time > _t}, 1] call BIS_fnc_CPWaitUntil;
		};
		
		// --- wave #1
		
		_tNextWave = time + 300;
		
		_playersNo = count units BIS_CP_grpMain;
		if (_playersNo >= 8) then {
			[BIS_CP_enemyVeh_UAV_small, 1] call BIS_fnc_CPSendReinforcements;
			[BIS_CP_enemyVeh_MRAP, if (BIS_CP_lessReinforcements) then {1} else {2}] call BIS_fnc_CPSendReinforcements;
			if (BIS_CP_moreReinforcements) then {
				[BIS_CP_enemyVeh_Truck, 1] call BIS_fnc_CPSendReinforcements;
			};
		} else {
			if (_playersNo >= 4) then {
				[BIS_CP_enemyVeh_UAV_small, 1] call BIS_fnc_CPSendReinforcements;
				[BIS_CP_enemyVeh_MRAP, if (BIS_CP_lessReinforcements) then {1} else {2}] call BIS_fnc_CPSendReinforcements;
				if (BIS_CP_moreReinforcements) then {
					[BIS_CP_enemyVeh_Truck, 1] call BIS_fnc_CPSendReinforcements;
				};
			} else {
				[BIS_CP_enemyVeh_UAV_small, 1] call BIS_fnc_CPSendReinforcements;
				[BIS_CP_enemyVeh_MRAP, if (BIS_CP_lessReinforcements) then {0} else {1}] call BIS_fnc_CPSendReinforcements;
				if (BIS_CP_moreReinforcements) then {
					[BIS_CP_enemyVeh_MRAP, 1] call BIS_fnc_CPSendReinforcements;
				};
			};
		};
		
		[{time > _tNextWave}, 1] call BIS_fnc_CPWaitUntil;
		
		// --- wave #2
		
		_tNextWave = time + 600;
		
		_playersNo = count units BIS_CP_grpMain;
		if (_playersNo >= 8) then {
			[BIS_CP_enemyVeh_UAV_small, 1] call BIS_fnc_CPSendReinforcements;
			if (BIS_CP_moreReinforcements) then {
				[BIS_CP_enemyVeh_reinfAir, 1] call BIS_fnc_CPSendReinforcements;
			};
			[BIS_CP_enemyVeh_MRAP, if (BIS_CP_lessReinforcements) then {0} else {1}] call BIS_fnc_CPSendReinforcements;
			[BIS_CP_enemyVeh_Truck, 1] call BIS_fnc_CPSendReinforcements;
		} else {
			if (_playersNo >= 4) then {
				[BIS_CP_enemyVeh_UAV_small, 1] call BIS_fnc_CPSendReinforcements;
				if (BIS_CP_moreReinforcements) then {
					[BIS_CP_enemyVeh_reinfAir, 1] call BIS_fnc_CPSendReinforcements;
				};
				[BIS_CP_enemyVeh_MRAP, if (BIS_CP_lessReinforcements) then {0} else {1}] call BIS_fnc_CPSendReinforcements;
				[BIS_CP_enemyVeh_Truck, 1] call BIS_fnc_CPSendReinforcements;
			} else {
				[BIS_CP_enemyVeh_UAV_small, 1] call BIS_fnc_CPSendReinforcements;
				if (BIS_CP_lessReinforcements) then {
					[BIS_CP_enemyVeh_MRAP, 1] call BIS_fnc_CPSendReinforcements;
				} else {
					[BIS_CP_enemyVeh_Truck, 1] call BIS_fnc_CPSendReinforcements;
				};
				if (BIS_CP_moreReinforcements) then {
					[BIS_CP_enemyVeh_MRAP, 1] call BIS_fnc_CPSendReinforcements;
				};
			};
		};
		
		[{time > _tNextWave}, 1] call BIS_fnc_CPWaitUntil;
		
		// --- wave #3
		
		_playersNo = count units BIS_CP_grpMain;
		if (_playersNo >= 8) then {
			[BIS_CP_enemyVeh_UAV_big, 1] call BIS_fnc_CPSendReinforcements;
			[BIS_CP_enemyVeh_MRAP, 1] call BIS_fnc_CPSendReinforcements;
			[BIS_CP_enemyVeh_Truck, if (BIS_CP_lessReinforcements) then {1} else {2}] call BIS_fnc_CPSendReinforcements;
			if (BIS_CP_moreReinforcements) then {
				[BIS_CP_enemyVeh_reinf2, 1] call BIS_fnc_CPSendReinforcements;
			};
		} else {
			if (_playersNo >= 4) then {
				[BIS_CP_enemyVeh_UAV_big, if (BIS_CP_lessReinforcements) then {0} else {1}] call BIS_fnc_CPSendReinforcements;
				[BIS_CP_enemyVeh_MRAP, 1] call BIS_fnc_CPSendReinforcements;
				[BIS_CP_enemyVeh_Truck, 1] call BIS_fnc_CPSendReinforcements;
				if (BIS_CP_moreReinforcements) then {
					[BIS_CP_enemyVeh_reinf1, 1] call BIS_fnc_CPSendReinforcements;
				};
			} else {
				[BIS_CP_enemyVeh_UAV_big, if (BIS_CP_lessReinforcements) then {0} else {1}] call BIS_fnc_CPSendReinforcements;
				if (BIS_CP_moreReinforcements) then {
					[BIS_CP_enemyVeh_reinfAir, 1] call BIS_fnc_CPSendReinforcements;
				};
				[BIS_CP_enemyVeh_MRAP, 1] call BIS_fnc_CPSendReinforcements;
				[BIS_CP_enemyVeh_Truck, 1] call BIS_fnc_CPSendReinforcements;
			};
		};
	};
	
	// --- zero casualties handle (AI)
		
	_null = [] spawn {
		while {isNil "BIS_CP_death"} do {
			{
				if !(alive _x) then {
					_null = _x spawn {
						sleep 3;
						if (!alive _this) then {missionNamespace setVariable ["BIS_CP_death", TRUE, TRUE]};
					};
				}
			} forEach ((units BIS_CP_grpMain) select {!isPlayer _x});
			sleep 3;
		};
	};
	
	// --- zero casaulties task handle

	_null = [] spawn {
		waitUntil {!isNil "BIS_CP_death"};
		if !(["BIS_CP_taskSurvive"] call BIS_fnc_taskCompleted) then {
			["BIS_CP_taskSurvive", "Failed"] call BIS_fnc_taskSetState;
		};
	};

	// --- heavy losses handle

	_null = [] spawn {
		[{([BIS_CP_grpMain] call BIS_fnc_respawnTickets) <= floor (BIS_CP_preset_tickets / 2)}, 1] call BIS_fnc_CPWaitUntil;
		call BIS_fnc_CPObjHeavyLosses;
	};
};

if !(isDedicated) then {
	
	// --- briefing
	
	call BIS_fnc_CPObjBriefingSetup;

	// --- zero casualties handle (player)
	
	_null = [] spawn {
		waitUntil {!alive player};
		sleep 3;
		if !(alive player) then {
			missionNamespace setVariable ["BIS_CP_death", TRUE, TRUE];
		};
	};
	
	// mission start msg
	
	if (!(missionNamespace getVariable ["BIS_CP_objectiveDone", FALSE]) && !(missionNamespace getVariable ["BIS_CP_objectiveFailed", FALSE])) then {
		[] spawn {
			sleep 1;
			playSound selectRandom ["cp_mission_start_1", "cp_mission_start_2", "cp_mission_start_3"];
		};
	};
	
	// heavy losses msg
	
	if (!(missionNamespace getVariable ["BIS_CP_objectiveDone", FALSE]) && !(missionNamespace getVariable ["BIS_CP_objectiveFailed", FALSE])) then {
		[] spawn {
			waitUntil {missionNamespace getVariable ["BIS_CP_objectiveFailed", FALSE]};
			sleep 1;
			if !(missionNamespace getVariable ["BIS_CP_objectiveTimeout", FALSE]) then {
				playSound selectRandom ["cp_casualties_induced_exfil_1", "cp_casualties_induced_exfil_2", "cp_casualties_induced_exfil_3"];
			};
		};
	};
	
	// objective done msg
	
	if (!(missionNamespace getVariable ["BIS_CP_objectiveDone", FALSE]) && !(missionNamespace getVariable ["BIS_CP_objectiveFailed", FALSE])) then {
		[] spawn {
			waitUntil {missionNamespace getVariable ["BIS_CP_objectiveDone", FALSE]};
			playSound selectRandom ["cp_mission_accomplished_1", "cp_mission_accomplished_2", "cp_mission_accomplished_3"];
		};
	};
};

// --- main objective handle
	
if (isServer) then {
	_null = [] spawn {
		call BIS_fnc_CPObjHandle;
	};
};

// --- mission end handle

_null = [] spawn {
	if (isServer) then {
		[{missionNamespace getVariable ["BIS_CP_objectiveDone", FALSE] || missionNamespace getVariable ["BIS_CP_objectiveFailed", FALSE] || !isNil "BIS_CP_missionFail_death"}, 1] call BIS_fnc_CPWaitUntil;
		[{!isNil "BIS_CP_missionFail_death" || ({_x distance BIS_CP_exfilPos < 30 && alive _x} count units BIS_CP_grpMain == ({alive _x} count units BIS_CP_grpMain) && {alive _x} count units BIS_CP_grpMain > 0)}, 1] call BIS_fnc_CPWaitUntil;
		if !(isNil "BIS_CP_missionFail_death") exitWith {
			if (missionNamespace getVariable ["BIS_CP_objectiveDone", FALSE]) then {
				missionNamespace setVariable ["BIS_CP_ending", 5, TRUE];
			} else {
				missionNamespace setVariable ["BIS_CP_ending", 4, TRUE];
			}
		};
		["BIS_CP_taskExfil", "Succeeded"] call BIS_fnc_taskSetState;
		if (isNil "BIS_CP_death") then {
			["BIS_CP_taskSurvive", "Succeeded"] call BIS_fnc_taskSetState;
		};
		if (missionNamespace getVariable ["BIS_CP_objectiveDone", FALSE]) then {
			missionNamespace setVariable ["BIS_CP_ending", 1, TRUE];
		} else {
			if (([BIS_CP_grpMain] call BIS_fnc_respawnTickets) == 0 && {!alive _x} count units BIS_CP_grpMain > 0) then {
				missionNamespace setVariable ["BIS_CP_ending", 3, TRUE];
			} else {
				missionNamespace setVariable ["BIS_CP_ending", 2, TRUE];
			};
		};
	} else {
		[{(missionNamespace getVariable ["BIS_CP_ending", 0]) > 0}, 1] call BIS_fnc_CPWaitUntil;
	};
	//if !(isDedicated) then {setPlayerRespawnTime 9999};
	/*
	switch (BIS_CP_ending) do {
		case 1: {playSound selectRandom ["cp_exfil_successful_primary_done_1", "cp_exfil_successful_primary_done_2", "cp_exfil_successful_primary_done_3"];};
		case 2: {playSound selectRandom ["cp_exfil_successful_primary_failed_1", "cp_exfil_successful_primary_failed_2", "cp_exfil_successful_primary_failed_3"];};
		case 3: {playSound selectRandom ["cp_exfil_successful_primary_done_1", "cp_exfil_successful_primary_done_2", "cp_exfil_successful_primary_done_3"];};
		case 4: {playSound selectRandom ["cp_exfil_successful_primary_failed_1", "cp_exfil_successful_primary_failed_2", "cp_exfil_successful_primary_failed_3"];};
		case 5: {playSound selectRandom ["cp_exfil_successful_primary_failed_1", "cp_exfil_successful_primary_failed_2", "cp_exfil_successful_primary_failed_3"];};
	};
	missionNamespace setVariable ["BIS_CP_ending",nil];
	missionNamespace setVariable ["BIS_CP_objectiveDone",nil];
	missionNamespace setVariable ["BIS_CP_objectiveFailed",nil];
	missionNamespace setVariable ["BIS_CP_missionFail_death",nil];
	missionNamespace setVariable ["BIS_CP_objectiveTimeout",nil];
	missionNamespace setVariable ["BIS_CP_voting_countdown_end",nil];
	missionNamespace setVariable ["BIS_CP_targetLocationPos",nil];
	missionNamespace setVariable ["BIS_CP_targetLocationID",nil];
	missionNamespace setVariable ["BIS_CP_alarm",nil];
	missionNamespace setVariable ["BIS_forcerInsertionDir",nil];
	missionNamespace setVariable ["BIS_CP_initDone",nil];
	missionNamespace setVariable ["BIS_CP_death",nil];
	sleep 3;
	if (hasInterface) then {
		player setVariable ["BIS_CP_votedFor",nil];
		forceRespawn player;
	};
	*/

	switch (BIS_CP_ending) do {
		case 1: {playSound selectRandom ["cp_exfil_successful_primary_done_1", "cp_exfil_successful_primary_done_2", "cp_exfil_successful_primary_done_3"]; sleep 3; ["CPEndTotalVictory"] call BIS_fnc_endMission};
		case 2: {playSound selectRandom ["cp_exfil_successful_primary_failed_1", "cp_exfil_successful_primary_failed_2", "cp_exfil_successful_primary_failed_3"]; sleep 3; ["CPEndFullExfil"] call BIS_fnc_endMission};
		case 3: {["CPEndPartialExfil", FALSE] call BIS_fnc_endMission};
		case 4: {["CPEndAllDeadMissionFail", FALSE] call BIS_fnc_endMission};
		case 5: {["CPEndAllDeadMissionSuccess", FALSE] call BIS_fnc_endMission};
	};
};
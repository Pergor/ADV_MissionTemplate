/*
 * Author: Belbo
 *
 * Automatically executed initPlayerLocal.sqf-substitute. Spawned via adv_fnc_initOrganizer.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: No
 */

if (!hasInterface) exitWith {};

//parameter variables are initialized, if player is not hosting:
waitUntil {player == player && !isNil "paramsArray"};
if (!isServer) then {
	//parameters and variables:
	call adv_fnc_parVariables;
	call adv_fnc_variables;
	call adv_fnc_userVariables;
	call adv_fnc_tfarSettings;
	call adv_fnc_acreSettings;
};
//removes all the mission relevant markers from the map:
call ADV_fnc_missionMarkers;
call ADV_fnc_sideMarkers;

//waitUntil param variables are initialized:
waitUntil {!isNil "ADV_params_defined"};
//and if they're somehow still not, let's initialize them again:
if (isNil "adv_par_customWeap") then { call adv_fnc_parVariables };

//disable channels (description.ext seems not to work correctly in that regard):
[[1,3,4,5],true] call adv_fnc_enableChannels;
[[0,2],false] call adv_fnc_enableChannels;
//remove radio:
if ( (missionNamespace getVariable ["adv_par_customLoad",1]) > 0 ) then {
	player unlinkItem "ItemRadio";
};

//prevents the player units from blabbering on their radios
if (isMultiplayer) then {
	player setVariable ["BIS_noCoreConversations", true];
	enableRadio false;
};

//waituntil postinit is executed:
waitUntil {!isNil "BIS_fnc_init"};
waitUntil {missionNamespace getVariable "bis_fnc_init"};

//add admin commands to briefing screen:
if ( serverCommandAvailable "#kick" ) then {
	if	!( (call BIS_fnc_admin) isEqualTo 1 ) then {
		call adv_fnc_adminCommands;
	};
};

//add onPreloadFinished-EVH, so after map the screen will revert to normal:
adv_var_preloadFinished = false;
adv_evh_preloadFinished = ["adv_preloadFinished_hints", "onPreloadFinished" , {
	adv_var_preloadFinished = true;
	["adv_preloadFinished_hints", "onPreloadFinished"] call BIS_fnc_removeStackedEventHandler;
}] call BIS_fnc_addStackedEventHandler;

["InitializePlayer", [player,false]] call BIS_fnc_dynamicGroups;

//collections
if (!isServer) then {
	call adv_fnc_collectCrates;
	call adv_fnc_collectFlags;
};

//title text:
titleText ["", "BLACK FADED"];
titleText [format ["%1 \n\n\nThis mission was built by %2 \n\n\n Have Fun! :)", briefingName, getMissionConfigValue ["Author","[SeL] Belbo"]], "BLACK FADED",0];

//fuck mcc
if (!isNil "mcc_actionInedx") then { player removeAction mcc_actionInedx; };

//stupid goggles are removed:
if ( (toUpper (goggles player)) in ["MASK_M40_OD","MASK_M40","MASK_M50","G_BALACLAVA_BLK","G_BALACLAVA_COMBAT","G_BALACLAVA_LOWPROFILE","G_BALACLAVA_OLI","G_BANDANNA_AVIATOR","G_BANDANNA_BEAST","G_BANDANNA_BLK"
	,"G_BANDANNA_KHK","G_BANDANNA_OLI","G_BANDANNA_SHADES","G_BANDANNA_SPORT","G_BANDANNA_TAN","G_GOGGLES_VR","MURSHUN_CIGS_CIG0","MURSHUN_CIGS_CIG1","MURSHUN_CIGS_CIG2","MURSHUN_CIGS_CIG3","MURSHUN_CIGS_CIG4"]
) then { removeGoggles player; };

waitUntil {time > 0};

//disableUserInput on mission start:
//[true] call adv_fnc_disableInput;
adv_handle_disableShooting = player addAction ["", {true}, [], 0, false, false, "DefaultAction", "true"];

//logistics menu:
if ( (missionNamespace getVariable ["ADV_par_logisticAmount",99]) > 0 ) then {
	{
		private _flagHandle = _x addAction [("<t color='#33FFFF' size='2' align='center'>" + ("Logistik-Menü") + "</t>"), {createDialog "adv_logistic_mainDialog";},nil,8,false,true,"","side (group player) isEqualTo west",5];
		_x setVariable ["adv_handle_logisticAction",_flagHandle];
		nil;
	} count adv_objects_westFlags;
	{
		private _flagHandle = _x addAction [("<t color='#33FFFF' size='2' align='center'>" + ("Logistik-Menü") + "</t>"), {createDialog "adv_logistic_mainDialog";},nil,40,false,true,"","side (group player) isEqualTo east",5];
		_x setVariable ["adv_handle_logisticAction",_flagHandle];
		nil;
	} count adv_objects_eastFlags;
	{
		private _flagHandle = _x addAction [("<t color='#33FFFF' size='2' align='center'>" + ("Logistik-Menü") + "</t>"), {createDialog "adv_logistic_mainDialog";},nil,40,false,true,"","side (group player) isEqualTo independent",5];
		_x setVariable ["adv_handle_logisticAction",_flagHandle];
		nil;
	} count adv_objects_indFlags;
};
//gearsaving menu:
ADV_objects_clearCargo call adv_fnc_gearsaving;
//ADV_objects_gearSaving call adv_fnc_gearloading;

//adds loadout menu to BriefingBoards:
if ( (missionNamespace getVariable ["ADV_par_ChooseLoad",1]) isEqualTo 1 ) then {
	{
		call {
			_cpactions = {
				params ["_target"];
				_target addAction [("<t color='#FFFFFF' size='2'>" + ("Combat Patrol starten (RANDOM)") + "</t>"), { [-1] remoteExec ["adv_fnc_cpinit",0] },nil,40,true,true,"","adv_par_headlessClient isEqualTo 3 && player == (leader (group player))",5];
				_target addAction [("<t color='#FFFFFF' size='2'>" + ("Combat Patrol starten (SABOTAGE VEHICLES)") + "</t>"), { [1] remoteExec ["adv_fnc_cpinit",0] },nil,40,true,true,"","adv_par_headlessClient isEqualTo 3 && player == (leader (group player))",5];
				_target addAction [("<t color='#FFFFFF' size='2'>" + ("Combat Patrol starten (SABOTAGE COMMS)") + "</t>"), { [2] remoteExec ["adv_fnc_cpinit",0] },nil,40,true,true,"","adv_par_headlessClient isEqualTo 3 && player == (leader (group player))",5];
				_target addAction [("<t color='#FFFFFF' size='2'>" + ("Combat Patrol starten (ELIMINATE HVT)") + "</t>"), { [3] remoteExec ["adv_fnc_cpinit",0] },nil,40,true,true,"","adv_par_headlessClient isEqualTo 3 && player == (leader (group player))",5];
			};
		
			if ( ["opf_briefing",str _x] call BIS_fnc_inString ) exitWith {
				private _boardHandle = _x addAction [("<t color='#00FF00' size='2' align='center'>" + ("Loadout-Menü") + "</t>"), {createDialog "adv_loadouts_mainDialog";},nil,50,true,true,"","!(side (group player) isEqualTo west || side (group player) isEqualTo independent)",5];
				_x setVariable ["adv_handle_loadoutAction",_boardHandle];
				[_x] call _cpActions;
			};
			if ( ["ind_briefing",str _x] call BIS_fnc_inString ) exitWith {
				private _boardHandle = _x addAction [("<t color='#00FF00' size='2' align='center'>" + ("Loadout-Menü") + "</t>"), {createDialog "adv_loadouts_mainDialog";},nil,50,true,true,"","!(side (group player) isEqualTo east || side (group player) isEqualTo west)",5];
				_x setVariable ["adv_handle_loadoutAction",_boardHandle];
				_x addAction [("<t color='#FFFFFF' size='2' align='center'>" + ("Combat Patrol starten") + "</t>"), { [] remoteExec ["adv_fnc_cpinit",0] },nil,40,true,true,"","adv_par_headlessClient isEqualTo 5 && player == (leader (group player))",5];
				[_x] call _cpActions;
			};
			if ( ["briefing",str _x] call BIS_fnc_inString ) exitWith {
				private _boardHandle = _x addAction [("<t color='#00FF00' size='2' align='center'>" + ("Loadout-Menü") + "</t>"), {createDialog "adv_loadouts_mainDialog";},nil,50,true,true,"","!(side (group player) isEqualTo east || side (group player) isEqualTo independent)",5];
				_x setVariable ["adv_handle_loadoutAction",_boardHandle];
				[_x] call _cpActions;
			};
		};
		nil;
	} count (allMissionObjects "Land_MapBoard_F");
};

//handling of respawned players:
call {
	if ( missionNamespace getVariable ["ADV_par_moveMarker",2] isEqualTo 99 ) exitWith {
		setPlayerRespawnTime 9999;
	};
	adv_objects_flags call ADV_fnc_flag;
	if ( missionNamespace getVariable ["ADV_par_moveMarker",2] isEqualTo 3 ) then {
		ADV_handle_moveRespMarker = [120,20, missionNamespace getVariable ["ADV_par_remRespWest",0]] call ADV_fnc_moveRespMarker;
	};
};

//disable fatigue if wanted:
if ( (missionNamespace getVariable ["ADV_par_fatigue",1]) isEqualTo 0 ) then {
	player enableFatigue false;
	player enableStamina false;
	adv_evh_fatigue = player addEventhandler ["Respawn", {player enableFatigue false; player enableStamina false;}]; 
};

//adds action to throw it away if a disposable launcher is shot.
if !(isClass (configFile >> "CfgPatches" >> "adv_dropLauncher")) then { ADV_index_dispLaunch = [] call ADV_fnc_dispLaunch; };

//defines the player's unit:
[player] call ADV_fnc_playerUnit;
sleep 1;
//loadouts and RespawnMPEVH are placed on the units on spawn. [target]
[player] call ADV_fnc_applyLoadout;
if ( toUpper ([(str player),(count str player)-5] call BIS_fnc_trimString) isEqualTo "RECON" ) then {player setUnitPos "MIDDLE";};

//failsafe for missing curator interface:
if ( toUpper (str player) in ["Z1","Z2","Z3","Z4","Z5","OPF_Z1","OPF_Z2","OPF_Z3","OPF_Z4","OPF_Z5","IND_Z1","IND_Z2","IND_Z3","IND_Z4","IND_Z5"] || !isNull getAssignedCuratorLogic player ) then {
	private _loadoutHandle = player addAction [("<t color='#00FF00'>" + ("Loadout-Menü") + "</t>"), {createDialog "adv_loadouts_mainDialog";},nil,-2,false,true,"","vehicle player isEqualTo player",5];
	player setVariable ["adv_handle_loadoutAction",_loadoutHandle];
	if ( isNull (getAssignedCuratorLogic player) ) then { [str player, 3] remoteExecCall ["adv_fnc_createZeus",2]; };
	[] call adv_fnc_aresModules;
	if ( isNil "adv_evh_zeusRespawn" ) then {
		adv_evh_zeusRespawn = player addEventhandler ["RESPAWN",{
			private _loadoutHandle = player addAction [("<t color='#00FF00'>" + ("Loadout-Menü") + "</t>"), {createDialog "adv_loadouts_mainDialog";},nil,-2,false,true,"","vehicle player isEqualTo player",5];
			player setVariable ["adv_handle_loadoutAction",_loadoutHandle];
			if ( isNull (getAssignedCuratorLogic player) ) then { [str player, 3] remoteExecCall ["adv_fnc_createZeus",2]; };
		}];
	};
};

//safe zones around respawn markers::
switch ( side (group player) ) do {
	case west: { [player,"respawn_west",70] call adv_fnc_safezone; };
	case east: { [player,"respawn_east",70] call adv_fnc_safezone; };
	case independent: { [player,"respawn_guerrila",70] call adv_fnc_safezone; };
	default {};
};

//igi-load
if !( isClass(configFile >> "CfgPatches" >> "ace_cargo") ) then {
	ADV_handle_igiLoad = [] execVM "scripts\IgiLoad\IgiLoadInit.sqf";
};

//moves the player to position of object called respawn_west, respawn_east or respawn_guerrila, if it's present (for Nimitz for example):
call {
	if ( side (group player) isEqualTo east && !isNil "respawn_east" ) exitWith {
		adv_evh_respawnMover = player addEventhandler ["RESPAWN",{
			player setPosATL (getPosATL respawn_east);
			player setDir (getDir respawn_east);
		}];
	};
	if ( side (group player) isEqualTo independent && !isNil "respawn_guerrila" ) exitWith {
		adv_evh_respawnMover = player addEventhandler ["RESPAWN",{
			player setPosATL (getPosATL respawn_guerrila);
			player setDir (getDir respawn_guerrila);
		}];
	};
	if ( !isNil "respawn_west" ) exitWith {
		adv_evh_respawnMover = player addEventhandler ["RESPAWN",{
			player setPosATL (getPosATL respawn_west);
			player setDir (getDir respawn_west);
		}];
	};
};

//disarming actions for pre placed mines:
if ( isClass(configFile >> "CfgPatches" >> "ace_explosives") ) then {
	[] call adv_fnc_aceMine;
};
//raise jam chance for enemy weapons:
if ( isClass(configFile >> "CfgPatches" >> "ace_overheating") && missionNamespace getVariable ["adv_par_jamChance",0] isEqualTo 1 ) then {
	[] call adv_fnc_jamChance;
};

//variable for preload-check:
//[{time > 40},{adv_var_preloadFinished = true}] call cba_fnc_waitUntilAndExecute;
waitUntil {adv_var_preloadFinished};
[] call adv_fnc_privateDebug;

if (leader (group player) isEqualTo player) then {
	["RegisterGroup", [group player, leader (group player), [player call BIS_fnc_getUnitInsignia,groupId (group player),false]]] call BIS_fnc_dynamicGroups;
	//["RegisterGroup", [group player, leader (group player), [player call BIS_fnc_getUnitInsignia,groupId (group player),false]]] call BIS_fnc_dynamicGroups;
};

//titletext:
sleep 4;
titleText ["", "BLACK FADED",0];
sleep 1;
titleFadeOut 3;
sleep 2;
//disableUserInput false on mission start:
//[false] call adv_fnc_disableInput;
player removeAction adv_handle_disableShooting;

//hint if cba is not run:
if !( isClass(configFile >> "CfgPatches" >> "cba_main") ) then {
	hintC "This mission needs CBA_A3 in order to run properly.";
};
//a little hint stating the date and time
call {
	if ( (toUpper worldname) in ["STRATIS","ALTIS"] ) exitWith {
		["Have Fun!"] spawn BIS_fnc_infoText;
		[] spawn compile preprocessFileLineNumbers "a3\missions_f_epa\Campaign_shared\Functions\Timeline\fn_camp_showOSD.sqf";
	};
	["Have Fun!", "Datum:" + str (date select 2) + "/" + str (date select 1) + "/" + str (date select 0)] spawn BIS_fnc_infoText;
};

/*
if ( isClass(configFile >> "CfgPatches" >> "adv_aceRefill") ) then {
	private _news = (parseText "<t align='center'><t size='1.5'><t color='#00B2EE'>Was gibt es neues?</t><br/>_____________<br/><br/>
	<t size='1'><t color='#00FF33'>
	""[ADV] Individual First Aid Kit""/""[ADV] Persönliche Sanitätsausstattung"" lässt sich über das ACE-Selbstinteraktionsmenü-> Equipment ""öffnen"".
	<br/>Dadurch werden eure Medic-Items aufgefrischt.
	<br/><br/>Für Sanitäter steht das ""[ADV] Medical Refill Kit""/""[ADV] Sanitätsnachfüllpack"" zur Verfügung.
	<br/><br/>Jeder Schütze hat am Anfang wenigstens ein ""[ADV] Individual First Aid Kit"". Denkt daran, es auszupacken!
	</t>");
	hint _news;
};
*/

//end of initPlayerLocal.
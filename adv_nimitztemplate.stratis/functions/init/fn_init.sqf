// JIP Check (This code should be placed first line of init.sqf file)
if (!isServer && isNull player) then {isJIP=true;} else {isJIP=false;};
enableSaving [false, false];

//UpsMon-Init:
//for the server upsmon is called via preInit!

//parameters:
call ADV_fnc_parVariables;
call ADV_fnc_variables;
call ADV_fnc_tfarSettings;

if ( hasInterface ) then {
	titleText [format ["Einen Moment Geduld bitte, %1.\n\n\n Es geht gleich weiter.", profileName], "BLACK FADED"];
};
waitUntil {!isNil "ADV_params_defined"};
//custom init (mission specific):
[] spawn compile preprocessFileLineNumbers "mission\init_custom.sqf";

if ( isServer ) then {
	//BIS_initRespawn_disconnect = -1;
	//time and date:
	setDate [2016, 8, missionNamespace getVariable ["ADV_par_day",23], missionNamespace getVariable ["ADV_par_hour",6] , missionNamespace getVariable ["ADV_par_minute",0]];

	//randomweather:
	if !( (missionNamespace getVariable ["ADV_par_randomWeather",99]) isEqualTo 99 ) then {
		ADV_handle_randomWeather = [] spawn MtB_fnc_randomWeather;
	};
	
	//stops the blabbering of AI units and players
	if ( isMultiplayer ) then {
		{_x setVariable ["BIS_noCoreConversations", true, true]} count allUnits;
	};
	
	//collections:
	call adv_fnc_collectCrates;
	call adv_fnc_collectFlags;
	
	//ADV_handle_zbeCache = [1200,-1,false,100,1200,1200] spawn compile preprocessFileLineNumbers "scripts\zbe_cache\main.sqf";	
	
	sleep 1;
	
	//custom vehicles:
	//[] call ADV_fnc_manageVeh;
	//[] call ADV_opf_fnc_manageVeh;
	//[] call ADV_ind_fnc_manageVeh;
	
	/*	
	//dead body and vehicle removery
	if !( (missionNamespace getVariable ["ADV_par_headlessClient",1]) isEqualTo 1 ) then {
		ADV_handle_cleanUp = [
			10*60,	// seconds to delete dead bodies (0 means don't delete) 
			15*60,	// seconds to delete dead vehicles (0 means don't delete)
			0*60,	// seconds to delete immobile vehicles (0 means don't delete)
			10*60,	// seconds to delete dropped weapons (0 means don't delete)
			0*60,	// seconds to deleted planted explosives (0 means don't delete)
			6*60	// seconds to delete dropped smokes/chemlights (0 means don't delete)
		] spawn aeroson_fnc_cleanUp;
	};*/
	
	//removes notification and bird of all curators:
	{ _x setVariable ["birdType",""]; _x setVariable ["showNotification",false]; [_x, [-1, -2, 2]] call bis_fnc_setCuratorVisionModes; nil;} count allCurators;

	//sets ownership of the units to either zeus or the HC:
	if ( (missionNamespace getVariable ["ADV_par_headlessClient",1]) isEqualTo 1 && !(missionnamespace getVariable ["ace_zeus_autoAddObjects",false]) ) then {
		[] spawn {
			waitUntil {time > 1};
			ADV_handle_zeusObjects = [true] call ADV_fnc_zeusObjects;
		};
	};
	
	//crates and gear related
	[] spawn {
		ADV_objects_clearCargo call ADV_fnc_clearCargo;
		sleep 2;
		ADV_objects_westCargo call ADV_fnc_crate;
		ADV_objects_eastCargo call ADV_opf_fnc_crate;
		ADV_objects_indCargo call ADV_ind_fnc_crate;
	};
	
	//setTextures:
	{ _x setFlagTexture "img\flag.paa"; nil; } count adv_objects_flags;
	if (!isNil "BriefingBoard1") then { [BriefingBoard1] call ADV_fnc_board; };
	if (!isNil "opf_BriefingBoard1") then { [opf_BriefingBoard1] call ADV_fnc_board; };
	if (!isNil "ind_BriefingBoard1") then { [ind_BriefingBoard1] call ADV_fnc_board; };
	
	//deletes empty groups:
	adv_handle_emptyGroupsDeleter = addMissionEventHandler ["EntityKilled",{_grp = group (_this select 0);if ( count (units _grp) == 0 ) then { deleteGroup _grp };}];
	
	//spawns large crate right at the beginning:
	if ( (missionNamespace getVariable ["ADV_par_logisticTeam",1]) > 1 ) then {
		if !(getMarkerPos "ADV_locationCrateLarge" isEqualTo [0,0,0]) then {
			["ADV_LOGISTIC_CRATELARGE",true,west] call adv_fnc_dialogLogistic;
		};
		if !(getMarkerPos "ADV_ind_locationCrateLarge" isEqualTo [0,0,0]) then {
			["ADV_LOGISTIC_CRATELARGE",true,independent] call adv_fnc_dialogLogistic;
		};
		if !(getMarkerPos "ADV_opf_locationCrateLarge" isEqualTo [0,0,0]) then {
			["ADV_LOGISTIC_CRATELARGE",true,east] call adv_fnc_dialogLogistic;
		};
	};
};

if ( hasInterface ) then {
	titleText [format ["%1 \n\n\nThis mission was built by %2 \n\n\n Have Fun! :)", briefingName, missionNamespace getVariable ["ADV_missionAuthor","[SeL] Belbo // Adrian"]], "BLACK FADED"];
};

//mission dramaturgy (will be executed on server as long as HC param is not selected. If HC param is selected it will be executed on HC only)
if ( (missionNamespace getVariable ["ADV_par_headlessClient",1]) isEqualTo 2 ) then {
	//Werthles Headless Client, script version:
	//ADV_handle_werthles = [true, 30, false, false, 30, 3, false, []] spawn compile preprocessFileLineNumbers "scripts\WerthlesHeadless.sqf";
	if !(isServer || hasInterface) then {
		ADV_handle_storyboard = [] execVM "mission\ADV_storyboard.sqf";
	};
} else {
	if (isServer) then {
		ADV_handle_storyboard = [] execVM "mission\ADV_storyboard.sqf";
	};
};

//engine artillery
if ( (missionNamespace getVariable ["ADV_par_engineArtillery",0]) isEqualTo 1) then {
	enableEngineArtillery false;
};

//ACE stuff that's been forgotten by the developers:
if (isClass(configFile >> "CfgPatches" >> "ace_explosives")) then {
	[] call adv_fnc_aceMine;
};

//friggin' ace
missionNamespace setVariable ["ace_medical_healHitPointAfterAdvBandage",true];

if (true) exitWith {};
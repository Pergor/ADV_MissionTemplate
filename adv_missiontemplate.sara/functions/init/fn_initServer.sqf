/*
 * Author: Belbo
 *
 * Automatically executed initServer-substitute. Spawned via adv_fnc_initOrganizer.
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

if (!isServer) exitWith {};

//parameters:
call ADV_fnc_parVariables;
call ADV_fnc_variables;
call ADV_fnc_tfarSettings;
call ADV_fnc_acreSettings;
//collections:
call adv_fnc_collectCrates;
call adv_fnc_collectFlags;

//waitUntil param variables are defined:
waitUntil {!isNil "ADV_params_defined"};

//date:
setDate [2016, 8, missionNamespace getVariable ["ADV_par_day",23], missionNamespace getVariable ["ADV_par_hour",6] , missionNamespace getVariable ["ADV_par_minute",0]];

//stops the blabbering of AI units and players
if ( isMultiplayer ) then {
	{_x setVariable ["BIS_noCoreConversations", true, true]} count allUnits;
};

//removes notification and bird of all curators:
{ _x setVariable ["birdType",""]; _x setVariable ["showNotification",false]; [_x, [-1, -2, 2]] call bis_fnc_setCuratorVisionModes; nil;} count allCurators;

//clear and fill starting crates:
[] spawn {
	ADV_objects_clearCargo call ADV_fnc_clearCargo;
	sleep 1;
	ADV_objects_westCargo call ADV_fnc_crate;
	ADV_objects_eastCargo call ADV_opf_fnc_crate;
	ADV_objects_indCargo call ADV_ind_fnc_crate;
};

//waituntil postinit is executed:
waitUntil {!isNil "BIS_fnc_init"};
waitUntil {missionNamespace getVariable "bis_fnc_init"};

//custom vehicles:
[] call ADV_fnc_manageVeh;
[] call ADV_opf_fnc_manageVeh;
[] call ADV_ind_fnc_manageVeh;

//makes units available to zeus:
if ( (missionNamespace getVariable ["ADV_par_headlessClient",1]) isEqualTo 1 && !(missionnamespace getVariable ["ace_zeus_autoAddObjects",false]) ) then {
	[] spawn {
		waitUntil {time > 1};
		ADV_handle_zeusObjects = [true] call ADV_fnc_zeusObjects;
	};
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

//end of initServer.
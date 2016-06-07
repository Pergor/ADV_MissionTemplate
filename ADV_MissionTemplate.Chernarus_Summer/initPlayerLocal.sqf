// JIP Check (This code should be placed first line of init.sqf file)
if (!isServer && isNull player) then {isJIP=true;} else {isJIP=false;};

//custom initPlayerLocal (mission specific):
ADV_handle_initPlayerLocal_custom = [] spawn compile preprocessFileLineNumbers "mission\initPlayerLocal_custom.sqf";

//removes all the mission relevant markers from the map:
call ADV_fnc_missionMarkers;
//parameter variables are re-initialized:
call ADV_fnc_parVariables;
call ADV_fnc_variables;

//waitUntil-player is initialized:
waitUntil {player == player && !isNil "ADV_params_defined"};

//defines the player's unit:
[player] call ADV_fnc_playerUnit;

//prevents the player units from blabbering on their radios
if (isMultiplayer) then {
	player setVariable ["BIS_noCoreConversations", true];
	enableRadio false;
};

//randomweather:
if (ADV_par_weather != 99) then {
	ADV_handle_randomWeather = [] spawn MtB_fnc_randomWeather;
};

//waitUntil-player is on map
titleText ["", "BLACK FADED"];
titleText [format ["%1 \n\n\nThis mission was built by %2 \n\n\n Have Fun! :)", briefingName, missionNamespace getVariable "ADV_missionAuthor"], "BLACK FADED"];

//fuck mcc
if (!isNil "mcc_actionInedx") then { player removeAction mcc_actionInedx; };

//stupid goggles are removed:
if ( goggles player in ["Mask_M40_OD","Mask_M40","Mask_M50","G_Balaclava_blk","G_Balaclava_combat","G_Balaclava_lowprofile","G_Balaclava_oli","G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_blk",
	"G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan","G_Goggles_VR"]
) then { removeGoggles player; };
sleep 1;
//loadouts and RespawnMPEVH are placed on the units on spawn. [target]
[player] call ADV_fnc_applyLoadout;
sleep 1;

//gearsaving
ADV_objects_gearSaving = [];
if ( ADV_par_logisticAmount > 0 ) then {
	if (!isNil "flag_1") then {
		ADV_handle_logisticAction = flag_1 addAction [("<t color=""#33FFFF"">" + ("Logistik-Menü") + "</t>"), {createDialog "adv_2_loadoutDialog";},nil,3,false,true,"","side player == west && player distance cursortarget <5"];
	};
	if (!isNil "opf_flag_1") then {
		ADV_handle_opfLogisticAction_opf = opf_flag_1 addAction [("<t color=""#33FFFF"">" + ("Logistik-Menü") + "</t>"), {createDialog "adv_2_loadoutDialog";},nil,3,false,true,"","side player == east && player distance cursortarget <5"];
	};
	if (!isNil "ind_flag_1") then {
		ADV_handle_indLogisticAction_ind = ind_flag_1 addAction [("<t color=""#33FFFF"">" + ("Logistik-Menü") + "</t>"), {createDialog "adv_2_loadoutDialog";},nil,3,false,true,"","side player == independent && player distance cursortarget <5"];
	};
};
if (!isNil "crate_2") then {ADV_objects_gearSaving pushBack crate_2};
if (!isNil "crate_3") then {ADV_objects_gearSaving pushBack crate_3};
if (!isNil "crate_4") then {ADV_objects_gearSaving pushBack crate_4};
if (!isNil "crate_5") then {ADV_objects_gearSaving pushBack crate_5};
if (!isNil "crate_6") then {ADV_objects_gearSaving pushBack crate_6};
if (!isNil "crate_7") then {ADV_objects_gearSaving pushBack crate_7};
if (!isNil "mgCrate") then {ADV_objects_gearSaving pushBack mgCrate};

if (!isNil "ind_crate_2") then {ADV_objects_gearSaving pushBack ind_crate_2};

if (!isNil "opf_crate_2") then {ADV_objects_gearSaving pushBack opf_crate_2};
if (!isNil "opf_crate_3") then {ADV_objects_gearSaving pushBack opf_crate_3};
if (!isNil "opf_crate_4") then {ADV_objects_gearSaving pushBack opf_crate_4};
if (!isNil "opf_crate_5") then {ADV_objects_gearSaving pushBack opf_crate_5};
if (!isNil "opf_crate_6") then {ADV_objects_gearSaving pushBack opf_crate_6};
if (!isNil "opf_crate_7") then {ADV_objects_gearSaving pushBack opf_crate_7};
if (!isNil "opf_mgCrate") then {ADV_objects_gearSaving pushBack opf_mgCrate};

if (!isNil "crate_empty") then {ADV_objects_gearSaving pushBack crate_empty};
if (!isNil "ind_crate_empty") then {ADV_objects_gearSaving pushBack ind_crate_empty};
if (!isNil "opf_crate_empty") then {ADV_objects_gearSaving pushBack opf_crate_empty};
if !(count ADV_objects_gearSaving == 0) then {
	ADV_objects_gearSaving spawn aeroson_fnc_gearsaving;
	//ADV_objects_gearSaving spawn aeroson_fnc_gearloading;
};

//disable fatigue if wanted:
if (ADV_par_fatigue == 0) then {
	player enableFatigue false;
	player enableStamina false;
	ADV_fatigue_EVH = player addEventhandler ["Respawn", {player enableFatigue false; player enableStamina false;}]; 
};

//reduce aim sway coefficient:
/*
if (!isClass(configFile >> "CfgPatches" >> "adv_aimcoeff")) then {
	player setCustomAimCoef 0.8;
	ADV_setCustomAimCoef_EVH = player addEventhandler ["Respawn",{player setCustomAimCoef 0.8;}];
};
*/

//move/remove respawn marker:
//[120 = Time until the respawn marker is moved again, 20 = radius around the group leader to place the marker]
ADV_scriptVar_initMoveMarker_jump = {
	(_this select 0) addAction [("<t color=""#00FF00"">" + ("Parajump") + "</t>"), {[_this select 1] call ADV_fnc_paraJump},nil,3,false,true,"","player distance cursortarget <5"];
};
switch ( ADV_par_moveMarker ) do {
	case 1: {
		ADV_handle_moveRespMarker = [120,20,ADV_par_remRespWest] spawn ADV_fnc_moveRespMarker;
	};
	default {
		if (!isNil "flag_1") then { [flag_1] call ADV_fnc_flag; };
		if (!isNil "opf_flag_1") then { [opf_flag_1] call ADV_fnc_flag; };
		if (!isNil "ind_flag_1") then {	[ind_flag_1] call ADV_fnc_flag;	};
	};
	case 3: {
		if (!isNil "flag_1") then { [flag_1] call ADV_scriptVar_initMoveMarker_jump; };
		if (!isNil "opf_flag_1") then { [opf_flag_1] call ADV_scriptVar_initMoveMarker_jump; };
		if (!isNil "ind_flag_1") then {	[ind_flag_1] call ADV_scriptVar_initMoveMarker_jump;	};
	};
	case 4: {
		if (!isNil "flag_1") then { [flag_1] call ADV_fnc_flag; [flag_1] call ADV_scriptVar_initMoveMarker_jump; };
		if (!isNil "opf_flag_1") then { [opf_flag_1] call ADV_fnc_flag; [opf_flag_1] call ADV_scriptVar_initMoveMarker_jump; };
		if (!isNil "ind_flag_1") then {	[ind_flag_1] call ADV_fnc_flag;	[ind_flag_1] call ADV_scriptVar_initMoveMarker_jump; };
	};
	case 99: {
		setPlayerRespawnTime 9999;
	};
	case 0: {};
};

//adds briefing pictures (00.jpg-05.jpg in \img\) to the specified object:
if (!isNil "BriefingBoard1") then {[BriefingBoard1] call ADV_fnc_board;};
if (!isNil "opf_BriefingBoard1") then {[opf_BriefingBoard1] call ADV_fnc_board;};
if (!isNil "ind_BriefingBoard1") then {[ind_BriefingBoard1] call ADV_fnc_board;};

//adds an option to choose from different loadouts to the specified object.
if (ADV_par_ChooseLoad == 1) then {
	if (!isNil "crate_1") then {
		ADV_handle_chooseLoadoutAction = crate_1 addAction [("<t color=""#00FF00"">" + ("Loadout-Menü") + "</t>"), {createDialog "adv_1_loadoutDialog";},nil,6,false,true,"","side player == west && player distance cursortarget <5"];
	};
	if (!isNil "opf_crate_1") then {
		ADV_handle_chooseLoadoutAction_opf = opf_crate_1 addAction [("<t color=""#00FF00"">" + ("Loadout-Menü") + "</t>"), {createDialog "adv_1_loadoutDialog";},nil,6,false,true,"","side player == east && player distance cursortarget <5"];
	};
	if (!isNil "ind_crate_1") then {
		ADV_handle_chooseLoadoutAction_ind = ind_crate_1 addAction [("<t color=""#00FF00"">" + ("Loadout-Menü") + "</t>"), {createDialog "adv_1_loadoutDialog";},nil,6,false,true,"","side player == independent && player distance cursortarget <5"];
	};
} else {
	if (!isNil "crate_1") then {ADV_handle_gearsaving = [crate_1] spawn aeroson_fnc_gearsaving;};
	if (!isNil "opf_crate_1") then {ADV_handle_gearsaving = [opf_crate_1] spawn aeroson_fnc_gearsaving;};
	if (!isNil "ind_crate_1") then {ADV_handle_gearsaving = [ind_crate_1] spawn aeroson_fnc_gearsaving;};
};

//adds action to throw it away if a disposable launcher is shot.
if !(isClass (configFile >> "CfgPatches" >> "adv_dropLauncher")) then { ADV_handle_dispLaunch = [] spawn ADV_fnc_dispLaunch; };

if ( (str player) in ["z1","z2","opf_z1","opf_z2","ind_z1","ind_z2"] ) then {
	if ( isNull (getAssignedCuratorLogic player) ) then { [str player] remoteExecCall ["adv_fnc_createZeus",2]; };
	if (isClass (configFile >> "CfgWeapons" >> "H_Cap_capPatch_SeL")) then {
		player addHeadgear "H_Cap_capPatch_SeL";
	};
};

//add raise/lower headset-action:
//[player] spawn ADV_fnc_radioHeadset;

sleep 3;
titleText ["", "BLACK FADED"];
sleep 1;
titleFadeOut 3;

//igi-load
if !(isClass(configFile >> "CfgPatches" >> "ace_cargo")) then {
	ADV_handle_igiLoad = [] execVM "scripts\IgiLoad\IgiLoadInit.sqf";
};

sleep 8;
//a little hint stating the date and time
["Have Fun!", "Datum:" + str (date select 2) + "/" + str (date select 1) + "/" + str (date select 0)] spawn BIS_fnc_infoText;

if (true) exitWith {};
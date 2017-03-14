// JIP Check (This code should be placed first line of init.sqf file)
if (!isServer && isNull player) then {isJIP=true;} else {isJIP=false;};

//custom initPlayerLocal (mission specific):
ADV_handle_initPlayerLocal_custom = [] spawn compile preprocessFileLineNumbers "mission\initPlayerLocal_custom.sqf";

//removes all the mission relevant markers from the map:
call ADV_fnc_missionMarkers;
//parameter variables are re-initialized:
call ADV_fnc_parVariables;
call ADV_fnc_variables;
call ADV_fnc_tfarSettings;
//collections
call adv_fnc_collectCrates;
call adv_fnc_collectFlags;

//waitUntil-player is initialized:
waitUntil {player == player && !isNil "ADV_params_defined"};
if (adv_par_customLoad > 0) then {
	player unlinkItem "ItemRadio";
};

//defines the player's unit:
[player] call ADV_fnc_playerUnit;

//prevents the player units from blabbering on their radios
if (isMultiplayer) then {
	player setVariable ["BIS_noCoreConversations", true];
	enableRadio false;
};

//randomweather:
if (ADV_par_randomWeather != 99) then {
	ADV_handle_randomWeather = [] spawn MtB_fnc_randomWeather;
};

//waitUntil-player is on map
titleText ["", "BLACK FADED"];
titleText [format ["%1 \n\n\nThis mission was built by %2 \n\n\n Have Fun! :)", briefingName, missionNamespace getVariable ["ADV_missionAuthor","[SeL] Belbo // Adrian"]], "BLACK FADED"];

//fuck mcc
if (!isNil "mcc_actionInedx") then { player removeAction mcc_actionInedx; };

//stupid goggles are removed:
if ( (toUpper (goggles player)) in ["MASK_M40_OD","MASK_M40","MASK_M50","G_BALACLAVA_BLK","G_BALACLAVA_COMBAT","G_BALACLAVA_LOWPROFILE","G_BALACLAVA_OLI","G_BANDANNA_AVIATOR","G_BANDANNA_BEAST","G_BANDANNA_BLK",
	"G_BANDANNA_KHK","G_BANDANNA_OLI","G_BANDANNA_SHADES","G_BANDANNA_SPORT","G_BANDANNA_TAN","G_GOGGLES_VR","MURSHUN_CIGS_CIG0","MURSHUN_CIGS_CIG1","MURSHUN_CIGS_CIG2","MURSHUN_CIGS_CIG3","MURSHUN_CIGS_CIG4"]
) then { removeGoggles player; };
sleep 1;
//loadouts and RespawnMPEVH are placed on the units on spawn. [target]
[player] call ADV_fnc_applyLoadout;
sleep 1;

//logistics menu
if ( ADV_par_logisticAmount > 0 ) then {
	{ nul = _x addAction [("<t color='#33FFFF' size='2'>" + ("Logistik-Menü") + "</t>"), {createDialog "adv_logistic_mainDialog";},nil,3,false,true,"","side player == west",5]; nil; } count adv_objects_westFlags;
	{ nul = _x addAction [("<t color='#33FFFF' size='2'>" + ("Logistik-Menü") + "</t>"), {createDialog "adv_logistic_mainDialog";},nil,3,false,true,"","side player == east",5]; nil; } count adv_objects_eastFlags;
	{ nul = _x addAction [("<t color='#33FFFF' size='2'>" + ("Logistik-Menü") + "</t>"), {createDialog "adv_logistic_mainDialog";},nil,3,false,true,"","side player == independent",5]; } count adv_objects_indFlags;
};
//gearsaving
ADV_objects_clearCargo spawn adv_fnc_gearsaving;
//ADV_objects_gearSaving spawn adv_fnc_gearloading;

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
/*
ADV_scriptVar_initMoveMarker_jump = {
	{
		private _target = _x;
		_target addAction [("<t color=""#00FF00"">" + ("Parajump") + "</t>"), {[_this select 1] call ADV_fnc_paraJumpSelection},nil,3,false,true,"","player == leader (group player)",5];
		nil;
	} count _this;
};
*/
//moves the player to position of object called "respawn_helper", if it's present (for Nimitz for example):
if (!isNil "respawn_helper") then {
	adv_evh_respawnMover = player addEventhandler ["RESPAWN",{
		player setPosATL (getPosATL respawn_helper);
		player setDir (getDir respawn_helper);
	}];
};
//handling of respawned players:
switch ( ADV_par_moveMarker ) do {
	case 1: {
		ADV_handle_moveRespMarker = [120,20,ADV_par_remRespWest] spawn ADV_fnc_moveRespMarker;
	};
	default {
		adv_objects_flags call ADV_fnc_flag;
	};
	case 3: {
		adv_objects_flags call ADV_fnc_flag;
		{ nul = _x addAction [("<t color='#00FF00' size='2'>" + ("Parajump") + "</t>"), {[_this select 1] call ADV_fnc_paraJumpSelection},nil,3,false,true,"","player == leader (group player)",5]; nil; } count adv_objects_flags;
	};
	case 99: {
		setPlayerRespawnTime 9999;
	};
	case 0: {};
};

//adds briefing pictures (00.jpg-05.jpg in \img\) to the specified object and loadout actions:
if (!isNil "BriefingBoard1") then {[BriefingBoard1] call ADV_fnc_board;};
if (!isNil "opf_BriefingBoard1") then {[opf_BriefingBoard1] call ADV_fnc_board;};
if (!isNil "ind_BriefingBoard1") then {[ind_BriefingBoard1] call ADV_fnc_board;};
if (ADV_par_ChooseLoad == 1) then {
	if (!isNil "BriefingBoard1") then {
			ADV_handle_chooseLoadoutAction = BriefingBoard1 addAction [("<t color='#00FF00' size='2' align='center'>" + ("Loadout-Menü") + "</t>"), {createDialog "adv_loadouts_mainDialog";},nil,6,true,true,"","side player == west",5];
	};
	if (!isNil "opf_BriefingBoard1") then {
		ADV_handle_chooseLoadoutAction_opf = opf_BriefingBoard1 addAction [("<t color='#00FF00' size='2' align='center'>" + ("Loadout-Menü") + "</t>"), {createDialog "adv_loadouts_mainDialog";},nil,6,true,true,"","side player == east",5];
	};
	if (!isNil "ind_BriefingBoard1") then {
		ADV_handle_chooseLoadoutAction_ind = ind_BriefingBoard1 addAction [("<t color='#00FF00' size='2' align='center'>" + ("Loadout-Menü") + "</t>"), {createDialog "adv_loadouts_mainDialog";},nil,6,true,true,"","side player == independent",5];
	};
};

//adds action to throw it away if a disposable launcher is shot.
if !(isClass (configFile >> "CfgPatches" >> "adv_dropLauncher")) then { ADV_handle_dispLaunch = [] spawn ADV_fnc_dispLaunch; };

if ( toUpper (str player) in ["Z1","Z2","Z3","Z4","Z5","OPF_Z1","OPF_Z2","OPF_Z3","OPF_Z4","OPF_Z5","IND_Z1","IND_Z2","IND_Z3","IND_Z4","IND_Z5"] ) then {
	if ( isNull (getAssignedCuratorLogic player) ) then { [str player, 3] remoteExecCall ["adv_fnc_createZeus",2]; };
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

switch (side (group player)) do {
	case west: { [player,"respawn_west",70] call adv_fnc_safezone; };
	case east: { [player,"respawn_east",70] call adv_fnc_safezone; };
	case independent: { [player,"respawn_guerrila",70] call adv_fnc_safezone; };
	default {};
};

sleep 4;
//a little hint stating the date and time
if ((toUpper worldname) in ["STRATIS","ALTIS"]) then {
	["Have Fun!"] spawn BIS_fnc_infoText;
	sleep 4;
	[] spawn compile preprocessFileLineNumbers "a3\missions_f_epa\Campaign_shared\Functions\Timeline\fn_camp_showOSD.sqf";
} else {
	["Have Fun!", "Datum:" + str (date select 2) + "/" + str (date select 1) + "/" + str (date select 0)] spawn BIS_fnc_infoText;
};

//TFAR Workaround:
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
	["unit", {
		if (player != (_this select 0)) then {
			player setVariable ["TFAR_controlledUnit",(_this select 0), true];
		} else {
			player setVariable ["TFAR_controlledUnit",nil, true];
		};

		TFAR_currentUnit = (_this select 0);
	}] call CBA_fnc_addPlayerEventHandler;
};

if (true) exitWith {};
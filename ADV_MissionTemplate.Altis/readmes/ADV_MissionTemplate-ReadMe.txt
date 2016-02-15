# ADV_MissionTemplate
Mission Template by Belbo for Spezialeinheit Luchs

Files open for editing are found in the \mission\-folder. Don't change init.sqf, initPlayerLocal.sqf oder description.ext - you might break the mission otherwise!
The license.txt MUST NOT be removed from the mission folder.

If you want to build a mission on the base of the ADV-Mission Template, you'll have to edit the following files first:
ADV_credits.sqf: Put your name in ADV_missionAuthor = "[SeL] Belbo // Adrian";
mission\ADV_defines.hpp: Edit to your liking, especially MISSIONAUTHOR, MISSIONNAME and MISSIONPLAYERS

If you want to execute code from init.sqf or initPlayerLocal.sqf add your code to the mission\init_custom.sqf or mission\initPlayerLocal_custom.sqf.

adv_dramaturgy.sqf will be executed on server only or on HC if HC is present and the HC-parameter is selected in MP lobby.

Most settings for this template can be altered in the MP lobby.

The following functions might proove helpfull while creating a mission:

[["O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_soldier_AR_F","O_medic_F"],east,50,["LIMITED","CARELESS","STAG COLUMN"],[spawnLogic_1]] call ADV_fnc_spawnPatrol;
Will spawn a group of OPFOR-soldiers with the side east at the position of spawnLogic_1. The units will patrol within a 50 meter radius around the spawn location
with the UPSMON-parameters provided. (Execution on SERVER or HC only!)

[["I_Soldier_TL_F","I_Soldier_AR_F","I_Soldier_F","I_soldier_GL_F","I_medic_F"],independent,50,[spawnLogic_1],attackLogic_1] call ADV_fnc_spawnAttack;
Will spawn a group of INDFOR-soldiers with the side independent at the position of spawnLogic_1. The units will attack an area of 50 meter radius around
the position of attackLogic_1. (Execution on SERVER or HC only!)

[player,40] spawn ADV_fnc_undercover;
AI won't shoot at the player, as long as he isn't holding a weapon and has been at least 40 meters from the next enemy when putting away his weapon.
(Execution on CLIENT only!)

[player] call ADV_fnc_fullHeal;
Heals player fully, especially with both the basic and advanced system of ace_medical. (Execution on CLIENT only!)

[VEHICLE,true,true,1,false] call ADV_fnc_vehicleLoad;
Adds gear to VEHICLE, depending on which kind of weapons or uniforms are selected in MP lobby. If first bool is true, it's defined as a medical vehicle
(with additional medical items). If second bool is true, VEHICLE will have weapons and ammunition. The number is the amount of spareparts that the
vehicle will have loaded with ace_repair. Last bool defines vehicle as repair-vehicle with ace_repair. For OPFOR- and INDEPENDENT-vehicles
use ADV_opf_fnc_vehicleLoad or ADV_ind_fnc_vehicleLoad. (Execution on SERVER only!)

[VEHICLE,300] spawn ADV_fnc_respawnVeh;
Will respawn VEHICLE at it's starting position at 300 seconds after destruction. (May not have the same items in it's inventory, if it's not named
according to the naming standards of this Template.) For OPFOR- and INDEPENDENT-vehicles use ADV_opf_fnc_respawnVeh or ADV_ind_fnc_respawnVeh.
(Execution on SERVER only!)

[[flareLogic_1,flareLogic_2],"red",30,120] call ADV_fnc_flare;
Will spawn a flare of color "red" in a radius of 30 meter around the positions of each object or marker provided. Height of the flare will be 120 meters.
(Execution on SERVER only!)

[[target_1,target_2],"Sh_155mm_AMOS",[3,7],300,5,50] spawn ADV_fnc_artillery;
Will have 5 artillery shells of type Sh_155mm_AMOS drop down in a radius of 50 meter around the positions of each object or marker provided.
The shells will start to fall at a height of 300 meter and between each shell there will be a delay between 3 and 7 seconds.
(Execution on SERVER only!)

[fireLogic_1,"FIRE_BIG"] call ADV_fnc_spawnFire;
Will spawn a big fire at position of fireLogic_1. Possible parameters are: "FIRE_SMALL","FIRE_MEDIUM","FIRE_BIG","SMOKE_SMALL","SMOKE_MEDIUM","SMOKE_BIG".
(Execution on CLIENT only!)

if (!isNil "ADV_respawn_EVH") then {player removeEventhandler ["Respawn",ADV_respawn_EVH]};
aeroson_loadout = [player] call aeroson_fnc_getLoadout;
ADV_respawn_EVH = player addEventhandler ["Respawn",{[player, aeroson_loadout] spawn aeroson_fnc_setLoadout;}];
This code will exchange the players saved loadout if any changes have been made to it's gear (in mission\initPlayerLocal_custom.sqf!)

Addaction functions:

ADV_handle_paraJumpAction = OBJECT addAction [("<t color=""#33FFFF"">" + ("Parajump") + "</t>"), {[_this select 1] call ADV_fnc_paraJump},nil,3,false,true,"","player distance cursortarget <5"];
Adds an action to OBJECT that gives player option to choose location for a parajump (parachute will be added to back, but backpack will be readded after landing).
(Execution on CLIENT only!)

[FLAGNAME_1,FLAGNAME_2] spawn ADV_fnc_flag;
Adds action to each object provided that gives player option to teleport to his group leader. (Execution on CLIENT only!)

[VEHICLE, west, 90] spawn ADV_fnc_radioRelay;
Will add action to VEHICLE to make it a radio relay that boosts radio range with TFAR for each unit of side west, as long as vehicle is not in motion
and at least 90 meter above sea level. (Execution on SERVER AND CLIENT!)

ADV_handle_logisticAction = OBJECT addAction [("<t color=""#33FFFF"">" + ("Logistik-Menü") + "</t>"), {createDialog "adv_2_loadoutDialog";},nil,3,false,true,"","player distance cursortarget <5"];
Adds an action to OBJECT that opens logistic menu to spawn crates with gear (according to weapons selected in MP lobby). (Execution on CLIENT only!)

Important variables:
player getVariable ["ADV_var_hasLoadout",false];
Returns true as soon as player has received his first loadout.

VEHICLE getVariable ["adv_var_vehicleIsChanged",false];
Returns true as soon as a vehicle has been changed, if it's being changed.

missionNamespace getVariable ["ADV_var_manageVeh",false];
Returns true as soon as vehicle management has been completed. (Does not include change of vehicles according to parameters in MP lobby). Variables for other sides OPFOR and INDEPENDENT are ADV_var_manageVeh_opf and ADV_var_manageVeh_ind.

# ADV_MissionTemplate
Mission Template by Belbo for Spezialeinheit Luchs

Files open for editing are found in the \mission\-folder. Don't change init.sqf, initPlayerLocal.sqf oder description.ext - you might break the mission otherwise!
The license.txt MUST NOT be removed from the mission folder.

If you want to build a mission on the base of the ADV-Mission Template, you'll have to edit the following files first:
ADV_credits.sqf: Put your name in ADV_missionAuthor = "[SeL] Belbo // Adrian";
mission\ADV_defines.hpp: Edit to your liking, especially MISSIONAUTHOR, MISSIONNAME and MISSIONPLAYERS

If you want to execute code from init.sqf or initPlayerLocal.sqf add your code to the files mission\init_custom.sqf or mission\initPlayerLocal_custom.sqf.

mission\adv_dramaturgy.sqf will be executed on server only or on HC if HC is present and the HC-parameter is selected in MP lobby.

Units named according to readmes\loadoutNames.txt will receive their loadouts automatically depending on selected uniform- and weapons-parameter in MP lobby.
Vehicles named according to readmes\vehicleNames.txt will be handled by vehicle exchange and respawn system (according to paramter in MP lobby) and have gear and variables fitting to side of players and their selected weapon sets.
If you don't use these names, I don't furnish a guarantee that your mission will be a success.

Don't EVER place playable units that aren't included in the base game (ie. vanilla units).

Most settings for this template can be altered in the MP lobby or in mission\CfgParams.hpp (standards for MP lobby params), mission\CfgACEParams.hpp (standards for MP lobby params for ACE³) or in mission\CfgACE.hpp (ACE-Settings).

/////////////////////
The following functions might proove helpful while creating a mission:

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

This code will exchange the players saved loadout if any changes have been made to it's gear (in mission\initPlayerLocal_custom.sqf only!)

[OBJECT] call ADV_fnc_rollDice;

Adds action to an object (not player) that allows dice rolls. The rolled value will be displayed and a diary entry created that logs the dice rolls. (Execution on CLIENT only!)

/////////////////////
Addaction functions:

OBJECT addAction [("<t color=""#00FF00"">" + ("Loadout-Menü") + "</t>"), {createDialog "adv_1_loadoutDialog";},nil,6,false,true,"","player distance cursortarget <5"];

Adds an action to OBJECT that gives player option to choose loadout. (Execution on CLIENT only!)

OBJECT addAction [("<t color=""#33FFFF"">" + ("Parajump") + "</t>"), {[_this select 1] call ADV_fnc_paraJump},nil,3,false,true,"","player distance cursortarget <5"];

Adds an action to OBJECT that gives player option to choose location for a parajump (parachute will be added to back, but backpack will be readded after landing).
(Execution on CLIENT only!)

[FLAGNAME_1,FLAGNAME_2] spawn ADV_fnc_flag;

Adds action to each object provided that gives player option to teleport to his group leader. (Execution on CLIENT only!)

[VEHICLE, west, 90] spawn ADV_fnc_radioRelay;

Will add action to VEHICLE to make it a radio relay that boosts radio range with TFAR for each unit of side west, as long as vehicle is not in motion
and at least 90 meter above sea level. (Execution on SERVER AND CLIENT!)

OBJECT addAction [("<t color=""#33FFFF"">" + ("Logistik-Menü") + "</t>"), {createDialog "adv_2_loadoutDialog";},nil,3,false,true,"","player distance cursortarget <5"];

Adds an action to OBJECT that opens logistic menu to spawn crates with gear (according to weapons selected in MP lobby). (Execution on CLIENT only!)

/////////////////////
Important variables:

player getVariable ["ADV_var_hasLoadout",false];

Turns true as soon as player has received his first loadout.

VEHICLE getVariable ["adv_var_vehicleIsChanged",false];

Turns true as soon as a vehicle has been changed, if it's being changed.

missionNamespace getVariable ["ADV_var_manageVeh",false];

Turns true as soon as vehicle management has been completed. (Does not include change of vehicles according to parameters in MP lobby). Variables for other sides OPFOR and INDEPENDENT are ADV_var_manageVeh_opf and ADV_var_manageVeh_ind.

/////////////////////
Useful other commands:

If you want or need to put something in a vehicles init-line (which be will applied to the vehicle even after respawn) do it like this:
this setVariable ["adv_vehicleinit","_this call any_function"];
this call compile (this getVariable "adv_vehicleinit");
You can put your code in the field "_this call any_function". Remember to refer to the vehicle with _this instead of this!

removeFromRemainsCollector [this];

Put in init-line of unit to have it removed from garbage collection.

UNIT setVariable ["ACE_medical_medicClass", 2];

Put in init-line of unit or vehicle to define it as ace_medical-doctor.

OBJECT setVariable ["ACE_medical_isMedicalFacility", true];

Put in init-line of building to define it as ace_medical-medical-facility.

VEHICLE setVariable ["ACE_isRepairVehicle", 1];

Put in init-line of vehicle to define it as ace_repair-repair-vehicle.

OBJECT setVariable ["ACE_isRepairFacility", 1];

Put in init-line of vehicle to define it as ace_repair-repair-facility.

/////////////////////
Hints for using mission\adv_dramaturgy.sqf:

If you want to create a mission flow that fully utilizes the adv_dramaturgy.sqf you should work like this:

For every position you want enemies to spawn put down a game logic and name it.
For every new "chapter" of the mission (ie. if you want enemies to spawn or something to happen only if players move to a certain area) you place a trigger with your conditions or, if you just want to check if
players are inside use this:

Activation: Anybody

Once/Repeatedly: Once

Condition: (vehicle player) in thisList && ( (getPosATL (vehicle player)) select 2 < 5 )

On Activation: ADV_taskVar = 1; publicVariable "ADV_taskVar";

Now put this in mission\adv_dramaturgy.sqf:

waitUntil { sleep 1; ADV_taskVar==1 };

Now everything after this waitUntil will only be executed if players walk into your trigger.

Rinse and repeat.

To have nested execution you need to put your code and the waitUntil inside a spawn, like this:

[] spawn {
	waitUntil { sleep 1; ADV_taskVar==2 };
	{... code ...};
};

Have Fun!
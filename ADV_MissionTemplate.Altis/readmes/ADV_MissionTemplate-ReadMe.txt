ADV_MissionTemplate-ReadMe:

This file contains a little overview to the functions that are part of the ADV_MissionTemplate. These functions are supposed to create and/or support your mission-building.
Everything that is supposed to be mission-specific can be put inside the folder "mission\". Within this folder you'll find the briefing- and task-files, the params.hpp (for preconfiguring the
mission parameters like time, weather, loadouts etc.), a custom init.sqf, a custom initPlayerLocal.sqf and the ADV_dramaturgy.sqf

The ADV_dramaturgy.sqf is the most important part for creating a mission. This file is called at the end of the init.sqf and will be run serverside only. Within this file you can
call everything that is related to the mission. If you want something to happen place a trigger on the map with the following content in the on Act.-field: 

ADV_taskVar=1;publicVariable "ADV_taskVar";

The ADV_dramaturgy.sqf contains a waitUntil {ADV_taskVar==1}; inside a spawn-command. That means that the code after the waitUntil and inside the spawn {} will only be executed once the ADV_taskVar is equal to 1.
With that little trick you can avoid all those aggravating locality-issues that can hinder your mission progress.

These are the functions that you can use to change your mission (in a meaningful and not alphabetical order):

ADV_fnc_spawnPatrol:
	With this you can spawn a group of units that utilizes UPSMON to get their waypoints. You can do that by either using an existing marker or an existing object (like a gamelogic - the radius in the call defines a
	circle around the object that will be the patrol radius of the unit). Call on Server only!
	possible call:
	[["O_Soldier_TL_F","O_Soldier_GL_F","O_soldier_AR_F","O_medic_F"],east,200,["LIMITED","STAG COLUMN","NOFOLLOW"],[spawnLogic,spawnLogic_1,spawnLogic_2]] call ADV_fnc_spawnPatrol;
		-> This will spawn a group of four soldiers with the given names belonging to the east-side at the thre spawnLogic-items who will patrol within a 200 meter radius around their respective objects with
		the "LIMITED","STAG COLUMN","NOFOLLOW"-parameters from UPSMON.

ADV_fnc_artillery:
	With this you can call an artillery-strike on a given position. Spawn on server only!
	possible call:
	["Sh_155mm_AMOS",[target_1,target_2],[3,7],300,5,50] spawn ADV_fnc_artillery;
		-> This will spawn two artillery strikes at the location of the target-objects of the type "Sh_155mm_AMOS". The impacts will follow each other with a random interval between 3 and 7 seconds. The shells will spawn
		at a height of 300 meter. 5 shells will be coming down within a 50 meter radius.

ADV_fnc_showArtiSetting:
	With this you can give players the possibility to see their current artillery computer settings (the range, so to speak). Spawn on all clients!
	possible call:
	[arty_1,arty_2] call ADV_fnc_showArtiSetting;
		-> This will add an action to the gunners of all the unique vehicles in the array, to trigger a hint with the current artillery settings.

ADV_fnc_clearCargo:
	With this you can clear the cargo of a given container. Call on server only!
	possible call:
	[item_1,item_2] call ADV_fnc_clearCargo;
		-> This will clear the cargo for every unique item listed in the array.

ADV_fnc_crate:
	With this you can add the predefined (balanced and matched to the loadout-parameter!) crate-content to a crate. Call on Server only!
	possible call:
	[crate_1,crate_2] call ADV_fnc_crate;
		-> This will add the crate-content to every unique item listed in the array.

ADV_fnc_vehicleLoad:
	With this you can add the predefined (balanced and matched to the loadout-parameter!) vehicle load to a vehicle. Call on Server only!
	possible call:
	[vehicle_1,true,true,2,4] call ADV_fnc_vehicleLoad;
		-> This will add the load to the item called "vehicle_1". The first boolean defines the vehicle as a medical-vehicle and add more medical items, if the second boolean is set to true, it will add weapons and ammunition to
		the vehicle. With this call you will have add 2 jerry cans and 4 spare wheels, if AGM is running on your server.

ADV_fnc_submarineLoad:
	With this you can add the predefined (balanced and matched to the loadout-parameter!) submarine load to a submarine. Call on Server only!
	possible call:
	[submarine_1,submarine_2] call ADV_fnc_submarineLoad;
		-> This will add the load to all the unique vehicles listed in the array.

ADV_fnc_removeWeapon:
	With this you can remove all the weapons from a unit and place them in a groundweaponholder. (Combine with a waitUntil {captive TARGET}; to simulate capturing and disarming a unit)
	possible call:
	[target_1] call ADV_fnc_removeWeapon;
		-> This will remove all the weapons from all the unique units in the array and place them on the ground.

ADV_fnc_addMagazine:
	With this you can add magazines for the current weapon of a unit (without providing a specific name).
	possible call:
	[TARGET,3,0,0] call ADV_fnc_addMagazine;
		-> This will add 3 magazines to the unique unit TARGET. The first 0 defines the weapon (0=primary weapon;1=handgun;2=secondary weapon). The second 0 defines the magazine index.

ADV_fnc_changeName:
	With this you can change the display name of an AI-unit. Works for UGVs and UAVs too. Has to be called on all clients!
	possible call:
	[TARGET,"Peter","Schmitz"] call ADV_fnc_changeName;
		-> This will give the unique unit TARGET the display name "Peter Schmitz".
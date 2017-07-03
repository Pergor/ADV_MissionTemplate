# ADV_MissionTemplate
Mission Template by Belbo for Spezialeinheit Luchs

Files open for editing are found in the \mission\-folder. Don't change description.ext if you don't know what you do - you might break the mission otherwise!
init.sqf, initPlayerLocal.sqf and initServer.sqf can be edited to your liking except for the first few marked lines.
The licence.txt MUST NOT be removed from the mission folder.

If you want to build a mission on the base of the ADV-Mission Template, you'll have to edit the following files first:

	mission\ADV_defines.hpp: Edit to your liking.
		You HAVE to change the following: MISSIONAUTHOR, MISSIONNAME and MISSIONPLAYERS

mission\adv_storyboard.sqf will be executed on server only or on HC if HC is present and the HC-parameter is selected in MP lobby.

Units named according to readmes\loadoutNames.txt will receive their loadouts automatically depending on selected uniform- and weapons-parameter in MP lobby.
Vehicles named according to readmes\vehicleNames.txt will be handled by vehicle exchange and respawn system (according to paramter in MP lobby) and have gear and variables fitting to side of players and their selected weapon sets.
If you don't use these names, I don't furnish a guarantee that your mission will be a success.

Don't EVER place playable units that aren't included in the base game (ie. vanilla units).

Most settings for this template can be altered in the MP lobby or in:

	mission\CfgParams.hpp (standards for MP lobby params)
	mission\CfgACEParams.hpp (standards for MP lobby params for ACE³ - these overwrite the corresponding settings in mission\CfgACE.hpp)
	mission\CfgACE.hpp (ACE-Settings).

/////////////////////
Important variables:

//Turns true as soon as player has received his first loadout:

	player getVariable ["ADV_var_hasLoadout",false];

//turns true if a vehicle has been changed via lobby params:

	VEHICLE getVariable ["adv_var_vehicleIsChanged",false];

/////////////////////
Useful other commands:

//Put in init-line of unit to have it removed from garbage collection:

	removeFromRemainsCollector [this];

//Put in init-line of unit or vehicle to define it as ace_medical-doctor:

	this setVariable ["ACE_medical_medicClass", 2];

//Put in init-line of building to define it as ace_medical-medical-facility:

	this setVariable ["ACE_medical_isMedicalFacility", true];

//Put in init-line of vehicle to define it as ace_repair-repair-vehicle:

	this setVariable ["ACE_isRepairVehicle", 1];

//Put in init-line of vehicle to define it as ace_repair-repair-facility:

	this setVariable ["ACE_isRepairFacility", 1];

/////////////////////

Have Fun!


	License for every part of adv_missiontemplate:
	
	This mission is based on the ADV Mission Template by Belbo.

	This file must not be removed from the folder and must be contained in every work based on the ADV Mission Template.

	If you edit this mission, you may only do so as long as you change the mission name and the name of the author. This includes the entries in description.ext (to be easily changed in
	\mission\ADV_defines.hpp), the adv_credits.sqf and those settings editable in the mission editor.

	This mission is published under the APL-SA licence:

	"	With this licence you are free to adapt (i.e. modify, rework or update) and share (i.e. copy, distribute or transmit) the material under the following conditions:
		Attribution - You must attribute the material in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the material).
		Noncommercial - You may not use this material for any commercial purposes.
		Arma Only - You may not convert or adapt this material to be used in other games than Arma.
		Share Alike - If you adapt, or build upon this material, you may distribute the resulting material only under the same licence.	" 
	( http://www.bistudio.com/community/licenses/arma-public-license-share-alike )

	Noncommercial includes monetized servers: This mission or parts or derivatives of it may not be used on monetized servers.
	Altis Life: This mission or parts or derivatives of it may not be used in any derivative of Life gamemode.
	Steam Workshop: This mission or parts or derivatives of it may not be uploaded to Steam Workshop, neither individually nor as part of a collection.
	
	Different licences may apply to scripts not written by the author. The respective rights remain with the authors of these scripts.
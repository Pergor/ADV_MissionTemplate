/*
if you want to use the slingloadable crate, you have to place a marker at the location you want it to spawn at, called:
"ADV_locationCrateLarge" for BLUFOR, "ADV_opf_locationCrateLarge" for OPFOR, "ADV_ind_locationCrateLarge" for INDFOR
*/

ADV_par_logisticDrop = 0;		//Should logistic crates be droppable upon mapclick? (0 - no, 1 - yes) Crates will be dropped after 2 to 3 minutes.
ADV_par_logisticTeam = 0;		//Should larger crates (0 - no, 1 - crate Team, 2 - crate Team and slingloadable crate) be placeable?

if (hasInterface) then {
	waitUntil {player == player};
};
//waitUntil-player is initialized
waitUntil {time > 1};

if (!isNil "OBJECT") then { OBJECT addAction [("<t color=""#33FFFF"">" + ("Logistik-Menü") + "</t>"), {createDialog "adv_2_loadoutDialog";},nil,3,false,true,"","player distance cursortarget <5"]; };

if (true) exitWith {};
/////////initPlayerLocal.sqf is only executed on player clients/////////
//////////////////////Feel free to edit below: /////////////////////////

//wait for player object to be available.
waitUntil {player == player && !isNil "ADV_params_defined"};
//place your code below:


//wait until player has his loadout:
if ( (missionNamespace getVariable ["adv_par_customLoad",1]) > 0 ) then { waitUntil {player getVariable ["ADV_var_hasLoadout",false]}; };
//place your code below:


//wait until player has launched into mission:
waitUntil {time > 0};
//place your code below:





//below are some optional scripts that you might find useful. Uncomment/comment or change the ones you want/need:

//make players go undercover if he has no weapon/changes his uniform to an enemy uniform:
//[true] call adv_fnc_undercover;

//reduce minimum speed of ace-speedlimiter and add additional abilities to speedlimiter:
//[] call adv_fnc_speedLimiter;
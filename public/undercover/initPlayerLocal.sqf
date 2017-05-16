/////////initPlayerLocal.sqf is only executed on player clients/////////
//////////////////////Feel free to edit below: /////////////////////////

//wait for player object to be available.
waitUntil {player == player};

//make players go undercover if he has no weapon/changes his uniform to an enemy uniform:
[false] call compile preprocessFileLineNumbers "undercover\fn_undercover.sqf";
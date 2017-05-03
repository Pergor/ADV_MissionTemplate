/////////init.sqf is executed on both player clients and server/////////
//////////////////////Feel free to edit below: /////////////////////////

//waitUntil param variables are defined:
waitUntil {!isNil "ADV_params_defined"};
//place your code below:

//wait until mission has started:
waitUntil {time > 0};
//place your code below:



//these are some optional scripts that you might find useful. Uncomment/comment or change the ones you want/need:

//turn a vehicle into a radio relay that pushes the sending/receiving-distance for a specific side:
//adv_handle_radioRelay_west = [VEHICLENAME, west, 50] call adv_fnc_radioRelay;

//turn a vehicle into a radio jammer that jams radio signals in the given radius:
//adv_handle_jammer_west = [MRAP_1,500] call adv_fnc_jammer;
/////////init.sqf is executed on both player clients and server/////////
//////////////////////Feel free to edit below: /////////////////////////

//waitUntil param variables are defined:
waitUntil {!isNil "ADV_params_defined"};
//place your code below:


//wait until mission has started:
waitUntil {time > 0};
//place your code below:




//below are some optional scripts that you might find useful. Uncomment/comment or change the ones you want/need:

//dynamic simulation (ai units spawned with adv_fnc_aiTask or other adv_fnc-functions are automatically are spawned with dynamicSimulationEnabled).
//dynamic simulation is on by default. The values shown here are the defaults. Change to your liking:
	enableDynamicSimulationSystem true;
	//"Group" setDynamicSimulationDistance 500;
	//"Vehicle" setDynamicSimulationDistance 350;
	//"EmptyVehicle" setDynamicSimulationDistance 250;
	//"Prop" setDynamicSimulationDistance 50;
	//"IsMoving" setDynamicSimulationDistanceCoef 2;

//turn a vehicle into a radio relay that pushes the sending/receiving-distance for a specific side:
	//adv_handle_radioRelay_west = [VEHICLENAME, west, 50] call adv_fnc_radioRelay;

//turn a vehicle into a radio jammer that jams radio signals in the given radius:
	//adv_handle_jammer_west = [MRAP_1,500] call adv_fnc_jammer;
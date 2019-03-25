////////////////initServer.sqf is only executed on server///////////////
//////////////////////Feel free to edit below: /////////////////////////

//waitUntil param variables are defined:
waitUntil {!isNil "ADV_params_defined"};
//place your code below:


//wait until mission has started:
waitUntil {time > 0};
//place your code below:




//below are some optional scripts that you might find useful. Uncomment/comment or change the ones you want/need:

//Changing vanilla- or CUP-IEDs to ACE-IEDs:
[] call adv_fnc_IEDhandler;
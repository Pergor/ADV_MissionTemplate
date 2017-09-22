/*
 * Author: Belbo
 *
 * Automatically executed init.sqf-substitute. Spawned via adv_fnc_initOrganizer.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: No
 */

// JIP Check (This code should be placed first line of init.sqf file)
isJIP = if (!isServer && isNull player) then {true} else {false};
enableSaving [false, false];

//waitUntil param variables are defined:
waitUntil {!isNil "ADV_params_defined"};

call {
	//randomweather:
	if !( (missionNamespace getVariable ["ADV_par_randomWeather",99]) isEqualTo 99 ) exitWith {
		ADV_handle_weather = [] spawn MtB_fnc_randomWeather;
	};
	//fixed weather:
	if !( (missionNamespace getVariable ["ADV_par_weather",99]) isEqualTo 99 ) exitWith {
		ADV_handle_weather = [] spawn adv_fnc_weather;
	};
};

//engine artillery
if ( (missionNamespace getVariable ["ADV_par_engineArtillery",0]) isEqualTo 1 ) then {
	enableEngineArtillery false;
};

//ACE stuff that's been forgotten by the developers:
//missionNamespace setVariable ["ace_medical_healHitPointAfterAdvBandage",true];

//end of init.
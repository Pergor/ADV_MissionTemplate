/*
ADV_par_Variables by Belbo
contains all the variables that are put into description.ext via params.hpp
call from init.sqf AND initPlayerLocal.sqf via (as early as possible):
call compile preprocessfilelinenumbers "ADV_Setup\ADV_par_Variables.sqf";
or per preInit via cfgFunctions
*/

private ["_arrayCreation","_param","_suffix","_value","_var"];

_arrayCreation = {
	{
		_param = configName ((missionConfigFile >> "Params") select _ForEachIndex);
		_suffix = [_param,6] call BIS_fnc_trimString;
		_value = paramsArray select _ForEachIndex;
		_var = format ["adv_par_%1 = %2",_suffix, _value];
		if( _suffix != "" ) then {
			call compileFinal _var;
		};
	} forEach paramsArray;
};

call _arrayCreation;

publicVariable "ADV_par_seriousMode";
publicVariable "ADV_par_headlessClient";

if (isServer) then {
	switch (ADV_par_sideRelations) do {
		case 0: {west setFriend [resistance, 0];resistance setFriend [west, 0];east setFriend [resistance, 0];resistance setFriend [east, 0];};
		case 1: {west setFriend [resistance, 1];resistance setFriend [west, 1];east setFriend [resistance, 0];resistance setFriend [east, 0];};
		case 2: {west setFriend [resistance, 0];resistance setFriend [west, 0];east setFriend [resistance, 1];resistance setFriend [east, 1];};
		case 3: {west setFriend [resistance, 1];resistance setFriend [west, 1];east setFriend [resistance, 1];resistance setFriend [east, 1];};
	};
};

ADV_par_respWithGear = ADV_par_customLoad;

ADV_par_DLCContent = 1;

if (ADV_par_Assets_cars == 99) then {ADV_par_modCarAssets = 99;ADV_par_modTruckAssets=99;ADV_par_opfTruckAssets=99;ADV_par_opfCarAssets=99;ADV_par_indCarAssets=99;};
if (ADV_par_Assets_heavy == 99) then {ADV_par_modHeavyAssets = 99;ADV_par_opfHeavyAssets=99;};
if (ADV_par_Assets_tanks == 99) then {ADV_par_modTankAssets = 99;ADV_par_opfTankAssets=99;};
if (ADV_par_Assets_air_helis == 99) then {ADV_par_modHeliAssets = 99;ADV_par_opfHeliAssets=99;};
if (ADV_par_Assets_air_fixed == 99) then {ADV_par_modAirAssets = 99;ADV_par_opfAirAssets=99;};

//just to be on the safe side:
//call _arrayCreation;

//finalization:
ADV_params_defined = true;

if (true) exitWith {};
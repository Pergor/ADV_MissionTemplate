/*
 * Author: Belbo
 *
 * Creates all the variables that are put into description.ext via params.hpp
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [] call adv_fnc_parVariables;
 *
 * Public: No
 */

private _arrayCreation = {
	{
		private _param = configName ((missionConfigFile >> "Params") select _ForEachIndex);
		private _suffix = [_param,6] call BIS_fnc_trimString;
		private _value = paramsArray select _ForEachIndex;
		private _var = format ["adv_par_%1 = %2",_suffix, _value];
		if( _suffix != "" ) then {
			call compileFinal _var;
		};
	} forEach paramsArray;
};

call _arrayCreation;

private _variables = {
	if (isServer) then {
		switch (adv_par_sideRelations) do {
			case 0: {west setFriend [resistance, 0];resistance setFriend [west, 0];east setFriend [resistance, 0];resistance setFriend [east, 0];};
			case 1: {west setFriend [resistance, 1];resistance setFriend [west, 1];east setFriend [resistance, 0];resistance setFriend [east, 0];};
			case 2: {west setFriend [resistance, 0];resistance setFriend [west, 0];east setFriend [resistance, 1];resistance setFriend [east, 1];};
			case 3: {west setFriend [resistance, 1];resistance setFriend [west, 1];east setFriend [resistance, 1];resistance setFriend [east, 1];};
		};
	};

	adv_par_respWithGear = adv_par_customLoad;

	ADV_par_DLCContent = 1;

	if (ADV_par_Assets_cars == 99) then {ADV_par_modCarAssets = 99;ADV_par_modTruckAssets=99;ADV_par_opfTruckAssets=99;ADV_par_opfCarAssets=99;ADV_par_indCarAssets=99;};
	if (ADV_par_Assets_heavy == 99) then {ADV_par_modHeavyAssets = 99;ADV_par_opfHeavyAssets=99;};
	if (ADV_par_Assets_tanks == 99) then {ADV_par_modTankAssets = 99;ADV_par_opfTankAssets=99;};
	if (ADV_par_Assets_air_helis == 99) then {ADV_par_modHeliAssets = 99;ADV_par_opfHeliAssets=99;};
	if (ADV_par_Assets_air_fixed == 99) then {ADV_par_modAirAssets = 99;ADV_par_opfAirAssets=99;};

	if (ADV_par_engineArtillery == 0) then {
		missionNamespace setVariable ["ace_mk6mortar_allowComputerRangefinder",true];
		missionNamespace setVariable ["ace_mk6mortar_airResistanceEnabled",false];
	};
	
	adv_aceCPR_onlyDoctors = if ( adv_par_adv_aceCPR_onlyDoctors > 0 ) then {true} else {false};

	if ( isClass(configFile >> "CfgPatches" >> "adv_aceCPR") && !adv_aceCPR_onlyDoctors ) then {
		missionNamespace setVariable ["ace_medical_useCondition_PAK",0];
	};
};

call _variables;

//finalization:
ADV_params_defined = true;

true;
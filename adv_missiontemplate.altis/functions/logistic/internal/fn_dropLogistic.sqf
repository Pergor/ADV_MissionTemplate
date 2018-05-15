/*
 * Author: Belbo
 *
 * Adds action to an ammo box so it can be dropped at a location selected via map.
 *
 * Arguments:
 * Array of ammo boxes - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [crate_1, crate_2, ..., crate_n] call adv_fnc_dropLogistic;
 *
 * Public: No
 */

ADV_sriptfnc_dropLogistic = {
	params [
		["_crate", objNull, [objNull]],
		["_targetPos", [0,0,0], [[]]]
	];
	systemChat "ETA: ~1 minute.";
	sleep 60;
	_targetPos = [_targetPos select 0, _targetPos select 1, 600];
	_chute = createVehicle ["B_Parachute_02_F", _targetPos, [], 0, "NONE"];
	_crate setPos _targetPos;
	{ _x addCuratorEditableObjects [[_crate],false] } forEach allCurators;
	_crate attachTo [_chute, [0, 0, -1]];
	_chute setVelocity [0,0,-50];
	_light = createVehicle ["Chemlight_red", (getPosATL _crate), [], 0, "NONE"];
	_IRlight = createVehicle ["B_IRStrobe", (getPosATL _crate), [], 0, "NONE"];
	{_x attachTo [_crate, [0, 0, 0]];} forEach [_light,_IRlight];
	[_crate,"G_40mm_SmokeGreen"] spawn {
		params ["_cargo","_smokeType"];
		
		waitUntil {sleep 1; ((getPos _cargo) select 2) < 40};
		
		private _smoke = _smokeType createVehicle (getPosWorld _cargo);
		private _IRlight = "B_IRStrobe" createVehicle (getPosWorld _cargo);
		private _signals = [_smoke,_IRlight];
		if (sunOrMoon < 1) then {
			private _lightType = if (isClass(configFile >> "CfgPatches" >> "ace_grenades")) then { "ACE_F_Hand_Red" } else { "Chemlight_red" };
			private _light = _lightType createVehicle (getPosWorld _cargo);
			_signals pushBack _light;
		};
		{_x attachTo [_cargo, [0, 0, 0.82]]; nil} count _signals;

		waitUntil {sleep 1; ((getPos _crate) select 2) < 2};
		detach _crate;
	};
};

{
	ADV_action_dropLogistic = _x addAction [
		("<t color=""#FFFFFF"">" + ("Abwurf vorbereiten") + "</t>"), 
		{
			openmap true;
			if !((_this select 0) getVariable ["adv_var_logistic_isSlingload",false]) then {
				[_this select 0] onMapSingleClick "openmap false; [_this select 0,_pos] spawn ADV_sriptfnc_dropLogistic; onmapsingleclick '';";
			} else {
				[_this select 0] onMapSingleClick "openmap false;private _start = [[_pos, 6000, 6000, 0, false],true] call CBA_fnc_randPosArea; [_pos, _start, 1, (missionNamespace getVariable ['adv_logistic_var_dropType','B_T_VTOL_01_vehicle_F']), (_this select 0)] call adv_fnc_slingloadSupply; onmapsingleclick '';";
			};
			(_this select 0) removeAction (_this select 2);
		},
		nil,3,false,true,"","player distance cursortarget <5"
	];
} forEach _this;

true;
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
			private _lightType = if ( isClass(configFile >> "CfgPatches" >> "ace_grenades") && ((missionNamespace getVariable ["adv_par_NVGs",0] < 2) || (missionNamespace getVariable ["adv_par_opfNVGs",0] < 2)) ) then { "ACE_F_Hand_Red" } else { "Chemlight_red" };
			private _light = _lightType createVehicle (getPosWorld _cargo);
			_signals pushBack _light;
		};
		{_x attachTo [_cargo, [0, 0, 0.82]]; nil} count _signals;

		waitUntil {sleep 1; ((getPos _crate) select 2) < 2};
		detach _crate;
	};
};

{
	private _target = _x;
	private _id = _x addAction [
		("<t color=""#FFFFFF"">" + ("Abwurf vorbereiten") + "</t>"), 
		{
			openmap true;
			params ["_target","_caller","_id","_args"];
			private _side = side (group _caller);
			private _respMarker = call {
				if (_side isEqualTo west) exitWith {"respawn_west"};
				if (_side isEqualTo east) exitWith {"respawn_east"};
				if (_side isEqualTo independent) exitWith {"respawn_guerrila"};
				""
			};
			if ( !(_respMarker isEqualTo "") && {_target distance _respMarker > 500}) exitWith { (_target) removeAction _id; ["Zu weit vom Start entfernt",5] call adv_fnc_timedHint; };
			[_target] onMapSingleClick "openmap false; [_pos, nil, 1, (missionNamespace getVariable ['adv_logistic_var_dropType','B_T_VTOL_01_vehicle_F']), (_this select 0)] call adv_fnc_slingloadSupply; onmapsingleclick '';";
			_target setVariable ["adv_handle_dropLogistic",_nil,true];
			(_target) removeAction _id;
		},
		nil,3,false,true,"","true",5
	];
	_target setVariable ["adv_handle_dropLogistic",_id,true];
	nil
} count _this;

true;
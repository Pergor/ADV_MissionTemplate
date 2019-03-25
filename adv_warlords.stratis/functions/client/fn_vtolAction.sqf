/*
 * Author: Belbo
 *
 * Adds an action to a VTOL that enables you to change it into infantry or vehicle version.
 *
 * Arguments:
 * 0: object the action should be attached to - <OBJECT>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [target] call adv_fnc_vtolAction;
 *
 * Public: No
 */

params [
	["_target",objNull,[objNull]]
];

if (_target isKindOf 'B_T_VTOL_01_vehicle_F' || _target isKindOf 'B_T_VTOL_01_infantry_F') then {
	_target setFuel (_target getVariable ["adv_vtolAction_fuel",fuel _target]);
	private _hitPoints = (_target getVariable ["adv_vtolAction_hitPoints",(getAllHitPointsDamage _target) select 0]);
	private _hitPointDamage = (_target getVariable ["adv_vtolAction_hitPointsDamage",(getAllHitPointsDamage _target) select 2]);
	{ _target setHitPointDamage [_x,(_hitPointDamage select _forEachIndex),false]; } forEach _hitPoints;
	/*
	if ( isClass (configFile >> "CfgPatches" >> "ACE_cargo") ) then {
		private _cargoLoad = (_target getVariable ["adv_vtolAction_ace_cargo_loaded",_target getVariable ["ace_cargo_loaded",[objNull]]]);
		{ detach _x; nil; } count _cargoLoad;
		_target setVariable ["ace_cargo_loaded",[],true];
		{[_x,_target] call ace_cargo_fnc_loadItem; nil;} count _cargoLoad;
	};
	*/
};

adv_scriptFNC_vtolAction = {
	params ["_target","_caller","_id","_args"];
	_args params ["_vehType","_text"];
	[_target,clientOwner] remoteExec ["setOwner",2];
	_target setVariable ["adv_vtolAction_fuel",(fuel _target)];
	_target setVariable ["adv_vtolAction_hitPoints",(getAllHitPointsDamage _target) select 0];
	_target setVariable ["adv_vtolAction_hitPointsDamage",(getAllHitPointsDamage _target) select 2];
	/*
	if ( isClass (configFile >> "CfgPatches" >> "ACE_cargo") ) then {
		_target setVariable [ "adv_vtolAction_ace_cargo_loaded",_target getVariable ["ace_cargo_loaded",[objNull]] ];
		private _cargoLoad = _target getVariable "adv_vtolAction_ace_cargo_loaded";
		{ detach _x; nil; } count _cargoLoad;
		_target setVariable ["ace_cargo_loaded",[],true];
	};
	*/
	["<t color='#ff0000' size = '.8'>ACHTUNG!<br/>Sicherheitsabstand von mindestens 10 Metern!</t>",-1,0,4,1,0,789] spawn BIS_fnc_dynamicText;
	_target animateDoor ["door_1_source",1];
	for "_i" from 1 to 3 do {
		[_target,["AlarmCar",15]] remoteExecCall ["say3D",0];
		sleep 2;
	};
	[_target,["AlarmCar",15]] remoteExecCall ["say3D",0];
	[[str _target],[_vehType],west] remoteExec ["adv_fnc_changeVeh",2];
	sleep 2;
	systemChat _text;
	[_text,5] call adv_fnc_timedHint;
};

if (_target isKindOf 'B_T_VTOL_01_vehicle_F') exitWith {
	private _vtolType = if (_target isKindOf 'B_T_VTOL_01_vehicle_blue_F') then {"B_T_VTOL_01_infantry_blue_F"} else {"B_T_VTOL_01_infantry_F"};
	_target addAction [("<t color='#00FF00' size='2' align='center'>" + ("Sitze einbauen") + "</t>"),{
		_this spawn adv_scriptFNC_vtolAction;
	},[_vtolType,"Sitze eingebaut."],50,true,true,"","isTouchingGround _target && count (crew _target) isEqualTo 0",15];
	true;
};

if (_target isKindOf 'B_T_VTOL_01_infantry_F') exitWith {
	private _vtolType = if (_target isKindOf 'B_T_VTOL_01_infantry_blue_F') then {"B_T_VTOL_01_vehicle_blue_F"} else {"B_T_VTOL_01_vehicle_F"};
	_target addAction [("<t color='#00FF00' size='2' align='center'>" + ("Sitze ausbauen") + "</t>"),{
		_this spawn adv_scriptFNC_vtolAction;
	},[_vtolType,"Sitze ausgebaut."],50,true,true,"","isTouchingGround _target && count (crew _target) isEqualTo 0",15];
	true;
};

false;
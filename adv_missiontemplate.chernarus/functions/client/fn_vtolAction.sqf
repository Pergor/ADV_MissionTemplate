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
 * [target] spawn adv_fnc_vtolAction;
 *
 * Public: No
 */

params [
	["_target",objNull,[objNull]]
];

if (_target isKindOf 'B_T_VTOL_01_vehicle_F') exitWith {
	_target addAction [("<t color='#00FF00' size='2' align='center'>" + ("Sitze einbauen") + "</t>"),{
		_this spawn {
			params ["_target","_caller","_id","_args"];
			["<t color='#ff0000' size = '.8'>ACHTUNG!<br/>Sicherheitsabstand von mindestens 10 Metern!</t>",-1,0,4,1,0,789] spawn BIS_fnc_dynamicText;
			_target say3D "AlarmCar";
			sleep 2;
			_target say3D "AlarmCar";
			sleep 2;
			_target say3D "AlarmCar";
			sleep 2;
			_target say3D "AlarmCar";
			[[str _target],["B_T_VTOL_01_infantry_F"],west] remoteExec ["adv_fnc_changeVeh",2];
			sleep 2;
			systemChat "Sitze eingebaut";
			["Sitze eingebaut",5] call adv_fnc_timedHint;
		};
	},nil,50,true,true,"","isTouchingGround _target && count (crew _target) isEqualTo 0"];
	true;
};

if (_target isKindOf 'B_T_VTOL_01_infantry_F') exitWith {
	_target addAction [("<t color='#00FF00' size='2' align='center'>" + ("Sitze ausbauen") + "</t>"),{
		_this spawn {
			params ["_target","_caller","_id","_args"];
			["<t color='#ff0000' size = '.8'>ACHTUNG!<br/>Sicherheitsabstand von mindestens 10 Metern!</t>",-1,0,4,1,0,789] spawn BIS_fnc_dynamicText;
			_target say3D "AlarmCar";
			sleep 2;
			_target say3D "AlarmCar";
			sleep 2;
			_target say3D "AlarmCar";
			sleep 2;
			_target say3D "AlarmCar";
			[[str _target],["B_T_VTOL_01_vehicle_F"],west] remoteExec ["adv_fnc_changeVeh",2];
			sleep 2;
			systemChat "Sitze ausgebaut";
			["Sitze ausgebaut",5] call adv_fnc_timedHint;
		};
	},nil,50,true,true,"","isTouchingGround _target && count (crew _target) isEqualTo 0"];
	true;
};

false;
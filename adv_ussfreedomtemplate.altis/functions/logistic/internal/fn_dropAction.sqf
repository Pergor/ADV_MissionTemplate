/*
 * Author: Belbo
 *
 * Adds action to an object so it can be dropped at a location selected via map.
 *
 * Arguments:
 * 0: Object to attach the action to - <OBJECT>
 *
 * Return Value:
 * ID of action - will be removed automatically as soon as action is executed.
 *
 * Example:
 * [crate_1] call adv_fnc_dropAction;
 *
 * Public: No
 */

params ["_target"];

private _id = _target addAction [
	("<t color=""#FFFFFF"">" + ("Abwurf vorbereiten") + "</t>"), 
	{
		params ["_target","_caller","_id","_args"];
		private _side = side (group _caller);
		private _respMarker = call {
			if (_side isEqualTo west) exitWith {"respawn_west"};
			if (_side isEqualTo east) exitWith {"respawn_east"};
			if (_side isEqualTo independent) exitWith {"respawn_guerrila"};
			""
		};
		if ( !(_respMarker isEqualTo "") && {(_target distance (getMarkerPos _respMarker)) > 500}) exitWith { (_target) removeAction _id; ["Zu weit vom Start entfernt",5] call adv_fnc_timedHint; };
		
		openmap true;
		hintSilent "Wähle Abwurfposition.\n\n--------\n\nKlick für Flugzeug, Shift-Klick für Hubschrauber";
		[_target,_side] onMapSingleClick "openmap false;
		hintSilent '';
		params ['_target','_side'];
		private _veh = 'B_T_VTOL_01_vehicle_F';
		call {
			if (_side isEqualTo west) exitWith {
				_veh = if (!_shift) then {'B_T_VTOL_01_vehicle_F'} else {'B_Heli_Transport_03_F'};
			};
			if (_side isEqualTo east) exitWith {
				_veh = if (!_shift) then {'O_T_VTOL_02_vehicle_F'} else {'O_Heli_Transport_04_F'};
			};
			if (_side isEqualTo independent) exitWith {
				_veh = if (!_shift) then {'B_T_VTOL_01_vehicle_F'} else {'I_Heli_Transport_02_F'};
			};
		};
		[_pos, nil, _side, _veh, _target] call adv_fnc_slingloadSupply;
		onmapsingleclick '';";
		_target setVariable ["adv_handle_dropLogistic",nil,true];
		(_target) removeAction _id;
	},
	nil,3,false,true,"","true",5
];
_target setVariable ["adv_handle_dropLogistic",_id,true];

_id
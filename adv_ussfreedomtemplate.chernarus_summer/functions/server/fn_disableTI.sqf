/*
 * Author: Belbo
 *
 * Disables TIEquipment or NVGEquipment for all vehicles
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Script handle - <HANDLE>
 *
 * Example:
 * _handle = [] call adv_fnc_disableTI;
 *
 * Public: Yes
 */

if (!isServer) exitWith {};

_handle = [] spawn {
	while { ADV_par_TIEquipment > 0 } do {
		{
			_x disableTIEquipment true;
			if (ADV_par_TIEquipment == 4) then {
				_x disableNVGEquipment true;
			};
			nil;
		} count vehicles;
		sleep 10;			
	};

	if (ADV_par_TIEquipment == 0) exitWith { { _x disableTIEquipment false; _x disableNVGEquipment false; } count vehicles; };
};

_handle;
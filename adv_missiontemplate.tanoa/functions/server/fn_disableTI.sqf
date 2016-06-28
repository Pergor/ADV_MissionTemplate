/*
disable TI script by Belbo
disables TI for all vehicles throughout a mission.
[] spawn ADV_fnc_disableTI;
*/

if (!isServer) exitWith {};

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
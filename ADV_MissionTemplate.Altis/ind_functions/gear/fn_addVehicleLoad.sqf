if (!isServer) exitWith {};

	//readds the loadout
{
	switch (true) do {
		case (str _x in ADV_ind_veh_Transport+ADV_ind_veh_Fuel): {
			[_x,false,false,2] call ADV_ind_fnc_vehicleLoad;
		};
		case (str _x in ADV_ind_veh_SUV+ADV_ind_veh_Offroad+ADV_ind_veh_OffroadHMG): {
			[_x,false,true,2] call ADV_ind_fnc_vehicleLoad;
		};
		case (str _x in ADV_ind_veh_Repair): {
			[_x,false,false,2,true] call ADV_ind_fnc_vehicleLoad;
		};
		case (str _x in ADV_ind_veh_AirRecon): {
			[_x,true,false,0] call ADV_ind_fnc_vehicleLoad;
		};
	};
} forEach _this;

if (true) exitWith {};
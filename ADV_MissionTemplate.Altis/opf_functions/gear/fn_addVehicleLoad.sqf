if (!isServer) exitWith {};

	//readds the loadout
{
	switch (true) do {
		case (str _x in ADV_opf_veh_transport): {
			[_x,false,true,4] call ADV_opf_fnc_vehicleLoad;
		};
		case (str _x in ADV_opf_veh_logistic_fuel+ADV_opf_veh_logistic_ammo+ADV_opf_veh_airContainerTransport): {
			[_x,false,false,4] call ADV_fnc_vehicleLoad;
		};
		case (str _x in ADV_opf_veh_logistic_repair): {
			[_x,false,false,4,true] call ADV_fnc_vehicleLoad;
		};
		case (str _x in ADV_opf_veh_logistic_medic+ADV_opf_veh_airContainerMedic || str _x == "opf_air_logistic_1"): {
			[_x,true,false,4] call ADV_fnc_vehicleLoad;
		};
		case (str _x in ADV_opf_veh_air && !(str _x == "opf_air_logistic_1") ): {
			[_x,false,false,0] call ADV_opf_fnc_vehicleLoad;
		};
		case (str _x in ADV_opf_veh_MRAPs+ADV_opf_veh_MRAPsHMG+ADV_opf_veh_MRAPsGMG): {
			[_x,false,true,2] call ADV_opf_fnc_vehicleLoad;
		};
		case (str _x in ADV_opf_veh_heavys): {
			[_x,false,true,2] call ADV_opf_fnc_vehicleLoad;
		};
		case (str _x in ADV_opf_veh_tanks+ADV_opf_veh_artys): {
			[_x,false,false,2] call ADV_opf_fnc_vehicleLoad;
		};
		case (str _x in ADV_opf_veh_ATVs): {
			[_x,false,false,0] call ADV_opf_fnc_vehicleLoad;
		};
	};
} forEach _this;

if (true) exitWith {};
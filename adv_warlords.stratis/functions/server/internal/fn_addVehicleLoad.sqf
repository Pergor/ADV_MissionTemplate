/*
 * Author: Belbo
 *
 * Executes adv_fnc_vehicleLoad on vehicles when applicable.
 *
 * Arguments:
 * Array of vehicles - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [MRAP_1, MRAP_2, ..., MRAP_n] call adv_fnc_addVehicleLoad;
 *
 * Public: No
 */
 
if (!isServer) exitWith {};

{
	switch (true) do {
		case (str _x in ADV_veh_transport): {
			[_x,false,true,4] call ADV_fnc_vehicleLoad;
		};
		case (str _x in ADV_veh_logistic_fuel+ADV_veh_logistic_ammo): {
			[_x,false,false,4] call ADV_fnc_vehicleLoad;
		};
		case (str _x in ADV_veh_logistic_repair): {
			[_x,false,false,4,true] call ADV_fnc_vehicleLoad;
		};		
		case (str _x in ADV_veh_logistic_medic): {
			[_x,true,false,4] call ADV_fnc_vehicleLoad;
		};
		case (str _x in ADV_veh_air && !(str _x in ADV_veh_airLogistic)): {
			[_x,false,false,0] call ADV_fnc_vehicleLoad;
		};
		case (str _x in ADV_veh_airLogistic): {
			[_x,true,false,0] call ADV_fnc_vehicleLoad;
		};
		case (str _x in ADV_veh_car): {
			[_x,false,true,2] call ADV_fnc_vehicleLoad;
		};
		case (str _x in ADV_veh_heavys): {
			[_x,false,true,2] call ADV_fnc_vehicleLoad;
		};
		case (str _x in ADV_veh_tanks+ADV_veh_artys): {
			[_x,false,true,2] call ADV_fnc_vehicleLoad;
		};
		case (str _x in ADV_veh_ATVs+ADV_veh_UAVs+ADV_veh_UGVs): {
			[_x,false,false,0] call ADV_fnc_vehicleLoad;
		};
		case (str _x in ADV_veh_UGVs_repair): {
			[_x,false,false,0,true] call ADV_fnc_vehicleLoad;
		};
		case (str _x in ADV_veh_boats): {
			[_x,false,true,0] call ADV_fnc_vehicleLoad;
		};
	};
	nil;
} count _this;

true;
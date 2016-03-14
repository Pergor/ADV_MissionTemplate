/*
disable Vehicles script by Belbo
disables all preplaced air and/or ground vehicles and their garage-markers.
defined in cfgFunctions (functions\server\fn_manageVeh.sqf)
Call from init.sqf (as early as possible) via:
[] call ADV_fnc_manageVeh;
*/

if (!isServer) exitWith {};

//unique vehicles placed in the editor:
ADV_ind_veh_SUV = ["ind_SUV_1","ind_SUV_2","ind_SUV_3","ind_SUV_4","ind_SUV_5","ind_SUV_6","ind_SUV_7","ind_SUV_8","ind_SUV_9","ind_SUV_10"];
ADV_ind_veh_Offroad = ["ind_Offroad_1","ind_Offroad_2","ind_Offroad_3","ind_Offroad_4","ind_Offroad_5","ind_Offroad_6","ind_Offroad_7","ind_Offroad_8","ind_Offroad_9","ind_Offroad_10"];
ADV_ind_veh_OffroadHMG = ["ind_Offroad_hmg_1","ind_Offroad_hmg_2","ind_Offroad_hmg_3","ind_Offroad_hmg_4","ind_Offroad_hmg_5","ind_Offroad_hmg_6","ind_Offroad_hmg_7","ind_Offroad_hmg_8","ind_Offroad_hmg_9","ind_Offroad_hmg_10"];
ADV_ind_veh_car = ADV_ind_veh_SUV+ADV_ind_veh_Offroad+ADV_ind_veh_OffroadHMG;
ADV_ind_veh_heavys = ["ind_heavy_1","ind_heavy_2","ind_heavy_3","ind_heavy_4","ind_heavy_5","ind_heavy_6","ind_heavy_7","ind_heavy_8","ind_heavy_9","ind_heavy_10"];
ADV_ind_veh_tanks = ["ind_tank_1","ind_tank_2","ind_tank_3","ind_tank_4","ind_tank_5","ind_tank_6","ind_tank_7","ind_tank_8","ind_tank_9","ind_tank_10"];
ADV_ind_veh_armored = ADV_ind_veh_heavys+ADV_ind_veh_tanks;
ADV_ind_veh_transport = ["ind_transport_1","ind_transport_2","ind_transport_3","ind_transport_4","ind_transport_5","ind_transport_6","ind_transport_7","ind_transport_8","ind_transport_9","ind_transport_10"];
ADV_ind_veh_repair = ["ind_repair_1","ind_repair_2","ind_repair_3","ind_repair_4","ind_repair_5","ind_repair_6","ind_repair_7","ind_repair_8","ind_repair_9","ind_repair_10"];
ADV_ind_veh_fuel = ["ind_fuel_1","ind_fuel_2","ind_fuel_3","ind_fuel_4","ind_fuel_5","ind_fuel_6","ind_fuel_7","ind_fuel_8","ind_fuel_9","ind_fuel_10"];
ADV_ind_veh_ammo = ["ind_logistic_ammo_1","ind_logistic_ammo_2","ind_logistic_ammo_3","ind_logistic_ammo_4","ind_logistic_ammo_5","ind_logistic_ammo_6","ind_logistic_ammo_7","ind_logistic_ammo_8","ind_logistic_ammo_9","ind_logistic_ammo_10"];
ADV_ind_veh_medic = ["ind_logistic_medic_1","ind_logistic_medic_2","ind_logistic_medic_3","ind_logistic_medic_4","ind_logistic_medic_5","ind_logistic_medic_6","ind_logistic_medic_7","ind_logistic_medic_8","ind_logistic_medic_9","ind_logistic_medic_10"];
ADV_ind_veh_AirRecon = ["ind_air_recon_1","ind_air_recon_2","ind_air_recon_3","ind_air_recon_4","ind_air_recon_5","ind_air_recon_6","ind_air_recon_7","ind_air_recon_8","ind_air_recon_9","ind_air_recon_10"];
ADV_ind_veh_AirTransport = ["ind_air_transport_1","ind_air_transport_2","ind_air_transport_3","ind_air_transport_4","ind_air_transport_5","ind_air_transport_6","ind_air_transport_7","ind_air_transport_8","ind_air_transport_9","ind_air_transport_10"];
ADV_ind_veh_Air = ADV_ind_veh_AirRecon+ADV_ind_veh_AirTransport;
ADV_veh_support = ADV_ind_veh_transport+ADV_ind_veh_repair+ADV_ind_veh_fuel+ADV_ind_veh_ammo+ADV_ind_veh_medic;
ADV_ind_veh_AllVeh = ADV_ind_veh_car+ADV_ind_veh_armored+ADV_ind_veh_Air+ADV_veh_support;

///// No editing necessary below this line /////

//replaces MRAPS with mod cars:
switch (ADV_par_indCarAssets) do {
	case 1: {[ADV_ind_veh_SUV,["I_MRAP_03_F"]] spawn ADV_ind_fnc_changeVeh;[ADV_ind_veh_Offroad+ADV_ind_veh_OffroadHMG,["I_MRAP_03_hmg_F"]] spawn ADV_ind_fnc_changeVeh;[ADV_ind_veh_AirRecon,["I_Heli_light_03_F"]] spawn ADV_ind_fnc_changeVeh;};
	case 99: {[ADV_ind_veh_AllVeh,[""]] spawn ADV_ind_fnc_changeVeh;};
	default {};
};

/*
//replaces trucks with mod trucks:
switch (ADV_par_modTruckAssets) do {
	//DAR MTVR
	//case 1: {[ADV_veh_transport,["DAR_MK27","DAR_MK27T"]] spawn ADV_fnc_changeVeh;[ADV_veh_logistic_fuel,["DAR_LHS_8"]] spawn ADV_ind_fnc_changeVeh;[ADV_veh_logistic_repair+ADV_veh_logistic_ammo,["DAR_LHS_16"]] spawn ADV_ind_fnc_changeVeh;};
	default {};
};
//replaces heavy vehicles with mod vehicles:
switch (ADV_par_modHeavyAssets) do {
	//BWmod Puma sand
	//case 1: {[ADV_veh_heavys,["BWA3_Puma_Tropen"]] spawn ADV_ind_fnc_changeVeh;};
	default {};
};
//replaces tanks with mod tanks:
switch (ADV_par_modTankAssets) do {
	//BWmod Leopard sand
	//case 1: {[ADV_veh_tanks,["BWA3_Leopard2A6M_Tropen"]] spawn ADV_ind_fnc_changeVeh;};
	default {};
};
//replaces helis with mod helis:
switch (ADV_par_modHeliAssets) do {
	//BAFHelis
	//case 1: {[ADV_veh_airTransport,["UK3CB_BAF_Wildcat_Transport_RN_ZZ396"]] spawn ADV_ind_fnc_changeVeh;[ADV_veh_airRecon,["UK3CB_BAF_Wildcat_Armed_Army_ZZ400"]] spawn ADV_ind_fnc_changeVeh;[ADV_veh_airLogistic,["UK3CB_BAF_Vehicles_Merlin_RAF_ZJ124"]] spawn ADV_ind_fnc_changeVeh;};
	default {};
};
//replaces planes with mod planes:
switch (ADV_par_modAirAssets) do {
	//FA18E
	//case 1: {[ADV_veh_airCAS,["JS_JC_FA18E"]] spawn ADV_ind_fnc_changeVeh;};
	default {};
};
*/

//manages disablement and load.
{
	if (str _x in ADV_ind_veh_AllVeh) then {
		[_x] call ADV_fnc_clearCargo;
		[_x] call ADV_ind_fnc_addVehicleLoad;
		[_x,ADV_par_vehicleRespawn, (typeOf _x)] spawn ADV_ind_fnc_respawnVeh;
		if (ADV_par_TIEquipment > 0) then {
			_x disableTIEquipment true;
			if (ADV_par_TIEquipment > 2) then {
				_x disableNVGEquipment true;
			};
		};
		if ( ADV_par_Radios > 0 && (_x isKindOf "CAR" || _x isKindOf "TANK" || _x isKindOf "AIR") ) then {
			_x setVariable ["tf_hasRadio", true, true];
			//_x setVariable ["tf_side", independent, true];
		};
		if (ADV_par_indUni != 1) then {
			if (str _x in ADV_ind_veh_SUV) then {
				_x setObjectTextureGlobal [0,"\A3\Soft_F_Gamma\SUV_01\Data\SUV_01_ext_02_CO.paa"];
			} else {
				_x setObjectTextureGlobal [0,'#(rgb,8,8,3)color(1,1,1,0.004)'];
				if (str _x in ADV_ind_veh_Transport) then {
					_x setObjectTextureGlobal [1,'#(rgb,8,8,3)color(1,1,1,0.004)'];
				};
				if (str _x in ADV_ind_veh_Offroad+ADV_ind_veh_OffroadHMG+ADV_ind_veh_Repair) then {
					_x setObjectMaterial [0,"A3\soft_f_bootcamp\Offroad_01\Data\offroad_01_ext_repair_ig_plastic.rvmat"];
				};
			};
		};
	};
} forEach vehicles;


if (true) exitWith { missionNamespace setVariable ["ADV_var_manageVeh_ind",true,true]; };
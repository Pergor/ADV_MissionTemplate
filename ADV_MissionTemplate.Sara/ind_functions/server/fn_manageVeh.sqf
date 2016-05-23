/*
disable Vehicles script by Belbo
disables all preplaced air and/or ground vehicles and their garage-markers.
defined in cfgFunctions (functions\server\fn_manageVeh.sqf)
Call from init.sqf (as early as possible) via:
[] call ADV_fnc_manageVeh;
*/

if (!isServer) exitWith {};

//markers for the vehicle garages:
_veh_lightMarkers = ["ind_garage_1","ind_garage_2","ind_garage_3","ind_garage_4","ind_garage_5"];
_veh_heavyMarkers = ["ind_garage_heavy_1","ind_garage_heavy_2","ind_garage_heavy_3","ind_garage_heavy_4","ind_garage_heavy_5"];
_veh_heliMarkers = ["ind_garage_air_1"];
_veh_fixedMarkers = ["ind_garage_air_2"];

ADV_ind_veh_airTransport = [];
ADV_ind_veh_airRecon = [];
ADV_ind_veh_airLogistic = [];

ADV_ind_veh_airCAS = [];
ADV_ind_veh_airC130 = [];

ADV_ind_veh_MRAPs = [];
ADV_ind_veh_MRAPsHMG = [];
ADV_ind_veh_MRAPsGMG = [];
ADV_ind_veh_SUV = [];
ADV_ind_veh_Offroad = [];
ADV_ind_veh_OffroadHMG = [];
ADV_ind_veh_transport = [];
ADV_ind_veh_logistic_fuel = ["ind_fuel_1","ind_fuel_2","ind_fuel_3","ind_fuel_4","ind_fuel_5","ind_fuel_6","ind_fuel_7","ind_fuel_8","ind_fuel_9","ind_fuel_10"];
ADV_ind_veh_logistic_ammo = [];
ADV_ind_veh_logistic_repair = ["ind_repair_1","ind_repair_2","ind_repair_3","ind_repair_4","ind_repair_5","ind_repair_6","ind_repair_7","ind_repair_8","ind_repair_9","ind_repair_10"];
ADV_ind_veh_logistic_medic = [];
ADV_ind_veh_ATVs = [];
ADV_ind_veh_UAVs = [];
ADV_ind_veh_UGVs = [];
ADV_ind_veh_UGVs_repair = [];

ADV_ind_veh_heavys = [];
ADV_ind_veh_tanks = [];
ADV_ind_veh_artys = [];

{
	_vehicleName = str _x;
	switch ( true ) do {
		//helicopters
		case ( [_vehicleName,0,16] call BIS_fnc_trimString == "ind_air_transport" ): { ADV_ind_veh_airTransport pushBack _vehicleName; };
		case ( [_vehicleName,0,12] call BIS_fnc_trimString == "ind_air_recon" ): { ADV_ind_veh_airRecon pushBack _vehicleName; };
		case ( [_vehicleName,0,15] call BIS_fnc_trimString == "ind_air_logistic" ): { ADV_ind_veh_airLogistic pushBack _vehicleName; };
		//fixed wing planes
		case ( [_vehicleName,0,10] call BIS_fnc_trimString == "ind_air_cas" ): { ADV_ind_veh_airCAS pushBack _vehicleName; };
		case ( [_vehicleName,0,11] call BIS_fnc_trimString == "ind_air_c130" ): { ADV_ind_veh_airC130 pushBack _vehicleName; };
		//MRAPs
		case ( [_vehicleName,0,11] call BIS_fnc_trimString == "ind_MRAP_hmg" ): { ADV_ind_veh_MRAPsHMG pushBack _vehicleName; };
		case ( [_vehicleName,0,11] call BIS_fnc_trimString == "ind_MRAP_gmg" ): { ADV_ind_veh_MRAPsGMG pushBack _vehicleName; };
		case ( [_vehicleName,0,7] call BIS_fnc_trimString == "ind_MRAP" ): { ADV_ind_veh_MRAPs pushBack _vehicleName; };
		case ( [_vehicleName,0,6] call BIS_fnc_trimString == "ind_SUV" ): { ADV_ind_veh_SUV pushBack _vehicleName; };
		case ( [_vehicleName,0,13] call BIS_fnc_trimString == "ind_OffroadHMG" ): { ADV_ind_veh_OffroadHMG pushBack _vehicleName; };
		case ( [_vehicleName,0,10] call BIS_fnc_trimString == "ind_Offroad" ): { ADV_ind_veh_Offroad pushBack _vehicleName; };
		//logistics
		case ( [_vehicleName,0,6] call BIS_fnc_trimString == "ind_uav" ): { ADV_ind_veh_UAVs pushBack _vehicleName; };
		case ( [_vehicleName,0,6] call BIS_fnc_trimString == "ind_ugv" ): { ADV_ind_veh_UGVs pushBack _vehicleName; };
		case ( [_vehicleName,0,13] call BIS_fnc_trimString == "ind_ugv_repair" ): { ADV_ind_veh_UGVs_repair pushBack _vehicleName; };
		case ( [_vehicleName,0,6] call BIS_fnc_trimString == "ind_ATV" ): { ADV_ind_veh_ATVs pushBack _vehicleName; };
		case ( [_vehicleName,0,12] call BIS_fnc_trimString == "ind_transport" ): { ADV_ind_veh_transport pushBack _vehicleName; };
		case ( [_vehicleName,0,16] call BIS_fnc_trimString == "ind_logistic_fuel" ): { ADV_ind_veh_logistic_fuel pushBack _vehicleName; };
		case ( [_vehicleName,0,16] call BIS_fnc_trimString == "ind_logistic_ammo" ): { ADV_ind_veh_logistic_ammo pushBack _vehicleName; };
		case ( [_vehicleName,0,18] call BIS_fnc_trimString == "ind_logistic_repair" ): { ADV_ind_veh_logistic_repair pushBack _vehicleName; };
		case ( [_vehicleName,0,17] call BIS_fnc_trimString == "ind_logistic_medic" ): { ADV_ind_veh_logistic_medic pushBack _vehicleName; };
		//armored
		case ( [_vehicleName,0,8] call BIS_fnc_trimString == "ind_heavy" ): { ADV_ind_veh_heavys pushBack _vehicleName; };
		case ( [_vehicleName,0,7] call BIS_fnc_trimString == "ind_tank" ): { ADV_ind_veh_tanks pushBack _vehicleName; };
		case ( [_vehicleName,0,7] call BIS_fnc_trimString == "ind_arty" ): { ADV_ind_veh_artys pushBack _vehicleName; };
		default {};
	};
} forEach vehicles;

ADV_ind_veh_helis = ADV_ind_veh_airRecon+ADV_ind_veh_airTransport+ADV_ind_veh_airLogistic;
ADV_ind_veh_fixedWing = ADV_ind_veh_airCAS+ADV_ind_veh_airC130+ADV_ind_veh_UAVs;
ADV_ind_veh_air = ADV_ind_veh_helis+ADV_ind_veh_fixedWing;
ADV_ind_veh_armored = ADV_ind_veh_heavys+ADV_ind_veh_tanks+ADV_ind_veh_artys;
ADV_ind_veh_car = ADV_ind_veh_MRAPs+ADV_ind_veh_MRAPsHMG+ADV_ind_veh_MRAPsGMG+ADV_ind_veh_SUV+ADV_ind_veh_Offroad+ADV_ind_veh_OffroadHMG;
ADV_ind_veh_light = ADV_ind_veh_ATVs+ADV_ind_veh_UGVs+ADV_ind_veh_UGVs_repair+ADV_ind_veh_car+ADV_ind_veh_transport+ADV_ind_veh_logistic_repair+ADV_ind_veh_logistic_fuel+ADV_ind_veh_logistic_ammo+ADV_ind_veh_logistic_medic;

ADV_ind_veh_all = ADV_ind_veh_light+ADV_ind_veh_armored+ADV_ind_veh_air;

///// No editing necessary below this line /////

//replaces MRAPS with mod cars:
switch (ADV_par_indCarAssets) do {
	case 1: {[ADV_ind_veh_SUV,["I_MRAP_03_F"],independent] spawn ADV_fnc_changeVeh;[ADV_ind_veh_Offroad+ADV_ind_veh_OffroadHMG,["I_MRAP_03_hmg_F"],independent] spawn ADV_fnc_changeVeh;[ADV_ind_veh_airRecon,["I_Heli_light_03_F"],independent] spawn ADV_fnc_changeVeh;};
	case 99: {[ADV_ind_veh_all,[""],independent] spawn ADV_fnc_changeVeh;};
	default {};
};

/*
//replaces trucks with mod trucks:
switch (ADV_par_modTruckAssets) do {
	//DAR MTVR
	//case 1: {[ADV_veh_transport,["DAR_MK27","DAR_MK27T"]] spawn ADV_fnc_changeVeh;[ADV_veh_logistic_fuel,["DAR_LHS_8"],independent] spawn ADV_fnc_changeVeh;[ADV_veh_logistic_repair+ADV_veh_logistic_ammo,["DAR_LHS_16"],independent] spawn ADV_fnc_changeVeh;};
	default {};
};
//replaces heavy vehicles with mod vehicles:
switch (ADV_par_modHeavyAssets) do {
	//BWmod Puma sand
	//case 1: {[ADV_veh_heavys,["BWA3_Puma_Tropen"],independent] spawn ADV_fnc_changeVeh;};
	default {};
};
//replaces tanks with mod tanks:
switch (ADV_par_modTankAssets) do {
	//BWmod Leopard sand
	//case 1: {[ADV_veh_tanks,["BWA3_Leopard2A6M_Tropen"],independent] spawn ADV_fnc_changeVeh;};
	default {};
};
//replaces helis with mod helis:
switch (ADV_par_modHeliAssets) do {
	//BAFHelis
	//case 1: {[ADV_veh_airTransport,["UK3CB_BAF_Wildcat_Transport_RN_ZZ396"],independent] spawn ADV_fnc_changeVeh;[ADV_veh_airRecon,["UK3CB_BAF_Wildcat_Armed_Army_ZZ400"],independent] spawn ADV_fnc_changeVeh;[ADV_veh_airLogistic,["UK3CB_BAF_Vehicles_Merlin_RAF_ZJ124"],independent] spawn ADV_fnc_changeVeh;};
	default {};
};
//replaces planes with mod planes:
switch (ADV_par_modAirAssets) do {
	//FA18E
	//case 1: {[ADV_veh_airCAS,["JS_JC_FA18E"],independent] spawn ADV_fnc_changeVeh;};
	default {};
};
*/

//removes the markers according to the lobby params
if (ADV_par_Assets_cars == 0 || ADV_par_Assets_cars == 99 || ADV_par_indCarAssets == 99) then {
	{_x setMarkerAlpha 0;} forEach _veh_lightMarkers
};
if (ADV_par_Assets_tanks == 0 || ADV_par_Assets_tanks == 99) then {
	{_x setMarkerAlpha 0;} forEach _veh_heavyMarkers;
};
if (ADV_par_Assets_air_helis == 0 || ADV_par_Assets_air_helis == 99) then {
	{_x setMarkerAlpha 0;} forEach _veh_heliMarkers;
};
if ( (ADV_par_Assets_air_fixed == 0 && ADV_par_Assets_air_helis == 0) || (ADV_par_Assets_air_fixed == 99 && ADV_par_Assets_air_helis == 99)) then {
	{_x setMarkerAlpha 0;} forEach _veh_fixedMarkers;
};

//manages disablement and load.
{
	if (str _x in ADV_ind_veh_all) then {
		[_x] call ADV_fnc_clearCargo;
		[_x] call ADV_ind_fnc_addVehicleLoad;
		[_x] call ADV_ind_fnc_disableVehSelector;
		[_x,ADV_par_vehicleRespawn, independent, (typeOf _x)] spawn ADV_fnc_respawnVeh;
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
			_x setObjectTextureGlobal [0,'#(rgb,8,8,3)color(1,1,1,0.004)'];
			if (str _x in ADV_ind_veh_transport) then {
				_x setObjectTextureGlobal [1,'#(rgb,8,8,3)color(1,1,1,0.004)'];
			};
			/*
			if (str _x in ADV_ind_veh_Offroad+ADV_ind_veh_OffroadHMG) then {
				_x setObjectMaterial [0,"A3\soft_f_bootcamp\Offroad_01\Data\offroad_01_ext_repair_ig_plastic.rvmat"];
			};
			*/
		};
	};
} forEach vehicles;


if (true) exitWith { missionNamespace setVariable ["ADV_var_manageVeh_ind",true,true]; };
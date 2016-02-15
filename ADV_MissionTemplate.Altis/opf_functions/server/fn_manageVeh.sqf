/*
disable Vehicles script by Belbo
disables all preplaced air and/or ground vehicles and their garage-markers.
defined in cfgFunctions (functions\server\fn_manageVeh.sqf)
Call from init.sqf (as early as possible) via:

[] call ADV_fnc_manageVeh;
*/

if (!isServer) exitWith {};

//markers for the vehicle garages:
_veh_lightMarkers = ["opf_garage_1","opf_garage_2"];
_veh_heavyMarkers = ["opf_garage_heavy_1","opf_garage_heavy_2","opf_garage_heavy_3"];
_veh_heliMarkers = ["opf_garage_air_1"];
_veh_fixedMarkers = ["opf_garage_air_2"];

//unique vehicles placed in the editor:
ADV_opf_veh_airTransport = ["opf_air_transport_1","opf_air_transport_2","opf_air_transport_3","opf_air_transport_4","opf_air_transport_5","opf_air_transport_6","opf_air_transport_7","opf_air_transport_8","opf_air_transport_9","opf_air_transport_10"];
ADV_opf_veh_airLogistic = ["opf_air_logistic_1","opf_air_logistic_2","opf_air_logistic_3","opf_air_logistic_4","opf_air_logistic_5","opf_air_logistic_6","opf_air_logistic_7","opf_air_logistic_8","opf_air_logistic_9","opf_air_logistic_10"];
ADV_opf_veh_airContainerMedic = ["opf_air_container_medical_1"];
ADV_opf_veh_airContainerTransport = ["opf_air_container_transport_1"];
ADV_opf_veh_airRecon = ["opf_air_recon_1","opf_air_recon_2","opf_air_recon_3","opf_air_recon_4","opf_air_recon_5","opf_air_recon_6","opf_air_recon_7","opf_air_recon_8","opf_air_recon_9","opf_air_recon_10"];
ADV_opf_veh_airCAS = ["opf_air_a164_1","opf_air_a164_2","opf_air_a164_3","opf_air_a164_4","opf_air_a164_5","opf_air_a164_6","opf_air_a164_7","opf_air_a164_8","opf_air_a164_9","opf_air_a164_10"];
ADV_opf_veh_helis = ADV_opf_veh_airLogistic+ADV_opf_veh_airTransport+ADV_opf_veh_airRecon+ADV_opf_veh_airContainerMedic+ADV_opf_veh_airContainerTransport;
ADV_opf_veh_air = ADV_opf_veh_helis+ADV_opf_veh_airCAS;
ADV_opf_veh_heavys = ["opf_heavy_1","opf_heavy_2","opf_heavy_3","opf_heavy_4","opf_heavy_5","opf_heavy_6","opf_heavy_7","opf_heavy_8","opf_heavy_9","opf_heavy_10"];
ADV_opf_veh_tanks = ["opf_tank_1","opf_tank_2","opf_tank_3","opf_tank_4","opf_tank_5","opf_tank_6","opf_tank_7","opf_tank_8","opf_tank_9","opf_tank_10"];
ADV_opf_veh_artys = ["opf_arty_1","opf_arty_2","opf_arty_3","opf_arty_4","opf_arty_5","opf_arty_6","opf_arty_7","opf_arty_8","opf_arty_9","opf_arty_10"];
ADV_opf_veh_armored = ADV_opf_veh_heavys+ADV_opf_veh_tanks+ADV_opf_veh_artys;
ADV_opf_veh_transport = ["opf_transport_1","opf_transport_2","opf_transport_3","opf_transport_4","opf_transport_5","opf_transport_6","opf_transport_7","opf_transport_8","opf_transport_9","opf_transport_10"];
ADV_opf_veh_logistic_fuel = ["opf_logistic_fuel_1","opf_logistic_fuel_2","opf_logistic_fuel_3","opf_logistic_fuel_4","opf_logistic_fuel_5","opf_logistic_fuel_6","opf_logistic_fuel_7","opf_logistic_fuel_8","opf_logistic_fuel_9","opf_logistic_fuel_10"];
ADV_opf_veh_logistic_ammo = ["opf_logistic_ammo_1","opf_logistic_ammo_2","opf_logistic_ammo_3","opf_logistic_ammo_4","opf_logistic_ammo_5","opf_logistic_ammo_6","opf_logistic_ammo_7","opf_logistic_ammo_8","opf_logistic_ammo_9","opf_logistic_ammo_10"];
ADV_opf_veh_logistic_repair = ["opf_logistic_repair_1","opf_logistic_repair_2","opf_logistic_repair_3","opf_logistic_repair_4","opf_logistic_repair_5","opf_logistic_repair_6","opf_logistic_repair_7","opf_logistic_repair_8","opf_logistic_repair_9","opf_logistic_repair_10"];
ADV_opf_veh_logistic_medic = ["opf_logistic_medic_1","opf_logistic_medic_2","opf_logistic_medic_3","opf_logistic_medic_4","opf_logistic_medic_5","opf_logistic_medic_6","opf_logistic_medic_7","opf_logistic_medic_8","opf_logistic_medic_9","opf_logistic_medic_10"];
ADV_opf_veh_MRAPs = ["opf_MRAP_1","opf_MRAP_2","opf_MRAP_3","opf_MRAP_4","opf_MRAP_5","opf_MRAP_6","opf_MRAP_7","opf_MRAP_8","opf_MRAP_9","opf_MRAP_10"];
ADV_opf_veh_MRAPsHMG = ["opf_MRAP_hmg_1","opf_MRAP_hmg_2","opf_MRAP_hmg_3","opf_MRAP_hmg_4","opf_MRAP_hmg_5","opf_MRAP_hmg_6","opf_MRAP_hmg_7","opf_MRAP_hmg_8","opf_MRAP_hmg_9","opf_MRAP_hmg_10"];
ADV_opf_veh_MRAPsGMG = ["opf_MRAP_gmg_1","opf_MRAP_gmg_2","opf_MRAP_gmg_3","opf_MRAP_gmg_4","opf_MRAP_gmg_5","opf_MRAP_gmg_6","opf_MRAP_gmg_7","opf_MRAP_gmg_8","opf_MRAP_gmg_9","opf_MRAP_gmg_10"];
ADV_opf_veh_ATVs = ["opf_ATV_1","opf_ATV_2","opf_ATV_3","opf_ATV_4","opf_ATV_5","opf_ATV_6","opf_ATV_7","opf_ATV_8","opf_ATV_9","opf_ATV_10","opf_ATV_11","opf_ATV_12","opf_ATV_13","opf_ATV_14","opf_ATV_15","opf_ATV_16"];
ADV_opf_veh_light = ADV_opf_veh_transport+ADV_opf_veh_MRAPS+ADV_opf_veh_MRAPsHMG+ADV_opf_veh_MRAPsGMG+ADV_opf_veh_ATVs+ADV_opf_veh_logistic_fuel+ADV_opf_veh_logistic_ammo+ADV_opf_veh_logistic_repair+ADV_opf_veh_logistic_medic;
ADV_opf_veh_all = ADV_opf_veh_light+ADV_opf_veh_armored+ADV_opf_veh_air;

///// No editing necessary below this line /////

//replaces MRAPS with mod cars:
switch (ADV_par_opfCarAssets) do {
	//RHS UAZ
	case 1: {[ADV_opf_veh_MRAPs+ADV_opf_veh_MRAPsHMG,["rhs_uaz_msv_01","rhs_uaz_open_msv_01"]] spawn ADV_opf_fnc_changeVeh;};
	//RHS GAZ
	case 2: {[ADV_opf_veh_MRAPs,["rhs_tigr_msv"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_MRAPsHMG,["rhs_tigr_ffv_msv"]] spawn ADV_opf_fnc_changeVeh;};
	//RDS vehicles
	case 3: {[ADV_opf_veh_MRAPs+ADV_opf_veh_MRAPsHMG,["RDS_Gaz24_Civ_01","RDS_Gaz24_Civ_02","RDS_Gaz24_Civ_03","RDS_Lada_Civ_01","RDS_Lada_Civ_02","RDS_Lada_Civ_03","RDS_Lada_Civ_04"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_ATVs,[""]] spawn ADV_opf_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_opf_veh_MRAPs+ADV_opf_veh_MRAPsHMG+ADV_opf_veh_ATVs,[""]] spawn ADV_opf_fnc_changeVeh;};
	default {};
};

//replaces trucks with mod trucks:
switch (ADV_par_opfTruckAssets) do {
	//RHS
	case 1: {[ADV_opf_veh_transport,["rhs_gaz66_msv","rhs_gaz66o_msv","rhs_ural_msv_01","rhs_ural_open_msv_01"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_logistic_ammo,["rhs_gaz66_ammo_msv"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_logistic_fuel,["rhs_ural_fuel_msv_01"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_logistic_repair,["rhs_gaz66_repair_msv"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_logistic_medic,["rhs_ural_msv_01"]] spawn ADV_opf_fnc_changeVeh;};
	//RDS vehicles
	case 2: {[ADV_opf_veh_transport+ADV_opf_veh_logistic_medic+ADV_opf_veh_logistic_ammo+ADV_opf_veh_logistic_fuel+ADV_opf_veh_logistic_repair,["RHS_Ural_Open_Civ_01","RHS_Ural_Open_Civ_02","RHS_Ural_Open_Civ_03","RHS_Ural_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Civ_03"]] spawn ADV_opf_fnc_changeVeh;};
	//no Trucks
	case 99: {[ADV_opf_veh_transport+ADV_opf_veh_logistic_medic+ADV_opf_veh_logistic_ammo+ADV_opf_veh_logistic_fuel+ADV_opf_veh_logistic_repair,[""]] spawn ADV_opf_fnc_changeVeh;};
	default {};
};

//replaces heavy vehicles with mod vehicles:
switch (ADV_par_opfHeavyAssets) do {
	//RHS BTR
	case 1: {[ADV_opf_veh_heavys,["rhs_btr80a_msv","rhs_btr80_msv","rhs_btr70_msv"]] spawn ADV_opf_fnc_changeVeh;};
	//RHS BMP
	case 2: {[ADV_opf_veh_heavys,["rhs_bmp1_msv","rhs_bmp1d_msv","rhs_bmp1k_msv","rhs_bmp1p_msv","rhs_bmp2_msv","rhs_bmp2d_msv","rhs_bmp2e_msv","rhs_bmp2k_msv"]] spawn ADV_opf_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_opf_veh_heavys,[""]] spawn ADV_opf_fnc_changeVeh;};
	default {};
};

//replaces tanks with mod tanks:
switch (ADV_par_opfTankAssets) do {
	//RHS T72
	case 1: {[ADV_opf_veh_tanks,["rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_artys,["RDS_D30_CSAT"]] spawn ADV_opf_fnc_changeVeh;};
	//RHS T80
	case 2: {[ADV_opf_veh_tanks,["rhs_t80a","rhs_t80b","rhs_t80bk","rhs_t80bv","rhs_t80bvk","rhs_t80u"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_artys,["rhs_2s3_tv"]] spawn ADV_opf_fnc_changeVeh;};	
	//RHS T90
	case 3: {[ADV_opf_veh_tanks,["rhs_t90_tv"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_artys,["rhs_2s3_tv"]] spawn ADV_opf_fnc_changeVeh;};	
	//RDS T34
	case 4: {[ADV_opf_veh_tanks,["RDS_T34_AAF_01"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_artys,["RDS_D30_CSAT"]] spawn ADV_opf_fnc_changeVeh; [ADV_opf_veh_logistic_medic,["RDS_BMP2_Ambul_01"]] spawn ADV_opf_fnc_changeVeh;};
	//RDS T55
	case 5: {[ADV_opf_veh_tanks,["RDS_T55_AAF_01"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_artys,["RDS_D30_CSAT"]] spawn ADV_opf_fnc_changeVeh; [ADV_opf_veh_logistic_medic,["RDS_BMP2_Ambul_01"]] spawn ADV_opf_fnc_changeVeh;};
	//no vehicles 
	case 99: {[ADV_opf_veh_tanks+ADV_opf_veh_artys,[""]] spawn ADV_opf_fnc_changeVeh;};
	default {};
};

//replaces helis with mod helis:
switch (ADV_par_opfHeliAssets) do {
	//RHS transport
	case 1: {[ADV_opf_veh_airTransport+ADV_opf_veh_airLogistic,["rhs_mi8amt_vvsc","rhs_mi8amt_vvs","rhs_mi8amtsh_vvsc","rhs_mi8amtsh_vvs","rhs_mi8mt_vvsc","rhs_mi8mt_vvs","rhs_mi8mtv3_vvsc","rhs_mi8mtv3_vvs"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_airRecon,["rhs_ka60_c","rhs_ka60_grey"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_airContainerMedic+ADV_opf_veh_airContainerTransport,[""]] spawn ADV_opf_fnc_changeVeh;};
	//RHS transport Mi24
	case 2: {[ADV_opf_veh_airTransport+ADV_opf_veh_airLogistic,["rhs_mi8amt_vvsc","rhs_mi8amt_vvs","rhs_mi8amtsh_vvsc","rhs_mi8amtsh_vvs","rhs_mi8mt_vvsc","rhs_mi8mt_vvs","rhs_mi8mtv3_vvsc","rhs_mi8mtv3_vvs"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_airRecon,["rhs_mi24p_vvs","rhs_mi24p_vvsc","rhs_mi24v_vvs","rhs_mi24v_vvsc"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_airContainerMedic+ADV_opf_veh_airContainerTransport,[""]] spawn ADV_opf_fnc_changeVeh;};
	//RHS transport Ka52
	case 3: {[ADV_opf_veh_airTransport+ADV_opf_veh_airLogistic,["rhs_mi8amt_vvsc","rhs_mi8amt_vvs","rhs_mi8amtsh_vvsc","rhs_mi8amtsh_vvs","rhs_mi8mt_vvsc","rhs_mi8mt_vvs","rhs_mi8mtv3_vvsc","rhs_mi8mtv3_vvs"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_airRecon,["rhs_ka52_vvsc","rhs_ka52_vvs"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_airContainerMedic+ADV_opf_veh_airContainerTransport,[""]] spawn ADV_opf_fnc_changeVeh;};
	//RHS CAS only
	case 4: {[ADV_opf_veh_airLogistic,["rhs_mi8amt_vvsc","rhs_mi8amt_vvs","rhs_mi8amtsh_vvsc","rhs_mi8amtsh_vvs","rhs_mi8mt_vvsc","rhs_mi8mt_vvs","rhs_mi8mtv3_vvsc","rhs_mi8mtv3_vvs"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_airTransport,["rhs_mi24p_vvs","rhs_mi24p_vvsc","rhs_mi24v_vvs","rhs_mi24v_vvsc"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_airRecon,["rhs_ka52_vvsc","rhs_ka52_vvs"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_airContainerMedic+ADV_opf_veh_airContainerTransport,[""]] spawn ADV_opf_fnc_changeVeh;};
	//RHS civilian
	case 5: {[ADV_opf_veh_helis,["RHS_Mi8amt_civilian"]] spawn ADV_opf_fnc_changeVeh;[ADV_opf_veh_airContainerMedic+ADV_opf_veh_airContainerTransport,[""]] spawn ADV_opf_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_opf_veh_helis+ADV_opf_veh_airContainerMedic+ADV_opf_veh_airContainerTransport,[""]] spawn ADV_opf_fnc_changeVeh;};
	default {};
};

//replaces planes with mod planes:
switch (ADV_par_opfAirAssets) do {
	//RHS SU-25
	case 1: {[ADV_opf_veh_airCAS,["RHS_Su25SM_vvsc","RHS_Su25SM_vvs"]] spawn ADV_opf_fnc_changeVeh;};
	//RHS Su T-50
	case 2: {[ADV_opf_veh_airCAS,["RHS_T50_vvs_generic","RHS_T50_vvs_blueonblue"]] spawn ADV_opf_fnc_changeVeh;};
	//JS SU35
	case 3: {[ADV_opf_veh_airCAS,["JS_JC_SU35"]] spawn ADV_opf_fnc_changeVeh;};
	//no planes
	case 99: {[ADV_opf_veh_airCAS,[""]] spawn ADV_opf_fnc_changeVeh;};
	default {};
};

//removes the markers according to the lobby params
//disables the vehicles
if (ADV_par_Assets_cars == 0 || ADV_par_opfCarAssets == 99) then {
	{_x setMarkerAlpha 0;} forEach _veh_lightMarkers
};
if (ADV_par_Assets_tanks == 0 || ADV_par_opftankAssets == 99) then {
	{_x setMarkerAlpha 0;} forEach _veh_heavyMarkers;
};
if (ADV_par_Assets_air_helis == 0 || ADV_par_opfheliAssets == 99) then {
	{_x setMarkerAlpha 0;} forEach _veh_heliMarkers;
};
if ( (ADV_par_Assets_air_fixed == 0 && ADV_par_Assets_air_helis == 0) || ADV_par_opfAirAssets == 99) then {
	{_x setMarkerAlpha 0;} forEach _veh_fixedMarkers;
};

//disables vehicles at start
{
	if (str _x in ADV_opf_veh_all) then {
		[_x] call ADV_opf_fnc_disableVehSelector;
		[_x] call ADV_fnc_clearCargo;
		[_x] call ADV_opf_fnc_addVehicleLoad;
		if (str _x in ADV_opf_veh_artys) then {
			[_x] call ADV_fnc_showArtiSetting;
		};
		if ( ADV_par_Radios > 0 && (_x isKindOf "CAR" || _x isKindOf "TANK" || _x isKindOf "AIR") ) then {
			_x setVariable ["tf_hasRadio", true, true];
			//_x setVariable ["tf_side", east, true];
		};
		[_x,ADV_par_vehicleRespawn, (typeOf _x)] spawn ADV_opf_fnc_respawnVeh;
		if (ADV_par_TIEquipment > 0) then {
			_x disableTIEquipment true;
			if (ADV_par_TIEquipment > 2) then {
				_x disableNVGEquipment true;
			};
		};
	};
} forEach Vehicles;

if (true) exitWith { missionNamespace setVariable ["ADV_var_manageVeh_opf",true,true]; };
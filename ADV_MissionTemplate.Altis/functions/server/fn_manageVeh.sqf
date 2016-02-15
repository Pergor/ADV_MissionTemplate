/*
disable Vehicles script by Belbo
disables all preplaced air and/or ground vehicles and their garage-markers.
defined in cfgFunctions (functions\server\fn_manageVeh.sqf)
Call from init.sqf (as early as possible) via:

[] call ADV_fnc_manageVeh;
*/

if (!isServer) exitWith {};

//markers for the vehicle garages:
_veh_lightMarkers = ["garage_1","garage_2","garage_3","garage_4","garage_5"];
_veh_heavyMarkers = ["garage_heavy_1","garage_heavy_2","garage_heavy_3","garage_heavy_4","garage_heavy_5"];
_veh_heliMarkers = ["garage_air_1"];
_veh_fixedMarkers = ["garage_air_2"];

//unique vehicles placed in the editor:
ADV_veh_airTransport = ["air_transport_1","air_transport_2","air_transport_3","air_transport_4","air_transport_5","air_transport_6","air_transport_7","air_transport_8","air_transport_9","air_transport_10"];
ADV_veh_airLogistic = ["air_logistic_1","air_logistic_2","air_logistic_3","air_logistic_4","air_logistic_5","air_logistic_6","air_logistic_7","air_logistic_8","air_logistic_9","air_logistic_10"];
ADV_veh_airRecon = ["air_recon_1","air_recon_2","air_recon_3","air_recon_4","air_recon_5","air_recon_6","air_recon_7","air_recon_8","air_recon_9","air_recon_10"];
ADV_veh_airCAS = ["air_a164_1","air_a164_2","air_a164_3","air_a164_4","air_a164_5","air_a164_6","air_a164_7","air_a164_8","air_a164_9","air_a164_10"];
ADV_veh_airC130 = ["air_c130_1","air_c130_2","air_c130_3","air_c130_4","air_c130_5","air_c130_6","air_c130_7","air_c130_8","air_c130_9","air_c130_10"];
ADV_veh_fixedWing = ADV_veh_airCAS+ADV_veh_airC130;
ADV_veh_helis = ADV_veh_airLogistic+ADV_veh_airTransport+ADV_veh_airRecon;
ADV_veh_air = ADV_veh_helis+ADV_veh_fixedWing;
ADV_veh_heavys = ["heavy_1","heavy_2","heavy_3","heavy_4","heavy_5","heavy_6","heavy_7","heavy_8","heavy_9","heavy_10"];
ADV_veh_tanks = ["tank_1","tank_2","tank_3","tank_4","tank_5","tank_6","tank_7","tank_8","tank_9","tank_10"];
ADV_veh_artys = ["arty_1","arty_2","arty_3","arty_4","arty_5","arty_6","arty_7","arty_8","arty_9","arty_10"];
ADV_veh_armored = ADV_veh_heavys+ADV_veh_tanks+ADV_veh_artys;
ADV_veh_transport = ["transport_1","transport_2","transport_3","transport_4","transport_5","transport_6","transport_7","transport_8","transport_9","transport_10"];
ADV_veh_logistic_fuel = ["logistic_fuel_1","logistic_fuel_2","logistic_fuel_3","logistic_fuel_4","logistic_fuel_5","logistic_fuel_6","logistic_fuel_7","logistic_fuel_8","logistic_fuel_9","logistic_fuel_10"];
ADV_veh_logistic_ammo = ["logistic_ammo_1","logistic_ammo_2","logistic_ammo_3","logistic_ammo_4","logistic_ammo_5","logistic_ammo_6","logistic_ammo_7","logistic_ammo_8","logistic_ammo_9","logistic_ammo_10"];
ADV_veh_logistic_repair = ["logistic_repair_1","logistic_repair_2","logistic_repair_3","logistic_repair_4","logistic_repair_5","logistic_repair_6","logistic_repair_7","logistic_repair_8","logistic_repair_9","logistic_repair_10"];
ADV_veh_logistic_medic = ["logistic_medic_1","logistic_medic_2","logistic_medic_3","logistic_medic_4","logistic_medic_5","logistic_medic_6","logistic_medic_7","logistic_medic_8","logistic_medic_9","logistic_medic_10"];
ADV_veh_MRAPs = ["MRAP_1","MRAP_2","MRAP_3","MRAP_4","MRAP_5","MRAP_6","MRAP_7","MRAP_8","MRAP_9","MRAP_10"];
ADV_veh_MRAPsHMG = ["MRAP_hmg_1","MRAP_hmg_2","MRAP_hmg_3","MRAP_hmg_4","MRAP_hmg_5","MRAP_hmg_6","MRAP_hmg_7","MRAP_hmg_8","MRAP_hmg_9","MRAP_hmg_10"];
ADV_veh_MRAPsGMG = ["MRAP_gmg_1","MRAP_gmg_2","MRAP_gmg_3","MRAP_gmg_4","MRAP_gmg_5","MRAP_gmg_6","MRAP_gmg_7","MRAP_gmg_8","MRAP_gmg_9","MRAP_gmg_10"];
ADV_veh_ATVs = ["ATV_1","ATV_2","ATV_3","ATV_4","ATV_5","ATV_6","ATV_7","ATV_8","ATV_9","ATV_10","ATV_11","ATV_12","ATV_13","ATV_14","ATV_15","ATV_16","ATV_17","ATV_18","ATV_19","ATV_20"];
ADV_veh_light = ADV_veh_transport+ADV_veh_MRAPS+ADV_veh_MRAPsHMG+ADV_veh_MRAPsGMG+ADV_veh_ATVs+ADV_veh_logistic_fuel+ADV_veh_logistic_ammo+ADV_veh_logistic_repair+ADV_veh_logistic_medic;
ADV_veh_all = ADV_veh_light+ADV_veh_armored+ADV_veh_air;

///// No editing necessary below this line /////

//replaces MRAPS with mod cars:
switch (ADV_par_modCarAssets) do {
	//Bundeswehr sand
	case 1: {[ADV_veh_MRAPs,["Fennek_Tropen","Fennek_Tropen","Fennek_Tropen","Fennek_Tropen_san"]] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["BW_Dingo_Des"]] spawn ADV_fnc_changeVeh;};
	//Bundeswehr woodland
	case 2: {[ADV_veh_MRAPs,["Fennek_Flecktarn","Fennek_Flecktarn","Fennek_Flecktarn","Fennek_Flecktarn_san"]] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["BW_Dingo_Wdl"]] spawn ADV_fnc_changeVeh;};
	//BAF sand
	case 3: {[ADV_veh_MRAPs,["BAF_Offroad_D"]] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["UK3CB_BAF_Jackal2_L2A1_D","UK3CB_BAF_Coyote_Passenger_L111A1_D"]] spawn ADV_fnc_changeVeh;};
	//BAF woodland
	case 4: {[ADV_veh_MRAPs,["BAF_Offroad_W"]] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["UK3CB_BAF_Jackal2_L2A1_W","UK3CB_BAF_Coyote_Passenger_L111A1_W"]] spawn ADV_fnc_changeVeh;};
	//RHS ARMY desert
	case 5: {[ADV_veh_MRAPs,["rhsusf_m1025_d","rhsusf_m1025_d","rhsusf_m998_d_4dr"]] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["rhsusf_m1025_d_m2"]] spawn ADV_fnc_changeVeh;};
	//RHS ARMY woodland
	case 6: {[ADV_veh_MRAPs,["rhsusf_m1025_w","rhsusf_m1025_w","rhsusf_m998_w_4dr"]] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["rhsusf_m1025_w_m2"]] spawn ADV_fnc_changeVeh;};
	//RHS Marines desert
	case 7: {[ADV_veh_MRAPs,["rhsusf_m1025_d_s","rhsusf_m1025_d_s","rhsusf_m998_d_s_4dr"]] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["rhsusf_m1025_d_s_m2"]] spawn ADV_fnc_changeVeh;};
	//RHS Marines woodland
	case 8: {[ADV_veh_MRAPs,["rhsusf_m1025_w_s","rhsusf_m1025_w_s","rhsusf_m998_w_s_4dr"]] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["rhsusf_m1025_w_s_m2"]] spawn ADV_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_veh_MRAPs+ADV_veh_MRAPsHMG+ADV_veh_MRAPsGMG+ADV_veh_ATVs,[""]] spawn ADV_fnc_changeVeh;};
	default {};
};

//replaces trucks with mod trucks:
switch (ADV_par_modTruckAssets) do {
	//DAR MTVR
	case 1: {[ADV_veh_transport,["DAR_MK27","DAR_MK27T"]] spawn ADV_fnc_changeVeh;[ADV_veh_logistic_fuel,["DAR_LHS_8"]] spawn ADV_fnc_changeVeh;[ADV_veh_logistic_repair+ADV_veh_logistic_ammo,["DAR_LHS_16"]] spawn ADV_fnc_changeVeh;[ADV_veh_logistic_medic,["DAR_MK23"]] spawn ADV_fnc_changeVeh;};
	//RHS sand
	case 2: {[ADV_veh_transport,["rhsusf_M1083A1P2_d_fmtv_usarmy","rhsusf_M1083A1P2_B_d_fmtv_usarmy"]] spawn ADV_fnc_changeVeh;[ADV_veh_logistic_fuel,["rhsusf_M978A2_CPK_usarmy_wd"]] spawn ADV_fnc_changeVeh;};
	//RHS woodland
	case 3: {[ADV_veh_transport,["rhsusf_M1083A1P2_wd_fmtv_usarmy","rhsusf_M1083A1P2_B_wd_fmtv_usarmy"]] spawn ADV_fnc_changeVeh;[ADV_veh_logistic_fuel,["rhsusf_M978A2_usarmy_wd"]] spawn ADV_fnc_changeVeh;};
	//BAF desert
	case 4: {[ADV_veh_transport,["UK3CB_BAF_Coyote_Logistics_L111A1_D"]] spawn ADV_fnc_changeVeh;};
	//BAF woodland
	case 5: {[ADV_veh_transport,["UK3CB_BAF_Coyote_Logistics_L111A1_W"]] spawn ADV_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_veh_transport+ADV_veh_logistic_fuel+ADV_veh_logistic_medic+ADV_veh_logistic_repair+ADV_veh_logistic_ammo,[""]] spawn ADV_fnc_changeVeh;};
	default {};
};

//replaces heavy vehicles with mod vehicles:
switch (ADV_par_modHeavyAssets) do {
	//BWmod Puma sand
	case 1: {[ADV_veh_heavys,["BWA3_Puma_Tropen"]] spawn ADV_fnc_changeVeh;};
	//BWmod Puma woodland
	case 2: {[ADV_veh_heavys,["BWA3_Puma_Fleck"]] spawn ADV_fnc_changeVeh;};
	//Stryker Pack sand
	case 3: {[ADV_veh_heavys,["M1126_ICV_M134_DG1_NOSLATDES","M1126_ICV_M134_DG1_SLATDES","M1126_ICV_M2_DG1_NOSLATDES","M1126_ICV_M2NEST_DG1_NOSLATDES","M1130_CV_DG1_NOSLATDES","M1130_CV_DG1_SLATDES","M1133_MEV_DG1_SLATDES"]] spawn ADV_fnc_changeVeh;};
	//Stryker Pack woodland
	case 4: {[ADV_veh_heavys,["M1126_ICV_M134_DG1_NOSLATWOOD","M1126_ICV_M134_DG1_SLATWOOD","M1126_ICV_M2_DG1_NOSLATWOOD","M1126_ICV_M2NEST_DG1_NOSLATWOOD","M1130_CV_DG1_NOSLATWOOD","M1130_CV_DG1_SLATWOOD","M1133_MEV_DG1_SLATWOOD"]] spawn ADV_fnc_changeVeh;};
	//DAR MaxxPro MRAP
	case 5: {[ADV_veh_heavys,["DAR_MaxxProDeploy","DAR_MaxxProDeploy","DAR_MaxxPro","DAR_MaxxProDXM","DAR_MaxxProPlus"]] spawn ADV_fnc_changeVeh;};
	//stv retextures
	case 6: {[ADV_veh_heavys,["Steve_IFV_Warrior","Steve_IFV_Marid"]] spawn ADV_fnc_changeVeh;};
	//RHS M2 desert
	case 7: {[ADV_veh_heavys,["RHS_M2A2","RHS_M2A2_BUSKI","RHS_M2A3_BUSKIII"]] spawn ADV_fnc_changeVeh; [ADV_veh_logistic_medic,["rhsusf_m113d_usarmy_medical"]] spawn ADV_fnc_changeVeh; [ADV_veh_logistic_ammo,["rhsusf_m113d_usarmy_supply"]] spawn ADV_fnc_changeVeh;};
	//RHS M2 woodland
	case 8: {[ADV_veh_heavys,["RHS_M2A2_wd","RHS_M2A2_BUSKI_WD","RHS_M2A3_BUSKIII_wd"]] spawn ADV_fnc_changeVeh; [ADV_veh_logistic_medic,["rhsusf_m113_usarmy_medical"]] spawn ADV_fnc_changeVeh;[ADV_veh_logistic_ammo,["rhsusf_m113_usarmy_supply"]] spawn ADV_fnc_changeVeh;};
	//RHS MRAP desert
	case 9: {[ADV_veh_heavys,["rhsusf_rg33_d","rhsusf_rg33_m2_d","rhsusf_rg33_m2_d"]] spawn ADV_fnc_changeVeh; [ADV_veh_logistic_medic,["rhsusf_m113_usarmy_medical"]] spawn ADV_fnc_changeVeh; [ADV_veh_logistic_ammo,["rhsusf_m113d_usarmy_supply"]] spawn ADV_fnc_changeVeh;};
	//RHS MRAP woodland
	case 10: {[ADV_veh_heavys,["rhsusf_rg33_wd","rhsusf_rg33_m2_wd","rhsusf_rg33_m2_wd"]] spawn ADV_fnc_changeVeh; [ADV_veh_logistic_medic,["rhsusf_m113d_usarmy_medical"]] spawn ADV_fnc_changeVeh; [ADV_veh_logistic_ammo,["rhsusf_m113d_usarmy_supply"]] spawn ADV_fnc_changeVeh;};
	//CHA LAVs desert
	case 11: {[ADV_veh_heavys,["Cha_Des1_LAV25","Cha_Des1_LAV25A2","Cha_Des1_LAV25A2"]] spawn ADV_fnc_changeVeh;};
	//CHA LAVs woodland
	case 12: {[ADV_veh_heavys,["Cha_LAV25","Cha_LAV25A2","Cha_LAV25A2"]] spawn ADV_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_veh_heavys,[""]] spawn ADV_fnc_changeVeh;};
	default {};
};

//replaces tanks with mod tanks:
switch (ADV_par_modTankAssets) do {
	//BWmod Leopard sand
	case 1: {[ADV_veh_tanks,["BWA3_Leopard2A6M_Tropen"]] spawn ADV_fnc_changeVeh;};
	//BWmod Leopard woodland
	case 2: {[ADV_veh_tanks,["BWA3_Leopard2A6M_Fleck"]] spawn ADV_fnc_changeVeh;};
	//Burne's M1A2 sand
	case 3: {[ADV_veh_tanks,["Burnes_M1A2_MEU_02_Public"]] spawn ADV_fnc_changeVeh;};
	//Burne's M1A2 woodland
	case 4: {[ADV_veh_tanks,["Burnes_M1A2_MEU_01_Public"]] spawn ADV_fnc_changeVeh;};
	//stv retextures
	case 5: {[ADV_veh_tanks,["Steve_MBT_Kuma"]] spawn ADV_fnc_changeVeh;};
	//RHS desert
	case 6: {[ADV_veh_tanks,["rhsusf_m1a1fep_d","rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy"]] spawn ADV_fnc_changeVeh;[ADV_veh_artys,["rhsusf_m109d_usarmy"]] spawn ADV_fnc_changeVeh;};
	case 8: {[ADV_veh_tanks,["rhsusf_m1a1fep_d","rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy"]] spawn ADV_fnc_changeVeh;[ADV_veh_artys,["RDS_M119_FIA"]] spawn ADV_fnc_changeVeh;};
	//RHS woodland
	case 7: {[ADV_veh_tanks,["rhsusf_m1a1fep_wd","rhsusf_m1a1fep_od","rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy"]] spawn ADV_fnc_changeVeh;[ADV_veh_artys,["rhsusf_m109_usarmy"]] spawn ADV_fnc_changeVeh;};
	case 9: {[ADV_veh_tanks,["rhsusf_m1a1fep_wd","rhsusf_m1a1fep_od","rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy"]] spawn ADV_fnc_changeVeh;[ADV_veh_artys,["RDS_M119_FIA"]] spawn ADV_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_veh_tanks+ADV_veh_artys,[""]] spawn ADV_fnc_changeVeh;};
	default {};
};

//replaces helis with mod helis:
switch (ADV_par_modHeliAssets) do {
	//BAFHelis
	case 1: {[ADV_veh_airTransport,["UK3CB_BAF_Wildcat_Transport_RN_ZZ396"]] spawn ADV_fnc_changeVeh;[ADV_veh_airRecon,["UK3CB_BAF_Wildcat_Armed_Army_ZZ400"]] spawn ADV_fnc_changeVeh;[ADV_veh_airLogistic,["UK3CB_BAF_Merlin_RAF_ZJ124"]] spawn ADV_fnc_changeVeh;};
	//BWHelis
	case 2: {[ADV_veh_airTransport,["BW_NH90Armed","BW_NH90Armed","BW_NH90Armed","BW_NH90","EC635_Unarmed_BW","EC635_BW"]] spawn ADV_fnc_changeVeh;[ADV_veh_airRecon,["EC635_Unarmed_BW","EC635_BW"]] spawn ADV_fnc_changeVeh;[ADV_veh_airLogistic,["CUP_B_CH53E_BW"]] spawn ADV_fnc_changeVeh;};
	//RHS Army
	case 3: {[ADV_veh_airTransport,["RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_MEV_d"]] spawn ADV_fnc_changeVeh;[ADV_veh_airRecon,["rhs_ah64d","rhs_ah64d_cs"]] spawn ADV_fnc_changeVeh;[ADV_veh_airLogistic,["RHS_CH_47F","RHS_CH_47F","RHS_CH_47F","RHS_CH_47F_LIGHT"]] spawn ADV_fnc_changeVeh;};
	//RHS Marines
	case 4: {[ADV_veh_airTransport,["rhs_uh1y"]] spawn ADV_fnc_changeVeh;[ADV_veh_airRecon,["rhs_ah1z"]] spawn ADV_fnc_changeVeh;[ADV_veh_airLogistic,["rhsusf_CH53E_USMC"]] spawn ADV_fnc_changeVeh;};
	//RHS Army with MELB
	case 5: {[ADV_veh_airTransport,["RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_MEV_d"]] spawn ADV_fnc_changeVeh;[ADV_veh_airRecon,["MELB_AH6M_M","MELB_MH6M"]] spawn ADV_fnc_changeVeh;[ADV_veh_airLogistic,["RHS_CH_47F","RHS_CH_47F","RHS_CH_47F","RHS_CH_47F_LIGHT"]] spawn ADV_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_veh_helis,[""]] spawn ADV_fnc_changeVeh;};
	default {};
};

//replaces planes with mod planes:
switch (ADV_par_modAirAssets) do {
	//FA18E
	case 1: {[ADV_veh_airCAS,["JS_JC_FA18E"]] spawn ADV_fnc_changeVeh;};
	//FA18F
	case 2: {[ADV_veh_airCAS,["JS_JC_FA18F"]] spawn ADV_fnc_changeVeh;};
	//AV8B Hawker Harrier
	case 3: {[ADV_veh_airCAS,["Cha_AV8B_CAP","Cha_AV8B_GBU12","Cha_AV8B_MK82"]] spawn ADV_fnc_changeVeh;};
	//RHS A-10
	case 4: {[ADV_veh_airCAS,["RHS_A10"]] spawn ADV_fnc_changeVeh;};
	//RHS F-22A
	case 5: {[ADV_veh_airCAS,["rhsusf_f22"]] spawn ADV_fnc_changeVeh;};
	//F-14D
	case 6: {[ADV_veh_airCAS,["FIR_F14D_A88","FIR_F14D_VF101","FIR_F14D_VF103","FIR_F14D_VF32","FIR_F14D_VF84"]] spawn ADV_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_veh_fixedWing,[""]] spawn ADV_fnc_changeVeh;};
	default {};
};
if (ADV_par_modAirAssets == 4 || ADV_par_modAirAssets == 5) then {[ADV_veh_airC130,["RHS_C130J"]] spawn ADV_fnc_changeVeh;} else {[ADV_veh_airC130,[""]] spawn ADV_fnc_changeVeh;};

//removes the markers according to the lobby params
if (ADV_par_Assets_cars == 0 || ADV_par_Assets_cars == 99 || ADV_par_modCarAssets == 99) then {
	{_x setMarkerAlpha 0;} forEach _veh_lightMarkers
};
if (ADV_par_Assets_tanks == 0 || ADV_par_Assets_tanks == 99 ||ADV_par_modTankAssets == 99) then {
	{_x setMarkerAlpha 0;} forEach _veh_heavyMarkers;
};
if (ADV_par_Assets_air_helis == 0 || ADV_par_Assets_air_helis == 99 || ADV_par_modHeliAssets == 99) then {
	{_x setMarkerAlpha 0;} forEach _veh_heliMarkers;
};
if ( (ADV_par_Assets_air_fixed == 0 && ADV_par_Assets_air_helis == 0) || (ADV_par_Assets_air_fixed == 99 && ADV_par_Assets_air_helis == 99) || ADV_par_modAirAssets == 99) then {
	{_x setMarkerAlpha 0;} forEach _veh_fixedMarkers;
};

//manages disablement and load.
{
	if (str _x in ADV_veh_all) then {
		[_x] call ADV_fnc_disableVehSelector;
		[_x] call ADV_fnc_clearCargo;
		[_x] call ADV_fnc_addVehicleLoad;
		if (ADV_par_engineArtillery == 1 && str _x in ADV_veh_artys) then {
			[_x] call ADV_fnc_showArtiSetting;
		};
		[_x,ADV_par_vehicleRespawn, (typeOf _x)] spawn ADV_fnc_respawnVeh;
		if (ADV_par_TIEquipment > 0) then {
			_x disableTIEquipment true;
			if (ADV_par_TIEquipment > 2) then {
				_x disableNVGEquipment true;
			};
		};
		if ( ADV_par_Radios > 0 && (_x isKindOf "CAR" || _x isKindOf "TANK" || _x isKindOf "AIR") ) then {
			_x setVariable ["tf_hasRadio", true, true];
			//_x setVariable ["tf_side", west, true];
		};
	};
} forEach vehicles;

if (ADV_par_TIEquipment == 2 && ADV_par_TIEquipment == 4) then {
	[] spawn {
		while {true} do {
			{
				_x disableTIEquipment true;
				if (ADV_par_TIEquipment == 4) then {
					_x disableNVGEquipment true;
				};
			} forEach vehicles;
			sleep 10;			
		};
	};
};

if (true) exitWith { missionNamespace setVariable ["ADV_var_manageVeh",true,true]; };
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
ADV_veh_airTransport = [];
ADV_veh_airRecon = [];
ADV_veh_airLogistic = [];

ADV_veh_airCAS = [];
ADV_veh_airC130 = [];

ADV_veh_MRAPs = [];
ADV_veh_MRAPsHMG = [];
ADV_veh_MRAPsGMG = [];
ADV_veh_transport = [];
ADV_veh_logistic_fuel = [];
ADV_veh_logistic_ammo = [];
ADV_veh_logistic_repair = [];
ADV_veh_logistic_medic = [];
ADV_veh_ATVs = [];
ADV_veh_UAVs = [];
ADV_veh_UGVs = [];
ADV_veh_UGVs_repair = [];

ADV_veh_heavys = [];
ADV_veh_tanks = [];
ADV_veh_artys = [];

{
	_vehicleName = str _x;
	switch ( true ) do {
		//helicopters
		case ( [_vehicleName,0,12] call BIS_fnc_trimString == "air_transport" ): { ADV_veh_airTransport pushBack _vehicleName; };
		case ( [_vehicleName,0,8] call BIS_fnc_trimString == "air_recon" ): { ADV_veh_airRecon pushBack _vehicleName; };
		case ( [_vehicleName,0,11] call BIS_fnc_trimString == "air_logistic" ): { ADV_veh_airLogistic pushBack _vehicleName; };
		//fixed wing planes
		case ( [_vehicleName,0,7] call BIS_fnc_trimString == "air_a164" ): { ADV_veh_airCAS pushBack _vehicleName; };
		case ( [_vehicleName,0,6] call BIS_fnc_trimString == "air_cas" ): { ADV_veh_airCAS pushBack _vehicleName; };
		case ( [_vehicleName,0,7] call BIS_fnc_trimString == "air_c130" ): { ADV_veh_airC130 pushBack _vehicleName; };
		//MRAPs
		case ( [_vehicleName,0,7] call BIS_fnc_trimString == "MRAP_hmg" ): { ADV_veh_MRAPsHMG pushBack _vehicleName; };
		case ( [_vehicleName,0,7] call BIS_fnc_trimString == "MRAP_gmg" ): { ADV_veh_MRAPsGMG pushBack _vehicleName; };
		case ( [_vehicleName,0,3] call BIS_fnc_trimString == "MRAP" ): { ADV_veh_MRAPs pushBack _vehicleName; };
		//logistics
		case ( [_vehicleName,0,2] call BIS_fnc_trimString == "uav" ): { ADV_veh_UAVs pushBack _vehicleName; };
		case ( [_vehicleName,0,2] call BIS_fnc_trimString == "ugv" ): { ADV_veh_UGVs pushBack _vehicleName; };
		case ( [_vehicleName,0,9] call BIS_fnc_trimString == "ugv_repair" ): { ADV_veh_UGVs_repair pushBack _vehicleName; };
		case ( [_vehicleName,0,2] call BIS_fnc_trimString == "ATV" ): { ADV_veh_ATVs pushBack _vehicleName; };
		case ( [_vehicleName,0,8] call BIS_fnc_trimString == "transport" ): { ADV_veh_transport pushBack _vehicleName; };
		case ( [_vehicleName,0,12] call BIS_fnc_trimString == "logistic_fuel" ): { ADV_veh_logistic_fuel pushBack _vehicleName; };
		case ( [_vehicleName,0,12] call BIS_fnc_trimString == "logistic_ammo" ): { ADV_veh_logistic_ammo pushBack _vehicleName; };
		case ( [_vehicleName,0,14] call BIS_fnc_trimString == "logistic_repair" ): { ADV_veh_logistic_repair pushBack _vehicleName; };
		case ( [_vehicleName,0,13] call BIS_fnc_trimString == "logistic_medic" ): { ADV_veh_logistic_medic pushBack _vehicleName; };
		//armored
		case ( [_vehicleName,0,4] call BIS_fnc_trimString == "heavy" ): { ADV_veh_heavys pushBack _vehicleName; };
		case ( [_vehicleName,0,3] call BIS_fnc_trimString == "tank" ): { ADV_veh_tanks pushBack _vehicleName; };
		case ( [_vehicleName,0,3] call BIS_fnc_trimString == "arty" ): { ADV_veh_artys pushBack _vehicleName; };
		default {};
	};
} forEach vehicles;

ADV_veh_helis = ADV_veh_airLogistic+ADV_veh_airTransport+ADV_veh_airRecon;
ADV_veh_fixedWing = ADV_veh_airCAS+ADV_veh_airC130+ADV_veh_UAVs;
ADV_veh_air = ADV_veh_helis+ADV_veh_fixedWing;
ADV_veh_armored = ADV_veh_heavys+ADV_veh_tanks+ADV_veh_artys;
ADV_veh_car = ADV_veh_MRAPS+ADV_veh_MRAPsHMG+ADV_veh_MRAPsGMG;
ADV_veh_light = ADV_veh_ATVs+ADV_veh_UGVs+ADV_veh_UGVs_repair+ADV_veh_car+ADV_veh_transport+ADV_veh_logistic_fuel+ADV_veh_logistic_ammo+ADV_veh_logistic_repair+ADV_veh_logistic_medic;

ADV_veh_all = ADV_veh_light+ADV_veh_armored+ADV_veh_air;

///// No editing necessary below this line /////

//replaces MRAPS with mod cars:
switch (ADV_par_modCarAssets) do {
	//Bundeswehr sand
	case 1: {[ADV_veh_MRAPs,["Fennek_Tropen","Fennek_Tropen","Fennek_Tropen","Fennek_Tropen_san"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["BW_Dingo_Des"],west] spawn ADV_fnc_changeVeh;};
	//Bundeswehr woodland
	case 2: {[ADV_veh_MRAPs,["Fennek_Flecktarn","Fennek_Flecktarn","Fennek_Flecktarn","Fennek_Flecktarn_san"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["BW_Dingo_Wdl"],west] spawn ADV_fnc_changeVeh;};
	//BAF sand
	case 3: {[ADV_veh_MRAPs,["BAF_Offroad_D"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["UK3CB_BAF_Jackal2_L2A1_D","UK3CB_BAF_Coyote_Passenger_L111A1_D"],west] spawn ADV_fnc_changeVeh;};
	//BAF woodland
	case 4: {[ADV_veh_MRAPs,["BAF_Offroad_W"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["UK3CB_BAF_Jackal2_L2A1_W","UK3CB_BAF_Coyote_Passenger_L111A1_W"],west] spawn ADV_fnc_changeVeh;};
	//RHS ARMY desert
	case 5: {[ADV_veh_MRAPs,["rhsusf_m1025_d","rhsusf_m1025_d","rhsusf_m998_d_4dr"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["rhsusf_m1025_d_m2"],west] spawn ADV_fnc_changeVeh;};
	//RHS ARMY woodland
	case 6: {[ADV_veh_MRAPs,["rhsusf_m1025_w","rhsusf_m1025_w","rhsusf_m998_w_4dr"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["rhsusf_m1025_w_m2"],west] spawn ADV_fnc_changeVeh;};
	//RHS ARMY plain green
	case 7: {[ADV_veh_MRAPs,["rhsusf_m1025_w","rhsusf_m1025_w","rhsusf_m998_w_4dr"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["rhsusf_m1025_w_m2"],west] spawn ADV_fnc_changeVeh;};
	//RHS Marines desert
	case 8: {[ADV_veh_MRAPs,["rhsusf_m1025_d_s","rhsusf_m1025_d_s","rhsusf_m998_d_s_4dr"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["rhsusf_m1025_d_s_m2"],west] spawn ADV_fnc_changeVeh;};
	//RHS Marines woodland
	case 9: {[ADV_veh_MRAPs,["rhsusf_m1025_w_s","rhsusf_m1025_w_s","rhsusf_m998_w_s_4dr"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["rhsusf_m1025_w_s_m2"],west] spawn ADV_fnc_changeVeh;};
	//adv_retex Fenneks
	case 10: {[ADV_veh_MRAPs,["adv_retex_b_strider_f"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["adv_retex_b_strider_hmg_f"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsGMG,["adv_retex_b_strider_gmg_f"],west] spawn ADV_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_veh_MRAPs+ADV_veh_MRAPsHMG+ADV_veh_MRAPsGMG+ADV_veh_ATVs,[""],west] spawn ADV_fnc_changeVeh;};
	default {};
};

//replaces trucks with mod trucks:
switch (ADV_par_modTruckAssets) do {
	//DAR MTVR
	case 1: {[ADV_veh_transport,["DAR_MK27","DAR_MK27T"],west] spawn ADV_fnc_changeVeh;[ADV_veh_logistic_fuel,["DAR_LHS_8"],west] spawn ADV_fnc_changeVeh;[ADV_veh_logistic_repair+ADV_veh_logistic_ammo,["DAR_LHS_16"],west] spawn ADV_fnc_changeVeh;[ADV_veh_logistic_medic,["DAR_MK23"],west] spawn ADV_fnc_changeVeh;};
	//RHS sand
	case 2: {[ADV_veh_transport,["rhsusf_M1083A1P2_d_fmtv_usarmy","rhsusf_M1083A1P2_B_d_fmtv_usarmy"],west] spawn ADV_fnc_changeVeh;
		[ADV_veh_logistic_repair,["rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_d","rhsusf_M977A4_REPAIR_BKIT_usarmy_d"],west] spawn ADV_fnc_changeVeh;
		[ADV_veh_logistic_ammo,["rhsusf_M977A4_AMMO_BKIT_M2_usarmy_d","rhsusf_M977A4_AMMO_BKIT_usarmy_d"],west] spawn ADV_fnc_changeVeh;
	};
	//RHS woodland
	case 3: {[ADV_veh_transport,["rhsusf_M1083A1P2_wd_fmtv_usarmy","rhsusf_M1083A1P2_B_wd_fmtv_usarmy"],west] spawn ADV_fnc_changeVeh;
		[ADV_veh_logistic_repair,["rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_wd","rhsusf_M977A4_REPAIR_BKIT_usarmy_wd"],west] spawn ADV_fnc_changeVeh;
		[ADV_veh_logistic_ammo,["rhsusf_M977A4_AMMO_BKIT_M2_usarmy_wd","rhsusf_M977A4_AMMO_BKIT_usarmy_wd"],west] spawn ADV_fnc_changeVeh;
	};
	//BAF desert
	case 4: {[ADV_veh_transport,["UK3CB_BAF_Coyote_Logistics_L111A1_D"],west] spawn ADV_fnc_changeVeh;};
	//BAF woodland
	case 5: {[ADV_veh_transport,["UK3CB_BAF_Coyote_Logistics_L111A1_W"],west] spawn ADV_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_veh_transport+ADV_veh_logistic_fuel+ADV_veh_logistic_medic+ADV_veh_logistic_repair+ADV_veh_logistic_ammo,[""],west] spawn ADV_fnc_changeVeh;};
	default {};
};

//replaces heavy vehicles with mod vehicles:
switch (ADV_par_modHeavyAssets) do {
	//BWmod Puma sand
	case 1: {[ADV_veh_heavys,["BWA3_Puma_Tropen"],west] spawn ADV_fnc_changeVeh;};
	//BWmod Puma woodland
	case 2: {[ADV_veh_heavys,["BWA3_Puma_Fleck"],west] spawn ADV_fnc_changeVeh;};
	//Stryker Pack sand
	case 3: {[ADV_veh_heavys,["M1126_ICV_M134_DG1_NOSLATDES","M1126_ICV_M134_DG1_SLATDES","M1126_ICV_M2_DG1_NOSLATDES","M1126_ICV_M2NEST_DG1_NOSLATDES","M1130_CV_DG1_NOSLATDES","M1130_CV_DG1_SLATDES","M1133_MEV_DG1_SLATDES"],west] spawn ADV_fnc_changeVeh;};
	//Stryker Pack woodland
	case 4: {[ADV_veh_heavys,["M1126_ICV_M134_DG1_NOSLATWOOD","M1126_ICV_M134_DG1_SLATWOOD","M1126_ICV_M2_DG1_NOSLATWOOD","M1126_ICV_M2NEST_DG1_NOSLATWOOD","M1130_CV_DG1_NOSLATWOOD","M1130_CV_DG1_SLATWOOD","M1133_MEV_DG1_SLATWOOD"],west] spawn ADV_fnc_changeVeh;};
	//DAR MaxxPro MRAP
	case 5: {[ADV_veh_heavys,["DAR_MaxxProDeploy","DAR_MaxxProDeploy","DAR_MaxxPro","DAR_MaxxProDXM","DAR_MaxxProPlus"],west] spawn ADV_fnc_changeVeh;};
	//stv warrior
	case 6: {
		if (isClass(configFile >> "CfgPatches" >> "adv_retex")) then {
			[ADV_veh_heavys,["adv_retex_b_mora_f"],west] spawn ADV_fnc_changeVeh;
		} else {	
			[ADV_veh_heavys,["Steve_IFV_Warrior"],west] spawn ADV_fnc_changeVeh;
		};
	};
	//stv marid
	case 7: {
		if (isClass(configFile >> "CfgPatches" >> "adv_retex")) then {
			[ADV_veh_heavys,["adv_retex_b_marid_f"],west] spawn ADV_fnc_changeVeh;
		} else {
			[ADV_veh_heavys,["Steve_IFV_Marid"],west] spawn ADV_fnc_changeVeh;
		};
	};
	//RHS M2 desert
	case 8: {[ADV_veh_heavys,["RHS_M2A2","RHS_M2A2_BUSKI","RHS_M2A3_BUSKIII"],west] spawn ADV_fnc_changeVeh; [ADV_veh_logistic_medic,["rhsusf_m113d_usarmy_medical"],west] spawn ADV_fnc_changeVeh;
		if !(ADV_par_modTruckAssets == 2) then {
			[ADV_veh_logistic_ammo,["rhsusf_m113d_usarmy_supply"],west] spawn ADV_fnc_changeVeh;
		};
	};
	//RHS M2 woodland
	case 9: {[ADV_veh_heavys,["RHS_M2A2_wd","RHS_M2A2_BUSKI_WD","RHS_M2A3_BUSKIII_wd"],west] spawn ADV_fnc_changeVeh; [ADV_veh_logistic_medic,["rhsusf_m113_usarmy_medical"],west] spawn ADV_fnc_changeVeh;
		if !(ADV_par_modTruckAssets == 3) then {
			[ADV_veh_logistic_ammo,["rhsusf_m113_usarmy_supply"],west] spawn ADV_fnc_changeVeh;
		};	
	};
	//RHS MRAP desert
	case 10: {[ADV_veh_heavys,["rhsusf_rg33_d","rhsusf_rg33_m2_d","rhsusf_rg33_m2_d"],west] spawn ADV_fnc_changeVeh; [ADV_veh_logistic_medic,["rhsusf_m113_usarmy_medical"],west] spawn ADV_fnc_changeVeh;};
	//RHS MRAP woodland
	case 11: {[ADV_veh_heavys,["rhsusf_rg33_wd","rhsusf_rg33_m2_wd","rhsusf_rg33_m2_wd"],west] spawn ADV_fnc_changeVeh; [ADV_veh_logistic_medic,["rhsusf_m113d_usarmy_medical"],west] spawn ADV_fnc_changeVeh;};
	//CHA LAVs desert
	case 12: {[ADV_veh_heavys,["Cha_Des1_LAV25","Cha_Des1_LAV25A2","Cha_Des1_LAV25A2"],west] spawn ADV_fnc_changeVeh;};
	//CHA LAVs woodland
	case 13: {[ADV_veh_heavys,["Cha_LAV25","Cha_LAV25A2","Cha_LAV25A2"],west] spawn ADV_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_veh_heavys,[""],west] spawn ADV_fnc_changeVeh;};
	default {};
};

//replaces tanks with mod tanks:
switch (ADV_par_modTankAssets) do {
	//BWmod Leopard sand
	case 1: {[ADV_veh_tanks,["BWA3_Leopard2A6M_Tropen"],west] spawn ADV_fnc_changeVeh;};
	//BWmod Leopard woodland
	case 2: {[ADV_veh_tanks,["BWA3_Leopard2A6M_Fleck"],west] spawn ADV_fnc_changeVeh;};
	//stv retextures
	case 3: {[ADV_veh_tanks,["Steve_MBT_Kuma"],west] spawn ADV_fnc_changeVeh;};
	//RHS desert
	case 4: {[ADV_veh_tanks,["rhsusf_m1a1fep_d","rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy"],west] spawn ADV_fnc_changeVeh;[ADV_veh_artys,["rhsusf_m109d_usarmy"],west] spawn ADV_fnc_changeVeh;};
	case 5: {[ADV_veh_tanks,["rhsusf_m1a1fep_d","rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy"],west] spawn ADV_fnc_changeVeh;[ADV_veh_artys,["RHS_M119_D"],west] spawn ADV_fnc_changeVeh;};
	//RHS woodland
	case 6: {[ADV_veh_tanks,["rhsusf_m1a1fep_wd","rhsusf_m1a1fep_od","rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy"],west] spawn ADV_fnc_changeVeh;[ADV_veh_artys,["rhsusf_m109_usarmy"],west] spawn ADV_fnc_changeVeh;};
	case 7: {[ADV_veh_tanks,["rhsusf_m1a1fep_wd","rhsusf_m1a1fep_od","rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy"],west] spawn ADV_fnc_changeVeh;[ADV_veh_artys,["RHS_M119_WD"],west] spawn ADV_fnc_changeVeh;};
	//Burne's M1A2 sand
	case 8: {[ADV_veh_tanks,["Burnes_M1A2_MEU_02_Public"],west] spawn ADV_fnc_changeVeh;};
	//Burne's M1A2 woodland
	case 9: {[ADV_veh_tanks,["Burnes_M1A2_MEU_01_Public"],west] spawn ADV_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_veh_tanks+ADV_veh_artys,[""],west] spawn ADV_fnc_changeVeh;};
	default {};
};

//replaces helis with mod helis:
switch (ADV_par_modHeliAssets) do {
	//BWHelis
	case 1: {[ADV_veh_airTransport,["BW_NH90Armed","BW_NH90Armed","BW_NH90Armed","BW_NH90","EC635_Unarmed_BW","EC635_BW"],west] spawn ADV_fnc_changeVeh;[ADV_veh_airRecon,["EC635_Unarmed_BW","EC635_BW"],west] spawn ADV_fnc_changeVeh;[ADV_veh_airLogistic,["CUP_B_CH53E_BW"],west] spawn ADV_fnc_changeVeh;};
	//BAFHelis
	case 2: {[ADV_veh_airTransport,["UK3CB_BAF_Wildcat_Transport_RN_ZZ396"],west] spawn ADV_fnc_changeVeh;[ADV_veh_airRecon,["UK3CB_BAF_Wildcat_Armed_Army_ZZ400"],west] spawn ADV_fnc_changeVeh;[ADV_veh_airLogistic,["UK3CB_BAF_Merlin_RAF_ZJ124"],west] spawn ADV_fnc_changeVeh;};
	//RHS Army
	case 3: {[ADV_veh_airTransport,["RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_MEV_d"],west] spawn ADV_fnc_changeVeh;[ADV_veh_airRecon,["rhs_ah64d","rhs_ah64d_cs"],west] spawn ADV_fnc_changeVeh;[ADV_veh_airLogistic,["RHS_CH_47F","RHS_CH_47F","RHS_CH_47F","RHS_CH_47F_LIGHT"],west] spawn ADV_fnc_changeVeh;};
	//RHS Marines
	case 4: {[ADV_veh_airTransport,["rhs_uh1y"],west] spawn ADV_fnc_changeVeh;[ADV_veh_airRecon,["rhs_ah1z"],west] spawn ADV_fnc_changeVeh;[ADV_veh_airLogistic,["rhsusf_CH53E_USMC"],west] spawn ADV_fnc_changeVeh;};
	//RHS Army with RHS OH6M
	case 5: {[ADV_veh_airTransport,["RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_MEV_d"],west] spawn ADV_fnc_changeVeh;[ADV_veh_airRecon,["RHS_MELB_AH6M_M","RHS_MELB_AH6M_L","RHS_MELB_MH6M","RHS_MELB_MH6M"],west] spawn ADV_fnc_changeVeh;[ADV_veh_airLogistic,["RHS_CH_47F","RHS_CH_47F","RHS_CH_47F","RHS_CH_47F_LIGHT"],west] spawn ADV_fnc_changeVeh;};
	//RHS Army with MELB
	case 6: {[ADV_veh_airTransport,["RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_MEV_d"],west] spawn ADV_fnc_changeVeh;[ADV_veh_airRecon,["MELB_AH6M_M","MELB_MH6M"],west] spawn ADV_fnc_changeVeh;[ADV_veh_airLogistic,["RHS_CH_47F","RHS_CH_47F","RHS_CH_47F","RHS_CH_47F_LIGHT"],west] spawn ADV_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_veh_helis,[""],west] spawn ADV_fnc_changeVeh;};
	default {};
};

//replaces planes with mod planes:
switch (ADV_par_modAirAssets) do {
	//FA18E
	case 1: {[ADV_veh_airCAS,["JS_JC_FA18E"],west] spawn ADV_fnc_changeVeh;};
	//FA18F
	case 2: {[ADV_veh_airCAS,["JS_JC_FA18F"],west] spawn ADV_fnc_changeVeh;};
	//AV8B Hawker Harrier
	case 3: {[ADV_veh_airCAS,["Cha_AV8B_CAP","Cha_AV8B_GBU12","Cha_AV8B_MK82"],west] spawn ADV_fnc_changeVeh;};
	//RHS A-10
	case 4: {[ADV_veh_airCAS,["RHS_A10"],west] spawn ADV_fnc_changeVeh;};
	//RHS F-22A
	case 5: {[ADV_veh_airCAS,["rhsusf_f22"],west] spawn ADV_fnc_changeVeh;};
	//F-14D
	case 6: {[ADV_veh_airCAS,["FIR_F14D_A88","FIR_F14D_VF101","FIR_F14D_VF103","FIR_F14D_VF32","FIR_F14D_VF84"],west] spawn ADV_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_veh_fixedWing,[""],west] spawn ADV_fnc_changeVeh;};
	default {};
};
if (ADV_par_modAirAssets == 4 || ADV_par_modAirAssets == 5) then {[ADV_veh_airC130,["RHS_C130J"],west] spawn ADV_fnc_changeVeh;} else {[ADV_veh_airC130,[""],west] spawn ADV_fnc_changeVeh;};

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
		[_x] call ADV_fnc_clearCargo;
		[_x] call ADV_fnc_addVehicleLoad;
		[_x] call ADV_fnc_disableVehSelector;
		[_x,ADV_par_vehicleRespawn, west, (typeOf _x)] spawn ADV_fnc_respawnVeh;
		if (ADV_par_engineArtillery == 1 && str _x in ADV_veh_artys) then {
			[_x] call ADV_fnc_showArtiSetting;
		};
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
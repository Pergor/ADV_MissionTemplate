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

///// No editing necessary below this line /////

{
	_vehicleName = str _x;
	switch ( true ) do {
		//MRAPs
		case ( _vehicleName select [0,8] == "MRAP_hmg" ): { ADV_veh_MRAPsHMG pushBack _vehicleName; };
		case ( _vehicleName select [0,8] == "MRAP_gmg" ): { ADV_veh_MRAPsGMG pushBack _vehicleName; };
		case ( _vehicleName select [0,4] == "MRAP" ): { ADV_veh_MRAPs pushBack _vehicleName; };
		//armored
		case ( _vehicleName select [0,5] == "heavy" ): { ADV_veh_heavys pushBack _vehicleName; };
		case ( _vehicleName select [0,4] == "tank" ): { ADV_veh_tanks pushBack _vehicleName; };
		case ( _vehicleName select [0,4] == "arty" ): { ADV_veh_artys pushBack _vehicleName; };
		//logistics
		case ( _vehicleName select [0,9] == "transport" ): { ADV_veh_transport pushBack _vehicleName; };
		case ( _vehicleName select [0,13] == "logistic_fuel" ): { ADV_veh_logistic_fuel pushBack _vehicleName; };
		case ( _vehicleName select [0,13] == "logistic_ammo" ): { ADV_veh_logistic_ammo pushBack _vehicleName; };
		case ( _vehicleName select [0,15] == "logistic_repair" ): { ADV_veh_logistic_repair pushBack _vehicleName; };
		case ( _vehicleName select [0,14] == "logistic_medic" ): { ADV_veh_logistic_medic pushBack _vehicleName; };
		case ( _vehicleName select [0,3] == "ATV" ): { ADV_veh_ATVs pushBack _vehicleName; };
		case ( _vehicleName select [0,3] == "uav" ): { ADV_veh_UAVs pushBack _vehicleName; };
		case ( _vehicleName select [0,3] == "ugv" ): { ADV_veh_UGVs pushBack _vehicleName; };
		case ( _vehicleName select [0,10] == "ugv_repair" ): { ADV_veh_UGVs_repair pushBack _vehicleName; };
		//helicopters
		case ( _vehicleName select [0,13] == "air_transport" ): { ADV_veh_airTransport pushBack _vehicleName; };
		case ( _vehicleName select [0,9] == "air_recon" ): { ADV_veh_airRecon pushBack _vehicleName; };
		case ( _vehicleName select [0,12] == "air_logistic" ): { ADV_veh_airLogistic pushBack _vehicleName; };
		//fixed wing planes
		case ( _vehicleName select [0,8] == "air_a164" ): { ADV_veh_airCAS pushBack _vehicleName; };
		case ( _vehicleName select [0,7] == "air_cas" ): { ADV_veh_airCAS pushBack _vehicleName; };
		case ( _vehicleName select [0,8] == "air_c130" ): { ADV_veh_airC130 pushBack _vehicleName; };
		default {};
	};
	nil;
} count vehicles;

ADV_veh_helis = ADV_veh_airLogistic+ADV_veh_airTransport+ADV_veh_airRecon;
ADV_veh_fixedWing = ADV_veh_airCAS+ADV_veh_airC130+ADV_veh_UAVs;
ADV_veh_air = ADV_veh_helis+ADV_veh_fixedWing;
ADV_veh_armored = ADV_veh_heavys+ADV_veh_tanks+ADV_veh_artys;
ADV_veh_car = ADV_veh_MRAPS+ADV_veh_MRAPsHMG+ADV_veh_MRAPsGMG;
ADV_veh_light = ADV_veh_ATVs+ADV_veh_UGVs+ADV_veh_UGVs_repair+ADV_veh_car+ADV_veh_transport+ADV_veh_logistic_fuel+ADV_veh_logistic_ammo+ADV_veh_logistic_repair+ADV_veh_logistic_medic;

ADV_veh_all = ADV_veh_light+ADV_veh_armored+ADV_veh_air;

//removes the markers according to the lobby params
if (ADV_par_Assets_cars == 0 || ADV_par_Assets_cars == 99 || ADV_par_modCarAssets == 99) then {
	{_x setMarkerAlpha 0;} count _veh_lightMarkers
};
if (ADV_par_Assets_tanks == 0 || ADV_par_Assets_tanks == 99 ||ADV_par_modTankAssets == 99) then {
	{_x setMarkerAlpha 0;} count _veh_heavyMarkers;
};
if (ADV_par_Assets_air_helis == 0 || ADV_par_Assets_air_helis == 99 || ADV_par_modHeliAssets == 99) then {
	{_x setMarkerAlpha 0;} count _veh_heliMarkers;
};
if ( (ADV_par_Assets_air_fixed == 0 && ADV_par_Assets_air_helis == 0) || (ADV_par_Assets_air_fixed == 99 && ADV_par_Assets_air_helis == 99) || ADV_par_modAirAssets == 99) then {
	{_x setMarkerAlpha 0;} count _veh_fixedMarkers;
};

//creation of vehicle code:
adv_manageVeh_codeForAll = {
	_veh = _this;
	[_veh] call ADV_fnc_clearCargo;
	[_veh] call ADV_fnc_addVehicleLoad;
	[_veh] call ADV_fnc_disableVehSelector;
	if (ADV_par_engineArtillery == 1 && str _veh in ADV_veh_artys) then {
		[_veh] call ADV_fnc_showArtiSetting;
	};
	if (ADV_par_TIEquipment > 0) then {
		_veh disableTIEquipment true;
		if (ADV_par_TIEquipment > 2) then {
			_veh disableNVGEquipment true;
		};
	};
	if ( ADV_par_Radios > 0 && (_veh isKindOf 'CAR' || _veh isKindOf 'TANK' || _veh isKindOf 'AIR') ) then {
		_veh setVariable ['tf_hasRadio', true, true];
	};
	if (isClass(configFile >> 'CfgPatches' >> 'rhsusf_main')) then {
		[_veh] call ADV_fnc_rhsDecals;
	};
	if ( (toUpper worldname) in ADV_var_lushMaps ) then {
		if (_veh isKindOf 'B_LSV_01_unarmed_F' || _veh isKindof 'B_T_LSV_01_armed_F') then {
			[_veh,'OLIVE',nil] call BIS_fnc_initVehicle;
		};
	};
};

//application of code:
{
	if (isNil _x) exitWith {};
	private _vehObj = missionNamespace getVariable [_x,objNull];
	_vehObj spawn adv_manageVeh_codeForAll;
	[_vehObj,ADV_par_vehicleRespawn, west, (typeOf _vehObj)] spawn ADV_fnc_respawnVeh;
	nil;
} count ADV_veh_all;

if (ADV_par_TIEquipment == 2 || ADV_par_TIEquipment == 4) then {
	[] spawn ADV_fnc_disableTI;
};

//replaces MRAPS with mod cars:
switch (ADV_par_modCarAssets) do {
	//Bundeswehr
	case 1: {
		[] call {
			if ((toUpper worldname) in ADV_var_aridMaps) exitWith {
				[ADV_veh_MRAPs,["Fennek_Tropen","Fennek_Tropen","Fennek_Tropen","Fennek_Tropen_san"],west] spawn ADV_fnc_changeVeh;
				[ADV_veh_MRAPsHMG,["CUP_B_Dingo_Ger_Des"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsGMG,["CUP_B_Dingo_GL_Ger_Des"],west] spawn ADV_fnc_changeVeh;
			};
			[ADV_veh_MRAPs,["Fennek_Flecktarn","Fennek_Flecktarn","Fennek_Flecktarn","Fennek_Flecktarn_san"],west] spawn ADV_fnc_changeVeh;
			[ADV_veh_MRAPsHMG,["CUP_B_Dingo_Ger_Wdl"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsGMG,["CUP_B_Dingo_GL_Ger_Wdl"],west] spawn ADV_fnc_changeVeh;
		};
		//[ADV_veh_MRAPsHMG,["BW_Dingo_Des"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsGMG,["BW_Dingo_GL_Des"],west] spawn ADV_fnc_changeVeh;
	};
	//Bundeswehr woodland
	case 2: {
		//[ADV_veh_MRAPsHMG,["BW_Dingo_Wdl"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsGMG,["BW_Dingo_GL_Wdl"],west] spawn ADV_fnc_changeVeh;
	};
	//CUP BAF
	case 3: {
		[] call {
			if ((toUpper worldname) in ADV_var_aridMaps) exitWith {
				[ADV_veh_MRAPs,["CUP_B_LR_Transport_GB_D"],west] spawn ADV_fnc_changeVeh;
				[ADV_veh_MRAPsHMG,["CUP_B_LR_Special_M2_GB_D","CUP_B_Jackal2_L2A1_GB_D","CUP_B_BAF_Coyote_L2A1_D","CUP_B_Ridgback_LMG_GB_D"],west] spawn ADV_fnc_changeVeh;
			};
			[ADV_veh_MRAPs,["CUP_B_LR_Transport_GB_W"],west] spawn ADV_fnc_changeVeh;
			[ADV_veh_MRAPsHMG,["CUP_B_LR_Special_M2_GB_W","CUP_B_LR_MG_GB_W","CUP_B_Jackal2_L2A1_GB_W","CUP_B_BAF_Coyote_L2A1_W","CUP_B_Ridgback_LMG_GB_W"],west] spawn ADV_fnc_changeVeh;
		};
		//[ADV_veh_MRAPs,["BAF_Offroad_D"],west] spawn ADV_fnc_changeVeh;
		//[ADV_veh_MRAPsHMG,["UK3CB_BAF_Jackal2_L2A1_D","UK3CB_BAF_Coyote_Passenger_L111A1_D"],west] spawn ADV_fnc_changeVeh;
	};
	//BAF woodland
	case 4: {};
	//RHS ARMY desert
	case 5: {
		[] call {
			if ((toUpper worldname) in ADV_var_aridMaps) exitWith {
				[ADV_veh_MRAPs,["rhsusf_m1025_d","rhsusf_m1025_d","rhsusf_m998_d_4dr"],west] spawn ADV_fnc_changeVeh;
				[ADV_veh_MRAPsHMG,["rhsusf_m1025_d_m2"],west] spawn ADV_fnc_changeVeh;
			};
			[ADV_veh_MRAPs,["rhsusf_m1025_w","rhsusf_m1025_w","rhsusf_m998_w_4dr"],west] spawn ADV_fnc_changeVeh;
			[ADV_veh_MRAPsHMG,["rhsusf_m1025_w_m2"],west] spawn ADV_fnc_changeVeh;
		};
	};
	//RHS ARMY woodland
	case 6: {};
	//RHS ARMY plain green
	case 7: {
		[ADV_veh_MRAPs,["rhsusf_m1025_w","rhsusf_m1025_w","rhsusf_m998_w_4dr"],west] spawn ADV_fnc_changeVeh;
		[ADV_veh_MRAPsHMG,["rhsusf_m1025_w_m2"],west] spawn ADV_fnc_changeVeh;
	};
	//RHS Marines
	case 8: {
		[] call {
			if ((toUpper worldname) in ADV_var_aridMaps) exitWith {
				[ADV_veh_MRAPs,["rhsusf_m1025_d_s","rhsusf_m1025_d_s","rhsusf_m998_d_s_4dr"],west] spawn ADV_fnc_changeVeh;
				[ADV_veh_MRAPsHMG,["rhsusf_m1025_d_s_m2"],west] spawn ADV_fnc_changeVeh;
			};
			[ADV_veh_MRAPs,["rhsusf_m1025_w_s","rhsusf_m1025_w_s","rhsusf_m998_w_s_4dr"],west] spawn ADV_fnc_changeVeh;
			[ADV_veh_MRAPsHMG,["rhsusf_m1025_w_s_m2"],west] spawn ADV_fnc_changeVeh;
		};
		if (isClass(configFile >> "CfgPatches" >> "cup_wheeledvehicles_m1030")) then {
			[ADV_veh_ATVs,["CUP_B_M1030"],west] spawn ADV_fnc_changeVeh;
		};
	};
	//RHS Marines woodland
	case 9: {};
	//adv_retex Fenneks
	case 10: {[ADV_veh_MRAPs,["adv_retex_b_strider_f"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG,["adv_retex_b_strider_hmg_f"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsGMG,["adv_retex_b_strider_gmg_f"],west] spawn ADV_fnc_changeVeh;};
	//Apex Prowler
	case 11: {[ADV_veh_MRAPs,["B_LSV_01_unarmed_F"],west] spawn ADV_fnc_changeVeh;[ADV_veh_MRAPsHMG+ADV_veh_MRAPsGMG,["B_T_LSV_01_armed_F"],west] spawn ADV_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_veh_MRAPs+ADV_veh_MRAPsHMG+ADV_veh_MRAPsGMG+ADV_veh_ATVs,[""],west] spawn ADV_fnc_changeVeh;};
	default {};
};

//replaces trucks with mod trucks:
switch (ADV_par_modTruckAssets) do {
	//DAR MTVR
	case 1: {
		[ADV_veh_transport,["DAR_MK27","DAR_MK27T"],west] spawn ADV_fnc_changeVeh;
		[ADV_veh_logistic_fuel,["DAR_LHS_8"],west] spawn ADV_fnc_changeVeh;
		[ADV_veh_logistic_repair+ADV_veh_logistic_ammo,["DAR_LHS_16"],west] spawn ADV_fnc_changeVeh;
		[ADV_veh_logistic_medic,["DAR_MK23"],west] spawn ADV_fnc_changeVeh;
	};
	//CUP MTVR
	case 6: {
		[] call {
			if ((toUpper worldname) in ADV_var_aridMaps) exitWith {
				[ADV_veh_transport,["CUP_B_MTVR_USA"],west] spawn ADV_fnc_changeVeh;
				[ADV_veh_logistic_fuel,["CUP_B_MTVR_Refuel_USA"],west] spawn ADV_fnc_changeVeh;
				[ADV_veh_logistic_repair,["CUP_B_MTVR_Repair_USA"],west] spawn ADV_fnc_changeVeh;
				[ADV_veh_logistic_ammo,["CUP_B_MTVR_Ammo_USA"],west] spawn ADV_fnc_changeVeh;
				[ADV_veh_logistic_medic,["CUP_B_HMMWV_Ambulance_USA"],west] spawn ADV_fnc_changeVeh;
			};
			[ADV_veh_transport,["CUP_B_MTVR_USMC"],west] spawn ADV_fnc_changeVeh;
			[ADV_veh_logistic_fuel,["CUP_B_MTVR_Refuel_USMC"],west] spawn ADV_fnc_changeVeh;
			[ADV_veh_logistic_repair,["CUP_B_MTVR_Repair_USMC"],west] spawn ADV_fnc_changeVeh;
			[ADV_veh_logistic_ammo,["CUP_B_MTVR_Ammo_USMC"],west] spawn ADV_fnc_changeVeh;
			[ADV_veh_logistic_medic,["CUP_B_HMMWV_Ambulance_USMC"],west] spawn ADV_fnc_changeVeh;
		};
	};
	//RHS Army
	case 2: {
		[] call {
			if ((toUpper worldname) in ADV_var_aridMaps) exitWith {
				[ADV_veh_transport,["rhsusf_M1083A1P2_d_fmtv_usarmy","rhsusf_M1083A1P2_B_d_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy"],west] spawn ADV_fnc_changeVeh;
				[ADV_veh_logistic_repair,["rhsusf_M977A4_REPAIR_usarmy_d","rhsusf_M977A4_REPAIR_BKIT_usarmy_d","rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_d"],west] spawn ADV_fnc_changeVeh;
				[ADV_veh_logistic_ammo,["rhsusf_M977A4_AMMO_usarmy_d","rhsusf_M977A4_AMMO_BKIT_usarmy_d","rhsusf_M977A4_AMMO_BKIT_M2_usarmy_d"],west] spawn ADV_fnc_changeVeh;
				[ADV_veh_logistic_fuel,["rhsusf_M978A4_usarmy_d","rhsusf_M978A4_BKIT_usarmy_d"],west] spawn ADV_fnc_changeVeh;
			};
			[ADV_veh_transport,["rhsusf_M1083A1P2_wd_fmtv_usarmy","rhsusf_M1083A1P2_B_wd_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_wd_fmtv_usarmy"],west] spawn ADV_fnc_changeVeh;
			[ADV_veh_logistic_repair,["rhsusf_M977A4_REPAIR_usarmy_wd","rhsusf_M977A4_REPAIR_BKIT_usarmy_wd","rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_wd"],west] spawn ADV_fnc_changeVeh;
			[ADV_veh_logistic_ammo,["rhsusf_M977A4_AMMO_usarmy_wd","rhsusf_M977A4_AMMO_BKIT_usarmy_wd","rhsusf_M977A4_AMMO_BKIT_M2_usarmy_wd"],west] spawn ADV_fnc_changeVeh;
			[ADV_veh_logistic_fuel,["rhsusf_M978A4_usarmy_wd","rhsusf_M978A4_BKIT_usarmy_wd"],west] spawn ADV_fnc_changeVeh;
		};
	};
	//RHS woodland
	case 3: {
	};
	//CUP BAF
	case 4: {
		[] call {
			if ((toUpper worldname) in ADV_var_aridMaps) exitWith {
				[ADV_veh_transport,["CUP_B_BAF_Coyote_L2A1_D"],west] spawn ADV_fnc_changeVeh;
			};
			[ADV_veh_transport,["CUP_B_BAF_Coyote_L2A1_W"],west] spawn ADV_fnc_changeVeh;
		};
		//[ADV_veh_transport,["UK3CB_BAF_Coyote_Logistics_L111A1_D"],west] spawn ADV_fnc_changeVeh;
	};
	//BAF woodland
	case 5: {
		//[ADV_veh_transport,["UK3CB_BAF_Coyote_Logistics_L111A1_W"],west] spawn ADV_fnc_changeVeh;
	};
	//no vehicles
	case 99: {[ADV_veh_transport+ADV_veh_logistic_fuel+ADV_veh_logistic_medic+ADV_veh_logistic_repair+ADV_veh_logistic_ammo,[""],west] spawn ADV_fnc_changeVeh;};
	default {};
};

//replaces heavy vehicles with mod vehicles:
switch (ADV_par_modHeavyAssets) do {
	//BWmod
	case 1: {
		[] call {
			if ((toUpper worldname) in ADV_var_aridMaps) exitWith {
				[ADV_veh_heavys,["BWA3_Puma_Tropen"],west] spawn ADV_fnc_changeVeh;
			};
			[ADV_veh_heavys,["BWA3_Puma_Fleck"],west] spawn ADV_fnc_changeVeh;
		};
	};
	//BWmod Puma woodland
	case 2: {};
	//Stryker
	case 3: {
		[] call {
			if ((toUpper worldname) in ADV_var_aridMaps) exitWith {
				[ADV_veh_heavys,["CUP_B_M1126_ICV_M2_Desert_Slat","CUP_B_M1126_ICV_M2_Desert"],west] spawn ADV_fnc_changeVeh;
				if (ADV_par_modTruckAssets isEqualTo 0) then {
					[ADV_veh_logistic_medic,["CUP_B_M1133_MEV_Desert","CUP_B_M1133_MEV_Desert_Slat"],west] spawn ADV_fnc_changeVeh;
				};
			};
			[ADV_veh_heavys,["CUP_B_M1126_ICV_M2_Woodland_Slat","CUP_B_M1126_ICV_M2_Woodland"],west] spawn ADV_fnc_changeVeh;
			if (ADV_par_modTruckAssets isEqualTo 0) then {
				[ADV_veh_logistic_medic,["CUP_B_M1133_MEV_Woodland","CUP_B_M1133_MEV_Woodland_Slat"],west] spawn ADV_fnc_changeVeh;
			};
		};
	};
	//Stryker Pack woodland
	case 4: {};
	//DAR MaxxPro MRAP
	case 5: {
		[ADV_veh_heavys,["DAR_MaxxProDeploy","DAR_MaxxProDeploy","DAR_MaxxPro","DAR_MaxxProDXM","DAR_MaxxProPlus"],west] spawn ADV_fnc_changeVeh;
	};
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
	//RHS M2A3
	case 8: {
		[] call {
			if ((toUpper worldname) in ADV_var_aridMaps) exitWith {
				[ADV_veh_heavys,["RHS_M2A2","RHS_M2A2_BUSKI","RHS_M2A3_BUSKIII"],west] spawn ADV_fnc_changeVeh;
				if (ADV_par_modTruckAssets isEqualTo 0) then {
					[ADV_veh_logistic_ammo,["rhsusf_m113d_usarmy_supply"],west] spawn ADV_fnc_changeVeh;
				};
				if (ADV_par_modTruckAssets isEqualTo 2) then {
					[ADV_veh_logistic_medic,["rhsusf_m113d_usarmy_medical"],west] spawn ADV_fnc_changeVeh;
				};
			};
			[ADV_veh_heavys,["RHS_M2A2_wd","RHS_M2A2_BUSKI_WD","RHS_M2A3_BUSKIII_wd"],west] spawn ADV_fnc_changeVeh;
			if (ADV_par_modTruckAssets isEqualTo 0) then {
				[ADV_veh_logistic_ammo,["rhsusf_m113_usarmy_supply"],west] spawn ADV_fnc_changeVeh;
			};
			if (ADV_par_modTruckAssets isEqualTo 2) then {
				[ADV_veh_logistic_medic,["rhsusf_m113_usarmy_medical"],west] spawn ADV_fnc_changeVeh;
			};
		};
	};
	//RHS M2 woodland
	case 9: {};
	//RHS RG33
	case 10: {
		[] call {
			if ((toUpper worldname) in ADV_var_aridMaps) exitWith {
				[ADV_veh_heavys,["rhsusf_rg33_d","rhsusf_rg33_m2_d","rhsusf_rg33_m2_d"],west] spawn ADV_fnc_changeVeh;
				if (ADV_par_modTruckAssets isEqualTo 2) then {
					[ADV_veh_logistic_medic,["rhsusf_m113_usarmy_medical"],west] spawn ADV_fnc_changeVeh;
				};
			};
			[ADV_veh_heavys,["rhsusf_rg33_wd","rhsusf_rg33_m2_wd","rhsusf_rg33_m2_wd"],west] spawn ADV_fnc_changeVeh;
			if (ADV_par_modTruckAssets isEqualTo 2) then {
				[ADV_veh_logistic_medic,["rhsusf_m113d_usarmy_medical"],west] spawn ADV_fnc_changeVeh;
			};
		};
	};
	//RHS MRAP woodland
	case 11: {};
	//CUP Marines
	case 12: {
		[ADV_veh_heavys,["CUP_B_LAV25_USMC","CUP_B_LAV25M240_USMC","CUP_B_AAV_USMC"],west] spawn ADV_fnc_changeVeh;
	};
	//CHA LAVs woodland
	case 13: {};
	//no vehicles
	case 99: {[ADV_veh_heavys,[""],west] spawn ADV_fnc_changeVeh;};
	default {};
};

//replaces tanks with mod tanks:
switch (ADV_par_modTankAssets) do {
	//BWmod Leopard sand
	case 1: {
		[] call {
			if ((toUpper worldname) in ADV_var_aridMaps) exitWith {
				[ADV_veh_tanks,["BWA3_Leopard2A6M_Tropen"],west] spawn ADV_fnc_changeVeh;
			};
			[ADV_veh_tanks,["BWA3_Leopard2A6M_Fleck"],west] spawn ADV_fnc_changeVeh;
		};
	};
	//BWmod Leopard woodland
	case 2: {};
	//stv retextures
	case 3: {[ADV_veh_tanks,["Steve_MBT_Kuma"],west] spawn ADV_fnc_changeVeh;};
	//RHS m109
	case 4: {
		[] call {
			if ((toUpper worldname) in ADV_var_aridMaps) exitWith {
				[ADV_veh_tanks,["rhsusf_m1a1fep_d","rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy"],west] spawn ADV_fnc_changeVeh;[ADV_veh_artys,["rhsusf_m109d_usarmy"],west] spawn ADV_fnc_changeVeh;
			};
			[ADV_veh_tanks,["rhsusf_m1a1fep_wd","rhsusf_m1a1fep_od","rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy"],west] spawn ADV_fnc_changeVeh;[ADV_veh_artys,["rhsusf_m109_usarmy"],west] spawn ADV_fnc_changeVeh;
		};
	};
	case 5: {};
	//RHS m119
	case 6: {
		[] call {
			if ((toUpper worldname) in ADV_var_aridMaps) exitWith {
				[ADV_veh_tanks,["rhsusf_m1a1fep_d","rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy"],west] spawn ADV_fnc_changeVeh;[ADV_veh_artys,["RHS_M119_D"],west] spawn ADV_fnc_changeVeh;
			};
			[ADV_veh_tanks,["rhsusf_m1a1fep_wd","rhsusf_m1a1fep_od","rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy"],west] spawn ADV_fnc_changeVeh;[ADV_veh_artys,["RHS_M119_WD"],west] spawn ADV_fnc_changeVeh;
		};
	};
	case 7: {};
	//Burne's M1A2 sand
	case 8: {
		[] call {
			if ((toUpper worldname) in ADV_var_aridMaps) exitWith {
				[ADV_veh_tanks,["Burnes_M1A2_MEU_02_Public"],west] spawn ADV_fnc_changeVeh;
			};
			[ADV_veh_tanks,["Burnes_M1A2_MEU_01_Public"],west] spawn ADV_fnc_changeVeh;
		};
	};
	//Burne's M1A2 woodland
	case 9: {};
	//no vehicles
	case 99: {[ADV_veh_tanks+ADV_veh_artys,[""],west] spawn ADV_fnc_changeVeh;};
	default {};
};

//replaces helis with mod helis:
switch (ADV_par_modHeliAssets) do {
	//BWHelis
	case 1: {
		//[ADV_veh_airTransport,["BW_NH90Armed","BW_NH90Armed","BW_NH90Armed","BW_NH90","EC635_Unarmed_BW","EC635_BW"],west] spawn ADV_fnc_changeVeh;
		[ADV_veh_airTransport,["BW_NH90Armed","BW_NH90Armed","BW_NH90Armed","BW_NH90","CUP_B_UH1D_GER_KSK","CUP_B_UH1D_GER_KSK"],west] spawn ADV_fnc_changeVeh;
		//[ADV_veh_airRecon,["EC635_Unarmed_BW","EC635_BW"],west] spawn ADV_fnc_changeVeh;
		[ADV_veh_airRecon,["CUP_B_UH1D_GER_KSK"],west] spawn ADV_fnc_changeVeh;
		//[ADV_veh_airLogistic,["CUP_B_CH53E_BW"],west] spawn ADV_fnc_changeVeh;
		[ADV_veh_airLogistic,["CUP_B_CH53E_GER"],west] spawn ADV_fnc_changeVeh;
	};
	//BAFHelis
	case 2: {
		[ADV_veh_airTransport,["CUP_B_Merlin_HC3A_Armed_GB","CUP_B_Merlin_HC3_Armed_GB"],west] spawn ADV_fnc_changeVeh;
		[ADV_veh_airRecon,["CUP_B_AW159_Unarmed_GB"],west] spawn ADV_fnc_changeVeh;
		[ADV_veh_airLogistic,["CUP_B_CH47F_GB"],west] spawn ADV_fnc_changeVeh;	
		//[ADV_veh_airTransport,["UK3CB_BAF_Wildcat_Transport_RN_ZZ396"],west] spawn ADV_fnc_changeVeh;
		//[ADV_veh_airRecon,["UK3CB_BAF_Wildcat_Armed_Army_ZZ400"],west] spawn ADV_fnc_changeVeh;
		//[ADV_veh_airLogistic,["UK3CB_BAF_Merlin_RAF_ZJ124"],west] spawn ADV_fnc_changeVeh;
	};
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
	case 3: {
		call {
			if !(ADV_par_customUni isEqualTo 6 || ADV_par_modHeliAssets isEqualTo 2) exitWith {
				[ADV_veh_airCAS,["CUP_B_AV8B_Mk82_USMC","CUP_B_AV8B_AGM_USMC","CUP_B_AV8B_CAP_USMC"],west] spawn ADV_fnc_changeVeh;
			};
			[ADV_veh_airCAS,["CUP_B_GR9_Mk82_GB","CUP_B_GR9_AGM_GB","CUP_B_GR9_CAP_GB"],west] spawn ADV_fnc_changeVeh;
		};
		//[ADV_veh_airCAS,["Cha_AV8B_CAP","Cha_AV8B_GBU12","Cha_AV8B_MK82"],west] spawn ADV_fnc_changeVeh;
	};
	//RHS A-10
	case 4: {[ADV_veh_airCAS,["RHS_A10"],west] spawn ADV_fnc_changeVeh;};
	//RHS F-22A
	case 5: {[ADV_veh_airCAS,["rhsusf_f22"],west] spawn ADV_fnc_changeVeh;};
	//F-14D
	case 6: {[ADV_veh_airCAS,["FIR_F14D_A88","FIR_F14D_VF101","FIR_F14D_VF103","FIR_F14D_VF32","FIR_F14D_VF84"],west] spawn ADV_fnc_changeVeh;};
	//CUP F35
	case 7: {[ADV_veh_airCAS,["CUP_B_F35B_CAS_USMC","CUP_B_F35B_LGB_USMC"],west] spawn ADV_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_veh_fixedWing,[""],west] spawn ADV_fnc_changeVeh;};
	default {};
};
call {
	if (ADV_par_modAirAssets isEqualTo 4 || ADV_par_modAirAssets isEqualTo 5) exitWith {
		[ADV_veh_airC130,["RHS_C130J"],west] spawn ADV_fnc_changeVeh;
	};
	if (ADV_par_modAirAssets isEqualTo 3 || ADV_par_modAirAssets isEqualTo 7 || ADV_par_modHeliAssets isEqualTo 2) exitWith {
		if (ADV_par_customUni isEqualTo 6 || ADV_par_modHeliAssets isEqualTo 2) exitWith {
			[ADV_veh_airC130,["CUP_B_C130J_GB"],west] spawn ADV_fnc_changeVeh;
		};
		[ADV_veh_airC130,["CUP_B_C130J_USMC"],west] spawn ADV_fnc_changeVeh;
	};
	if !(toUpper worldname == "TANOA") exitWith {
		[ADV_veh_airC130,[""],west] spawn ADV_fnc_changeVeh;
	};
};

if (true) exitWith { missionNamespace setVariable ["ADV_var_manageVeh",true,true]; };
/*
 * Author: Belbo
 *
 * Handles all vehicles for side BLUFOR in adv_missiontemplate
 *
 * Arguments:
 * None.
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [] call adv_fnc_manageVeh;
 *
 * Public: Yes
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

ADV_veh_boats = [];

ADV_veh_heavys = [];
ADV_veh_tanks = [];
ADV_veh_artys = [];

//ADV_veh_empty = [];

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
		//boats
		case ( _vehicleName select [0,4] == "boat" ): { ADV_veh_boats pushBack _vehicleName; };
		//empty
		//case ( _vehicleName select [0,5] == "empty" ): { ADV_veh_empty pushBack _vehicleName; };
		default {};
	};
	nil;
} count vehicles;

ADV_veh_helis = ADV_veh_airLogistic+ADV_veh_airTransport+ADV_veh_airRecon;
ADV_veh_fixedWing = ADV_veh_airCAS+ADV_veh_airC130+ADV_veh_UAVs;
ADV_veh_air = ADV_veh_helis+ADV_veh_fixedWing;
ADV_veh_armored = ADV_veh_heavys+ADV_veh_tanks+ADV_veh_artys;
ADV_veh_car = ADV_veh_MRAPS+ADV_veh_MRAPsHMG+ADV_veh_MRAPsGMG;
ADV_veh_logistic = ADV_veh_transport+ADV_veh_logistic_fuel+ADV_veh_logistic_ammo+ADV_veh_logistic_repair+ADV_veh_logistic_medic;
ADV_veh_light = ADV_veh_ATVs+ADV_veh_UGVs+ADV_veh_UGVs_repair+ADV_veh_car+ADV_veh_logistic;

ADV_veh_all = ADV_veh_light+ADV_veh_armored+ADV_veh_air+ADV_veh_boats;
publicVariable "ADV_veh_all";

//lobby params:
private _par_assets_cars = missionNamespace getVariable ["ADV_par_Assets_cars",1];
private _par_assets_tanks = missionNamespace getVariable ["ADV_par_Assets_tanks",1];
private _par_assets_air_helis = missionNamespace getVariable ["ADV_par_Assets_air_helis",1];
private _par_assets_air_fixed = missionNamespace getVariable ["ADV_par_Assets_air_fixed",1];
private _par_modCarAssets = missionNamespace getVariable ["ADV_par_modCarAssets",0];
private _par_modTruckAssets = missionNamespace getVariable ["ADV_par_modTruckAssets",0];
private _par_modHeavyAssets = missionNamespace getVariable ["ADV_par_modHeavyAssets",0];
private _par_modTankAssets = missionNamespace getVariable ["ADV_par_modTankAssets",0];
private _par_modHeliAssets = missionNamespace getVariable ["ADV_par_modHeliAssets",0];
private _par_modAirAssets = missionNamespace getVariable ["ADV_par_modAirAssets",0];

//removes the markers according to the lobby params
if ( _par_assets_cars isEqualTo 0 || _par_assets_cars isEqualTo 99 || _par_modCarAssets isEqualTo 99 ) then {
	{_x setMarkerAlpha 0;} count _veh_lightMarkers
};
if ( _par_assets_tanks isEqualTo 0 || _par_assets_tanks isEqualTo 99 || _par_modTankAssets isEqualTo 99 ) then {
	{_x setMarkerAlpha 0;} count _veh_heavyMarkers;
};
if ( _par_assets_air_helis isEqualTo 0 || _par_assets_air_helis isEqualTo 99 || _par_modHeliAssets isEqualTo 99 ) then {
	{_x setMarkerAlpha 0;} count _veh_heliMarkers;
};
if ( (_par_assets_air_fixed isEqualTo 0 && _par_assets_air_helis isEqualTo 0) || (_par_Assets_air_fixed isEqualTo 99 && _par_Assets_air_helis isEqualTo 99) || _par_modAirAssets isEqualTo 99 ) then {
	{_x setMarkerAlpha 0;} count _veh_fixedMarkers;
};

//creation of vehicle code:
adv_manageVeh_codeForAll = {
	_veh = _this;
	private _isChanged = _veh getVariable ["adv_var_vehicleIsChanged",false];
	_veh setVariable ["adv_var_vehicleIsChanged",_isChanged,true];
	_veh enableDynamicSimulation true;
	if ( (missionNamespace getVariable ["adv_par_customLoad",1]) > 0 ) then {
		[_veh] call ADV_fnc_clearCargo;
		sleep 0.2;
		[_veh] call ADV_fnc_addVehicleLoad;
	};
	[_veh] call ADV_fnc_disableVehSelector;
	if ( (missionNamespace getVariable ["ADV_par_engineArtillery",0]) isEqualTo 1 && str _veh in ADV_veh_artys) then {
		[_veh] call ADV_fnc_showArtiSetting;
	};
	if ( (missionNamespace getVariable ["ADV_par_TIEquipment",0]) > 0 ) then {
		_veh disableTIEquipment true;
		if ( (missionNamespace getVariable ["ADV_par_TIEquipment",0]) > 2 ) then {
			_veh disableNVGEquipment true;
		};
	};
	if ( (missionNamespace getVariable ["ADV_par_Radios",1]) > 0 && (_veh isKindOf 'CAR' || _veh isKindOf 'TANK' || _veh isKindOf 'AIR') && !(_veh isKindOf "Quadbike_01_base_F") ) then {
		_veh setVariable ["tf_side", west, true];
		_veh setVariable ["tf_hasRadio", true, true];
		
		call {
			if (_veh isKindOf 'AIR') exitWith {
				if (isClass(configFile >> "CfgPatches" >> "tfar_core")) then {
					_veh setVariable ["TF_RadioType", "tfar_anarc210", true];
				} else {
					_veh setVariable ["TF_RadioType", "tf_anarc210", true];
				};
			};
			if (isClass(configFile >> "CfgPatches" >> "tfar_core")) then {
				_veh setVariable ["TF_RadioType", "tfar_rt1523g", true];
			} else {
				_veh setVariable ["TF_RadioType", "tf_rt1523g", true];
			};
		};
	};
	if (isClass(configFile >> 'CfgPatches' >> 'rhsusf_main')) then {
		[_veh] call ADV_fnc_rhsDecals;
	};
	[_veh] call adv_fnc_retexture;
	
	if !( (missionNamespace getVariable ["ADV_par_vehicleRespawn",300]) isEqualTo 9999 ) then {
		[_veh, missionNamespace getVariable ["ADV_par_vehicleRespawn",300], west] call ADV_fnc_respawnVeh;
	};
	if ( str _veh in ADV_veh_armored+ADV_veh_logistic && !(_veh isKindOf "LT_01_base_F") ) then {
		_veh forceFlagTexture (missionNamespace getVariable ["adv_var_vehicleFlag_west","img\flag.paa"]);
		if ( str _veh in ADV_veh_logistic_medic ) then {
			_veh forceFlagTexture "";
			if ( isClass(configFile >> "CfgPatches" >> "adv_insignia") ) then {
				_veh forceFlagTexture "\adv_insignia\img\adv_medic.paa";
			} else {
				_veh forceFlagTexture "\A3\Data_F\Flags\Flag_rcrystal_CO.paa";
			};
		};
	};
	if (_veh isKindOf 'AIR') then {
		_veh setCollisionLight true;
		if (_veh isKindOf 'PLANE') then {
			_veh setFeatureType 2;
		};
		_veh setVehicleReportRemoteTargets true;
		_veh setVehicleReceiveRemoteTargets true;
		_veh setVehicleReportOwnPosition true;
		if (_veh isKindOf 'Heli_Transport_03_base_F') then {
			_veh animateDoor ["door_rear_source",1];
		};
		if (_veh isKindOf 'VTOL_01_BASE_F') then {
			private _baseUnits = allUnits select {side (group _x) isEqualTo west};
			( _baseUnits select 0 ) action ["VTOLVectoring",_veh];
			( _baseUnits select 0 ) action ["VectoringUp",_veh];
			_veh animateSource ["thrustVector",1];
			[_veh] remoteExec ["adv_fnc_vtolaction",0,true];
			if (_veh isKindOf 'B_T_VTOL_01_infantry_F') then {
				_veh animateDoor ["door_1_source",1];
			};
		};
	};
};

//application of code:
{
	private _vehObj = missionNamespace getVariable [_x,objNull];
	if (!isNull _vehObj) then {
		_vehObj spawn adv_manageVeh_codeForAll;
	};
	nil;
} count ADV_veh_all;

if ( (missionNamespace getVariable ["ADV_par_TIEquipment",0]) isEqualTo 2 || (missionNamespace getVariable ["ADV_par_TIEquipment",0]) isEqualTo 4 ) then {
	[] call ADV_fnc_disableTI;
};

//replaces MRAPS with mod cars:
switch ( _par_modCarAssets ) do {
	//Apex Prowler
	case 1: {
		[ADV_veh_MRAPs,["B_LSV_01_unarmed_F"],west] call ADV_fnc_changeVeh;
		[ADV_veh_MRAPsHMG+ADV_veh_MRAPsGMG,["B_T_LSV_01_armed_F"],west] call ADV_fnc_changeVeh;
	};
	//adv_retex Fenneks
	case 2: {
		[ADV_veh_MRAPs,["adv_retex_b_strider_f"],west] call ADV_fnc_changeVeh;
		[ADV_veh_MRAPsHMG,["adv_retex_b_strider_hmg_f"],west] call ADV_fnc_changeVeh;
		[ADV_veh_MRAPsGMG,["adv_retex_b_strider_gmg_f"],west] call ADV_fnc_changeVeh;
	};
	//BW-Fahrzeuge
	case 10: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_MRAPs,["Fennek_Tropen","BWA3_Eagle_Tropen"],west] call ADV_fnc_changeVeh;
				[ADV_veh_MRAPsHMG,["CUP_B_Dingo_Ger_Des","BWA3_Eagle_FLW100_Tropen"],west] call ADV_fnc_changeVeh;[ADV_veh_MRAPsGMG,["CUP_B_Dingo_GL_Ger_Des"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_MRAPs,["Fennek_Flecktarn","BWA3_Eagle_Fleck"],west] call ADV_fnc_changeVeh;
			[ADV_veh_MRAPsHMG,["CUP_B_Dingo_Ger_Wdl","BWA3_Eagle_FLW100_Fleck"],west] call ADV_fnc_changeVeh;[ADV_veh_MRAPsGMG,["CUP_B_Dingo_GL_Ger_Wdl"],west] call ADV_fnc_changeVeh;
		};
		//[ADV_veh_MRAPsHMG,["BW_Dingo_Des"],west] call ADV_fnc_changeVeh;[ADV_veh_MRAPsGMG,["BW_Dingo_GL_Des"],west] call ADV_fnc_changeVeh;
	};
	//BW-Fahrzeuge + Redd & Tank TPZ Fuchs
	case 11: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_MRAPs,["Fennek_Tropen","BWA3_Eagle_Tropen"],west] call ADV_fnc_changeVeh;
				[ADV_veh_MRAPsHMG,["Redd_Tank_Fuchs_1A4_Jg_Tropentarn","Redd_Tank_Fuchs_1A4_Jg_Tropentarn","CUP_B_Dingo_Ger_Des"],west] call ADV_fnc_changeVeh;
				[ADV_veh_MRAPsGMG,["CUP_B_Dingo_GL_Ger_Des"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_MRAPs,["Fennek_Flecktarn","BWA3_Eagle_Fleck"],west] call ADV_fnc_changeVeh;
			[ADV_veh_MRAPsHMG,["Redd_Tank_Fuchs_1A4_Jg_Flecktarn","Redd_Tank_Fuchs_1A4_Jg_Flecktarn","CUP_B_Dingo_Ger_Wdl"],west] call ADV_fnc_changeVeh;
			[ADV_veh_MRAPsGMG,["CUP_B_Dingo_GL_Ger_Wdl"],west] call ADV_fnc_changeVeh;
		};
		//[ADV_veh_MRAPsHMG,["BW_Dingo_Des"],west] call ADV_fnc_changeVeh;[ADV_veh_MRAPsGMG,["BW_Dingo_GL_Des"],west] call ADV_fnc_changeVeh;
	};
	//RHS ARMY
	case 20: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_MRAPs,["rhsusf_m1025_d","rhsusf_m1025_d","rhsusf_m998_d_4dr"],west] call ADV_fnc_changeVeh;
				[ADV_veh_MRAPsHMG,["rhsusf_m1025_d_m2"],west] call ADV_fnc_changeVeh;
				[ADV_veh_MRAPsGMG,["rhsusf_m1025_d_Mk19"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_MRAPs,["rhsusf_m1025_w","rhsusf_m1025_w","rhsusf_m998_w_4dr"],west] call ADV_fnc_changeVeh;
			[ADV_veh_MRAPsHMG,["rhsusf_m1025_w_m2"],west] call ADV_fnc_changeVeh;
			[ADV_veh_MRAPsGMG,["rhsusf_m1025_w_Mk19"],west] call ADV_fnc_changeVeh;
		};
	};
	//RHS Marines
	case 21: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_MRAPs,["rhsusf_m1025_d_s","rhsusf_m1025_d_s","rhsusf_m998_d_s_4dr"],west] call ADV_fnc_changeVeh;
				[ADV_veh_MRAPsHMG,["rhsusf_m1025_d_s_m2"],west] call ADV_fnc_changeVeh;
				[ADV_veh_MRAPsGMG,["rhsusf_m1025_d_s_Mk19"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_MRAPs,["rhsusf_m1025_w_s","rhsusf_m1025_w_s","rhsusf_m998_w_s_4dr"],west] call ADV_fnc_changeVeh;
			[ADV_veh_MRAPsHMG,["rhsusf_m1025_w_s_m2"],west] call ADV_fnc_changeVeh;
			[ADV_veh_MRAPsGMG,["rhsusf_m1025_w_s_Mk19"],west] call ADV_fnc_changeVeh;
		};
		if (isClass(configFile >> "CfgPatches" >> "cup_wheeledvehicles_m1030")) then {
			[ADV_veh_ATVs,["CUP_B_M1030"],west] call ADV_fnc_changeVeh;
		};
	};
	//CUP BAF
	case 30: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_MRAPs,["CUP_B_LR_Transport_GB_D"],west] call ADV_fnc_changeVeh;
				[ADV_veh_MRAPsHMG,["CUP_B_LR_Special_M2_GB_D","CUP_B_Jackal2_L2A1_GB_D","CUP_B_BAF_Coyote_L2A1_D","CUP_B_Ridgback_LMG_GB_D","CUP_B_Ridgback_HMG_GB_D"],west] call ADV_fnc_changeVeh;
				[ADV_veh_MRAPsGMG,["CUP_B_Ridgback_GMG_GB_D"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_MRAPs,["CUP_B_LR_Transport_GB_W"],west] call ADV_fnc_changeVeh;
			[ADV_veh_MRAPsHMG,["CUP_B_LR_Special_M2_GB_W","CUP_B_LR_MG_GB_W","CUP_B_Jackal2_L2A1_GB_W","CUP_B_BAF_Coyote_L2A1_W","CUP_B_Ridgback_LMG_GB_W","CUP_B_Ridgback_HMG_GB_W"],west] call ADV_fnc_changeVeh;
			[ADV_veh_MRAPsGMG,["CUP_B_Ridgback_GMG_GB_W"],west] call ADV_fnc_changeVeh;
		};
		//[ADV_veh_MRAPs,["BAF_Offroad_D"],west] call ADV_fnc_changeVeh;
		//[ADV_veh_MRAPsHMG,["UK3CB_BAF_Jackal2_L2A1_D","UK3CB_BAF_Coyote_Passenger_L111A1_D"],west] call ADV_fnc_changeVeh;
	};
	//no vehicles
	case 99: {[ADV_veh_MRAPs+ADV_veh_MRAPsHMG+ADV_veh_MRAPsGMG+ADV_veh_ATVs,[""],west] call ADV_fnc_changeVeh;};
	default {};
};

//replaces trucks with mod trucks:
switch ( _par_modTruckAssets ) do {
	//BW Retex
	case 10: {
		if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
			[ADV_veh_transport,["BW_LKW_TRANSPORT_TROPEN","BW_LKW_TRANSPORT_OFFEN_TROPEN"],west] call ADV_fnc_changeVeh;
			[ADV_veh_logistic_fuel,["BW_LKW_TREIBSTOFF_TROPEN"],west] call ADV_fnc_changeVeh;
			[ADV_veh_logistic_repair,["BW_LKW_REPARATUR_TROPEN"],west] call ADV_fnc_changeVeh;
			[ADV_veh_logistic_ammo,["BW_LKW_MUNITION_TROPEN"],west] call ADV_fnc_changeVeh;
			if ( _par_modCarAssets isEqualTo 11 || _par_modHeavyAssets isEqualTo 11 ) then {
				[ADV_veh_logistic_medic,["Redd_Tank_Fuchs_1A4_San_Tropentarn"],west] call ADV_fnc_changeVeh;
			} else {
				[ADV_veh_logistic_medic,["BW_LKW_MEDIC_TROPEN"],west] call ADV_fnc_changeVeh;
			};
		};
		[ADV_veh_transport,["BW_LKW_TRANSPORT_FLECK","BW_LKW_TRANSPORT_OFFEN_FLECK"],west] call ADV_fnc_changeVeh;
		[ADV_veh_logistic_fuel,["BW_LKW_TREIBSTOFF_FLECK"],west] call ADV_fnc_changeVeh;
		[ADV_veh_logistic_repair,["BW_LKW_REPARATUR_FLECK"],west] call ADV_fnc_changeVeh;
		[ADV_veh_logistic_ammo,["BW_LKW_MUNITION_FLECK"],west] call ADV_fnc_changeVeh;
		if ( _par_modCarAssets isEqualTo 11 || _par_modHeavyAssets isEqualTo 11 ) then {
			[ADV_veh_logistic_medic,["Redd_Tank_Fuchs_1A4_San_Flecktarn"],west] call ADV_fnc_changeVeh;
		} else {
			[ADV_veh_logistic_medic,["BW_LKW_MEDIC_FLECK"],west] call ADV_fnc_changeVeh;
		};
	};
	//RHS Army
	case 20: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_transport,["rhsusf_M1083A1P2_d_fmtv_usarmy","rhsusf_M1083A1P2_B_d_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy"],west] call ADV_fnc_changeVeh;
				[ADV_veh_logistic_repair,["rhsusf_M977A4_REPAIR_usarmy_d","rhsusf_M977A4_REPAIR_BKIT_usarmy_d","rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_d"],west] call ADV_fnc_changeVeh;
				[ADV_veh_logistic_ammo,["rhsusf_M977A4_AMMO_usarmy_d","rhsusf_M977A4_AMMO_BKIT_usarmy_d","rhsusf_M977A4_AMMO_BKIT_M2_usarmy_d"],west] call ADV_fnc_changeVeh;
				[ADV_veh_logistic_fuel,["rhsusf_M978A4_usarmy_d","rhsusf_M978A4_BKIT_usarmy_d"],west] call ADV_fnc_changeVeh;
				[ADV_veh_logistic_medic,["rhsusf_M1085A1P2_B_D_Medical_fmtv_usarmy"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_transport,["rhsusf_M1083A1P2_wd_fmtv_usarmy","rhsusf_M1083A1P2_B_wd_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_wd_fmtv_usarmy"],west] call ADV_fnc_changeVeh;
			[ADV_veh_logistic_repair,["rhsusf_M977A4_REPAIR_usarmy_wd","rhsusf_M977A4_REPAIR_BKIT_usarmy_wd","rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_wd"],west] call ADV_fnc_changeVeh;
			[ADV_veh_logistic_ammo,["rhsusf_M977A4_AMMO_usarmy_wd","rhsusf_M977A4_AMMO_BKIT_usarmy_wd","rhsusf_M977A4_AMMO_BKIT_M2_usarmy_wd"],west] call ADV_fnc_changeVeh;
			[ADV_veh_logistic_fuel,["rhsusf_M978A4_usarmy_wd","rhsusf_M978A4_BKIT_usarmy_wd"],west] call ADV_fnc_changeVeh;
			[ADV_veh_logistic_medic,["rhsusf_M1085A1P2_B_WD_Medical_fmtv_usarmy"],west] call ADV_fnc_changeVeh;
		};
	};
	//CUP MTVR
	case 30: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_transport,["CUP_B_MTVR_USA"],west] call ADV_fnc_changeVeh;
				[ADV_veh_logistic_fuel,["CUP_B_MTVR_Refuel_USA"],west] call ADV_fnc_changeVeh;
				[ADV_veh_logistic_repair,["CUP_B_MTVR_Repair_USA"],west] call ADV_fnc_changeVeh;
				[ADV_veh_logistic_ammo,["CUP_B_MTVR_Ammo_USA"],west] call ADV_fnc_changeVeh;
				[ADV_veh_logistic_medic,["CUP_B_HMMWV_Ambulance_USA"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_transport,["CUP_B_MTVR_USMC"],west] call ADV_fnc_changeVeh;
			[ADV_veh_logistic_fuel,["CUP_B_MTVR_Refuel_USMC"],west] call ADV_fnc_changeVeh;
			[ADV_veh_logistic_repair,["CUP_B_MTVR_Repair_USMC"],west] call ADV_fnc_changeVeh;
			[ADV_veh_logistic_ammo,["CUP_B_MTVR_Ammo_USMC"],west] call ADV_fnc_changeVeh;
			[ADV_veh_logistic_medic,["CUP_B_HMMWV_Ambulance_USMC"],west] call ADV_fnc_changeVeh;
		};
	};
	//CUP BAF
	case 31: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_transport,["CUP_B_BAF_Coyote_L2A1_D"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_transport,["CUP_B_BAF_Coyote_L2A1_W"],west] call ADV_fnc_changeVeh;
		};
		//[ADV_veh_transport,["UK3CB_BAF_Coyote_Logistics_L111A1_D"],west] call ADV_fnc_changeVeh;
	};
	//DAR MTVR
	case 40: {
		[ADV_veh_transport,["DAR_MK27","DAR_MK27T"],west] call ADV_fnc_changeVeh;
		[ADV_veh_logistic_fuel,["DAR_LHS_8"],west] call ADV_fnc_changeVeh;
		[ADV_veh_logistic_repair+ADV_veh_logistic_ammo,["DAR_LHS_16"],west] call ADV_fnc_changeVeh;
		[ADV_veh_logistic_medic,["DAR_MK23"],west] call ADV_fnc_changeVeh;
	};
	//no vehicles
	case 99: {[ADV_veh_transport+ADV_veh_logistic_fuel+ADV_veh_logistic_medic+ADV_veh_logistic_repair+ADV_veh_logistic_ammo,[""],west] call ADV_fnc_changeVeh;};
	default {};
};

//replaces heavy vehicles with mod vehicles:
switch ( _par_modHeavyAssets ) do {
	//adv_retex gorgon
	case 1: {
		[ADV_veh_heavys,["adv_retex_b_gorgon_f"],west] call ADV_fnc_changeVeh;
	};
	//stv warrior
	case 2: {
		if (isClass(configFile >> "CfgPatches" >> "adv_retex")) then {
			[ADV_veh_heavys,["adv_retex_b_mora_f"],west] call ADV_fnc_changeVeh;
		} else {
			[ADV_veh_heavys,["Steve_IFV_Warrior"],west] call ADV_fnc_changeVeh;
		};
	};
	//stv marid
	case 3: {
		if (isClass(configFile >> "CfgPatches" >> "adv_retex")) then {
			[ADV_veh_heavys,["adv_retex_b_marid_f"],west] call ADV_fnc_changeVeh;
		} else {
			[ADV_veh_heavys,["Steve_IFV_Marid"],west] call ADV_fnc_changeVeh;
		};
	};
	//BWmod
	case 10: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_heavys,["BWA3_Puma_Tropen"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_heavys,["BWA3_Puma_Fleck"],west] call ADV_fnc_changeVeh;
		};
	};
	//Redd Fuchs
	case 11: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_heavys,["Redd_Tank_Fuchs_1A4_Jg_Tropentarn","Redd_Tank_Fuchs_1A4_Jg_Tropentarn","Redd_Tank_Fuchs_1A4_Pi_Tropentarn"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_heavys,["Redd_Tank_Fuchs_1A4_Jg_Flecktarn","Redd_Tank_Fuchs_1A4_Jg_Flecktarn","Redd_Tank_Fuchs_1A4_Pi_Flecktarn"],west] call ADV_fnc_changeVeh;
		};
	};
	//Redd Marder
	case 12: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_heavys,["Redd_Marder_1A5_Tropentarn"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_heavys,["Redd_Marder_1A5_Flecktarn"],west] call ADV_fnc_changeVeh;
		};
	};
	//RHS Bradleys
	case 20: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_heavys,["RHS_M2A2","RHS_M2A2_BUSKI","RHS_M2A3","RHS_M2A3_BUSKI","RHS_M2A3_BUSKIII"],west] call ADV_fnc_changeVeh;
				if ( _par_modTruckAssets isEqualTo 0 ) then {
					[ADV_veh_logistic_ammo,["rhsusf_m113d_usarmy_supply"],west] call ADV_fnc_changeVeh;
				};
			};
			[ADV_veh_heavys,["RHS_M2A2_wd","RHS_M2A2_BUSKI_WD","RHS_M2A3_wd","RHS_M2A3_BUSKI_wd","RHS_M2A3_BUSKIII_wd"],west] call ADV_fnc_changeVeh;
				if ( _par_modTruckAssets isEqualTo 0 ) then {
				[ADV_veh_logistic_ammo,["rhsusf_m113_usarmy_supply"],west] call ADV_fnc_changeVeh;
			};
		};
	};
	//RHS M113
	case 21: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_heavys,["rhsusf_m113d_usarmy","rhsusf_m113d_usarmy_M240","rhsusf_m113d_usarmy_MK19"],west] call ADV_fnc_changeVeh;
				if ( _par_modTruckAssets isEqualTo 0 ) then {
					[ADV_veh_logistic_ammo,["rhsusf_m113d_usarmy_supply"],west] call ADV_fnc_changeVeh;
				};
				if ( _par_modTruckAssets == 0 ) then {
					[ADV_veh_logistic_medic,["rhsusf_m113d_usarmy_medical"],west] call ADV_fnc_changeVeh;
				};
			};
			[ADV_veh_heavys,["rhsusf_m113_usarmy","rhsusf_m113_usarmy_M240","rhsusf_m113_usarmy_MK19"],west] call ADV_fnc_changeVeh;
			if ( _par_modTruckAssets isEqualTo 0 ) then {
				[ADV_veh_logistic_ammo,["rhsusf_m113_usarmy_supply"],west] call ADV_fnc_changeVeh;
			};
			if ( _par_modTruckAssets == 0 ) then {
				[ADV_veh_logistic_medic,["rhsusf_m113_usarmy_medical"],west] call ADV_fnc_changeVeh;
			};
		};
	};
	//RHS MRAPs
	case 22: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_heavys,["rhsusf_rg33_m2_usmc_d","rhsusf_M1220_M2_usarmy_d","rhsusf_M1230_M2_usarmy_d","rhsusf_M1232_M2_usarmy_d","rhsusf_M1237_M2_usarmy_d","rhsusf_M1220_MK19_usarmy_d","rhsusf_M1230_MK19_usarmy_d","rhsusf_M1232_MK19_usarmy_d","rhsusf_M1237_MK19_usarmy_d"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_heavys,["rhsusf_rg33_m2_usmc_wd","rhsusf_M1220_M2_usarmy_wd","rhsusf_M1230_M2_usarmy_wd","rhsusf_M1232_M2_usarmy_wd","rhsusf_M1237_M2_usarmy_wd","rhsusf_M1220_MK19_usarmy_wd","rhsusf_M1230_MK19_usarmy_wd","rhsusf_M1232_MK19_usarmy_wd","rhsusf_M1237_MK19_usarmy_wd"],west] call ADV_fnc_changeVeh;
		};
	};
	//CUP Stryker
	case 30: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_heavys,["CUP_B_M1126_ICV_M2_Desert_Slat","CUP_B_M1126_ICV_M2_Desert"],west] call ADV_fnc_changeVeh;
				if ( _par_modTruckAssets isEqualTo 0 ) then {
					[ADV_veh_logistic_medic,["CUP_B_M1133_MEV_Desert","CUP_B_M1133_MEV_Desert_Slat"],west] call ADV_fnc_changeVeh;
				};
			};
			[ADV_veh_heavys,["CUP_B_M1126_ICV_M2_Woodland_Slat","CUP_B_M1126_ICV_M2_Woodland"],west] call ADV_fnc_changeVeh;
			if ( _par_modTruckAssets isEqualTo 0 ) then {
				[ADV_veh_logistic_medic,["CUP_B_M1133_MEV_Woodland","CUP_B_M1133_MEV_Woodland_Slat"],west] call ADV_fnc_changeVeh;
			};
		};
	};
	//CUP LAV25
	case 31: {
		[ADV_veh_heavys,["CUP_B_LAV25_USMC","CUP_B_LAV25M240_USMC","CUP_B_AAV_USMC"],west] call ADV_fnc_changeVeh;
	};
	//CUP AAV7
	case 32: {
		[ADV_veh_heavys,["CUP_B_AAV_USMC"],west] call ADV_fnc_changeVeh;
	};
	//CUP BAF APCs
	case 33: {
		call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_heavys,["CUP_B_FV432_Bulldog_GB_D_RWS","CUP_B_FV432_Bulldog_GB_D","CUP_B_FV510_GB_D_SLAT","CUP_B_MCV80_GB_D_SLAT"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_heavys,["CUP_B_FV432_Bulldog_GB_W_RWS","CUP_B_FV432_Bulldog_GB_W","CUP_B_FV510_GB_W","CUP_B_MCV80_GB_W"],west] call ADV_fnc_changeVeh;
		};
	};
	//CUP BAF MRAPs
	case 34: {
		call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_heavys,["CUP_B_Ridgback_LMG_GB_D","CUP_B_Ridgback_HMG_GB_D","CUP_B_Ridgback_GMG_GB_D","CUP_B_Mastiff_LMG_GB_D","CUP_B_Mastiff_LMG_GB_D","CUP_B_Mastiff_HMG_GB_D","CUP_B_Mastiff_HMG_GB_D","CUP_B_Mastiff_GMG_GB_D"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_heavys,["CUP_B_Ridgback_LMG_GB_W","CUP_B_Ridgback_HMG_GB_W","CUP_B_Ridgback_GMG_GB_W","CUP_B_Mastiff_LMG_GB_W","CUP_B_Mastiff_LMG_GB_W","CUP_B_Mastiff_HMG_GB_W","CUP_B_Mastiff_HMG_GB_W","CUP_B_Mastiff_GMG_GB_W"],west] call ADV_fnc_changeVeh;
		};
	};
	//DAR MaxxPro MRAP
	case 40: {
		[ADV_veh_heavys,["DAR_MaxxProDeploy","DAR_MaxxProDeploy","DAR_MaxxPro","DAR_MaxxProDXM","DAR_MaxxProPlus"],west] call ADV_fnc_changeVeh;
	};
	//no vehicles
	case 99: {[ADV_veh_heavys,[""],west] call ADV_fnc_changeVeh;};
	default {};
};

//replaces tanks with mod tanks:
switch ( _par_modTankAssets ) do {
	//stv/adv retextures
	case 1: {
		if (isClass(configFile >> "CfgPatches" >> "adv_retex")) then {
			[ADV_veh_tanks,["adv_retex_b_kuma_f"],west] call ADV_fnc_changeVeh;
		} else {
			[ADV_veh_tanks,["Steve_MBT_Kuma"],west] call ADV_fnc_changeVeh;
		};
	};
	//BWmod Leopard
	case 10: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_tanks,["BWA3_Leopard2A6M_Tropen"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_tanks,["BWA3_Leopard2A6M_Fleck"],west] call ADV_fnc_changeVeh;
		};
	};
	//Redd Marder
	case 11: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_tanks,["Redd_Marder_1A5_Tropentarn"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_tanks,["Redd_Marder_1A5_Flecktarn"],west] call ADV_fnc_changeVeh;
		};
	};
	//RHS m109
	case 20: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_tanks,["rhsusf_m1a1fep_d","rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy"],west] call ADV_fnc_changeVeh;
				[ADV_veh_artys,["rhsusf_m109d_usarmy"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_tanks,["rhsusf_m1a1fep_wd","rhsusf_m1a1fep_od","rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy"],west] call ADV_fnc_changeVeh;
			[ADV_veh_artys,["rhsusf_m109_usarmy"],west] call ADV_fnc_changeVeh;
		};
	};
	//RHS m119
	case 21: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_tanks,["rhsusf_m1a1fep_d","rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy"],west] call ADV_fnc_changeVeh;
				[ADV_veh_artys,["RHS_M119_D"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_tanks,["rhsusf_m1a1fep_wd","rhsusf_m1a1fep_od","rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy"],west] call ADV_fnc_changeVeh;
			[ADV_veh_artys,["RHS_M119_WD"],west] call ADV_fnc_changeVeh;
		};
	};
	//CUP Challenger
	case 30: {
		call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_tanks,["CUP_B_Challenger2_Desert_BAF","CUP_B_Challenger2_Desert_BAF","CUP_B_Challenger2_2CD_BAF"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_tanks,["CUP_B_Challenger2_2CW_BAF","CUP_B_Challenger2_Woodland_BAF"],west] call ADV_fnc_changeVeh;
		};
	};
	//Burne's M1A2
	case 40: {
		[] call {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_aridMaps",[]]) ) exitWith {
				[ADV_veh_tanks,["Burnes_M1A2_MEU_02_Public"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_tanks,["Burnes_M1A2_MEU_01_Public"],west] call ADV_fnc_changeVeh;
		};
	};
	//no vehicles
	case 99: {[ADV_veh_tanks+ADV_veh_artys,[""],west] call ADV_fnc_changeVeh;};
	default {};
};

//replaces helis with mod helis:
switch ( missionNamespace getVariable ["ADV_par_modHeliAssets",0] ) do {
	//BWHelis
	case 10: {
		[ADV_veh_airTransport,["BW_NH90Armed","BW_NH90Armed","BW_NH90Armed","BW_NH90","CUP_B_UH1D_GER_KSK","CUP_B_UH1D_GER_KSK"],west] call ADV_fnc_changeVeh;
		//[ADV_veh_airRecon,["EC635_Unarmed_BW","EC635_BW"],west] call ADV_fnc_changeVeh;
		[ADV_veh_airRecon,["BWA3_Tiger_Gunpod_Heavy","BWA3_Tiger_Gunpod_PARS"],west] call ADV_fnc_changeVeh;
		[ADV_veh_airLogistic,["CUP_B_CH53E_GER"],west] call ADV_fnc_changeVeh;
	};
	//RHS Marines
	case 20: {
		[ADV_veh_airTransport,["rhs_uh1y","rhs_uh1y_gs"],west] call ADV_fnc_changeVeh;
		[ADV_veh_airRecon,["rhs_ah1z"],west] call ADV_fnc_changeVeh;
		[ADV_veh_airLogistic,["rhsusf_CH53E_USMC"],west] call ADV_fnc_changeVeh;
	};
	//RHS Army
	case 21: {
		[ADV_veh_airTransport,["RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_MEV_d"],west] call ADV_fnc_changeVeh;
		[ADV_veh_airRecon,["rhs_ah64d_aa","rhs_ah64d_noradar_aa","rhs_ah64d_cs","rhs_ah64d_noradar_cs"],west] call ADV_fnc_changeVeh;
		[ADV_veh_airLogistic,["RHS_CH_47F","RHS_CH_47F","RHS_CH_47F","RHS_CH_47F_LIGHT"],west] call ADV_fnc_changeVeh;
	};
	//RHS Army with RHS OH6M
	case 22: {
		[ADV_veh_airTransport,["RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_d","RHS_UH60M_MEV_d"],west] call ADV_fnc_changeVeh;
		[ADV_veh_airRecon,["RHS_MELB_AH6M_M","RHS_MELB_AH6M_L","RHS_MELB_MH6M","RHS_MELB_MH6M"],west] call ADV_fnc_changeVeh;
		[ADV_veh_airLogistic,["RHS_CH_47F","RHS_CH_47F","RHS_CH_47F","RHS_CH_47F_LIGHT"],west] call ADV_fnc_changeVeh;
	};
	//BAFHelis
	case 30: {
		[ADV_veh_airTransport,["CUP_B_Merlin_HC3A_Armed_GB","CUP_B_Merlin_HC3_Armed_GB"],west] call ADV_fnc_changeVeh;
		[ADV_veh_airRecon,["CUP_B_AW159_Unarmed_GB"],west] call ADV_fnc_changeVeh;
		[ADV_veh_airLogistic,["CUP_B_CH47F_GB"],west] call ADV_fnc_changeVeh;	
		//[ADV_veh_airTransport,["UK3CB_BAF_Wildcat_Transport_RN_ZZ396"],west] call ADV_fnc_changeVeh;
		//[ADV_veh_airRecon,["UK3CB_BAF_Wildcat_Armed_Army_ZZ400"],west] call ADV_fnc_changeVeh;
		//[ADV_veh_airLogistic,["UK3CB_BAF_Merlin_RAF_ZJ124"],west] call ADV_fnc_changeVeh;
	};
	//no vehicles
	case 99: {[ADV_veh_helis,[""],west] call ADV_fnc_changeVeh;};
	default {};
};

//replaces planes with mod planes:
switch ( _par_modAirAssets ) do {
	//RHS A-10
	case 20: {[ADV_veh_airCAS,["RHS_A10_AT"],west] call ADV_fnc_changeVeh;};
	//RHS F-22A
	case 21: {[ADV_veh_airCAS,["rhsusf_f22"],west] call ADV_fnc_changeVeh;};
	//AV8B Hawker Harrier
	case 30: {
		call {
			if !( (missionNamespace getVariable ["ADV_par_customUni",0]) isEqualTo 6 || _par_modHeliAssets isEqualTo 30) exitWith {
				[ADV_veh_airCAS,["CUP_B_AV8B_Mk82_USMC","CUP_B_AV8B_AGM_USMC","CUP_B_AV8B_CAP_USMC"],west] call ADV_fnc_changeVeh;
			};
			[ADV_veh_airCAS,["CUP_B_GR9_Mk82_GB","CUP_B_GR9_AGM_GB","CUP_B_GR9_CAP_GB"],west] call ADV_fnc_changeVeh;
		};
		//[ADV_veh_airCAS,["Cha_AV8B_CAP","Cha_AV8B_GBU12","Cha_AV8B_MK82"],west] call ADV_fnc_changeVeh;
	};
	//CUP F35
	case 31: {[ADV_veh_airCAS,["CUP_B_F35B_CAS_USMC","CUP_B_F35B_LGB_USMC"],west] call ADV_fnc_changeVeh;};
	//FA18E
	case 40: {[ADV_veh_airCAS,["JS_JC_FA18E"],west] call ADV_fnc_changeVeh;};
	//FA18F
	case 41: {[ADV_veh_airCAS,["JS_JC_FA18F"],west] call ADV_fnc_changeVeh;};
	//F-14D
	case 42: {[ADV_veh_airCAS,["FIR_F14D_A88","FIR_F14D_VF101","FIR_F14D_VF103","FIR_F14D_VF32","FIR_F14D_VF84"],west] call ADV_fnc_changeVeh;};
	//no vehicles
	case 99: {[ADV_veh_fixedWing,[""],west] call ADV_fnc_changeVeh;};
	default {};
};
call {
	if ( _par_modAirAssets >= 20 && _par_modAirAssets < 30 ) exitWith {
		[ADV_veh_airC130,["RHS_C130J"],west] call ADV_fnc_changeVeh;
	};
	if ( (_par_modAirAssets >= 30 && _par_modAirAssets < 40) || (_par_modHeliAssets >= 30 && _par_modHeliAssets < 40) ) exitWith {
		if ( (missionNamespace getVariable ["ADV_par_customUni",0]) isEqualTo 6 || _par_modHeliAssets isEqualTo 30 ) exitWith {
			[ADV_veh_airC130,["CUP_B_C130J_GB"],west] call ADV_fnc_changeVeh;
		};
		[ADV_veh_airC130,["CUP_B_C130J_USMC"],west] call ADV_fnc_changeVeh;
	};
	/*
	if !(toUpper worldname == "TANOA") exitWith {
		[ADV_veh_airC130,[""],west] call ADV_fnc_changeVeh;
	};
	*/
};

true;
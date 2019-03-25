/*
 * Author: Belbo
 *
 * Handles all vehicles for side OPFOR in adv_missiontemplate
 *
 * Arguments:
 * None.
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [] call adv_opf_fnc_manageVeh;
 *
 * Public: Yes
 */

if (!isServer) exitWith {};

//markers for the vehicle garages:
_veh_lightMarkers = ["opf_garage_1","opf_garage_2"];
_veh_heavyMarkers = ["opf_garage_heavy_1","opf_garage_heavy_2","opf_garage_heavy_3"];
_veh_heliMarkers = ["opf_garage_air_1"];
_veh_fixedMarkers = ["opf_garage_air_2"];

//unique vehicles placed in the editor:
ADV_opf_veh_airTransport = [];
ADV_opf_veh_airRecon = [];
ADV_opf_veh_airLogistic = [];
ADV_opf_veh_airContainerMedic = [];
ADV_opf_veh_airContainerTransport = [];

ADV_opf_veh_airCAS = [];
ADV_opf_veh_airC130 = [];

ADV_opf_veh_MRAPs = [];
ADV_opf_veh_MRAPsHMG = [];
ADV_opf_veh_MRAPsGMG = [];
ADV_opf_veh_transport = [];
ADV_opf_veh_logistic_fuel = [];
ADV_opf_veh_logistic_ammo = [];
ADV_opf_veh_logistic_repair = [];
ADV_opf_veh_logistic_medic = [];
ADV_opf_veh_ATVs = [];
ADV_opf_veh_UAVs = [];
ADV_opf_veh_UGVs = [];
ADV_opf_veh_UGVs_repair = [];

ADV_opf_veh_heavys = [];
ADV_opf_veh_tanks = [];
ADV_opf_veh_artys = [];

///// No editing necessary below this line /////

{
	_vehicleName = str _x;
	switch ( true ) do {
		//helicopters
		case ( _vehicleName select [0,17] == "opf_air_transport" ): { ADV_opf_veh_airTransport pushBack _vehicleName; };
		case ( _vehicleName select [0,13] == "opf_air_recon" ): { ADV_opf_veh_airRecon pushBack _vehicleName; };
		case ( _vehicleName select [0,16] == "opf_air_logistic" ): { ADV_opf_veh_airLogistic pushBack _vehicleName; };
		//fixed wing planes
		case ( _vehicleName select [0,12] == "opf_air_a164" ): { ADV_opf_veh_airCAS pushBack _vehicleName; };
		case ( _vehicleName select [0,11] == "opf_air_cas" ): { ADV_opf_veh_airCAS pushBack _vehicleName; };
		case ( _vehicleName select [0,12] == "opf_air_c130" ): { ADV_opf_veh_airC130 pushBack _vehicleName; };
		//MRAPs
		case ( _vehicleName select [0,12] == "opf_MRAP_hmg" ): { ADV_opf_veh_MRAPsHMG pushBack _vehicleName; };
		case ( _vehicleName select [0,12] == "opf_MRAP_gmg" ): { ADV_opf_veh_MRAPsGMG pushBack _vehicleName; };
		case ( _vehicleName select [0,8] == "opf_MRAP" ): { ADV_opf_veh_MRAPs pushBack _vehicleName; };
		//logistics
		case ( _vehicleName select [0,7] == "opf_uav" ): { ADV_opf_veh_UAVs pushBack _vehicleName; };
		case ( _vehicleName select [0,7] == "opf_ugv" ): { ADV_opf_veh_UGVs pushBack _vehicleName; };
		case ( _vehicleName select [0,14] == "opf_ugv_repair" ): { ADV_opf_veh_UGVs_repair pushBack _vehicleName; };
		case ( _vehicleName select [0,7] == "opf_ATV" ): { ADV_opf_veh_ATVs pushBack _vehicleName; };
		case ( _vehicleName select [0,13] == "opf_transport" ): { ADV_opf_veh_transport pushBack _vehicleName; };
		case ( _vehicleName select [0,17] == "opf_logistic_fuel" ): { ADV_opf_veh_logistic_fuel pushBack _vehicleName; };
		case ( _vehicleName select [0,17] == "opf_logistic_ammo" ): { ADV_opf_veh_logistic_ammo pushBack _vehicleName; };
		case ( _vehicleName select [0,19] == "opf_logistic_repair" ): { ADV_opf_veh_logistic_repair pushBack _vehicleName; };
		case ( _vehicleName select [0,18] == "opf_logistic_medic" ): { ADV_opf_veh_logistic_medic pushBack _vehicleName; };
		//armored
		case ( _vehicleName select [0,9] == "opf_heavy" ): { ADV_opf_veh_heavys pushBack _vehicleName; };
		case ( _vehicleName select [0,8] == "opf_tank" ): { ADV_opf_veh_tanks pushBack _vehicleName; };
		case ( _vehicleName select [0,8] == "opf_arty" ): { ADV_opf_veh_artys pushBack _vehicleName; };
		//container
		case ( _vehicleName select [0,25] == "opf_air_container_medical" ): { ADV_opf_veh_airContainerMedic pushBack _vehicleName; };
		case ( _vehicleName select [0,27] == "opf_air_container_transport" ): { ADV_opf_veh_airContainerTransport pushBack _vehicleName; };
		default {};
	};
	nil;
} count vehicles;

ADV_opf_veh_helis = ADV_opf_veh_airLogistic+ADV_opf_veh_airTransport+ADV_opf_veh_airRecon+ADV_opf_veh_airContainerMedic+ADV_opf_veh_airContainerTransport;
ADV_opf_veh_fixedWing = ADV_opf_veh_airCAS+ADV_opf_veh_airC130+ADV_opf_veh_UAVs;
ADV_opf_veh_air = ADV_opf_veh_helis+ADV_opf_veh_fixedWing;
ADV_opf_veh_armored = ADV_opf_veh_heavys+ADV_opf_veh_tanks+ADV_opf_veh_artys;
ADV_opf_veh_car = ADV_opf_veh_MRAPS+ADV_opf_veh_MRAPsHMG+ADV_opf_veh_MRAPsGMG;
ADV_opf_veh_logistic = ADV_opf_veh_transport+ADV_opf_veh_logistic_fuel+ADV_opf_veh_logistic_ammo+ADV_opf_veh_logistic_repair+ADV_opf_veh_logistic_medic;
ADV_opf_veh_light = ADV_opf_veh_ATVs+ADV_opf_veh_UGVs+ADV_opf_veh_UGVs_repair+ADV_opf_veh_car+ADV_opf_veh_logistic;

ADV_opf_veh_all = ADV_opf_veh_light+ADV_opf_veh_armored+ADV_opf_veh_air;
publicVariable "ADV_opf_veh_all";

//lobby params:
private _par_assets_cars = missionNamespace getVariable ["ADV_par_Assets_cars",1];
private _par_assets_tanks = missionNamespace getVariable ["ADV_par_Assets_tanks",1];
private _par_assets_air_helis = missionNamespace getVariable ["ADV_par_Assets_air_helis",1];
private _par_assets_air_fixed = missionNamespace getVariable ["ADV_par_Assets_air_fixed",1];
private _par_opfCarAssets = missionNamespace getVariable ["ADV_par_opfCarAssets",0];
private _par_opfTruckAssets = missionNamespace getVariable ["ADV_par_opfTruckAssets",0];
private _par_opfHeavyAssets = missionNamespace getVariable ["ADV_par_opfHeavyAssets",0];
private _par_opfTankAssets = missionNamespace getVariable ["ADV_par_opfTankAssets",0];
private _par_opfHeliAssets = missionNamespace getVariable ["ADV_par_opfHeliAssets",0];
private _par_opfAirAssets = missionNamespace getVariable ["ADV_par_opfAirAssets",0];

//removes the markers according to the lobby params
if ( _par_Assets_cars isEqualTo 0 || _par_Assets_cars isEqualTo 99 || _par_opfCarAssets isEqualTo 99 ) then {
	{_x setMarkerAlpha 0;} count _veh_lightMarkers
};
if ( _par_Assets_tanks isEqualTo 0 || _par_Assets_tanks isEqualTo 99 || _par_opfTankAssets isEqualTo 99 ) then {
	{_x setMarkerAlpha 0;} count _veh_heavyMarkers;
};
if ( _par_Assets_air_helis isEqualTo 0 || _par_Assets_air_helis isEqualTo 99 || _par_opfHeliAssets isEqualTo 99 ) then {
	{_x setMarkerAlpha 0;} count _veh_heliMarkers;
};
if ( (_par_Assets_air_fixed isEqualTo 0 && _par_Assets_air_helis isEqualTo 0) || (_par_Assets_air_fixed isEqualTo 99 && _par_Assets_air_helis isEqualTo 99) ||  _par_opfAirAssets isEqualTo 99) then {
	{_x setMarkerAlpha 0;} count _veh_fixedMarkers;
};

//creation of vehicle code:
adv_opf_manageVeh_codeForAll = {
	_veh = _this;
	private _isChanged = _veh getVariable ["adv_var_vehicleIsChanged",false];
	_veh setVariable ["adv_var_vehicleIsChanged",_isChanged,true];
	_veh enableDynamicSimulation true;
	if ( (missionNamespace getVariable ["adv_par_customLoad",1]) > 0 ) then {
		[_veh] call ADV_fnc_clearCargo;
		sleep 0.2;
		[_veh] call ADV_opf_fnc_addVehicleLoad;
	};
	[_veh] call ADV_opf_fnc_disableVehSelector;
	if ( (missionNamespace getVariable ["ADV_par_engineArtillery",0]) isEqualTo 1 && str _veh in ADV_opf_veh_artys) then {
		[_veh] call ADV_fnc_showArtiSetting;
	};
	if ( (missionNamespace getVariable ["ADV_par_TIEquipment",0]) > 0 ) then {
		_veh disableTIEquipment true;
		if ( (missionNamespace getVariable ["ADV_par_TIEquipment",0]) > 2 ) then {
			_veh disableNVGEquipment true;
		};
	};
	if ( (missionNamespace getVariable ["ADV_par_Radios",1]) > 0 && (_veh isKindOf 'CAR' || _veh isKindOf 'TANK' || _veh isKindOf 'AIR') && !(_veh isKindOf "Quadbike_01_base_F") ) then {
		_veh setVariable ["tf_side", east, true];
		_veh setVariable ["tf_hasRadio", true, true];
		call {
			if (_veh isKindOf 'AIR') exitWith {
				if (isClass(configFile >> "CfgPatches" >> "tfar_core")) then {
					_veh setVariable ["TF_RadioType", "tfar_mr6000l", true];
				} else {
					_veh setVariable ["TF_RadioType", "tf_mr6000l", true];
				};
			};
			if (isClass(configFile >> "CfgPatches" >> "tfar_core")) then {
				_veh setVariable ["TF_RadioType", "tfar_mr3000", true];
			} else {
				_veh setVariable ["TF_RadioType", "tf_mr3000", true];
			};
		};
	};
	if (isClass(configFile >> 'CfgPatches' >> 'rhs_main')) then {
		[_veh] call ADV_opf_fnc_rhsDecals;
	};
	if !( (missionNamespace getVariable ["ADV_par_vehicleRespawn",300]) isEqualTo 9999 ) then {
		[_veh,ADV_par_vehicleRespawn, east] call ADV_fnc_respawnVeh;
	};
	if ( str _veh in ADV_opf_veh_armored+ADV_opf_veh_logistic && !(_veh isKindOf "LT_01_base_F") ) then {
		_veh forceFlagTexture (missionNamespace getVariable ["adv_var_vehicleFlag_east","img\flag.paa"]);
		if ( str _veh in ADV_opf_veh_logistic_medic ) then {
			_veh forceFlagTexture "";
			_veh forceFlagTexture "\A3\Data_F\Flags\Flag_rcrystal_CO.paa";
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
	};
};
//application of code:
{
	private _vehObj = missionNamespace getVariable [_x,objNull];
	if !(isNull _vehObj) then {
		_vehObj spawn adv_opf_manageVeh_codeForAll;
	};
	nil;
} count ADV_opf_veh_all;

//replaces MRAPS with mod cars:
switch ( _par_opfCarAssets ) do {
	//Apex Qilin
	case 1: {
		[ADV_opf_veh_MRAPs,["O_T_LSV_02_unarmed_F"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_MRAPsHMG+ADV_opf_veh_MRAPsGMG,["O_T_LSV_02_armed_F"],east] call ADV_fnc_changeVeh;
	};
	//RHS UAZ
	case 20: {
		[ADV_opf_veh_MRAPs+ADV_opf_veh_MRAPsHMG+ADV_opf_veh_MRAPsGMG,["rhs_uaz_msv_01","rhs_uaz_open_msv_01"],east] call ADV_fnc_changeVeh;
	};
	//RHS GAZ
	case 21: {
		[ADV_opf_veh_MRAPs,["rhs_tigr_msv"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_MRAPsHMG+ADV_opf_veh_MRAPsGMG,["rhs_tigr_ffv_msv"],east] call ADV_fnc_changeVeh;
	};
	//RDS vehicles
	case 40: {
		[ADV_opf_veh_MRAPs+ADV_opf_veh_MRAPsHMG+ADV_opf_veh_MRAPsGMG,["RDS_Gaz24_Civ_01","RDS_Gaz24_Civ_02","RDS_Gaz24_Civ_03","RDS_Lada_Civ_01","RDS_Lada_Civ_02","RDS_Lada_Civ_03","RDS_Lada_Civ_04"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_ATVs,[""],east] call ADV_fnc_changeVeh;
	};
	//no vehicles
	case 99: {[ADV_opf_veh_MRAPs+ADV_opf_veh_MRAPsHMG+ADV_opf_veh_MRAPsGMG+ADV_opf_veh_ATVs,[""],east] call ADV_fnc_changeVeh;};
	default {};
};

//replaces trucks with mod trucks:
switch ( _par_opfTruckAssets ) do {
	//RHS
	case 20: {
		[ADV_opf_veh_transport,["rhs_gaz66_msv","rhs_gaz66o_msv","rhs_ural_msv_01","rhs_ural_open_msv_01"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_logistic_ammo,["rhs_gaz66_ammo_msv"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_logistic_fuel,["rhs_ural_fuel_msv_01"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_logistic_repair,["rhs_gaz66_repair_msv"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_logistic_medic,["rhs_ural_msv_01"],east] call ADV_fnc_changeVeh;
	};
	//RHS civil
	case 21: {
		[ADV_opf_veh_transport+ADV_opf_veh_logistic_medic+ADV_opf_veh_logistic_ammo+ADV_opf_veh_logistic_fuel+ADV_opf_veh_logistic_repair,["RHS_Ural_Open_Civ_01","RHS_Ural_Open_Civ_02","RHS_Ural_Open_Civ_03","RHS_Ural_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Civ_03"],east] call ADV_fnc_changeVeh;
	};
	//no Trucks
	case 99: {[ADV_opf_veh_transport+ADV_opf_veh_logistic_medic+ADV_opf_veh_logistic_ammo+ADV_opf_veh_logistic_fuel+ADV_opf_veh_logistic_repair,[""],east] call ADV_fnc_changeVeh;};
	default {};
};

//replaces heavy vehicles with mod vehicles:
switch ( missionNamespace getVariable ["ADV_par_opfHeavyAssets",0] ) do {
	//RHS BTR
	case 20: {
		[ADV_opf_veh_heavys,["rhs_btr80a_msv","rhs_btr80_msv","rhs_btr70_msv"],east] call ADV_fnc_changeVeh;
	};
	//RHS BMP
	case 21: {
		[ADV_opf_veh_heavys,["rhs_bmp1_msv","rhs_bmp1d_msv","rhs_bmp1k_msv","rhs_bmp1p_msv","rhs_bmp2_msv","rhs_bmp2d_msv","rhs_bmp2e_msv","rhs_bmp2k_msv"],east] call ADV_fnc_changeVeh;
	};
	//no vehicles
	case 99: {[ADV_opf_veh_heavys,[""],east] call ADV_fnc_changeVeh;};
	default {};
};

//replaces tanks with mod tanks:
switch ( _par_opfTankAssets ) do {
	//RHS T90
	case 20: {
		[ADV_opf_veh_tanks,["rhs_t90a_tv"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_artys,["rhs_2s3_tv","rhs_2s3_tv","RHS_BM21_VSV_01"],east] call ADV_fnc_changeVeh;
	};
	//RHS T80
	case 21: {
		[ADV_opf_veh_tanks,["rhs_t80uk","rhs_t80ue1"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_artys,["rhs_d30_msv","rhs_d30_msv","RHS_BM21_VSV_01"],east] call ADV_fnc_changeVeh;
	};
	//RHS T72
	case 22: {
		[ADV_opf_veh_tanks,["rhs_t72bd_tv"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_artys,["rhs_d30_msv","rhs_d30_msv","RHS_BM21_VSV_01"],east] call ADV_fnc_changeVeh;
	};
	//CUP T55
	case 30: {
		[ADV_opf_veh_tanks,["CUP_O_T55_SLA","CUP_I_T55_TK_GUE"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_artys,["CUP_O_D30_RU"],east] call ADV_fnc_changeVeh;
	};
	//CUP T34
	case 31: {
		[ADV_opf_veh_tanks,["CUP_O_T34_TKA"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_artys,["CUP_O_D30_RU"],east] call ADV_fnc_changeVeh;
	};
	//RDS T55
	case 40: {
		[ADV_opf_veh_tanks,["RDS_T55_AAF_01"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_artys,["RDS_D30_CSAT"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_logistic_medic,["RDS_BMP2_Ambul_01"],east] call ADV_fnc_changeVeh;
	};
	//RDS T34
	case 41: {
		[ADV_opf_veh_tanks,["RDS_T34_AAF_01"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_artys,["RDS_D30_CSAT"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_logistic_medic,["RDS_BMP2_Ambul_01"],east] call ADV_fnc_changeVeh;
	};
	//no vehicles 
	case 99: {[ADV_opf_veh_tanks+ADV_opf_veh_artys,[""],east] call ADV_fnc_changeVeh;};
	default {};
};

//replaces helis with mod helis:
switch ( _par_opfHeliAssets ) do {
	//RHS transport
	case 20: {
		[ADV_opf_veh_airTransport,["RHS_Mi8MT_vdv","RHS_Mi8MT_vvs","RHS_Mi8MT_vvss"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airLogistic,["RHS_Mi8mt_Cargo_vdv","RHS_Mi8mt_Cargo_vvs","RHS_Mi8mt_Cargo_vvsc"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airRecon,["rhs_ka60_c","rhs_ka60_grey"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airContainerMedic+ADV_opf_veh_airContainerTransport,[""],east] call ADV_fnc_changeVeh;
	};
	//RHS transport Mi24
	case 21: {
		[ADV_opf_veh_airTransport,["RHS_Mi8MTV3_heavy_vdv","RHS_Mi8MTV3_heavy_vvs","RHS_Mi8MTV3_heavy_vvsc","RHS_Mi8MT_vdv","RHS_Mi8MT_vvs","RHS_Mi8MT_vvss"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airLogistic,["RHS_Mi8mt_Cargo_vdv","RHS_Mi8mt_Cargo_vvs","RHS_Mi8mt_Cargo_vvsc"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airRecon,["rhs_mi24p_vvs","rhs_mi24p_vvsc","rhs_mi24v_vvs","rhs_mi24v_vvsc"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airContainerMedic+ADV_opf_veh_airContainerTransport,[""],east] call ADV_fnc_changeVeh;
	};
	//RHS transport Ka52
	case 22: {
		[ADV_opf_veh_airTransport,["RHS_Mi8MTV3_heavy_vdv","RHS_Mi8MTV3_heavy_vvs","RHS_Mi8MTV3_heavy_vvsc","RHS_Mi8MT_vdv","RHS_Mi8MT_vvs","RHS_Mi8MT_vvss"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airLogistic,["RHS_Mi8mt_Cargo_vdv","RHS_Mi8mt_Cargo_vvs","RHS_Mi8mt_Cargo_vvsc"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airRecon,["rhs_ka52_vvsc","rhs_ka52_vvs"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airContainerMedic+ADV_opf_veh_airContainerTransport,[""],east] call ADV_fnc_changeVeh;
	};
	//RHS transport Mi28
	case 23: {
		[ADV_opf_veh_airTransport,["RHS_Mi8MTV3_heavy_vdv","RHS_Mi8MTV3_heavy_vvs","RHS_Mi8MTV3_heavy_vvsc","RHS_Mi8MT_vdv","RHS_Mi8MT_vvs","RHS_Mi8MT_vvss"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airLogistic,["RHS_Mi8mt_Cargo_vdv","RHS_Mi8mt_Cargo_vvs","RHS_Mi8mt_Cargo_vvsc"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airRecon,["rhs_mi28n_vvs","rhs_mi28n_vvsc"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airContainerMedic+ADV_opf_veh_airContainerTransport,[""],east] call ADV_fnc_changeVeh;
	};
	//RHS CAS only
	case 24: {
		[ADV_opf_veh_airLogistic,["RHS_Mi8MTV3_heavy_vdv","RHS_Mi8MTV3_heavy_vvs","RHS_Mi8MTV3_heavy_vvsc"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airTransport,["rhs_mi24p_vvs","rhs_mi24p_vvsc","rhs_mi24v_vvs","rhs_mi24v_vvsc"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airRecon,["rhs_ka52_vvsc","rhs_ka52_vvs","rhs_mi28n_vvs","rhs_mi28n_vvsc"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airContainerMedic+ADV_opf_veh_airContainerTransport,[""],east] call ADV_fnc_changeVeh;
	};
	//RHS civilian
	case 25: {
		[ADV_opf_veh_helis,["RHS_Mi8amt_civilian"],east] call ADV_fnc_changeVeh;
		[ADV_opf_veh_airContainerMedic+ADV_opf_veh_airContainerTransport,[""],east] call ADV_fnc_changeVeh;
	};
	//no vehicles
	case 99: {[ADV_opf_veh_helis+ADV_opf_veh_airContainerMedic+ADV_opf_veh_airContainerTransport,[""],east] call ADV_fnc_changeVeh;};
	default {};
};

//replaces planes with mod planes:
switch ( _par_opfAirAssets ) do {
	//Apex Xi'an
	//case 0: { [ADV_opf_veh_airC130,["O_T_VTOL_02_infantry_F"],west] call ADV_fnc_changeVeh; };
	//RHS SU-25
	case 20: {
		[ADV_opf_veh_airCAS,["RHS_Su25SM_vvsc","RHS_Su25SM_vvs"],east] call ADV_fnc_changeVeh;
	};
	//RHS Su T-50
	case 22: {
		[ADV_opf_veh_airCAS,["RHS_T50_vvs_generic","RHS_T50_vvs_blueonblue"],east] call ADV_fnc_changeVeh;
	};
	//JS SU35
	case 40: {
		[ADV_opf_veh_airCAS,["JS_JC_SU35"],east] call ADV_fnc_changeVeh;
	};
	//no planes
	case 99: {[ADV_opf_veh_airCAS,[""],east] call ADV_fnc_changeVeh;};
	default {};
};

true;
/*
 * Author: Belbo
 *
 * Handles all vehicles for side INDFOR in adv_missiontemplate
 *
 * Arguments:
 * None.
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [] call adv_ind_fnc_manageVeh;
 *
 * Public: Yes
 */

if (!isServer) exitWith {};

//markers for the vehicle garages:
_veh_lightMarkers = ["ind_garage_1","ind_garage_2","ind_garage_3","ind_garage_4","ind_garage_5"];
_veh_heavyMarkers = ["ind_garage_heavy_1","ind_garage_heavy_2","ind_garage_heavy_3","ind_garage_heavy_4","ind_garage_heavy_5"];
_veh_heliMarkers = ["ind_garage_air_1"];
_veh_fixedMarkers = ["ind_garage_air_2"];

//unique vehicles placed in the editor:
ADV_ind_veh_airTransport = [];
ADV_ind_veh_airRecon = [];
ADV_ind_veh_airLogistic = [];

ADV_ind_veh_airCAS = [];
ADV_ind_veh_airC130 = [];

ADV_ind_veh_MRAPs = [];
ADV_ind_veh_MRAPsHMG = [];
ADV_ind_veh_MRAPsGMG = [];
ADV_ind_veh_transport = [];
ADV_ind_veh_logistic_fuel = [];
ADV_ind_veh_logistic_ammo = [];
ADV_ind_veh_logistic_repair = [];
ADV_ind_veh_logistic_medic = [];
ADV_ind_veh_ATVs = [];
ADV_ind_veh_UAVs = [];
ADV_ind_veh_UGVs = [];
ADV_ind_veh_UGVs_repair = [];

ADV_ind_veh_heavys = [];
ADV_ind_veh_tanks = [];
ADV_ind_veh_artys = [];

///// No editing necessary below this line /////

{
	_vehicleName = str _x;
	switch ( true ) do {
		//helicopters
		case ( _vehicleName select [0,17] == "ind_air_transport" ): { ADV_ind_veh_airTransport pushBack _vehicleName; };
		case ( _vehicleName select [0,13] == "ind_air_recon" ): { ADV_ind_veh_airRecon pushBack _vehicleName; };
		case ( _vehicleName select [0,16] == "ind_air_logistic" ): { ADV_ind_veh_airLogistic pushBack _vehicleName; };
		//fixed wing planes
		case ( _vehicleName select [0,11] == "ind_air_cas" ): { ADV_ind_veh_airCAS pushBack _vehicleName; };
		case ( _vehicleName select [0,12] == "ind_air_c130" ): { ADV_ind_veh_airC130 pushBack _vehicleName; };
		//MRAPs
		case ( _vehicleName select [0,12] == "ind_MRAP_hmg" ): { ADV_ind_veh_MRAPsHMG pushBack _vehicleName; };
		case ( _vehicleName select [0,14] == "ind_OffroadHMG" ): { ADV_ind_veh_MRAPsHMG pushBack _vehicleName; };
		case ( _vehicleName select [0,12] == "ind_MRAP_gmg" ): { ADV_ind_veh_MRAPsGMG pushBack _vehicleName; };
		case ( _vehicleName select [0,8] == "ind_MRAP" ): { ADV_ind_veh_MRAPs pushBack _vehicleName; };
		case ( _vehicleName select [0,7] == "ind_SUV" ): { ADV_ind_veh_MRAPs pushBack _vehicleName; };
		case ( _vehicleName select [0,11] == "ind_Offroad" ): { ADV_ind_veh_MRAPs pushBack _vehicleName; };
		//logistics
		case ( _vehicleName select [0,7] == "ind_uav" ): { ADV_ind_veh_UAVs pushBack _vehicleName; };
		case ( _vehicleName select [0,7] == "ind_ugv" ): { ADV_ind_veh_UGVs pushBack _vehicleName; };
		case ( _vehicleName select [0,14] == "ind_ugv_repair" ): { ADV_ind_veh_UGVs_repair pushBack _vehicleName; };
		case ( _vehicleName select [0,7] == "ind_ATV" ): { ADV_ind_veh_ATVs pushBack _vehicleName; };
		case ( _vehicleName select [0,13] == "ind_transport" ): { ADV_ind_veh_transport pushBack _vehicleName; };
		case ( _vehicleName select [0,8] == "ind_fuel" ): { ADV_ind_veh_logistic_fuel pushBack _vehicleName; };
		case ( _vehicleName select [0,17] == "ind_logistic_fuel" ): { ADV_ind_veh_logistic_fuel pushBack _vehicleName; };
		case ( _vehicleName select [0,8] == "ind_ammo" ): { ADV_ind_veh_logistic_ammo pushBack _vehicleName; };
		case ( _vehicleName select [0,17] == "ind_logistic_ammo" ): { ADV_ind_veh_logistic_ammo pushBack _vehicleName; };
		case ( _vehicleName select [0,10] == "ind_repair" ): { ADV_ind_veh_logistic_repair pushBack _vehicleName; };
		case ( _vehicleName select [0,19] == "ind_logistic_repair" ): { ADV_ind_veh_logistic_repair pushBack _vehicleName; };
		case ( _vehicleName select [0,18] == "ind_logistic_medic" ): { ADV_ind_veh_logistic_medic pushBack _vehicleName; };
		//armored
		case ( _vehicleName select [0,9] == "ind_heavy" ): { ADV_ind_veh_heavys pushBack _vehicleName; };
		case ( _vehicleName select [0,8] == "ind_tank" ): { ADV_ind_veh_tanks pushBack _vehicleName; };
		case ( _vehicleName select [0,8] == "ind_arty" ): { ADV_ind_veh_artys pushBack _vehicleName; };
		default {};
	};
	nil;
} count vehicles;

ADV_ind_veh_helis = ADV_ind_veh_airRecon+ADV_ind_veh_airTransport+ADV_ind_veh_airLogistic;
ADV_ind_veh_fixedWing = ADV_ind_veh_airCAS+ADV_ind_veh_airC130+ADV_ind_veh_UAVs;
ADV_ind_veh_air = ADV_ind_veh_helis+ADV_ind_veh_fixedWing;
ADV_ind_veh_armored = ADV_ind_veh_heavys+ADV_ind_veh_tanks+ADV_ind_veh_artys;
ADV_ind_veh_car = ADV_ind_veh_MRAPs+ADV_ind_veh_MRAPsHMG+ADV_ind_veh_MRAPsGMG;
ADV_ind_veh_logistic = ADV_ind_veh_transport+ADV_ind_veh_logistic_repair+ADV_ind_veh_logistic_fuel+ADV_ind_veh_logistic_ammo+ADV_ind_veh_logistic_medic;
ADV_ind_veh_light = ADV_ind_veh_ATVs+ADV_ind_veh_UGVs+ADV_ind_veh_UGVs_repair+ADV_ind_veh_car+ADV_ind_veh_logistic;

ADV_ind_veh_all = ADV_ind_veh_light+ADV_ind_veh_armored+ADV_ind_veh_air;
publicVariable "ADV_ind_veh_all";

//lobby params:
private _par_assets_cars = missionNamespace getVariable ["ADV_par_Assets_cars",1];
private _par_assets_tanks = missionNamespace getVariable ["ADV_par_Assets_tanks",1];
private _par_assets_air_helis = missionNamespace getVariable ["ADV_par_Assets_air_helis",1];
private _par_assets_air_fixed = missionNamespace getVariable ["ADV_par_Assets_air_fixed",1];
private _par_indCarAssets = missionNamespace getVariable ["ADV_par_indCarAssets",0];

//removes the markers according to the lobby params
if ( _par_Assets_cars isEqualTo 0 || _par_Assets_cars isEqualTo 99 || _par_indCarAssets isEqualTo 99 ) then {
	{_x setMarkerAlpha 0;} count _veh_lightMarkers
};
if ( _par_Assets_tanks isEqualTo 0 || _par_Assets_tanks isEqualTo 99 ) then {
	{_x setMarkerAlpha 0;} count _veh_heavyMarkers;
};
if ( _par_Assets_air_helis isEqualTo 0 ||  _par_Assets_air_helis isEqualTo 99 ) then {
	{_x setMarkerAlpha 0;} count _veh_heliMarkers;
};
if ( (_par_Assets_air_fixed isEqualTo 0 && _par_Assets_air_helis isEqualTo 0) || (_par_Assets_air_fixed isEqualTo 99 && _par_Assets_air_helis isEqualTo 99)) then {
	{_x setMarkerAlpha 0;} count _veh_fixedMarkers;
};

//manages disablement and load.
adv_ind_manageVeh_codeForAll = {
	_veh = _this;
	private _isChanged = _veh getVariable ["adv_var_vehicleIsChanged",false];
	_veh setVariable ["adv_var_vehicleIsChanged",_isChanged,true];
	_veh enableDynamicSimulation true;
	if ( (missionNamespace getVariable ["adv_par_customLoad",1]) > 0 ) then {
		[_veh] call ADV_fnc_clearCargo;
		sleep 0.2;
		[_veh] call ADV_ind_fnc_addVehicleLoad;
	};
	[_veh] call ADV_ind_fnc_disableVehSelector;
	if ( (missionNamespace getVariable ["ADV_par_engineArtillery",0]) isEqualTo 1 && str _veh in ADV_ind_veh_artys) then {
		[_veh] call ADV_fnc_showArtiSetting;
	};
	if ( (missionNamespace getVariable ["ADV_par_TIEquipment",0]) > 0 ) then {
		_veh disableTIEquipment true;
		if ( (missionNamespace getVariable ["ADV_par_TIEquipment",0]) > 2 ) then {
			_veh disableNVGEquipment true;
		};
	};
	if ( (missionNamespace getVariable ["ADV_par_Radios",1]) > 0 && (_veh isKindOf 'CAR' || _veh isKindOf 'TANK' || _veh isKindOf 'AIR') && !(_veh isKindOf "Quadbike_01_base_F") ) then {
		_veh setVariable ["tf_side", independent, true];
		_veh setVariable ["tf_hasRadio", true, true];
		call {
			if (_veh isKindOf 'AIR') exitWith {
				if (isClass(configFile >> "CfgPatches" >> "tfar_core")) then {
					_veh setVariable ["TF_RadioType", "tfar_anarc164", true];
				} else {
					_veh setVariable ["TF_RadioType", "tf_anarc164", true];
				};
			};
			if (isClass(configFile >> "CfgPatches" >> "tfar_core")) then {
				_veh setVariable ["TF_RadioType", "tfar_anprc155", true];
			} else {
				_veh setVariable ["TF_RadioType", "tf_anprc155", true];
			};
		};
	};
	if ( (missionNamespace getVariable ["ADV_par_indUni",0]) isEqualTo 1 && (missionNamespace getVariable ["ADV_par_indCarAssets",0]) isEqualTo 1 && !(worldname == 'TANOA') && (str _veh in ADV_ind_veh_transport+ADV_ind_veh_airRecon)) then {
		_veh setObjectTextureGlobal [0,'#(rgb,8,8,3)color(1,1,1,0.004)'];
		if (str _veh in ADV_ind_veh_transport) then {
			_veh setObjectTextureGlobal [1,'#(rgb,8,8,3)color(1,1,1,0.004)'];
		};
	};
	if !( (missionNamespace getVariable ["ADV_par_vehicleRespawn",300]) isEqualTo 9999 ) then {
		[_veh,ADV_par_vehicleRespawn, independent] call ADV_fnc_respawnVeh;
	};
	if ( str _veh in ADV_ind_veh_armored+ADV_ind_veh_logistic && !(_veh isKindOf "LT_01_base_F") ) then {
		_veh forceFlagTexture (missionNamespace getVariable ["adv_var_vehicleFlag_ind","img\flag.paa"]);
		if ( str _veh in ADV_ind_veh_logistic_medic ) then {
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
	};
};
//application of code:
{
	private _vehObj = missionNamespace getVariable [_x,objNull];
	if (!isNull _vehObj) then {
		_vehObj spawn adv_ind_manageVeh_codeForAll;
	};
	nil;
} count ADV_ind_veh_all;

//replaces MRAPS with mod cars:
switch ( _par_indCarAssets ) do {
	case 1: {};
	case 99: {[ADV_ind_veh_all,[""],independent] call ADV_fnc_changeVeh;};
	default {};
};

true;
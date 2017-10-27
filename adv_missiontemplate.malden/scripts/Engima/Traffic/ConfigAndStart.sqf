/* 
 * This file contains parameters to config and function call to start an instance of
 * traffic in the mission. The file is edited by the mission developer.
 *
 * See file Engima\Traffic\Documentation.txt for documentation and a full reference of 
 * how to customize and use Engima's Traffic.
 */
 
private _unitConfig = call {
	if ( isClass(configfile >> "CfgPatches" >> "CUP_Creatures_People_Core") && toUpper worldname in ADV_var_aridMaps ) exitWith {
		[
			//smaller cars:
			"CUP_C_Volha_Blue_TKCIV","CUP_C_Volha_Gray_TKCIV","CUP_C_Volha_Limo_TKCIV","CUP_C_Skoda_Blue_CIV","CUP_C_Skoda_Green_CIV","CUP_C_Skoda_White_CIV","CUP_C_Datsun_Covered","CUP_C_Datsun_Plain","CUP_C_Datsun_Tubeframe","CUP_C_Lada_GreenTK_CIV","CUP_C_Lada_TK2_CIV"
			,"CUP_C_Volha_Blue_TKCIV","CUP_C_Volha_Gray_TKCIV","CUP_C_Volha_Limo_TKCIV","CUP_C_Skoda_Blue_CIV","CUP_C_Skoda_Green_CIV","CUP_C_Skoda_White_CIV","CUP_C_Datsun_Covered","CUP_C_Datsun_Plain","CUP_C_Datsun_Tubeframe","CUP_C_Lada_GreenTK_CIV","CUP_C_Lada_TK2_CIV"
			,"CUP_C_UAZ_Unarmed_TK_CIV","CUP_C_UAZ_Open_TK_CIV"
			//trucks and transporters:
			,"CUP_C_S1203_CIV","CUP_C_S1203_Ambulance_CIV"
			,"C_IDAP_Truck_02_water_F","C_Truck_02_fuel_F","CUP_C_Ikarus_TKC","CUP_C_Ural_Civ_01","CUP_C_Ural_Open_Civ_01","CUP_C_LR_Transport_CTK","CUP_C_V3S_Covered_TKC","CUP_C_V3S_Open_TKC","CUP_C_Ural_Civ_02","CUP_C_Ural_Open_Civ_02"
		]
	};
	if ( isClass(configfile >> "CfgPatches" >> "CUP_Creatures_People_Core") && toUpper worldname in ADV_var_europeMaps && !(toUpper worldname in ADV_var_vanillaMaps) ) exitWith {
		[	
			//smaller cars:
			"C_Offroad_02_unarmed_F","C_Offroad_01_repair_F","CUP_C_Skoda_Blue_CIV","CUP_C_Skoda_Green_CIV","CUP_C_Skoda_White_CIV","CUP_C_Datsun_Covered","CUP_C_Datsun_Plain","CUP_C_Datsun_Tubeframe","CUP_C_Golf4_random_Civ","CUP_C_Octavia_CIV"
			,"C_Offroad_02_unarmed_F","C_Offroad_01_repair_F","CUP_C_Skoda_Blue_CIV","CUP_C_Skoda_Green_CIV","CUP_C_Skoda_White_CIV","CUP_C_Datsun_Covered","CUP_C_Datsun_Plain","CUP_C_Datsun_Tubeframe","CUP_C_Golf4_random_Civ","CUP_C_Octavia_CIV"
			//trucks and transporters:
			,"C_Van_01_transport_F","C_Van_01_box_F","C_Van_01_fuel_F","C_Van_02_vehicle_F","C_Van_02_service_F","C_Van_02_transport_F","C_Truck_02_fuel_F","C_Truck_02_box_F","C_Truck_02_transport_F","C_Truck_02_covered_F"
			,"CUP_C_Ikarus_Chernarus","CUP_C_SUV_CIV","CUP_C_Ural_Civ_01","CUP_C_Ural_Open_Civ_01","CUP_C_LR_Transport_CTK","CUP_C_V3S_Covered_TKC"
		]
	};
	[
		//smaller cars:
		"C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Offroad_02_unarmed_F","C_Offroad_01_F","C_Offroad_01_repair_F","C_SUV_01_F"
		,"C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Offroad_02_unarmed_F","C_Offroad_01_F","C_Offroad_01_repair_F","C_SUV_01_F"
		,"C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Offroad_02_unarmed_F","C_Offroad_01_F","C_Offroad_01_repair_F","C_SUV_01_F"
		//trucks and transporters
		,"C_Van_01_transport_F","C_Van_01_box_F","C_Van_01_fuel_F","C_Van_02_vehicle_F","C_Van_02_service_F","C_Van_02_transport_F","C_Truck_02_fuel_F","C_Truck_02_box_F","C_Truck_02_transport_F","C_Truck_02_covered_F"
	]
};

// Set traffic parameters.
private _parameters = [
	["SIDE", civilian],
	["VEHICLES", _unitConfig],
	["VEHICLES_COUNT", 5],
	["MAX_GROUPS_COUNT", 0],
	["MIN_SPAWN_DISTANCE", 800],
	["MAX_SPAWN_DISTANCE", 2000],
	["MIN_SKILL", 0.01],
	["MAX_SKILL", 0.1],
	["AREA_MARKER", ""],
	["HIDE_AREA_MARKER", true],
	["ON_UNIT_CREATING", { true }],
	["ON_UNIT_CREATED", {}],
	["ON_UNIT_REMOVING", {}],
	["DEBUG", false]
];

// Start an instance of the traffic
_parameters spawn ENGIMA_TRAFFIC_StartTraffic;

/*
mission markers removal script by Belbo
removes UPS-/mission markers (numbers, areaX, area_X, upsmarker_X, missionMarker_X) from briefing or controls their opacity.
call from init.sqf and initPlayerLocal.sqf (as early as possible) via:
defined in cfgFunctions (functions\preInit\fn_missionMarkers.sqf)
called via preInit for server and once for every client in initPlayerLocal.sqf with:

	[] call ADV_fnc_sideMarkers;

*/	

[] spawn {
	//startMarkers:
	_bluforMarker = ["base","base_1","flagMarker","flagMarker_1","briefArea","briefArea_1","crates","crates_1","garage_1","garage_2","garage_heavy_1","garage_heavy_2","garage_heavy_3","garage_air_1","garage_air_2"];
	_opforMarker = ["opf_base","opf_base_1","opf_flagMarker","opf_flagMarker_1","opf_briefArea","opf_briefArea_1","opf_crates","opf_crates_1","opf_garage_1","opf_garage_2","opf_garage_heavy_1","opf_garage_heavy_2","opf_garage_heavy_3","opf_garage_air_1","opf_garage_air_2"];
	_indMarker = ["ind_base","ind_base_1","ind_flagMarker","ind_flagMarker_1","ind_briefArea","ind_briefArea_1","ind_crates","ind_crates_1","ind_garage_1","ind_garage_2","ind_garage_heavy_1","ind_garage_heavy_2","ind_garage_heavy_3","ind_garage_air_1","ind_garage_air_2"];

	///// No editing necessary below this line /////

	if (hasInterface) then {
		waitUntil {player == player};
		if ((side player) == west) then {
			{deleteMarkerLocal _x; nil;} count _opforMarker+_indMarker;
		};
		if ((side player) == east) then {
			{deleteMarkerLocal _x; nil;} count _bluforMarker+_indMarker;
		};
		if ((side player) == independent) then {
			{deleteMarkerLocal _x; nil;} count _bluforMarker+_opforMarker;
			if (!isNil "ADV_par_indUni") then {
				switch (ADV_par_indUni) do {
					case 20: {
						"ind_base" setMarkerTypeLocal "flag_Syndicat";
						"ind_base" setMarkerTextLocal "Syndikat";
						//{_x setMarkerColorLocal "ColorBrown"} forEach _indMarker;
					};
					case 1: {
						"ind_base" setMarkerTypeLocal "Ioc_WaterTower";
						"ind_base" setMarkerTextLocal "Brackwasser Security Consulting";
						"ind_base" setMarkerColorLocal "ColorGUER";
					};
					default {};
				};
			};
		};
		if ((side player) == sideEnemy) then {
			{deleteMarkerLocal _x; nil;} count _bluforMarker+_opforMarker+_indMarker;
		};
	};
};

true;
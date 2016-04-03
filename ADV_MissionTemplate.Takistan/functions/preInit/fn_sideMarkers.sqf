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
	_bluforMarker = ["base","flagMarker","briefArea","crates","garage_1","garage_2","garage_heavy_1","garage_heavy_2","garage_heavy_3","garage_air_1","garage_air_2"];
	_opforMarker = ["opf_base","opf_base_1","opf_flagMarker","opf_flagMarker_1","opf_briefArea","opf_briefArea_1","opf_crates","opf_crates_1","opf_garage_1","opf_garage_2","opf_garage_heavy_1","opf_garage_heavy_2","opf_garage_heavy_3","opf_garage_air_1","opf_garage_air_2"];
	_indMarker = ["ind_base","ind_flagMarker","ind_briefArea","ind_crates","ind_garage_1"];

	///// No editing necessary below this line /////

	if (hasInterface) then {
		waitUntil {player == player};
		if ((side player) == west) then {
			{_x setMarkerAlphaLocal 0;} forEach _opforMarker+_indMarker;
		};
		if ((side player) == east) then {
			{_x setMarkerAlphaLocal 0;} forEach _bluforMarker+_indMarker;
		};
		if ((side player) == independent) then {
			{_x setMarkerAlphaLocal 0;} forEach _bluforMarker+_opforMarker;
			if (!isNil "ADV_par_indUni") then {
				if (ADV_par_indUni == 1) then {
					"ind_base" setMarkerColorLocal "Default";
					"ind_base" setMarkerTypeLocal "flag_AAF";
					"ind_base" setMarkerTextLocal "";
				};
			};
		};
		if ((side player) == sideEnemy) then {
			{_x setMarkerAlphaLocal 0;} forEach _bluforMarker+_opforMarker+_indMarker;
		};
	};
};

true;
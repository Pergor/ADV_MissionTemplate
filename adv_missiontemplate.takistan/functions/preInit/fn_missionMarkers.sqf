﻿/*
mission markers removal script by Belbo
removes UPS-/mission markers (numbers, areaXYZ, upsmarkerXYZ) from briefing or controls their opacity.
call from init.sqf and initPlayerLocal.sqf (as early as possible) via:
defined in cfgFunctions (functions\preInit\fn_missionMarkers.sqf)
called via preInit for server and once for every client in initPlayerLocal.sqf with:

	[] call ADV_fnc_missionMarkers;

*/	

//additional Markers to be completely hidden:
//private _hideMarker = ["resupply","area","upsmarker","missionMarker","area_civ"];
//Markers with lower opacity:
private _opacMarker = ["snipe_pos"];

///// No editing necessary below this line /////
{
	if (toUpper (_x select [0,4]) == "AREA" || toUpper (_x select [0,9]) == "UPSMARKER") then {
		_x setMarkerAlphaLocal 0;
	};
} count allMapMarkers;

//{_x setMarkerAlphaLocal 0;} count _hideMarker;
for "_x" from 1 to 100 do {
	format ["%1",_x] setMarkerAlphaLocal 0;
	//format ["%1%2","area_",_x] setMarkerAlphaLocal 0;
	//format ["%1%2","area",_x] setMarkerAlphaLocal 0;
	//format ["%1%2","area_civ_",_x] setMarkerAlphaLocal 0;
	//format ["%1%2","upsmarker",_x] setMarkerAlphaLocal 0;
	//format ["%1%2","upsmarker_",_x] setMarkerAlphaLocal 0;
	//format ["%1%2","missionMarker",_x] setMarkerAlphaLocal 0;
	//format ["%1%2","missionMarker_",_x] setMarkerAlphaLocal 0;
};

//opacity for _opacMarker (range from 0.0 to 1.0)
_opacity = 0.7;
//mission markers with lower opacity:
{_x setmarkeralpha _opacity;} count _opacMarker;

true;
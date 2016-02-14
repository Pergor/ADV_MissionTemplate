/*
mission markers removal script by Belbo
removes UPS-/mission markers (numbers, areaX, area_X, upsmarker_X, missionMarker_X) from briefing or controls their opacity.
call from init.sqf and initPlayerLocal.sqf (as early as possible) via:
defined in cfgFunctions (functions\preInit\fn_missionMarkers.sqf)
called via preInit for server and once for every client in initPlayerLocal.sqf with:

	[] call ADV_fnc_missionMarkers;

*/	

//additional Markers to be completely hidden:
_hideMarker = ["resupply","area","upsmarker","missionMarker","area_civ"];
//Markers with lower opacity:
_opacMarker = ["snipe_pos"];

///// No editing necessary below this line /////
{_x setMarkerAlphaLocal 0;} forEach _hideMarker;
for "_x" from 1 to 100 do {
	format ["%1%2","area_",_x] setMarkerAlphaLocal 0;
	format ["%1%2","area",_x] setMarkerAlphaLocal 0;
	format ["%1",_x] setMarkerAlphaLocal 0;
	format ["%1%2","area_civ_",_x] setMarkerAlphaLocal 0;
	format ["%1%2","upsmarker",_x] setMarkerAlphaLocal 0;
	format ["%1%2","upsmarker_",_x] setMarkerAlphaLocal 0;
	format ["%1%2","missionMarker",_x] setMarkerAlphaLocal 0;
	format ["%1%2","missionMarker_",_x] setMarkerAlphaLocal 0;
};

//opacity for _opacMarker (range from 0.0 to 1.0)
_opacity = 0.7;
//mission markers with lower opacity:
{_x setmarkeralpha _opacity;} forEach _opacMarker;

true;
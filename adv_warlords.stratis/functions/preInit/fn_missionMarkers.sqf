/*
 * Author: Belbo
 *
 * hides UPS-/mission markers (numbers, areaXXX, upsmarkerXXX) from briefing or controls the opacity of certain markers.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [] call adv_fnc_missionMarkers;
 *
 * Public: No
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

true;
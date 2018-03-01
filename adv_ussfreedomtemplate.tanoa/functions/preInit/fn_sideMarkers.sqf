/*
 * Author: Belbo
 *
 * Hides markers from each side in adv_missiontemplate to the enemy sides on map
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [] call adv_fnc_sideMarkers;
 *
 * Public: No
 */

[] spawn {
	//startMarkers:
	
	private _markerArray = [] call adv_fnc_userMarkers;
	_markerArray params [
		"_bluforMarker"
		,"_opforMarker"
		,"_indMarker"
		,"_opacMarker"
	];

	///// No editing necessary below this line /////

	if (hasInterface) then {
		//opacity for _opacMarker (range from 0.0 to 1.0)
		private _opacity = 0.7;
		//mission markers with lower opacity:
		{_x setmarkeralphaLocal _opacity;} count _opacMarker;

		waitUntil {player == player};
		
		//remove/change markers:
		if ((side player) == west) exitWith {
			{deleteMarkerLocal _x; nil;} count _opforMarker+_indMarker;
			waitUntil {!isNil "ADV_params_defined"};
			private _uniforms = missionNamespace getVariable ["ADV_par_customUni",0];
			switch ( true ) do {
				case ( _uniforms in [2,1] ): { "base" setMarkerTypeLocal "flag_Germany"; };
				case ( _uniforms in [12,6,30] ): { "base" setMarkerTypeLocal "flag_UK"; };
				case ( _uniforms in [10,8,7] ): { "base" setMarkerTypeLocal "flag_USA"; };
				default {};
			};
		};
		if ((side player) == east) exitWith {
			{deleteMarkerLocal _x; nil;} count _bluforMarker+_indMarker;
			waitUntil {!isNil "ADV_params_defined"};
			private _uniforms = missionNamespace getVariable ["ADV_par_opfUni",0];
			switch ( true ) do {
				case ( _uniforms in [4,3,2,1] ): {
					"opf_base" setMarkerTypeLocal "rhs_flag_Russia";
				};
				default {};
			};	
		};
		if ((side player) == independent) exitWith {
			{deleteMarkerLocal _x; nil;} count _bluforMarker+_opforMarker;
			waitUntil {!isNil "ADV_params_defined"};
			switch ( missionNamespace getVariable ["ADV_par_indUni",0] ) do {
				case 20: {
					"ind_base" setMarkerTypeLocal "flag_Syndicat";
					"ind_base" setMarkerTextLocal "Syndikat";
					//{_x setMarkerColorLocal "ColorBrown"} forEach _indMarker;
				};
				case 1: {
					"ind_base" setMarkerTypeLocal "loc_WaterTower";
					"ind_base" setMarkerTextLocal "Brackwasser Security Consulting";
					"ind_base" setMarkerColorLocal "ColorGUER";
				};
				default {};
			};
		};
		if ((side player) == sideEnemy) exitWith {
			{deleteMarkerLocal _x; nil;} count _bluforMarker+_opforMarker+_indMarker;
		};
	};
};

true;
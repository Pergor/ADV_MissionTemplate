/*
 * Author: Belbo
 *
 * Creates civilian units that will roam the provided area or around location.
 *
 * Arguments:
 * 0: location for spawn (can be position, object or marker) - <ARRAY>, <OBJECT>, <STRING>
 *
 * Return Value:
 * Spawned group - <GROUP>
 *
 * Example:
 * ["spawnMarker",["O_Soldier_TL_F","O_Soldier_GL_F"],east,0,200] call adv_fnc_aiTask;
 * or
 * ["spawnMarker",["O_Soldier_TL_F","O_Soldier_GL_F"],east,4,200,[attackLogic,50]] call adv_fnc_aiTask;
 *
 * Public: Yes
 */

if (!isServer && hasInterface) exitWith {};

params [
	["_location", [0,0,0], [[],"",objNull]]
	,["_units", [], [[]]]
	,["_radius", 300, [0]]
];

if (_units isEqualTo []) then {
	_units = call {
		//fix wrong entry!
		if (isClass(configFile >> "CfgPatches" >> "CUP_CREATURES_PEOPLE_CIVIL_RUSSIA")) exitWith {
			if ( (toUpper worldname) in (missionNamespace getVariable ["ADV_var_europeMaps",[]]) ) exitWith {
				["CUP_C_C_CITIZEN_01","CUP_C_C_CITIZEN_02","CUP_C_C_PROFITEER_02","CUP_C_C_PROFITEER_03","CUP_C_C_WOODLANDER_01","CUP_C_C_WOODLANDER_04"]
			};
			["CUP_C_C_CITIZEN_01","CUP_C_C_CITIZEN_02","CUP_C_C_PROFITEER_02","CUP_C_C_PROFITEER_03","CUP_C_C_WOODLANDER_01","CUP_C_C_WOODLANDER_04"]
		};
		["C_MAN_CASUAL_1_F","C_MAN_CASUAL_2_F","C_MAN_CASUAL_3_F","C_MAN_POLO_1_F","C_MAN_POLO_2_F","C_MAN_P_FUGITIVE_F"]
	};
};

//get spawning location:
private _start = call {
	if (_location isEqualType "") exitWith {getMarkerPos _location};
	if (_location isEqualType objNull) exitWith {getPosATL _location};
	if (_location isEqualType []) exitWith {_location};
	nil;
};

//get _area if _location is already an appropriate marker:
private _area = "";
if (_location isEqualType "") then {
	if (markerShape _location in ["ELLIPSE","RECTANGLE","POLYLINE"]) then {
		private _size = getMarkerSize _location;
		private _biggerSide = (_size select 0) max (_size select 1);
		private _smallerSide = (_size select 0) min (_size select 1);
		//circle with radius of the geometric mean of the ellipse's radius has the same area as the ellipse:
		_radius = sqrt (_biggerSide * _smallerSide);
		_area = _location;
	};
};
//create _area if _location is either position, objekt or markershape "ICON":
if (isNil "adv_civilian_area_name") then { adv_civilian_area_name = 0 };
private _areaCreation = {
	params ["_start","_radius"];
	private _area = createMarker [format ["%1%2","adv_civilian_area_",adv_civilian_area_name], _start];
	adv_civilian_area_name = adv_civilian_area_name + 1;
	_area setMarkerShape "ELLIPSE";
	_area setMarkerSize [_radius,_radius];
	_area setMarkerAlpha 0;
	_area;
};
if (_area isEqualTo "") then {
	call {
		if (_location isEqualType "") exitWith {
			if !(toUpper (markerShape _location) in ["RECTANGLE","ELLIPSE","POLYLINE"]) then {
				_area = [_start,_radius] call _areaCreation;
			};
		};
		_area = [_start,_radius] call _areaCreation;
	};
};

private _spawnedCivs = [];
{
	private _grp = [_start,[_x],civilian] call adv_fnc_spawnGroup;
	_spawnedCivs pushBack _grp;
	nil;
} count _units;

{
	call {
		if (floor(random 10) < 2) exitWith {
			[_start, units _x, _radius, true, true] call adv_fnc_ZenOccupyHouse;
		};
		nul = [(leader _x),_area,"RANDOM","NOFOLLOW","LIMITED","CARELESS"] spawn adv_fnc_upsmon;
	};
} count _spawnedCivs;

_spawnedCivs;
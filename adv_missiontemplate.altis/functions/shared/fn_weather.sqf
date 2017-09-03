/*
 * Author: Belbo
 *
 * Creates pre set weather conditions for whole mission.
 *
 * Arguments:
 * None.
 *
 * Return Value:
 * Script handle <HANDLE>
 *
 * Example:
 * _handle = [] call adv_fnc_weather;
 *
 * Public: No
 */
 
_parRandomWeather = missionNamespace getVariable ["adv_par_randomWeather",99];
if !(_parRandomWeather isEqualTo 99) exitWith {};

params [
	["_parWeather",(missionNamespace getVariable ["adv_par_weather",99])]
];

_handle = [_parWeather] spawn {
	params ["_weather"];
	if (_weather isEqualTo 99) exitWith {};
	private _randomWeathers = [1,2,2,2,2,3,3,3,4,5,6,7,8,9];
	//_weatherValue = if (_weather == 98) then { (floor (random 9))+1 } else { _weather };
	private _weatherValue = if (_weather isEqualTo 98) then { selectRandom _randomWeathers } else { _weather };
	private _weatherArray = switch (_weatherValue) do {
		case 2: {[0.3, 0, [0, 0, 0], [1-(random 2), 1-(random 2), true], 0, 0.3]};	//clear
		case 3: {[0.69, 0, [0.05, 0.1, 10], [2-(random 4), 2-(floor random 4), true], 0.2, 0.6]};	//overcast
		case 4: {[0.71, 0.3, [0.1, 0.1, 20], [3-(random 6), 3-(random 6), true], 0.4, 0.6]};	//light rain
		case 5: {[0.75, 0.5, [0.1, 0.1, 20], [4-(random 8), 4-(random 8), true], 0.6, 0.8]};	//medium rain
		case 6: {[0.93, 0.9, [0.13, 0.005, 100], [5, 5, true], 0.9, 1]};	//heavy rain
		case 7: {[0.4, 0, [0.2, 0.01, 20], [0, 0, true], 0, 0.2]};	//light fog
		case 8: {[0.4, 0, [0.4, 0.005, 20], [0, 0, true], 0, 0.2]};	//medium fog
		case 9: {[0.5, 0, [0.5, 0.0025, 40], [0, 0, true], 0, 0.2]}; //dense fog
		default {[0, 0, [0, 0, 0], [1-(random 2), 1-(random 2), true], 0, 0.3]}; //sunny
	};

	if (isNil "_weatherArray") exitWith {false};

	_weatherArray params ["_initialOvercast","_initialRain","_initialFog","_initialWind","_initialLightning","_initialWaves"];

	skipTime 24;
	if (isServer) then {
		//84600 setOvercast _initialOvercast;
		[_initialOvercast] call BIS_fnc_setOvercast;
		0 setRain _initialRain;
		setWind _initialWind;
	};
	missionNamespace setVariable ["adv_var_weather",_weatherArray];
	0 setLightnings _initialLightning;
	0 setWaves _initialWaves;
	0 setFog _initialFog;
	skipTime -24;
};

_handle;
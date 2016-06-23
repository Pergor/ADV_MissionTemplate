// Setup Weather Types Array [Weather Name, Possible Weather Forecasts, Weather Settings] - Suggested that they are left as is.

if ( ADV_par_weather != 99 || ADV_par_fixedWeather == 99 ) exitWith {};

[] spawn {
	_weatherValue = if (ADV_par_fixedWeather == 98) then { (floor (random 9))+1 } else { ADV_par_fixedWeather };

	_weatherArray = switch (_weatherValue) do {
		case 1: {[0, 0, [0, 0, 0], [1, 1, true]]};	//sunny
		case 2: {[0.3, 0, [0, 0, 0], [1, 1, true]]};	//clear
		case 3: {[0.55, 0, [0.05, 0.05, 10], [2, 2, true]]};	//overcast
		case 4: {[0.6, 0.3, [0.1, 0.05, 20], [3, 3, true]]};	//light rain
		case 5: {[0.70, 0.5, [0.2, 0.05, 20], [4, 4, true]]};	//medium rain
		case 6: {[0.80, 0.9, [0.25, 0.05, 20], [5, 5, true]]};	//heavy rain
		case 7: {[0.4, 0, [0.2, 0.01, 20], [0, 0, true]]};	//light fog
		case 8: {[0.4, 0, [0.4, 0.005, 20], [0, 0, true]]};	//medium fog
		case 9: {[0.5, 0, [0.5, 0.0025, 40], [0, 0, true]]}; //dense fog
		default {nil};
	};

	if (isNil "_weatherArray") exitWith {false};

	//skipTime 24;
	_initialOvercast = _weatherArray select 0;
	_initialRain = _weatherArray select 1;
	_initialFog = _weatherArray select 2;
	_initialWind = _weatherArray select 3;

	if (isServer) then {
		//1 setOvercast _initialOvercast;
		[_initialOvercast] call BIS_fnc_setOvercast;
		1 setFog _initialFog;
	};

	1 setRain _initialRain;
	setWind _initialWind;

	sleep 1;
	
	//skipTime -24;
	sleep 1;
	simulWeatherSync;
};

true;
#include "defines.h"
/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Updates the view distance dependant on whether the player
	is on foot, a car or an aircraft.
*/
private "_dist";
switch (true) do {
	case (!(EQUAL(SEL(UAVControl getConnectedUAV player,1),""))): {
		setViewDistance tawvd_drone;
		profileNamespace setVariable ["tawvd_drone",tawvd_drone];
		_dist = tawvd_drone;
	};
	
	case ((vehicle player) isKindOf "Man"): {
		setViewDistance tawvd_foot;
		profileNamespace setVariable ["tawvd_foot",tawvd_foot];
		_dist = tawvd_foot;
	};
	
	case ((vehicle player) isKindOf "LandVehicle"): {
		setViewDistance tawvd_car;
		profileNamespace setVariable ["tawvd_car",tawvd_car];
		_dist = tawvd_car;
	};
	
	case ((vehicle player) isKindOf "Air"): {
		setViewDistance tawvd_air;
		profileNamespace setVariable ["tawvd_air",tawvd_air];
		_dist = tawvd_air;
	};
};

if (GVAR_MNS ["tawvd_syncObject",false]) then {
	setObjectViewDistance _dist;
	tawvd_object = _dist;
	profileNamespace setVariable ["tawvd_object",2000];
	saveProfileNamespace;
};
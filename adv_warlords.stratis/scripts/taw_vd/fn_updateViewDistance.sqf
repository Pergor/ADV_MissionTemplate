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
		_dist = tawvd_drone;
		profileNamespace setVariable ["tawvd_drone",_dist];
	};
	
	case ((vehicle player) isKindOf "Man"): {
		_dist = tawvd_foot;
		profileNamespace setVariable ["tawvd_foot",_dist];
	};
	
	case ((vehicle player) isKindOf "LandVehicle" || (vehicle player) isKindof "Ship"): {
		_dist = tawvd_car;
		profileNamespace setVariable ["tawvd_car",_dist];
	};
	
	case ((vehicle player) isKindOf "Air"): {
		_dist = tawvd_air;
		profileNamespace setVariable ["tawvd_air",_dist];
	};
};
setViewDistance _dist;

if (tawvd_syncObject) then {
	setObjectViewDistance _dist;
	tawvd_object = _dist;
	profileNamespace setVariable ["tawvd_object",2000];
	profileNamespace setVariable ["tawvd_syncObject",true];
} else {
	profileNamespace setVariable ["tawvd_syncObject",false];
};

saveProfileNamespace;
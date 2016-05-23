// Ausrüstungsskript by James, 
// in Anlehnung an Maeh, Feldhobel
//hint str(_this);

params [
	["_crateSelection", "", [""]],
	["_forcePlacement", false, [true]]
];

if (_crateSelection == "") exitWith { hint "Keine Aktion ausgewählt"; };

if (isNil "ADV_logistic_maxAmount_crateGrenades") then {
	switch ( ADV_par_logisticAmount ) do {
		case 1: {
			ADV_logistic_maxAmount_crateGrenades = 1;
			ADV_logistic_maxAmount_crateNormal = 3;
			ADV_logistic_maxAmount_crateAT = 1;
			ADV_logistic_maxAmount_crateMG = 1;
			ADV_logistic_maxAmount_crateMedic = 2;
			ADV_logistic_maxAmount_crateEOD = 1;
			ADV_logistic_maxAmount_crateSupport = 1;
		};
		case 2: {
			ADV_logistic_maxAmount_crateGrenades = 2;
			ADV_logistic_maxAmount_crateNormal = 6;
			ADV_logistic_maxAmount_crateAT = 2;
			ADV_logistic_maxAmount_crateMG = 2;
			ADV_logistic_maxAmount_crateMedic = 4;
			ADV_logistic_maxAmount_crateEOD = 2;
			ADV_logistic_maxAmount_crateSupport = 2;
		};
		case 3: {
			ADV_logistic_maxAmount_crateGrenades = 4;
			ADV_logistic_maxAmount_crateNormal = 8;
			ADV_logistic_maxAmount_crateAT = 4;
			ADV_logistic_maxAmount_crateMG = 4;
			ADV_logistic_maxAmount_crateMedic = 6;
			ADV_logistic_maxAmount_crateEOD = 4;
			ADV_logistic_maxAmount_crateSupport = 4;
		};
		default {
			ADV_logistic_maxAmount_crateGrenades = 999;
			ADV_logistic_maxAmount_crateNormal = 999;
			ADV_logistic_maxAmount_crateAT = 999;
			ADV_logistic_maxAmount_crateMG = 999;
			ADV_logistic_maxAmount_crateMedic = 999;
			ADV_logistic_maxAmount_crateEOD = 999;
			ADV_logistic_maxAmount_crateSupport = 999;	
		};
	};
};

switch ( side (group player) ) do {
	case west: {
		ADV_logistic_crateTypeLarge="B_CargoNet_01_ammo_F";
		ADV_logistic_crateTypeNormal="Box_NATO_Ammo_F";ADV_logistic_crateTypeAT="Box_NATO_WpsLaunch_F";
		ADV_logistic_crateTypeMG="Box_NATO_WpsSpecial_F";
		ADV_logistic_crateTypeSupport="Box_NATO_Support_F";ADV_logistic_crateTypeEOD="Box_NATO_AmmoOrd_F";
		ADV_logistic_crateTypeMedic="Box_NATO_Support_F";
		ADV_logistic_var_sidePrefix = "";
	};
	case east: {
		ADV_logistic_crateTypeLarge="O_CargoNet_01_ammo_F";
		ADV_logistic_crateTypeNormal="Box_East_Ammo_F";ADV_logistic_crateTypeAT="Box_East_WpsLaunch_F";
		ADV_logistic_crateTypeMG="Box_EAST_WpsSpecial_F";
		ADV_logistic_crateTypeSupport="Box_East_Support_F";ADV_logistic_crateTypeEOD="Box_East_AmmoOrd_F";
		ADV_logistic_crateTypeMedic="Box_East_Support_F";
		ADV_logistic_var_sidePrefix = "opf_";
	};
	case independent: {
		if ( ADV_par_indUni > 0) then {
			ADV_logistic_crateTypeLarge="I_CargoNet_01_ammo_F";
			ADV_logistic_crateTypeNormal="Box_IND_Ammo_F";ADV_logistic_crateTypeAT="Box_IND_WpsLaunch_F";
			ADV_logistic_crateTypeMG="Box_IND_WpsSpecial_F";
			ADV_logistic_crateTypeSupport="Box_IND_Support_F";ADV_logistic_crateTypeEOD="Box_IND_AmmoOrd_F";
			ADV_logistic_crateTypeMedic="Box_IND_Support_F";
		} else {
			ADV_logistic_crateTypeLarge="B_CargoNet_01_ammo_F";
			ADV_logistic_crateTypeNormal="Box_NATO_Ammo_F";ADV_logistic_crateTypeAT="Box_NATO_WpsLaunch_F";
			ADV_logistic_crateTypeMG="Box_NATO_WpsSpecial_F";
			ADV_logistic_crateTypeSupport="Box_NATO_Support_F";ADV_logistic_crateTypeEOD="Box_NATO_AmmoOrd_F";
			ADV_logistic_crateTypeMedic="Box_NATO_Support_F";
		};
		ADV_logistic_var_sidePrefix = "ind_";
	};
};
if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
	ADV_logistic_crateTypeMedic="ACE_medicalSupplyCrate_advanced";
};
ADV_logistic_locationCrateLarge = format ["ADV_%1locationCrateLarge",ADV_logistic_var_sidePrefix];

if !(_forcePlacement) then {
	switch ( toUpper (_crateSelection) ) do {
		//can grenade boxes be generated?
		case "ADV_LOGISTIC_CRATEGRENADES": {
			_crateVariable = format ["ADV_logistic_amount_%1_crateGrenades",ADV_logistic_var_sidePrefix];
			_crateAmount = missionNamespace getVariable [_crateVariable,ADV_logistic_maxAmount_crateGrenades];
			if ( _crateAmount > 0 ) then {
				hint format ["%1 weitere Granatenkisten stehen zur Verfügung.", _crateAmount - 1];
				missionNamespace setVariable [_crateVariable,_crateAmount - 1,true];
			} else {
				hint "Von der ausgewählten Kategorie stehen keine weiteren Kisten mehr zur Verfügung.";
			};
			ADV_var_logistic_isBoxAvailable = if ( _crateAmount > 0 ) then { 1 } else { 0 };
		};
		//can eod boxes be generated?
		case "ADV_LOGISTIC_CRATEEOD": {
			_crateVariable = format ["ADV_logistic_amount_%1_crateEOD",ADV_logistic_var_sidePrefix];
			_crateAmount = missionNamespace getVariable [_crateVariable,ADV_logistic_maxAmount_crateEOD];
			if ( _crateAmount > 0 ) then {
				hint format ["%1 weitere EOD-Kisten stehen zur Verfügung.", _crateAmount - 1];
				missionNamespace setVariable [_crateVariable,_crateAmount - 1,true];
			} else {
				hint "Von der ausgewählten Kategorie stehen keine weiteren Kisten mehr zur Verfügung.";
			};
			ADV_var_logistic_isBoxAvailable = if ( _crateAmount > 0 ) then { 1 } else { 0 };
		};
		//can regular ammunition boxes be generated?
		case "ADV_LOGISTIC_CRATENORMAL": {
			_crateVariable = format ["ADV_logistic_amount_%1_crateNormal",ADV_logistic_var_sidePrefix];
			_crateAmount = missionNamespace getVariable [_crateVariable,ADV_logistic_maxAmount_crateNormal];
			if ( _crateAmount > 0 ) then {
				hint format ["%1 weitere Munitionskisten stehen zur Verfügung.", _crateAmount - 1];
				missionNamespace setVariable [_crateVariable,_crateAmount - 1,true];
			} else {
				hint "Von der ausgewählten Kategorie stehen keine weiteren Kisten mehr zur Verfügung.";
			};
			ADV_var_logistic_isBoxAvailable = if ( _crateAmount > 0 ) then { 1 } else { 0 };	
		};
		//can mg boxes be generated?
		case "ADV_LOGISTIC_CRATEMG": {
			_crateVariable = format ["ADV_logistic_amount_%1_crateMG",ADV_logistic_var_sidePrefix];
			_crateAmount = missionNamespace getVariable [_crateVariable,ADV_logistic_maxAmount_crateMG];
			if ( _crateAmount > 0 ) then {
				hint format ["%1 weitere MG-Munitionskisten stehen zur Verfügung.", _crateAmount - 1];
				missionNamespace setVariable [_crateVariable,_crateAmount - 1,true];
			} else {
				hint "Von der ausgewählten Kategorie stehen keine weiteren Kisten mehr zur Verfügung.";
			};
			ADV_var_logistic_isBoxAvailable = if ( _crateAmount > 0 ) then { 1 } else { 0 };
		};
		//can at boxes be generated?
		case "ADV_LOGISTIC_CRATEAT": {
			_crateVariable = format ["ADV_logistic_amount_%1_crateAT",ADV_logistic_var_sidePrefix];
			_crateAmount = missionNamespace getVariable [_crateVariable,ADV_logistic_maxAmount_crateAT];
			if ( _crateAmount > 0 ) then {
				hint format ["%1 weitere AT-Kisten stehen zur Verfügung.", _crateAmount - 1];
				missionNamespace setVariable [_crateVariable,_crateAmount - 1,true];
			} else {
				hint "Von der ausgewählten Kategorie stehen keine weiteren Kisten mehr zur Verfügung.";
			};
			ADV_var_logistic_isBoxAvailable = if ( _crateAmount > 0 ) then { 1 } else { 0 };
		};
		//can medic boxes be generated?
		case "ADV_LOGISTIC_CRATEMEDIC": {
			_crateVariable = format ["ADV_logistic_amount_%1_crateMedic",ADV_logistic_var_sidePrefix];
			_crateAmount = missionNamespace getVariable [_crateVariable,ADV_logistic_maxAmount_crateMedic];
			if ( _crateAmount > 0 ) then {
				hint format ["%1 weitere Medic-Kisten stehen zur Verfügung.", _crateAmount - 1];
				missionNamespace setVariable [_crateVariable,_crateAmount - 1,true];
			} else {
				hint "Von der ausgewählten Kategorie stehen keine weiteren Kisten mehr zur Verfügung.";
			};
			ADV_var_logistic_isBoxAvailable = if ( _crateAmount > 0 ) then { 1 } else { 0 };
		};
		//can support boxes be generated?
		case "ADV_LOGISTIC_CRATESUPPORT": {
			_crateVariable = format ["ADV_logistic_amount_%1_crateSupport",ADV_logistic_var_sidePrefix];
			_crateAmount = missionNamespace getVariable [_crateVariable,ADV_logistic_maxAmount_crateSupport];
			if ( _crateAmount > 0 ) then {
				hint format ["%1 weitere Supportkisten stehen zur Verfügung.", _crateAmount - 1];
				missionNamespace setVariable [_crateVariable,_crateAmount - 1,true];
			} else {
				hint "Von der ausgewählten Kategorie stehen keine weiteren Kisten mehr zur Verfügung.";
			};
			ADV_var_logistic_isBoxAvailable = if ( _crateAmount > 0 ) then { 1 } else { 0 };
		};
		default { ADV_var_logistic_isBoxAvailable = 1; };
	};
} else {
	ADV_var_logistic_isBoxAvailable = 1;
};

if ( ADV_var_logistic_isBoxAvailable > 0 ) then {
	// Aufruf des ausgewählten Loadouts -> Übergabe aus Dialog
	_functionForAll = {
		_target = _this select 0;
		_target allowDamage false;
		[_target] call ADV_fnc_clearCargo;
		_target setPosASL (getPosASL player);
		if ( ADV_par_customLoad == 1 ) then {
			[_target] remoteExec ["aeroson_fnc_gearsaving",0,true];
		};
		if ( ADV_par_logisticDrop == 1 ) then { [_target] call adv_fnc_dropLogistic; };
	};
	switch ( toUpper (_crateSelection) ) do {
		case "ADV_LOGISTIC_CRATELARGE": {
			{deleteVehicle _x} forEach (nearestObjects [(getMarkerPos ADV_logistic_locationCrateLarge), ["ReammoBox_F"], 3]);
			[] spawn {
				sleep 1;
				_box = createVehicle [ADV_logistic_crateTypeLarge,getMarkerPos ADV_logistic_locationCrateLarge,[],0,"CAN_COLLIDE"];
				_box allowDamage false;
				[_box] call ADV_fnc_clearCargo;
				if ( ADV_par_customLoad == 1 ) then {
					[_box] remoteExec ["aeroson_fnc_gearsaving",0,true];
				};
				_function = format ["adv_%1%2",ADV_logistic_var_sidePrefix,"fnc_crateLarge"];
				[_box] remoteExecCall [_function,2];
			};
		};		
		case "ADV_LOGISTIC_CRATEGRENADES": {
			_box = createVehicle [ADV_logistic_crateTypeEOD,getPosASL player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			_function = format ["adv_%1%2",ADV_logistic_var_sidePrefix,"fnc_crateGrenades"];
			[_box] remoteExecCall [_function,2];
		};
		case "ADV_LOGISTIC_CRATEEOD": {
			_box = createVehicle [ADV_logistic_crateTypeEOD,getPosASL player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			_function = format ["adv_%1%2",ADV_logistic_var_sidePrefix,"fnc_crateEOD"];
			[_box] remoteExecCall [_function,2];
		};
		case "ADV_LOGISTIC_CRATESTUFF": {
			_box = createVehicle [ADV_logistic_crateTypeSupport,getPosASL player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			_function = format ["adv_%1%2",ADV_logistic_var_sidePrefix,"fnc_crateStuff"];
			[_box] remoteExecCall [_function,2];
		};
		case "ADV_LOGISTIC_CRATETEAM": {
			_box = createVehicle [ADV_logistic_crateTypeNormal,getPosASL player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			_function = format ["adv_%1%2",ADV_logistic_var_sidePrefix,"fnc_crateTeam"];
			[_box] remoteExecCall [_function,2];
		};
		case "ADV_LOGISTIC_CRATENORMAL": {
			_box = createVehicle [ADV_logistic_crateTypeNormal,getPosASL player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			_function = format ["adv_%1%2",ADV_logistic_var_sidePrefix,"fnc_crateNormal"];
			[_box] remoteExecCall [_function,2];
		};
		case "ADV_LOGISTIC_CRATEMG": {
			_box = createVehicle [ADV_logistic_crateTypeMG,getPosASL player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			_function = format ["adv_%1%2",ADV_logistic_var_sidePrefix,"fnc_crateMG"];
			[_box] remoteExecCall [_function,2];
		};
		case "ADV_LOGISTIC_CRATEAT": {
			_box = createVehicle [ADV_logistic_crateTypeAT,getPosASL player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			_function = format ["adv_%1%2",ADV_logistic_var_sidePrefix,"fnc_crateAT"];
			[_box] remoteExecCall [_function,2];
		};
		case "ADV_LOGISTIC_CRATEMEDIC": {
			_box = createVehicle [ADV_logistic_crateTypeMedic,getPosASL player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			_function = format ["adv_%1%2",ADV_logistic_var_sidePrefix,"fnc_crateMedic"];
			[_box] remoteExecCall [_function,2];
		};
		case "ADV_LOGISTIC_CRATESUPPORT": {
			_box = createVehicle [ADV_logistic_crateTypeSupport,getPosASL player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			_function = format ["adv_%1%2",ADV_logistic_var_sidePrefix,"fnc_crateSupport"];
			[_box] remoteExecCall [_function,2];
		};
		case "ADV_LOGISTIC_WHEEL": {
			if (isClass(configFile >> "CfgPatches" >> "ace_repair")) then {
				_box = createVehicle ["ACE_Wheel",getPosASL player,[],0,"CAN_COLLIDE"];
			};
		};
		case "ADV_LOGISTIC_TRACK": {
			if (isClass(configFile >> "CfgPatches" >> "ace_repair")) then {
				_box = createVehicle ["ACE_Track",getPosASL player,[],0,"CAN_COLLIDE"];
			};
		};
		case "ADV_LOGISTIC_CRATEDELETE": {
			{deleteVehicle _x} forEach (nearestObjects [player, ["ReammoBox_F"], 3]);
			if (isClass(configFile >> "CfgPatches" >> "ace_repair")) then {
				{deleteVehicle _x} forEach (nearestObjects [player, ["ACE_Wheel"], 3]);
				{deleteVehicle _x} forEach (nearestObjects [player, ["ACE_Track"], 3]);
			};
		};	
		case "ADV_LOGISTIC_CRATEEMPTY": {
			_box = createVehicle [ADV_logistic_crateTypeNormal,getPosASL player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
		};
		default {};
	};
};

closeDialog 1;
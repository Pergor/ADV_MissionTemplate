// Ausrüstungsskript by James, 
// in Anlehnung an Maeh, Feldhobel
//hint str(_this);

_crateSelection = _this select 0; //String zur Datei

if (_crateSelection == "") exitWith { hint "Keine Aktion ausgewählt"; };

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

switch ( side (group player) ) do {
	case west: {
		ADV_logistic_crateTypeLarge="B_CargoNet_01_ammo_F";
		ADV_logistic_crateTypeNormal="Box_NATO_Ammo_F";ADV_logistic_crateTypeAT="Box_NATO_WpsLaunch_F";
		ADV_logistic_crateTypeSupport="Box_NATO_Support_F";ADV_logistic_crateTypeEOD="Box_NATO_AmmoOrd_F";
		ADV_logistic_functionTeam="ADV_fnc_crateTeam";ADV_logistic_functionNormal="ADV_fnc_crateNormal";
		ADV_logistic_functionMG="ADV_fnc_crateMG";ADV_logistic_functionAT="ADV_fnc_crateAT";
		ADV_logistic_functionMedic="ADV_fnc_crateMedic";ADV_logistic_functionSupport="ADV_fnc_crateSupport";
		ADV_logistic_functionEOD="ADV_fnc_crateEOD";ADV_logistic_functionGrenades="ADV_fnc_crateGrenades";
		ADV_logistic_functionLarge="ADV_fnc_crateLarge";ADV_logistic_locationCrateLarge="ADV_locationCrateLarge";
	};
	case east: {
		ADV_logistic_crateTypeLarge="O_CargoNet_01_ammo_F";
		ADV_logistic_crateTypeNormal="Box_East_Ammo_F";ADV_logistic_crateTypeAT="Box_East_WpsLaunch_F";
		ADV_logistic_crateTypeSupport="Box_East_Support_F";ADV_logistic_crateTypeEOD="Box_East_AmmoOrd_F";
		ADV_logistic_functionTeam="ADV_opf_fnc_crateTeam";ADV_logistic_functionNormal="ADV_opf_fnc_crateNormal";
		ADV_logistic_functionMG="ADV_opf_fnc_crateMG";ADV_logistic_functionAT="ADV_opf_fnc_crateAT";
		ADV_logistic_functionMedic="ADV_opf_fnc_crateMedic";ADV_logistic_functionSupport="ADV_opf_fnc_crateSupport";
		ADV_logistic_functionEOD="ADV_opf_fnc_crateEOD";ADV_logistic_functionGrenades="ADV_opf_fnc_crateGrenades";
		ADV_logistic_functionLarge="ADV_opf_fnc_crateLarge";ADV_logistic_locationCrateLarge="ADV_opf_locationCrateLarge";
	};
	case independent: {
		if ( ADV_par_indUni > 0) then {
			ADV_logistic_crateTypeLarge="I_CargoNet_01_ammo_F";
			ADV_logistic_crateTypeNormal="Box_IND_Ammo_F";ADV_logistic_crateTypeAT="Box_IND_WpsLaunch_F";
			ADV_logistic_crateTypeSupport="Box_IND_Support_F";ADV_logistic_crateTypeEOD="Box_IND_AmmoOrd_F";
		} else {
			ADV_logistic_crateTypeLarge="B_CargoNet_01_ammo_F";
			ADV_logistic_crateTypeNormal="Box_NATO_Ammo_F";ADV_logistic_crateTypeAT="Box_NATO_WpsLaunch_F";
			ADV_logistic_crateTypeSupport="Box_NATO_Support_F";ADV_logistic_crateTypeEOD="Box_NATO_AmmoOrd_F";
		};
		ADV_logistic_functionTeam="ADV_ind_fnc_crateTeam";ADV_logistic_functionNormal="ADV_ind_fnc_crateNormal";
		ADV_logistic_functionMG="ADV_ind_fnc_crateMG";ADV_logistic_functionAT="ADV_ind_fnc_crateAT";
		ADV_logistic_functionMedic="ADV_ind_fnc_crateMedic";ADV_logistic_functionSupport="ADV_ind_fnc_crateSupport";
		ADV_logistic_functionEOD="ADV_ind_fnc_crateEOD";ADV_logistic_functionGrenades="ADV_ind_fnc_crateGrenades";
		ADV_logistic_functionLarge="ADV_ind_fnc_crateLarge";ADV_logistic_locationCrateLarge="ADV_ind_locationCrateLarge";
	};
};

switch ( toUpper (_crateSelection) ) do {
	//can grenade boxes be generated?
	case "ADV_LOGISTIC_CRATEGRENADES": {
		switch ( side (group player) ) do {
			case west: {
				if (isNil "ADV_logistic_amount_west_crateGrenades") then { ADV_logistic_amount_west_crateGrenades = ADV_logistic_maxAmount_crateGrenades; 
				} else {
					ADV_logistic_amount_west_crateGrenades = ADV_logistic_amount_west_crateGrenades - 1;
				};
				publicVariable "ADV_logistic_amount_west_crateGrenades";
				if ( ADV_logistic_amount_west_crateGrenades > 0 ) then { hint format ["%1 weitere Granatenkisten stehen zur Verfügung.", ADV_logistic_amount_west_crateGrenades - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_west_crateGrenades > 0 ) then { 1 } else { 0 };
			};
			case east: {
				if (isNil "ADV_logistic_amount_east_crateGrenades") then { ADV_logistic_amount_east_crateGrenades = ADV_logistic_maxAmount_crateGrenades; 
				} else {
					ADV_logistic_amount_east_crateGrenades = ADV_logistic_amount_east_crateGrenades - 1;
				};
				publicVariable "ADV_logistic_amount_east_crateGrenades";
				if ( ADV_logistic_amount_east_crateGrenades > 0 ) then { hint format ["%1 weitere Granatenkisten stehen zur Verfügung.", ADV_logistic_amount_east_crateGrenades - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_east_crateGrenades > 0 ) then { 1 } else { 0 };
			};
			case independent: {
				if (isNil "ADV_logistic_amount_ind_crateGrenades") then { ADV_logistic_amount_ind_crateGrenades = ADV_logistic_maxAmount_crateGrenades; 
				} else {
					ADV_logistic_amount_ind_crateGrenades = ADV_logistic_amount_ind_crateGrenades - 1;
				};
				publicVariable "ADV_logistic_amount_ind_crateGrenades";
				if ( ADV_logistic_amount_ind_crateGrenades > 0 ) then { hint format ["%1 weitere Granatenkisten stehen zur Verfügung.", ADV_logistic_amount_ind_crateGrenades - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_ind_crateGrenades > 0 ) then { 1 } else { 0 };
			};
		};
	};
	//can eod boxes be generated?
	case "ADV_LOGISTIC_CRATEEOD": {
		switch ( side (group player) ) do {
			case west: {
				if (isNil "ADV_logistic_amount_west_crateEOD") then { ADV_logistic_amount_west_crateEOD = ADV_logistic_maxAmount_crateEOD; 
				} else {
					ADV_logistic_amount_west_crateEOD = ADV_logistic_amount_west_crateEOD - 1;
				};
				publicVariable "ADV_logistic_amount_west_crateEOD";
				if ( ADV_logistic_amount_west_crateEOD > 0 ) then { hint format ["%1 weitere EOD-Kisten stehen zur Verfügung.", ADV_logistic_amount_west_crateEOD - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_west_crateEOD > 0 ) then { 1 } else { 0 };
			};
			case east: {
				if (isNil "ADV_logistic_amount_east_crateEOD") then { ADV_logistic_amount_east_crateEOD = ADV_logistic_maxAmount_crateEOD; 
				} else {
					ADV_logistic_amount_east_crateEOD = ADV_logistic_amount_east_crateEOD - 1;
				};
				publicVariable "ADV_logistic_amount_east_crateEOD";
				if ( ADV_logistic_amount_east_crateEOD > 0 ) then { hint format ["%1 weitere EOD-Kisten stehen zur Verfügung.", ADV_logistic_amount_east_crateEOD - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_east_crateEOD > 0 ) then { 1 } else { 0 };
			};
			case independent: {
				if (isNil "ADV_logistic_amount_ind_crateEOD") then { ADV_logistic_amount_ind_crateEOD = ADV_logistic_maxAmount_crateEOD; 
				} else {
					ADV_logistic_amount_ind_crateEOD = ADV_logistic_amount_ind_crateEOD - 1;
				};
				publicVariable "ADV_logistic_amount_ind_crateEOD";
				if ( ADV_logistic_amount_ind_crateEOD > 0 ) then { hint format ["%1 weitere EOD-Kisten stehen zur Verfügung.", ADV_logistic_amount_ind_crateEOD - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_ind_crateEOD > 0 ) then { 1 } else { 0 };
			};
		};
	};
	/*
	//can team boxes be generated?
	case "ADV_LOGISTIC_CRATETEAM": {
		switch ( side (group player) ) do {
			case west: {
				if (isNil "ADV_logistic_amount_west_crateTEAM") then { ADV_logistic_amount_west_crateTEAM = ADV_logistic_maxAmount_crateTEAM; 
						} else {
					ADV_logistic_amount_west_crateTEAM = ADV_logistic_amount_west_crateTEAM - 1;
				};
				publicVariable "ADV_logistic_amount_west_crateTEAM";
				if ( ADV_logistic_amount_west_crateTEAM > 0 ) then { hint format ["%1 weitere Fire-Team-Kisten stehen zur Verfügung.", ADV_logistic_amount_west_crateTEAM - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_west_crateTEAM > 0 ) then { 1 } else { 0 };
			};
			case east: {
				if (isNil "ADV_logistic_amount_east_crateTEAM") then { ADV_logistic_amount_east_crateTEAM = ADV_logistic_maxAmount_crateTEAM; 
						} else {
					ADV_logistic_amount_east_crateTEAM = ADV_logistic_amount_east_crateTEAM - 1;
				};
				publicVariable "ADV_logistic_amount_east_crateTEAM";
				if ( ADV_logistic_amount_east_crateTEAM > 0 ) then { hint format ["%1 weitere Fire-Team-Kisten stehen zur Verfügung.", ADV_logistic_amount_east_crateTEAM - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_east_crateTEAM > 0 ) then { 1 } else { 0 };
			};
			case independent: {
				if (isNil "ADV_logistic_amount_ind_crateTEAM") then { ADV_logistic_amount_ind_crateTEAM = ADV_logistic_maxAmount_crateTEAM; 
						} else {
					ADV_logistic_amount_ind_crateTEAM = ADV_logistic_amount_ind_crateTEAM - 1;
				};
				publicVariable "ADV_logistic_amount_ind_crateTEAM";
				if ( ADV_logistic_amount_ind_crateTEAM > 0 ) then { hint format ["%1 weitere Fire-Team-Kisten stehen zur Verfügung.", ADV_logistic_amount_ind_crateTEAM - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_ind_crateTEAM > 0 ) then { 1 } else { 0 };
			};
		};
	};
	*/
	//can regular ammunition boxes be generated?
	case "ADV_LOGISTIC_CRATENORMAL": {
		switch ( side (group player) ) do {
			case west: {
				if (isNil "ADV_logistic_amount_west_crateNORMAL") then { ADV_logistic_amount_west_crateNORMAL = ADV_logistic_maxAmount_crateNORMAL; 
				} else {
					ADV_logistic_amount_west_crateNORMAL = ADV_logistic_amount_west_crateNORMAL - 1;
				};
				publicVariable "ADV_logistic_amount_west_crateNORMAL";
				if ( ADV_logistic_amount_west_crateNORMAL > 0 ) then { hint format ["%1 weitere Munitions-Kisten stehen zur Verfügung.", ADV_logistic_amount_west_crateNORMAL - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_west_crateNORMAL > 0 ) then { 1 } else { 0 };
			};
			case east: {
				if (isNil "ADV_logistic_amount_east_crateNORMAL") then { ADV_logistic_amount_east_crateNORMAL = ADV_logistic_maxAmount_crateNORMAL; 
				} else {
					ADV_logistic_amount_east_crateNORMAL = ADV_logistic_amount_east_crateNORMAL - 1;
				};
				publicVariable "ADV_logistic_amount_east_crateNORMAL";
				if ( ADV_logistic_amount_east_crateNORMAL > 0 ) then { hint format ["%1 weitere Munitions-Kisten stehen zur Verfügung.", ADV_logistic_amount_east_crateNORMAL - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_east_crateNORMAL > 0 ) then { 1 } else { 0 };
			};
			case independent: {
				if (isNil "ADV_logistic_amount_ind_crateNORMAL") then { ADV_logistic_amount_ind_crateNORMAL = ADV_logistic_maxAmount_crateNORMAL; 
				} else {
					ADV_logistic_amount_ind_crateNORMAL = ADV_logistic_amount_ind_crateNORMAL - 1;
				};
				publicVariable "ADV_logistic_amount_ind_crateNORMAL";
				if ( ADV_logistic_amount_ind_crateNORMAL > 0 ) then { hint format ["%1 weitere Munitions-Kisten stehen zur Verfügung.", ADV_logistic_amount_ind_crateNORMAL - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_ind_crateNORMAL > 0 ) then { 1 } else { 0 };
			};
		};
	};
	//can mg boxes be generated?
	case "ADV_LOGISTIC_CRATEMG": {
		switch ( side (group player) ) do {
			case west: {
				if (isNil "ADV_logistic_amount_west_crateMG") then { ADV_logistic_amount_west_crateMG = ADV_logistic_maxAmount_crateMG; 
				} else {
					ADV_logistic_amount_west_crateMG = ADV_logistic_amount_west_crateMG - 1;
				};
				publicVariable "ADV_logistic_amount_west_crateMG";
				if ( ADV_logistic_amount_west_crateMG > 0 ) then { hint format ["%1 weitere MG-Kisten stehen zur Verfügung.", ADV_logistic_amount_west_crateMG - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_west_crateMG > 0 ) then { 1 } else { 0 };
			};
			case east: {
				if (isNil "ADV_logistic_amount_east_crateMG") then { ADV_logistic_amount_east_crateMG = ADV_logistic_maxAmount_crateMG; 
				} else {
					ADV_logistic_amount_east_crateMG = ADV_logistic_amount_east_crateMG - 1;
				};
				publicVariable "ADV_logistic_amount_east_crateMG";
				if ( ADV_logistic_amount_east_crateMG > 0 ) then { hint format ["%1 weitere MG-Kisten stehen zur Verfügung.", ADV_logistic_amount_east_crateMG - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_east_crateMG > 0 ) then { 1 } else { 0 };
			};
			case independent: {
				if (isNil "ADV_logistic_amount_ind_crateMG") then { ADV_logistic_amount_ind_crateMG = ADV_logistic_maxAmount_crateMG; 
				} else {
					ADV_logistic_amount_ind_crateMG = ADV_logistic_amount_ind_crateMG - 1;
				};
				publicVariable "ADV_logistic_amount_ind_crateMG";
				if ( ADV_logistic_amount_ind_crateMG > 0 ) then { hint format ["%1 weitere MG-Kisten stehen zur Verfügung.", ADV_logistic_amount_ind_crateMG - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_ind_crateMG > 0 ) then { 1 } else { 0 };
			};
		};
	};
	//can at boxes be generated?
	case "ADV_LOGISTIC_CRATEAT": {
		switch ( side (group player) ) do {
			case west: {
				if (isNil "ADV_logistic_amount_west_crateAT") then { ADV_logistic_amount_west_crateAT = ADV_logistic_maxAmount_crateAT; 
				} else {
					ADV_logistic_amount_west_crateAT = ADV_logistic_amount_west_crateAT - 1;
				};
				publicVariable "ADV_logistic_amount_west_crateAT";
				if ( ADV_logistic_amount_west_crateAT > 0 ) then { hint format ["%1 weitere AT-Kisten stehen zur Verfügung.", ADV_logistic_amount_west_crateAT - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_west_crateAT > 0 ) then { 1 } else { 0 };
			};
			case east: {
				if (isNil "ADV_logistic_amount_east_crateAT") then { ADV_logistic_amount_east_crateAT = ADV_logistic_maxAmount_crateAT; 
				} else {
					ADV_logistic_amount_east_crateAT = ADV_logistic_amount_east_crateAT - 1;
				};
				publicVariable "ADV_logistic_amount_east_crateAT";
				if ( ADV_logistic_amount_east_crateAT > 0 ) then { hint format ["%1 weitere AT-Kisten stehen zur Verfügung.", ADV_logistic_amount_east_crateAT - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_east_crateAT > 0 ) then { 1 } else { 0 };
			};
			case independent: {
				if (isNil "ADV_logistic_amount_ind_crateAT") then { ADV_logistic_amount_ind_crateAT = ADV_logistic_maxAmount_crateAT; 
				} else {
					ADV_logistic_amount_ind_crateAT = ADV_logistic_amount_ind_crateAT - 1;
				};
				publicVariable "ADV_logistic_amount_ind_crateAT";
				if ( ADV_logistic_amount_ind_crateAT > 0 ) then { hint format ["%1 weitere AT-Kisten stehen zur Verfügung.", ADV_logistic_amount_ind_crateAT - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_ind_crateAT > 0 ) then { 1 } else { 0 };
			};
		};
	};
	//can medic boxes be generated?
	case "ADV_LOGISTIC_CRATEMEDIC": {
		switch ( side (group player) ) do {
			case west: {
				if (isNil "ADV_logistic_amount_west_crateMEDIC") then { ADV_logistic_amount_west_crateMEDIC = ADV_logistic_maxAmount_crateMEDIC; 
				} else {
					ADV_logistic_amount_west_crateMEDIC = ADV_logistic_amount_west_crateMEDIC - 1;
				};
				publicVariable "ADV_logistic_amount_west_crateMEDIC";
				if ( ADV_logistic_amount_west_crateMEDIC > 0 ) then { hint format ["%1 weitere Sanitäts-Kisten stehen zur Verfügung.", ADV_logistic_amount_west_crateMEDIC - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_west_crateMEDIC > 0 ) then { 1 } else { 0 };
			};
			case east: {
				if (isNil "ADV_logistic_amount_east_crateMEDIC") then { ADV_logistic_amount_east_crateMEDIC = ADV_logistic_maxAmount_crateMEDIC; 
				} else {
					ADV_logistic_amount_east_crateMEDIC = ADV_logistic_amount_east_crateMEDIC - 1;
				};
				publicVariable "ADV_logistic_amount_east_crateMEDIC";
				if ( ADV_logistic_amount_east_crateMEDIC > 0 ) then { hint format ["%1 weitere Sanitäts-Kisten stehen zur Verfügung.", ADV_logistic_amount_east_crateMEDIC - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_east_crateMEDIC > 0 ) then { 1 } else { 0 };
			};
			case independent: {
				if (isNil "ADV_logistic_amount_ind_crateMEDIC") then { ADV_logistic_amount_ind_crateMEDIC = ADV_logistic_maxAmount_crateMEDIC; 
				} else {
					ADV_logistic_amount_ind_crateMEDIC = ADV_logistic_amount_ind_crateMEDIC - 1;
				};
				publicVariable "ADV_logistic_amount_ind_crateMEDIC";
				if ( ADV_logistic_amount_ind_crateMEDIC > 0 ) then { hint format ["%1 weitere Sanitäts-Kisten stehen zur Verfügung.", ADV_logistic_amount_ind_crateMEDIC - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_ind_crateMEDIC > 0 ) then { 1 } else { 0 };
			};
		};
	};
	//can support boxes be generated?
	case "ADV_LOGISTIC_CRATESUPPORT": {
		switch ( side (group player) ) do {
			case west: {
				if (isNil "ADV_logistic_amount_west_crateSUPPORT") then { ADV_logistic_amount_west_crateSUPPORT = ADV_logistic_maxAmount_crateSUPPORT; 
				} else {
					ADV_logistic_amount_west_crateSUPPORT = ADV_logistic_amount_west_crateSUPPORT - 1;
				};
				publicVariable "ADV_logistic_amount_west_crateSUPPORT";
				if ( ADV_logistic_amount_west_crateSUPPORT > 0 ) then { hint format ["%1 weitere Support-Kisten stehen zur Verfügung.", ADV_logistic_amount_west_crateSUPPORT - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_west_crateSUPPORT > 0 ) then { 1 } else { 0 };
			};
			case east: {
				if (isNil "ADV_logistic_amount_east_crateSUPPORT") then { ADV_logistic_amount_east_crateSUPPORT = ADV_logistic_maxAmount_crateSUPPORT; 
				} else {
					ADV_logistic_amount_east_crateSUPPORT = ADV_logistic_amount_east_crateSUPPORT - 1;
				};
				publicVariable "ADV_logistic_amount_east_crateSUPPORT";
				if ( ADV_logistic_amount_east_crateSUPPORT > 0 ) then { hint format ["%1 weitere Support-Kisten stehen zur Verfügung.", ADV_logistic_amount_east_crateSUPPORT - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_east_crateSUPPORT > 0 ) then { 1 } else { 0 };
			};
			case independent: {
				if (isNil "ADV_logistic_amount_ind_crateSUPPORT") then { ADV_logistic_amount_ind_crateSUPPORT = ADV_logistic_maxAmount_crateSUPPORT; 
				} else {
					ADV_logistic_amount_ind_crateSUPPORT = ADV_logistic_amount_ind_crateSUPPORT - 1;
				};
				publicVariable "ADV_logistic_amount_ind_crateSUPPORT";
				if ( ADV_logistic_amount_ind_crateSUPPORT > 0 ) then { hint format ["%1 weitere Support-Kisten stehen zur Verfügung.", ADV_logistic_amount_ind_crateSUPPORT - 1]; };
				ADV_var_logistic_isBoxAvailable = if ( ADV_logistic_amount_ind_crateSUPPORT > 0 ) then { 1 } else { 0 };
			};
		};
	};
	default { ADV_var_logistic_isBoxAvailable = 1; };
};

if ( ADV_var_logistic_isBoxAvailable > 0 ) then {
	// Aufruf des ausgewählten Loadouts -> Übergabe aus Dialog
	_functionForAll = {
		(_this select 0) allowDamage false;
		[(_this select 0)] call ADV_fnc_clearCargo;
		if ( ADV_par_customLoad == 1 ) then {
			//[[(_this select 0)],"aeroson_fnc_gearsaving",true,true,false] call BIS_fnc_MP;
			[(_this select 0)] remoteExec ["aeroson_fnc_gearsaving",0,true];
		};
		if ( ADV_par_logisticDrop == 1 ) then { [(_this select 0)] call adv_fnc_dropLogistic; };
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
					//[[_box],"aeroson_fnc_gearsaving",true,true,false] call BIS_fnc_MP;
					[(_this select 0)] remoteExec ["aeroson_fnc_gearsaving",0,true];
				};
				//[[_box],ADV_logistic_functionLarge,false] call BIS_fnc_MP;
				[_box] remoteExecCall [ADV_logistic_functionLarge,2];
			};
		};		
		case "ADV_LOGISTIC_CRATEGRENADES": {
			_box = createVehicle [ADV_logistic_crateTypeEOD,getPos player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			//[[_box],ADV_logistic_functionGrenades,false] call BIS_fnc_MP;
			[_box] remoteExecCall [ADV_logistic_functionGrenades,2];
		};
		case "ADV_LOGISTIC_CRATEEOD": {
			_box = createVehicle [ADV_logistic_crateTypeEOD,getPos player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			//[[_box],ADV_logistic_functionEOD,false] call BIS_fnc_MP;
			[_box] remoteExecCall [ADV_logistic_functionEOD,2];
		};
		case "ADV_LOGISTIC_CRATESTUFF": {
			_box = createVehicle [ADV_logistic_crateTypeSupport,getPos player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			//[[_box],"ADV_fnc_crateStuff",false] call BIS_fnc_MP;
			[_box] remoteExecCall ["ADV_fnc_crateStuff",2];
		};
		case "ADV_LOGISTIC_CRATETEAM": {
			_box = createVehicle [ADV_logistic_crateTypeNormal,getPos player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			//[[_box],ADV_logistic_functionTeam,false] call BIS_fnc_MP;
			[_box] remoteExecCall [ADV_logistic_functionTeam,2];
		};
		case "ADV_LOGISTIC_CRATENORMAL": {
			_box = createVehicle [ADV_logistic_crateTypeNormal,getPos player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			//[[_box],ADV_logistic_functionNormal,false] call BIS_fnc_MP;
			[_box] remoteExecCall [ADV_logistic_functionNormal,2];
		};
		case "ADV_LOGISTIC_CRATEMG": {
			_box = createVehicle [ADV_logistic_crateTypeNormal,getPos player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			//[[_box],ADV_logistic_functionMG,false] call BIS_fnc_MP;
			[_box] remoteExecCall [ADV_logistic_functionMG,2];
		};
		case "ADV_LOGISTIC_CRATEAT": {
			_box = createVehicle [ADV_logistic_crateTypeAT,getPos player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			//[[_box],ADV_logistic_functionAT,false] call BIS_fnc_MP;
			[_box] remoteExecCall [ADV_logistic_functionAT,2];
		};
		case "ADV_LOGISTIC_CRATEMEDIC": {
			_box = createVehicle [ADV_logistic_crateTypeSupport,getPos player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			//[[_box],ADV_logistic_functionMedic,false] call BIS_fnc_MP;
			[_box] remoteExecCall [ADV_logistic_functionMedic,2];
		};
		case "ADV_LOGISTIC_CRATESUPPORT": {
			_box = createVehicle [ADV_logistic_crateTypeSupport,getPos player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
			//[[_box],ADV_logistic_functionSupport,false] call BIS_fnc_MP;
			[_box] remoteExecCall [ADV_logistic_functionSupport,2];
		};
		case "ADV_LOGISTIC_WHEEL": {
			if (isClass(configFile >> "CfgPatches" >> "ace_repair")) then {
				_box = createVehicle ["ACE_Wheel",getPos player,[],0,"CAN_COLLIDE"];
			};
		};
		case "ADV_LOGISTIC_TRACK": {
			if (isClass(configFile >> "CfgPatches" >> "ace_repair")) then {
				_box = createVehicle ["ACE_Track",getPos player,[],0,"CAN_COLLIDE"];
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
			_box = createVehicle [ADV_logistic_crateTypeNormal,getPos player,[],0,"CAN_COLLIDE"];
			[_box] call _functionForAll;
		};
		default {};
	};
};

closeDialog 1; // OK

//sleep 4;
//hint "";
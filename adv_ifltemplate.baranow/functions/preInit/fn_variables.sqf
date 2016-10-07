/*
ADV_Variables by Belbo
contains all the variables that are important for a mission
call from init.sqf AND initPlayerLocal.sqf via (as early as possible):
call compile preprocessfilelinenumbers "ADV_Setup\ADV_Variables.sqf";
*/

//standard Variables:
if ( isNil "ADV_taskVar" ) then { ADV_taskVar = 0; };
if ( isNil "ADV_spawnVar" ) then { ADV_spawnVar = 0; };
if ( isNil "ADV_var_useDLCContent" ) then { ADV_par_useDLCContent = 1; };

missionNamespace setVariable ["ace_medical_healHitPointAfterAdvBandage",true];
if (isNil "ADV_par_customUni") then { adv_par_customUni = ["param_customUni",0] call BIS_fnc_getParamValue; };
if (isNil "ADV_par_customWeap") then { adv_par_customWeap = ["param_customWeap",0] call BIS_fnc_getParamValue; };
if (isNil "ADV_par_opfUni") then { adv_par_opfUni = ["param_opfUni",0] call BIS_fnc_getParamValue; };
if (isNil "ADV_par_indUni") then { adv_par_indUni = ["param_indUni",0] call BIS_fnc_getParamValue; };
if (isNil "ADV_par_Tablets") then { ADV_par_Tablets = ["param_Tablets",1] call BIS_fnc_getParamValue; };
		
//map variables:
ADV_var_aridMaps = [
	"MCN_ALIABAD","BMFAYSHKHABUR","CLAFGHAN","FALLUJAH","FATA","HELLSKITCHEN","HELLSKITCHENS","MCN_HAZARKOT","PRAA_AV","RESHMAAN",
	"SHAPUR_BAF","TAKISTAN","TORABORA","TUP_QOM","ZARGABAD","PJA307","PJA306","MOUNTAINS_ACR","TUNBA","KUNDUZ","PORTO"
];
ADV_var_sAridMaps = [
	"STRATIS","ALTIS","ISLADUALA3"
];
ADV_var_lushMaps = [
	"LINGOR3","MAK_JUNGLE","PJA305","TROPICA","TIGERIA","TIGERIA_SE","SARA","SARALITE","SARA_DBE1","INTRO","CHERNARUS","CHERNARUS_SUMMER",
	"FDF_ISLE1_A","MBG_CELLE2","WOODLAND_ACR","BOOTCAMP_ACR","THIRSK","BORNHOLM","UTES","ANIM_HELVANTIS_V2","ABRAMIA","PANTHERA3","VT5",
	"TANOA"
];
ADV_var_europeMaps = [
	"STRATIS","ALTIS",
	"SARA","SARALITE","SARA_DBE1","INTRO","CHERNARUS","CHERNARUS_SUMMER",
	"FDF_ISLE1_A","MBG_CELLE2","WOODLAND_ACR","BOOTCAMP_ACR","THIRSK","BORNHOLM","UTES","ANIM_HELVANTIS_V2","ABRAMIA","PANTHERA3","VT5"
];
switch ( ADV_par_customUni ) do {
	case 1: { ADV_par_customUni = if ((toUpper worldname) in ADV_var_lushMaps) then {2} else {1}; };
	case 2: { ADV_par_customUni = if ((toUpper worldname) in ADV_var_aridMaps) then {1} else {2}; };
	default {};
};

if ((toUpper worldname) isEqualTo "TANOA") then {
	if ( ADV_par_customUni == 0 ) then { ADV_par_customUni = 20 };
	if ( ADV_par_opfUni == 0 ) then { ADV_par_opfUni = 20 };
};

if (isClass(configFile >> "CfgPatches" >> "ace_rearm") && (ADV_par_modTankAssets == 1 || ADV_par_modTankAssets == 2)) then {
	missionNamespace setVariable ["ace_rearm_level",0];
};

//cTab-specials:
if (isClass (configFile >> "CfgPatches" >> "cTab") && ADV_par_Tablets == 1) then {
	cTab_encryptionKey_west = "b";
	cTab_encryptionKey_east = "o";
	if ( [independent,west] call BIS_fnc_sideIsFriendly ) then {
		cTab_encryptionKey_guer = "b";
	} else {
		if ( [independent,east] call BIS_fnc_sideIsFriendly ) then {
			cTab_encryptionKey_guer = "o";
		} else {
			cTab_encryptionKey_guer = "i";
		};
	};
	cTab_encryptionKey_civ = "c";
    cTab_vehicleClass_has_FBCB2 = ["Car","Armored"];
    cTab_vehicleClass_has_TAD = ["Helicopter","Plane"];
} else {
    cTab_vehicleClass_has_FBCB2 = [];
    cTab_vehicleClass_has_TAD = [];
};

//DLP:
//CL_IE_Module_Enabled = true;

//tawVD:
tawvd_disablenone = true;

//finalization:
ADV_variables_defined = true;

if (true) exitWith {};
/*
ADV_Variables by Belbo
contains all the variables that are important for a mission
call from init.sqf AND initPlayerLocal.sqf via (as early as possible):
call compile preprocessfilelinenumbers "ADV_Setup\ADV_Variables.sqf";
*/

//map variables:
ADV_var_aridMaps = [
	"MCN_ALIABAD","BMFAYSHKHABUR","CLAFGHAN","FALLUJAH","FATA","HELLSKITCHEN","HELLSKITCHENS","MCN_HAZARKOT","PRAA_AV","RESHMAAN"
	,"SHAPUR_BAF","TAKISTAN","TORABORA","TUP_QOM","ZARGABAD","PJA307","PJA306","MOUNTAINS_ACR","TUNBA","KUNDUZ","PORTO"
];
ADV_var_sAridMaps = [
	"STRATIS","ALTIS","ISLADUALA3"
];
ADV_var_lushMaps = [
	"LINGOR3","MAK_JUNGLE","PJA305","TROPICA","TIGERIA","TIGERIA_SE","SARA","SARALITE","SARA_DBE1","INTRO","CHERNARUS","CHERNARUS_SUMMER"
	,"FDF_ISLE1_A","MBG_CELLE2","WOODLAND_ACR","BOOTCAMP_ACR","THIRSK","BORNHOLM","UTES","ANIM_HELVANTIS_V2","ABRAMIA","PANTHERA3","VT5"
	,"TANOA"
];
ADV_var_europeMaps = [
	"STRATIS","ALTIS"
	,"SARA","SARALITE","SARA_DBE1","INTRO","CHERNARUS","CHERNARUS_SUMMER"
	,"FDF_ISLE1_A","MBG_CELLE2","WOODLAND_ACR","BOOTCAMP_ACR","THIRSK","BORNHOLM","UTES","ANIM_HELVANTIS_V2","ABRAMIA","PANTHERA3","VT5"
];

//finalization:
ADV_variables_defined = true;

if (true) exitWith {};
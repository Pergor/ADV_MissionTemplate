waitUntil {player == player};

ADV_par_Radios = 1;			// 0 no radios, 1 = radios, 2 = radios for leaders only
ADV_par_optics = 1;			// optics for west & indep
ADV_par_opfOptics = 1;		//optics for east
ADV_par_Silencers = 0;		//silencers for west & indep (0 = no silencers; 1 = silencers on weapons; 2 = silencers in inventory)
ADV_par_opfSilencers = 0;	//silencers for east (0 = no silencers; 1 = silencers on weapons; 2 = silencers in inventory)
ADV_par_NVGs = 0;			//NVGs for west & indep (0 = no night equipment; 1 = night equipment without NVGs; 2 = night equipment with NVGs)
ADV_par_opfNVGs = 0;		//NVGs for east (0 = no night equipment; 1 = night equipment without NVGs; 2 = night equipment with NVGs)
ADV_par_Tablets = 1;		//0 = vanilla gps, 1 = cTab, 2 = ACE, 99 = no gps
ADV_par_DLCContent = 1:		//define if dlc content should be given, if players own the DLCs

ADV_var_aridMaps = [
	"MCN_ALIABAD","BMFAYSHKHABUR","CLAFGHAN","FALLUJAH","FATA","HELLSKITCHEN","HELLSKITCHENS","MCN_HAZARKOT","PRAA_AV","RESHMAAN",
	"SHAPUR_BAF","TAKISTAN","TORABORA","TUP_QOM","ZARGABAD","PJA307","PJA306","MOUNTAINS_ACR","TUNBA","KUNDUZ"
];
ADV_var_sAridMaps = [
	"STRATIS","ALTIS","PORTO","ISLADUALA3"
];
ADV_var_lushMaps = [
	"LINGOR3","MAK_JUNGLE","PJA305","TROPICA","TIGERIA","TIGERIA_SE","SARA","SARALITE","SARA_DBE1","INTRO","CHERNARUS","CHERNARUS_SUMMER",
	"FDF_ISLE1_A","MBG_CELLE2","WOODLAND_ACR","BOOTCAMP_ACR","THIRSK","BORNHOLM","UTES","ANIM_HELVANTIS_V2","ABRAMIA","PANTHERA3","VT5"
];

//defines the player's unit:
[player] call ADV_fnc_playerUnit;

//waitUntil-player is initialized
waitUntil {time > 1};

//stupid goggles are removed:
if ( goggles player in ["Mask_M40_OD","Mask_M40","Mask_M50"] ) then { removeGoggles player; };
sleep 1;
//loadouts and RespawnMPEVH are placed on the units on spawn. [target, respawn with gear (bool)]
[player] call ADV_fnc_applyLoadout;

if (!isNil "OBJECT") then { OBJECT addAction [("<t color=""#00FF00"">" + ("Loadout-Menü") + "</t>"), {createDialog "adv_1_loadoutDialog";},nil,6,false,true,"","player distance cursortarget <5"]; };

if (true) exitWith {};
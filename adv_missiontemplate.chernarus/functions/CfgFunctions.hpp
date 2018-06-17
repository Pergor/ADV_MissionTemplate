class adv
{
	tag = "adv";
	class init
	{
		class initOrganizer { preInit = 1; };
		class init {};
		class initPlayerLocal {};
		class initServer {};
		class storyboard
		{
			file = "mission\ADV_storyboard.sqf";
			postInit = 1;
		};
	};
	class userSettings
	{
		class acreSettings { file = "mission\config\fn_acreSettings.sqf"; };
		class radioGroups { file = "mission\config\fn_radioGroups.sqf"; };
		class tfarSettings { file = "mission\config\fn_tfarSettings.sqf"; };
		class userMarkers { file = "mission\config\fn_userMarkers.sqf"; };
		class userVariables { file = "mission\config\fn_userVariables.sqf"; };
	};
	class preInit
	{
		class aceParams { postInit = 1; };
		class collectCrates {};
		class collectFlags {};
		class parVariables {};
		class variables {};
		class missionMarkers {};
		class sideMarkers {};
		class fhqTT
		{
			file = "scripts\fhqtt2.sqf";
			preInit = 1;
		};
		class init_upsmon
		{
			file = "scripts\Init_UPSMON.sqf";
			preInit = 1;
		};
		class credits { file = "mission\ADV_credits.sqf";preInit = 1; };
		class tasks { file = "mission\ADV_tasks.sqf";preInit = 1; };
		class briefing { file = "mission\ADV_briefing.sqf";preInit = 1; };
		class leaderBriefing { file = "mission\ADV_leaderBriefing.sqf"; preInit = 1; };
	};
	class postInit {
		class postInitVariables { postInit = 1; };
	};
	class shared
	{
		class CPInit {};
		class jammer {};
		class mortarFlare {};
		class radioRelay {};
		//class radioRelay_new {};
		class weather {};
	};
	class server_internal
	{
		file = "functions\server\internal";
		class addACEItems {};
		class addVehicleLoad {};
		class changeVeh {};
		class createAresLogic {};
		class disableVehSelector {};
		class enableInfoComponent {};
		class manageVeh {};
		class nil {};
		class rhsDecals {};
		class zeusEVH {};
	};
	class server
	{
		class armedHuron {};
		class artillery {};
		class board {};
		class CASRun {};
		class clearFreedom {};
		class createZeus {};
		class disableTI {};
		class disableVeh {};
		class findNearestObject {};
		class flare {};
		class getBaseClass {};
		class getClassNames {};
		class getGroupVehicles {};
		class getOppPos {};
		class getPos {};
		class HCobjects {};
		class IEDhandler {};
		class lockVeh {};
		class paraBomb {};
		class paraCrate {};
		class respawnVeh {};
		class retexture {};
		class setRating {};
		class slingloadSupply {};
		class zeusObjects {};
	};
	class serverGear
	{
		class clearCargo {};
		class crate {};
		class removeWeapon {};
		class submarineLoad {};
		class vehicleLoad {};
	};
	class AI
	{
		class aceHostage {};
		class aiTask {};
		class changeName {};
		class findNearestEnemy {};
		class setSafe {};
		class setSide {};
		class setSkill {};
		class spawnAttack {};
		class spawnConvoy {};
		class spawnGroup {};
		class spawnPatrol {};
		class upsmon {
			file = "scripts\UPSMON.sqf";
		};
		class ZenOccupyHouse {};
	};
	class client_internal
	{
		file = "functions\client\internal";
		class adminCommands {};
		class aresModules {};
		class dialogTeleport {};
		class execTeleport {};
		class moveRespMarker {};
		class privateDebug {};
	};
	class client
	{
		class aceMine {};	
		class changeUnit {};
		class disableInput {};
		class dispLaunch {};
		class enableChannels {};
		class findInGroup {};
		class flag {};
		class fullHeal {};
		class inGroup {};
		class jamChance {};
		class paraJump {};
		class paraJumpSelection {};
		class playerUnit {};
		class safeZone {};
		class showArtiSetting {};
		class siren {};
		class spawnFire {};
		class speedLimiter {};
		class teleport {};
		class timedHint {};
		class undercover {};
		class vtolAction {};
	};
	class gear_internal
	{
		file = "functions\gear\internal";
		class aceGear {};
		class aceMedicalItems {};
		class applyLoadout {};
		class dialogGearInit {};
		class dialogLoadout {};
		class loadoutVariables {};
		class rhsNametag {};
	};
	class gear
	{
		class aceFAK {};
		class aceGunbag {};
		class add40mm {};
		class addGPS {};
		class addGrenades {};
		class addMagazine {};
		class addRadios {};
		class CSW {};
		class defaultAttire {};
		class gear {};
		class insignia {};
		class LRBackpack {};
		class setChannels {};
		class setFaction {};
		class setFrequencies {};
		class standardWeapon {};
	};
	class gearsaving
	{
		class gearloading {};
		class gearsaving {};
		class loadoutStats {};
		class saveGear {};
		class readdGear {};
	};
	class loadouts
	{
		class AA {};
		class ABearer {};
		class AR {};
		class AT {};
		class assAA {};
		class assAR {};
		class assAT {};
		class cls {};
		class command {};
		class diver {};
		class diver_medic {};
		class diver_spec {};
		class driver {};
		class ftleader {};
		class gren {};
		class leader {};
		class lmg {};
		class log {};
		class marksman {};
		class medic {};
		class jetPilot {};
		class pilot {};
		class sniper {};
		class soldier {};
		class soldierAT {};
		class spec {};
		class spotter {};
		class uavOp {};
	};
	class loadouts_civ
	{
		class civ {};
		class civDiver {};
		class civEngineer {};
		class civEOD {};
		class civPilot {};
		class civDoc {};
		class civPolice {};
		class civPress {};
	};
	class logistic_internal
	{
		file = "functions\logistic\internal";
		class dialogLogInit {};
		class dialogLogistic {};
		class dropAction {};
		class dropLogistic {};
	};
	class logistic
	{
		class crateAA {};
		class crateAT {};
		class crateDrone {};
		class crateDrone_medic {};
		class crateEOD {};
		class crateGrenades {};
		class crateLarge {};
		class crateMedic {};
		class crateMG {};
		class crateNormal {};
		class crateShells {};
		class crateStuff {};
		class crateSupport {};
		class crateTeam {};
	};
};
class aeroson
{
	tag = "aeroson";
	class gearsaving
	{
		class gearsaving {};
		class gearloading {};
		class getloadout {};
		class setloadout {};
	};
	class cleanUp
	{
		class cleanUp {file = "scripts\repetitive_cleanup.sqf";};
	};
};
class MtB
{
	tag = "MtB";
	class randomWeather
	{
		class randomWeather {file = "scripts\randomWeather.sqf";};
	};
};
class SA
{
	tag = "SA";
	class advancedTowing
	{
		class advancedTowingInit {file = "scripts\fn_advancedTowingInit.sqf"; postInit = 1;};
	};
};
class whk
{
	tag = "whk";
	class headlessClient
	{
		class headless {file = "scripts\WerthlesHeadless.sqf";};
	};
};
class engima
{
	tag = "engima";
	class civilians
	{
		class civilians_init
		{
			file = "scripts\engima\civilians\init.sqf";
			postInit = 1;
		};
		class traffic_init
		{
			file = "scripts\engima\traffic\init.sqf";
			postInit = 1;
		};
	};
};
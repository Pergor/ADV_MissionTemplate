class adv
{
	tag = "adv";
	class init
	{
		class initOrganizer { preInit = 1; };
		class init {};
		class initPlayerLocal {};
		class initServer {};
	};
	class settings
	{
		class acreSettings {};
		class tfarSettings {};
	};
	class preInit
	{
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
	class shared
	{
		class jammer {};
		class radioRelay {};
		class weather {};
	};
	class server_internal
	{
		file = "functions\server\internal";
		class addACEItems {};
		class addVehicleLoad {};
		class changeVeh {};
		class disableVehSelector {};
		class manageVeh {};
		class nil {};
		class rhsDecals {};
	};
	class server
	{
		class armedHuron {};
		class artillery {};
		class board {};
		class CASRun {};
		class createZeus {};
		class disableTI {};
		class disableVeh {};
		class findNearestObject {};
		class flare {};
		class getOppPos {};
		class HCobjects {};
		class IEDhandler {};
		class lockVeh {};
		class paraBomb {};
		class paraCrate {};
		class respawnVeh {};
		class retexture {};
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
		class aiTask {};
		class findNearestEnemy {};
		class setSide {};
		class spawnAttack {};
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
		class dialogTeleport {};
		class execTeleport {};
		class moveRespMarker {};
	};
	class client
	{
		class aceMine {};		
		class changeName {};
		class changeUnit {};
		class dispLaunch {};
		class findInGroup {};
		class flag {};
		class fullHeal {};
		class inGroup {};
		class paraJump {};
		class paraJumpSelection {};
		class playerUnit {};
		class safeZone {};
		class showArtiSetting {};
		class spawnFire {};
		class speedLimiter {};
		class teleport {};
		class timedHint {};
		class undercover {};
	};
	class gear_internal
	{
		file = "functions\gear\internal";
		class aceGear {};
		class aceGunbag {};
		class aceMedicalItems {};
		class applyLoadout {};
		class dialogGearInit {};
		class dialogLoadout {};
		class loadoutVariables {};
	};
	class gear
	{
		class aceFAK {};
		class add40mm {};
		class addGPS {};
		class addGrenades {};
		class addMagazine {};
		class addRadios {};
		class CSW {};
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
		class civPilot {};
		class doc {};
		class police {};
		class press {};
	};
	class logistic_internal
	{
		file = "functions\logistic\internal";
		class dialogLogInit {};
		class dialogLogistic {};
		class dropLogistic {};
	};
	class logistic
	{
		class crateAA {};
		class crateAT {};
		class crateEOD {};
		class crateGrenades {};
		class crateLarge {};
		class crateMedic {};
		class crateMG {};
		class crateNormal {};
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
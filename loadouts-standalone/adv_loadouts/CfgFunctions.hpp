class ADV 
{
	tag = "ADV";
	class preInit
	{
		file = "adv_loadouts\preInit";
		class loadoutVariables {
			file = "adv_loadoutVariables.sqf";
			preInit = 1;
		};
		class variables { preInit = 1; };
	};
	class server
	{
		file = "adv_loadouts\server";
		class nil {};
	};
	class client
	{
		file = "adv_loadouts\client";
		class findInGroup {};
		class inGroup {};
		class playerUnit {};
		class setFrequencies {};
	};
	class gear
	{
		class aceFAK {};
		class aceGear {};
		class aceGunbag {};
		class aceMedicalItems {};
		class add40mm {};
		class addGPS {};
		class addGrenades {};
		class addMagazine {};
		class addRadios {};
		class applyLoadout {};
		class CSW {};
		class dialogGearInit {};
		class dialogLoadout {};
		class gear {};
		class insignia {};
		class setChannels {};
		class setFaction {};
		class standardWeapon {};
	};
	class gearsaving
	{
		class gearloading {};
		class gearsaving {};
		class saveGear {};
		class readdGear {};
	};
	//loadouts BLUFOR:
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
	//logistics BLUFOR:
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
		class crateTeam {};
		class crateStuff {};
		class crateSupport {};
		class dialogLogInit {};
		class dialogLogistic {};
		class dropLogistic {};
		class emptyCrate {};
		class paraCrate {};
	};
};

class ADV_ind
{
	tag = "adv_ind";
	//loadouts INDFOR:
	class loadouts
	{
		file = "adv_loadouts\loadouts_ind";
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
	//logistics INDFOR:
	class logistic
	{
		file = "adv_loadouts\logistic_ind";
		class crateAA {};
		class crateAT {};
		class crateEOD {};
		class crateGrenades {};
		class crateLarge {};
		class crateMedic {};
		class crateMG {};
		class crateNormal {};
		class crateTeam {};
		class crateSupport {};
	};
};

class ADV_opf
{
	tag = "adv_opf";
	//loadouts OPFOR:
	class loadouts
	{
		file = "adv_loadouts\loadouts_opf";
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
	//logistics OPFOR:
	class logistic
	{
		file = "adv_loadouts\logistic_opf";
		class crateAA {};
		class crateAT {};
		class crateEOD {};
		class crateGrenades {};
		class crateLarge {};
		class crateMedic {};
		class crateMG {};
		class crateNormal {};
		class crateTeam {};
		class crateSupport {};
	};
};
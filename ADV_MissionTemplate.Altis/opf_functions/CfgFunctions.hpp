class ADV_opf
{
	tag = "ADV_opf";
	class opf_server
	{
		file = "opf_functions\server";
		class changeVeh {};
		class disableVehSelector {};
		class manageVeh {postInit = 1;};
		class respawnVeh {};
	};
	class opf_gear
	{
		file = "opf_functions\gear";
		class addVehicleLoad {};
		class crate {};
		class mgCrate {};
		class vehicleLoad {};
	};
	class opf_loadouts
	{
		file = "opf_functions\loadouts";
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
	class opf_logistic
	{
		file = "opf_functions\logistic";
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
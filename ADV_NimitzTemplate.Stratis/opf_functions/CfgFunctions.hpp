class ADV_opf
{
	tag = "ADV_opf";
	class server
	{
		file = "opf_functions\server";
		class disableVehSelector {};
		class manageVeh { postInit = 1; };
		class rhsDecals {};
	};
	class gear
	{
		file = "opf_functions\gear";
		class addVehicleLoad {};
		class crate {};
		class vehicleLoad {};
	};
	class loadouts
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
	class logistic
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
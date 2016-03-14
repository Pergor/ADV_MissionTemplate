class ADV_ind
{	
	tag = "ADV_ind";
	class server
	{
		file = "ind_functions\server";
		class manageVeh {postInit = 1;};
		class changeVeh {};
		class respawnVeh {};
	};
	class gear
	{
		file = "ind_functions\gear";
		class addVehicleLoad {};
		class crate {};
		class vehicleLoad {};
	};
	class loadouts
	{
		file = "ind_functions\loadouts";
		class AA {};
		class ABearer {};
		class AR {};
		class assAA {};
		class assAR {};
		class assAT {};
		class AT {};
		class command {};
		class cls {};
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
	class ind_logistic
	{
		file = "ind_functions\logistic";
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
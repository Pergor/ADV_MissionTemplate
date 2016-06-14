if (!isServer) exitWith {};

private ["_submarine"];

{
	_submarine = _x;

	_submarine addMagazineCargoGlobal ["20Rnd_556x45_UW_mag",10];
	_submarine addMagazineCargoGlobal ["30Rnd_556x45_Stanag",10];
	
	_submarine addMagazineCargoGlobal ["SmokeShellBlue",5];
	_submarine addMagazineCargoGlobal ["Chemlight_Blue",5];

	_submarine addMagazineCargoGlobal ["SatchelCharge_Remote_Mag",2];

	//medical stuff
	//ACE items (if ACE is running on the server) - (integers)
	if (isClass (configFile >> "CfgPatches" >> "ACE_common")) then {
		_ACE_atropine = 2;
		_ACE_fieldDressing = 5;
		_ACE_elasticBandage = 5;
		_ACE_quikclot = 5;
		_ACE_bloodIV = 0;
		_ACE_bloodIV_500 = 0;
		_ACE_bloodIV_250 = 0;
		_ACE_bodyBag = 2;
		_ACE_epinephrine = 3;
		_ACE_morphine = 3;
		_ACE_packingBandage = 5;
		_ACE_personalAidKit = 3;
		_ACE_plasmaIV = 0;
		_ACE_plasmaIV_500 = 0;
		_ACE_plasmaIV_250 = 0;
		_ACE_salineIV = 0;
		_ACE_salineIV_500 = 3;
		_ACE_salineIV_250 = 0;
		_ACE_surgicalKit = 0;
		_ACE_tourniquet = 2;
	
		_ACE_EarPlugs = 0;

		_ACE_SpareBarrel = 0;
		_ACE_tacticalLadder = 0;
		_ACE_UAVBattery = 0;
		_ACE_wirecutter = 1;
		_ACE_Clacker = 0;
		_ACE_M26_Clacker = 0;
		_ACE_DeadManSwitch = 0;
		_ACE_DefusalKit = 1;
		_ACE_Cellphone = 0;
		_ACE_MapTools = 0;
		_ACE_CableTie = 0;
		_ACE_NonSteerableParachute = 0;

		_ACE_key_west = 0;
		_ACE_key_east = 0;
		_ACE_key_indp = 0;
		_ACE_key_civ = 0;
		_ACE_key_master = 0;
		_ACE_key_lockpick = 0;
		_ACE_kestrel = 0;
		_ACE_ATragMX = 0;
		_ACE_rangecard = 0;
		_ACE_altimeter = 0;
		_ACE_microDAGR = 0;
		_ACE_DAGR = 0;
		_ACE_RangeTable_82mm = 0;
		_ACE_rangefinder = 0;
		_ACE_NonSteerableParachute = 0;
		_ACE_IR_Strobe = 1;
		_ACE_M84 = 0;
		_ACE_HandFlare_Green = 0;
		_ACE_HandFlare_Red = 0;
		_ACE_HandFlare_White = 0;
		_ACE_HandFlare_Yellow = 0;
		[_submarine] call ADV_fnc_addACEItems;
	};
	if !(isClass (configFile >> "CfgPatches" >> "ACE_Medical")) then {
		_submarine addItemCargoGlobal ["FirstAidKit",20];
		_submarine addItemCargoGlobal ["MediKit",1];	
	};

} forEach _this;

if (true) exitWith {};
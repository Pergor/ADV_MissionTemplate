/*
cratefiller script by Belbo
put this into init-line of the crate that's supposed to contain the items specified below:
nul = [[this],true,true] call ADV_fnc_resupplyCrate;
*/

if (!isServer) exitWith {};
private ["_target","_bandages","_morphine","_epiPen","_bloodbag","_FAKs","_mediKit"];

{
	_target = _x;
	//makes the crates indestructible:
	_target allowDamage false;
	
	//weapons & ammo
	switch (true) do {
		//RHS
		case (ADV_par_opfWeap == 1 && ADV_par_opfWeap == 2): {
			_target addWeaponCargoGlobal ["rhs_weap_rpg7",1];
			
			_target addMagazineCargoGlobal ["rhs_rpg7_PG7VL_mag",4];
			_target addMagazineCargoGlobal ["rhs_rpg7_PG7VR_mag",4];
			
			_target addMagazineCargoGlobal ["rhs_mag_9k38_rocket",4];
		};
		//CUP
		case (ADV_par_opfWeap == 3): {
			_target addWeaponCargoGlobal ["CUP_launch_RPG7V",1];

			_target addMagazineCargoGlobal ["CUP_PG7V_M",4];
			_target addMagazineCargoGlobal ["CUP_PG7VL_M",4];
			
			_target addMagazineCargoGlobal ["CUP_Igla_M",4];
		};
		case (ADV_par_opfWeap == 4): {};
		default {
			_target addWeaponCargoGlobal ["launch_RPG32_F",1];
			
			_target addMagazineCargoGlobal ["RPG32_F",3];
			_target addMagazineCargoGlobal ["Titan_AT",4];
			
			_target addMagazineCargoGlobal ["Titan_AA",4];
		};
	};
	//grenades
	switch (true) do {
		case ( ADV_par_opfWeap == 1 && ADV_par_opfWeap == 2): {
			_target addMagazineCargoGlobal ["rhs_mag_rdg2_white",2];
		};
		default {
			_target addMagazineCargoGlobal ["SmokeShell",2];
		};
	};
	if ( ADV_par_opfNVGs == 2 && !(isClass (configFile >> "CfgPatches" >> "ACE_attach")) ) then {
		_target addMagazineCargoGlobal ["O_IR_Grenade",1];
	};

	_ACE_fieldDressing = 0;
	_ACE_packingBandage = 0;
	_ACE_elasticBandage = 0;
	_ACE_quikclot = 0;
	_ACE_atropine = 0;
	_ACE_epinephrine = 0;
	_ACE_morphine = 0;
	_ACE_tourniquet = 0;
	_ACE_bloodIV = 0;
	_ACE_bloodIV_500 = 0;
	_ACE_bloodIV_250 = 0;
	_ACE_plasmaIV = 0;
	_ACE_plasmaIV_500 = 0;
	_ACE_plasmaIV_250 = 0;
	_ACE_salineIV = 0;
	_ACE_salineIV_500 = 0;
	_ACE_salineIV_250 = 0;
	_ACE_personalAidKit = 0;
	_ACE_surgicalKit = 0;
	_ACE_bodyBag = 0;
	
	_FAKs = 2;
	_mediKit = 0;
	
	if !(isClass (configFile >> "CfgPatches" >> "ACE_Medical")) then {
		_target addItemCargoGlobal ["FirstAidKit",_FAKs];
		_target addItemCargoGlobal ["MediKit",_mediKit];
	};
	//medical stuff
	if (isClass (configFile >> "CfgPatches" >> "ACE_common")) then {
		_ACE_EarPlugs = 4;

		_ACE_SpareBarrel = 0;
		_ACE_tacticalLadder = 0;
		_ACE_UAVBattery = 0;
		_ACE_wirecutter = 0;
		_ACE_sandbag = 0;
		_ACE_Clacker = 0;
		_ACE_M26_Clacker = 0;
		_ACE_DeadManSwitch = 0;
		_ACE_DefusalKit = 0;
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
		_ACE_vector = 0;
		_ACE_NonSteerableParachute = 0;
		_ACE_IR_Strobe = 1;
		_ACE_M84 = 0;
		_ACE_HandFlare_Green = 0;
		_ACE_HandFlare_Red = 2;
		_ACE_HandFlare_White = 0;
		_ACE_HandFlare_Yellow = 0;
		[_target] call ADV_fnc_addACEItems;
	};
} forEach _this;

if (true) exitWith {true;};
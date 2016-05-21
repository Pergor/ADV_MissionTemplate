/*
cratefiller script by Belbo
put this into init-line of the crate that's supposed to contain the items specified below:
nul = [[this],true,true] call ADV_fnc_resupplyCrate;
*/

if (!isServer) exitWith {};
private ["_target"];
{
	_target = _x;
	//makes the crates indestructible:
	_target allowDamage false;

	//weapons
	_target addWeaponCargoGlobal ["launch_NLAW_F",5];
	//ammo
	if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _target addMagazineCargoGlobal ["NLAW_F",5]; };
	_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag",40];
	_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer",20];
	_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",40];
	_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red",20];
	_target addMagazineCargoGlobal ["20Rnd_762x51_Mag",20];
	_target addMagazineCargoGlobal ["200Rnd_65x39_cased_Box",12];
	_target addMagazineCargoGlobal ["130Rnd_338_Mag",12];
	_target addMagazineCargoGlobal ["150Rnd_762x54_Box",6];
	_target addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer",6];
	_target addMagazineCargoGlobal ["11Rnd_45ACP_Mag",20];
	//grenades
	_target addMagazineCargoGlobal ["HandGrenade",20];
	_target addMagazineCargoGlobal ["SmokeShell",30];
	_target addMagazineCargoGlobal ["SmokeShellGreen",20];
	_target addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",24];
	_target addMagazineCargoGlobal ["1Rnd_SmokeRed_Grenade_shell",12];
	_target addMagazineCargoGlobal ["1Rnd_SmokePurple_Grenade_shell",12];
	_target addMagazineCargoGlobal ["1Rnd_SmokeYellow_Grenade_shell",12];
	
	if !(isClass (configFile >> "CfgPatches" >> "ACE_attach")) then {
		_target addMagazineCargoGlobal ["B_IR_Grenade",6];
	};

	_ACE_fieldDressing = 24;
	_ACE_packingBandage = 50;
	_ACE_elasticBandage = 50;
	_ACE_quikclot = 80;
	_ACE_atropine = 10;
	_ACE_epinephrine = 40;
	_ACE_morphine = 40;
	_ACE_tourniquet = 24;
	_ACE_plasmaIV = 12;
	_ACE_plasmaIV_500 = 12;
	_ACE_plasmaIV_250 = 0;
	_ACE_salineIV = 12;
	_ACE_salineIV_500 = 12;
	_ACE_salineIV_250 = 0;
	_ACE_bloodIV = 12;
	_ACE_bloodIV_500 = 12;
	_ACE_bloodIV_250 = 0;
	_ACE_bodyBag = 10;
	if ( (missionnamespace getVariable ["ace_medical_consumeItem_PAK",0]) == 0 ) then {
		_ACE_personalAidKit = 0;
	} else {
		_ACE_personalAidKit = 5;
	};
	if ( (missionnamespace getVariable ["ace_medical_consumeItem_SurgicalKit",0]) == 0 ) then {
		_ACE_surgicalKit = 1;
	} else {
		_ACE_surgicalKit = 10;
	};
	
	_FAKs = 20;
	_mediKit = 1;
	
	if !(isClass (configFile >> "CfgPatches" >> "ACE_Medical")) then {
		_target addItemCargoGlobal ["FirstAidKit",_FAKs];
		_target addItemCargoGlobal ["MediKit",_mediKit];	
	};
	//medical stuff
	if (isClass (configFile >> "CfgPatches" >> "ACE_common")) then {
		_ACE_EarPlugs = 10;

		_ACE_SpareBarrel = 1;
		_ACE_tacticalLadder = 0;
		_ACE_UAVBattery = 0;
		_ACE_wirecutter = 0;
		_ACE_sandbag = 0;
		_ACE_Clacker = 0;
		_ACE_M26_Clacker = 0;
		_ACE_DeadManSwitch = 0;
		_ACE_DefusalKit = 0;
		_ACE_Cellphone = 0;
		_ACE_MapTools = 5;
		_ACE_CableTie = 20;
		_ACE_NonSteerableParachute = 0;

		_ACE_key_west = 1;
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
		_ACE_IR_Strobe = 6;
		_ACE_M84 = 0;
		_ACE_HandFlare_Green = 0;
		_ACE_HandFlare_Red = 10;
		_ACE_HandFlare_White = 0;
		_ACE_HandFlare_Yellow = 0;
		[_target] call ADV_logistic_fnc_addACEItems;
	};
} forEach _this;

if (true) exitWith {true;};
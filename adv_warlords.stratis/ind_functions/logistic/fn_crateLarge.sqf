/*
 * Author: Belbo
 *
 * Fills a crate with equipment and ammunition for roughly a whole squad for INDFOR
 *
 * Arguments:
 * Array of objects - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [this] call adv_ind_fnc_crateLarge;
 *
 * Public: Yes
 */
 
//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

{
	private _target = _x;
	//makes the crates indestructible:
	_target allowDamage false;

	//weapons & ammo
	switch (true) do {
		//RHS
		case (_par_indWeap == 2): {
			//ammo
			_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",40];
			_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red",20];
			_target addMagazineCargoGlobal ["rhsusf_200Rnd_556x45_soft_pouch",12];
			_target addMagazineCargoGlobal ["rhsusf_100Rnd_762x51_m80a1epr",12];
			_target addMagazineCargoGlobal ["rhsusf_20Rnd_762x51_m118_special_Mag",20];
			_target addMagazineCargoGlobal ["rhsusf_mag_7x45acp_MHP",20];
		};
		case (_par_indWeap == 3): {
			//ammo
			_target addMagazineCargoGlobal ["hlc_20rnd_762x51_b_G3",40];
			_target addMagazineCargoGlobal ["hlc_20rnd_762x51_T_G3",20];			
			_target addMagazineCargoGlobal ["hlc_20rnd_762x51_B_fal",40];
			_target addMagazineCargoGlobal ["hlc_20rnd_762x51_T_fal",20];
			_target addMagazineCargoGlobal ["hlc_50rnd_762x51_M_FAL",40];
			_target addMagazineCargoGlobal ["hlc_100Rnd_762x51_M_M60E4",12];
			if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
				_target addMagazineCargoGlobal ["RH_7Rnd_45cal_m1911",20];
			} else {
				_target addMagazineCargoGlobal ["11Rnd_45ACP_Mag",20];
			};
		};
		case (_par_indWeap == 21): {
			_target addMagazineCargoGlobal ["30Rnd_762x39_Mag_F",40];
			_target addMagazineCargoGlobal ["30Rnd_762x39_Mag_Tracer_F",20];
			_target addMagazineCargoGlobal ["30Rnd_545x39_Mag_F",10];
			_target addMagazineCargoGlobal ["200Rnd_556x45_Box_F",12];
			_target addMagazineCargoGlobal ["9Rnd_45ACP_Mag",20];

			_target addMagazineCargoGlobal ["20Rnd_762x51_Mag",20];
			_target addMagazineCargoGlobal ["150Rnd_762x54_Box",6];
			_target addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer",6];		
		};
		default {
			_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",40];
			_target addMagazineCargoGlobal ["30rnd_556x45_STANAG_Tracer_Yellow",20];
			_target addMagazineCargoGlobal ["20Rnd_762x51_Mag",20];
			call {
				if (_par_indWeap==20) exitWith {
					_target addMagazineCargoGlobal ["200Rnd_556x45_Box_F",12];
				};
				_target addMagazineCargoGlobal ["200Rnd_65x39_cased_Box",12];
			};
			_target addMagazineCargoGlobal ["130Rnd_338_Mag",12];
			_target addMagazineCargoGlobal ["9Rnd_45ACP_Mag",20];
			//_target addMagazineCargoGlobal ["150Rnd_762x54_Box",6];
			//_target addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer",6];
		};
	};
	//grenades
	switch (_par_indWeap) do {
		case 2: {
			_target addMagazineCargoGlobal ["rhs_mag_m67",20];
			_target addMagazineCargoGlobal ["rhs_mag_an_m8hc",30];
			_target addMagazineCargoGlobal ["rhs_mag_m18_green",10];
			_target addMagazineCargoGlobal ["rhs_mag_m18_red",10];
		};
		default {
			_target addMagazineCargoGlobal ["HandGrenade",10];
			_target addMagazineCargoGlobal ["MiniGrenade",10];
			_target addMagazineCargoGlobal ["SmokeShell",30];
			_target addMagazineCargoGlobal ["SmokeShellGreen",20];
		};
	};
	_target addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",24];
	_target addMagazineCargoGlobal ["1Rnd_SmokeRed_Grenade_shell",12];
	_target addMagazineCargoGlobal ["1Rnd_SmokePurple_Grenade_shell",12];
	_target addMagazineCargoGlobal ["1Rnd_SmokeYellow_Grenade_shell",12];
	_target addMagazineCargoGlobal ["UGL_FlareYellow_F",20];
	
	if ( _par_NVGs == 2 && !(isClass (configFile >> "CfgPatches" >> "ACE_attach")) ) then {
		_target addMagazineCargoGlobal ["I_IR_Grenade",6];
	};

	_ACE_fieldDressing = 100;
	_ACE_packingBandage = 20;
	_ACE_elasticBandage = 40;
	_ACE_quikclot = 20;
	if (missionnamespace getVariable ["ace_medical_enableAdvancedWounds",false]) then {
		_ACE_fieldDressing = 24;
		_ACE_packingBandage = 50;
		_ACE_elasticBandage = 50;
		_ACE_quikclot = 80;
	};
	_ACE_atropine = 10;
	_ACE_epinephrine = 20;
	_ACE_morphine = 20;
	_ACE_tourniquet = 24;
	_ACE_plasmaIV = 0;
	_ACE_plasmaIV_500 = 0;
	_ACE_plasmaIV_250 = 0;
	_ACE_salineIV = 24;
	_ACE_salineIV_500 = 24;
	_ACE_salineIV_250 = 0;
	_ACE_bloodIV = 0;
	_ACE_bloodIV_500 = 0;
	_ACE_bloodIV_250 = 0;
	_ACE_bodyBag = 10;
	_ACE_personalAidKit = 0;
	if ( (missionnamespace getVariable ["ace_medical_consumeItem_PAK",0]) > 0 ) then {
		_ACE_personalAidKit = 2;
	};
	_ACE_surgicalKit = 1;
	if ( (missionnamespace getVariable ["ace_medical_consumeItem_SurgicalKit",0]) > 0 ) then {
		_ACE_surgicalKit = 10;
	};
	
	_ACE_advACEsplint_splint = 12;
	
	_FAKs = 20;
	_mediKit = 1;
	
	if (isClass(configFile >> "CfgPatches" >> "adv_aceRefill")) then {
		_target addItemCargoGlobal ["adv_aceRefill_manualKit",2];
	};
	
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

		_ACE_key_west = 0;
		_ACE_key_east = 0;
		_ACE_key_indp = 1;
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
		[_target] call ADV_fnc_addACEItems;
	};
	nil;
} count _this;

true;
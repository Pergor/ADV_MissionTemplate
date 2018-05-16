/*
 * Author: Belbo
 *
 * Fills a crate with equipment and ammunition for roughly a whole squad for OPFOR
 *
 * Arguments:
 * Array of objects - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [this] call adv_opf_fnc_crateLarge;
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
		case (_par_opfWeap == 1 || _par_opfWeap == 2): {
			//ammo
			_target addMagazineCargoGlobal ["rhs_30Rnd_545x39_AK",40];
			_target addMagazineCargoGlobal ["rhs_30Rnd_545x39_7N10_AK",20];
			if (isClass(configFile >> "CfgPatches" >> "cup_weapons_ak")) then {
				_target addMagazineCargoGlobal ["CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",20];
				_target addMagazineCargoGlobal ["CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",12];
			};
			_target addMagazineCargoGlobal ["rhs_100Rnd_762x54mmR",6];
			_target addMagazineCargoGlobal ["rhs_100Rnd_762x54mmR_green",6];
			//_target addMagazineCargoGlobal ["rhs_45Rnd_545X39_AK",20];
			if (_par_opfSilencers > 0) then { _target addMagazineCargoGlobal ["rhs_20rnd_9x39mm_SP5",20]; } else { _target addMagazineCargoGlobal ["rhs_10Rnd_762x54mmR_7N1",20]; };
			_target addMagazineCargoGlobal ["rhs_mag_9x19_17",20];
		};
		//CUP
		case (_par_opfWeap == 3): {
			//ammo
			_target addMagazineCargoGlobal ["CUP_30Rnd_545x39_AK_M",40];
			_target addMagazineCargoGlobal ["CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",20];
			_target addMagazineCargoGlobal ["CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",20];
			_target addMagazineCargoGlobal ["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M",12];
			_target addMagazineCargoGlobal ["CUP_10Rnd_762x54_SVD_M",20];
			_target addMagazineCargoGlobal ["CUP_8Rnd_9x18_Makarov_M",20];
		};
		//case (ADV_par_opfWeap == 4): {};
		default {
			switch (true) do {
				case (_par_opfWeap == 21): {
					_target addMagazineCargoGlobal ["30Rnd_762x39_Mag_F",40];
					_target addMagazineCargoGlobal ["30Rnd_762x39_Mag_Tracer_F",20];
					_target addMagazineCargoGlobal ["100Rnd_580x42_Mag_F",24];
				};
				case (worldName == "TANOA" || _par_opfWeap == 20): {
					_target addMagazineCargoGlobal ["30Rnd_580x42_Mag_F",40];
					_target addMagazineCargoGlobal ["30Rnd_580x42_Mag_Tracer_F",20];
					_target addMagazineCargoGlobal ["100Rnd_580x42_Mag_F",24];
				};
				default {
					_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_green",40];
					_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_green_mag_Tracer",20];
					_target addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer",12];
				};
			};
			_target addMagazineCargoGlobal ["150Rnd_93x64_Mag",12];
			//_target addMagazineCargoGlobal ["150Rnd_762x54_Box",6];
			//_target addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer",6];
			_target addMagazineCargoGlobal ["10Rnd_762x51_Mag",40];
			_target addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag",20];
			_target addMagazineCargoGlobal ["16Rnd_9x21_Mag",20];
		};
	};
	//grenades
	switch (true) do {
		case ( _par_opfWeap == 1 && _par_opfWeap == 2): {
			_target addMagazineCargoGlobal ["rhs_mag_rgd5",20];
			_target addMagazineCargoGlobal ["rhs_mag_rdg2_white",30];
			_target addMagazineCargoGlobal ["rhs_mag_rdg2_black",20];
			_target addMagazineCargoGlobal ["rhs_VOG25",24];
			_target addMagazineCargoGlobal ["rhs_GRD40_White",12];
			_target addMagazineCargoGlobal ["rhs_GRD40_Green",12];
			_target addMagazineCargoGlobal ["rhs_GRD40_Red",12];
			_target addMagazineCargoGlobal ["rhs_VG40OP_white",20];
		};
		case ( _par_opfWeap == 3): {
			_target addMagazineCargoGlobal ["CUP_HandGrenade_RGD5",20];
			_target addMagazineCargoGlobal ["SmokeShell",30];
			_target addMagazineCargoGlobal ["SmokeShellYellow",20];
			_target addMagazineCargoGlobal ["CUP_1Rnd_HE_GP25_M",24];
			_target addMagazineCargoGlobal ["CUP_1Rnd_SmokeRed_GP25_M",12];
			_target addMagazineCargoGlobal ["CUP_1Rnd_SmokeGreen_GP25_M",12];
			_target addMagazineCargoGlobal ["CUP_1Rnd_SmokeYellow_GP25_M",12];
			_target addMagazineCargoGlobal ["CUP_FlareYellow_GP25_M",20];
		};
		default {
			_target addMagazineCargoGlobal ["HandGrenade",10];
			_target addMagazineCargoGlobal ["MiniGrenade",10];
			_target addMagazineCargoGlobal ["SmokeShell",30];
			_target addMagazineCargoGlobal ["SmokeShellYellow",20];
			_target addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",24];
			_target addMagazineCargoGlobal ["1Rnd_SmokeRed_Grenade_shell",12];
			_target addMagazineCargoGlobal ["1Rnd_SmokePurple_Grenade_shell",12];
			_target addMagazineCargoGlobal ["1Rnd_SmokeYellow_Grenade_shell",12];
			_target addMagazineCargoGlobal ["UGL_FlareYellow_F",20];
		};
	};
	
	if (_par_opfNVGs == 2 && !(isClass (configFile >> "CfgPatches" >> "ACE_attach")) ) then {
		_target addMagazineCargoGlobal ["O_IR_Grenade",6];
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
		_ACE_key_east = 1;
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
		[_target] call ADV_fnc_addACEItems;
	};
	nil;
} count _this;

true;
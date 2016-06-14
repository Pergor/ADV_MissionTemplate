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

	//weapons & ammo
	switch (true) do {
		//BWmod
		case (ADV_par_customWeap == 1): {
			//weapons
			_target addWeaponCargoGlobal ["BWA3_Pzf3_Loaded",5];
			//ammo
			if (isClass(configFile >> "CfgPatches" >> "hlcweapons_g36") && !(isClass(configFile >> "CfgPatches" >> "adv_hlcG36_bwmod"))) then {
				_target addMagazineCargoGlobal ["hlc_30rnd_556x45_EPR_G36",60];
			} else {
				_target addMagazineCargoGlobal ["BWA3_30Rnd_556x45_G36",40];
				_target addMagazineCargoGlobal ["BWA3_30Rnd_556x45_G36_Tracer",20];
			};
			_target addMagazineCargoGlobal ["BWA3_200Rnd_556x45",12];
			_target addMagazineCargoGlobal ["BWA3_120Rnd_762x51",6];
			_target addMagazineCargoGlobal ["BWA3_120Rnd_762x51_Tracer",6];
			_target addMagazineCargoGlobal ["BWA3_15Rnd_9x19_P8",20];
			_target addMagazineCargoGlobal ["BWA3_10Rnd_762x51_G28_LR",30];
		};
		//SeL RHS
		case (ADV_par_customWeap == 2 || ADV_par_customWeap == 3 || ADV_par_customWeap == 4): {
			//weapons
			_target addWeaponCargoGlobal ["rhs_weap_M136",5];
			//ammo
			if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _target addMagazineCargoGlobal ["rhs_m136_mag",5]; };
			_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",40];
			_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red",20];
			_target addMagazineCargoGlobal ["rhsusf_20Rnd_762x51_m118_special_Mag",30];
			_target addMagazineCargoGlobal ["rhsusf_100Rnd_762x51_m80a1epr",12];
			_target addMagazineCargoGlobal ["rhsusf_200Rnd_556x45_soft_pouch",12];
			if (ADV_par_customWeap == 3) then {
				_target addMagazineCargoGlobal ["rhsusf_mag_7x45acp_MHP",20];
			} else {
				_target addMagazineCargoGlobal ["rhsusf_mag_15Rnd_9x19_JHP",20];
			};
		};
		//SeL CUP MK16
		case (ADV_par_customWeap == 5 || ADV_par_customWeap == 6): {
			//weapons
			_target addWeaponCargoGlobal ["CUP_launch_M136",5];
			//ammo
			_target addMagazineCargoGlobal ["CUP_M136_M",5];
			_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",40];
			_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red",20];
			if (ADV_par_customWeap == 5) then {
				_target addMagazineCargoGlobal ["CUP_20Rnd_762x51_B_M110",20];
				_target addMagazineCargoGlobal ["CUP_20Rnd_762x51_B_SCAR",20];
			} else {
				_target addMagazineCargoGlobal ["20Rnd_762x51_Mag",20];
			};
			_target addMagazineCargoGlobal ["CUP_200Rnd_TE4_Red_Tracer_556x45_M249",12];
			_target addMagazineCargoGlobal ["CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",12];
			_target addMagazineCargoGlobal ["CUP_15Rnd_9x19_M9",20];
		};
		//SeL CUP L85
		case (ADV_par_customWeap ==7): {
			//weapons
			_target addWeaponCargoGlobal ["CUP_launch_M136",5];
			//ammo
			_target addMagazineCargoGlobal ["CUP_M136_M",5];
			_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",40];
			_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red",20];
			_target addMagazineCargoGlobal ["20Rnd_762x51_Mag",20];
			_target addMagazineCargoGlobal ["CUP_200Rnd_TE4_Red_Tracer_556x45_L110A1",12];
			_target addMagazineCargoGlobal ["CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",12];
			_target addMagazineCargoGlobal ["CUP_17Rnd_9x19_glock17",20];
		};
		case (ADV_par_customWeap == 8): {
			//weapons
			_target addWeaponCargoGlobal ["UK3CB_BAF_AT4_AP_Launcher",5];
			//ammo
			_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",40];
			_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red",10];
			_target addMagazineCargoGlobal ["UK3CB_BAF_20Rnd",20];
			_target addMagazineCargoGlobal ["UK3CB_BAF_200Rnd_T",12];
			_target addMagazineCargoGlobal ["UK3CB_BAF_75Rnd_T",10];
			_target addMagazineCargoGlobal ["UK3CB_BAF_75Rnd",10];
			_target addMagazineCargoGlobal ["UK3CB_BAF_17Rnd_9mm",20];
		};
		case (ADV_par_customWeap == 9): {
			//weapons
			if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {
				_target addWeaponCargoGlobal ["rhs_weap_M136",5];
				if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _target addMagazineCargoGlobal ["rhs_m136_mag",5]; };
			} else {
				_target addWeaponCargoGlobal ["launch_NLAW_F",5];
				if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _target addMagazineCargoGlobal ["NLAW_F",5]; };
			};
			//ammo
			_target addMagazineCargoGlobal ["hlc_20rnd_762x51_b_G3",40];
			_target addMagazineCargoGlobal ["hlc_20rnd_762x51_T_G3",20];
			_target addMagazineCargoGlobal ["hlc_20rnd_762x51_b_fal",40];
			_target addMagazineCargoGlobal ["hlc_20rnd_762x51_T_fal",20];
			_target addMagazineCargoGlobal ["hlc_50rnd_762x51_M_FAL",20];
			_target addMagazineCargoGlobal ["hlc_100Rnd_762x51_M_M60E4",12];
			if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
				_target addMagazineCargoGlobal ["RH_7Rnd_45cal_m1911",20];
			} else {
				_target addMagazineCargoGlobal ["11Rnd_45ACP_Mag",20];
			};
		};
		default {
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
		};
	};
	//grenades
	switch (true) do {
		case (ADV_par_customWeap == 1): {
			_target addMagazineCargoGlobal ["BWA3_DM51A1",20];		
			_target addMagazineCargoGlobal ["BWA3_DM25",30];		
			_target addMagazineCargoGlobal ["BWA3_DM32_Orange",10];		
			_target addMagazineCargoGlobal ["BWA3_DM32_Yellow",10];		
		};
		case (ADV_par_customWeap == 2 || ADV_par_customWeap == 3 || ADV_par_customWeap == 4): {
			_target addMagazineCargoGlobal ["rhs_mag_m67",20];
			_target addMagazineCargoGlobal ["rhs_mag_an_m8hc",30];
			_target addMagazineCargoGlobal ["rhs_mag_m18_green",10];
			_target addMagazineCargoGlobal ["rhs_mag_m18_red",10];
		};
		default {
			_target addMagazineCargoGlobal ["HandGrenade",20];
			_target addMagazineCargoGlobal ["SmokeShell",30];
			_target addMagazineCargoGlobal ["SmokeShellGreen",20];
		};
	};
	_target addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",24];
	_target addMagazineCargoGlobal ["1Rnd_SmokeRed_Grenade_shell",12];
	_target addMagazineCargoGlobal ["1Rnd_SmokePurple_Grenade_shell",12];
	_target addMagazineCargoGlobal ["1Rnd_SmokeYellow_Grenade_shell",12];
	
	if (ADV_par_NVGs == 2 && !(isClass (configFile >> "CfgPatches" >> "ACE_attach")) ) then {
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
		[_target] call ADV_fnc_addACEItems;
	};
} forEach _this;

if (true) exitWith {true;};
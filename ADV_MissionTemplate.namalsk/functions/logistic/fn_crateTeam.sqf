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
			_target addWeaponCargoGlobal ["BWA3_Pzf3_Loaded",1];
			//ammo
			if (isClass(configFile >> "CfgPatches" >> "hlcweapons_g36") && !(isClass(configFile >> "CfgPatches" >> "adv_hlcG36_bwmod"))) then {
				_target addMagazineCargoGlobal ["hlc_30rnd_556x45_EPR_G36",21];
			} else {
				_target addMagazineCargoGlobal ["BWA3_30Rnd_556x45_G36",21];
			};
			_target addMagazineCargoGlobal ["BWA3_200Rnd_556x45",4];
			_target addMagazineCargoGlobal ["BWA3_15Rnd_9x19_P8",8];
			_target addMagazineCargoGlobal ["BWA3_10Rnd_762x51_G28_LR",10];
		};
		//SeL RHS
		case (ADV_par_customWeap == 2 || ADV_par_customWeap == 3 || ADV_par_customWeap == 4): {
			//weapons
			_target addWeaponCargoGlobal ["rhs_weap_M136",1];
			//ammo
			if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _target addMagazineCargoGlobal ["rhs_m136_mag",1]; };
			_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",21];
			_target addMagazineCargoGlobal ["rhsusf_20Rnd_762x51_m118_special_Mag",7];
			_target addMagazineCargoGlobal ["rhsusf_200Rnd_556x45_soft_pouch",4];
			if (ADV_par_customWeap == 3) then {
				_target addMagazineCargoGlobal ["rhsusf_mag_7x45acp_MHP",8];
			} else {
				_target addMagazineCargoGlobal ["rhsusf_mag_15Rnd_9x19_JHP",8];
			};
		};
		//SeL CUP MK16
		case (ADV_par_customWeap == 5 || ADV_par_customWeap == 6): {
			//weapons
			_target addWeaponCargoGlobal ["CUP_launch_M136",1];
			//ammo
			_target addMagazineCargoGlobal ["CUP_M136_M",1];
			_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",21];
			if (ADV_par_customWeap == 5) then {
				_target addMagazineCargoGlobal ["CUP_20Rnd_762x51_B_M110",7];
				_target addMagazineCargoGlobal ["CUP_20Rnd_762x51_B_SCAR",7];
			} else {
				_target addMagazineCargoGlobal ["20Rnd_762x51_Mag",7];
			};
			_target addMagazineCargoGlobal ["CUP_200Rnd_TE4_Red_Tracer_556x45_M249",4];
			_target addMagazineCargoGlobal ["CUP_15Rnd_9x19_M9",8];
		};
		//SeL CUP L85
		case (ADV_par_customWeap == 7): {
			//weapons
			_target addWeaponCargoGlobal ["CUP_launch_M136",1];
			//ammo
			_target addMagazineCargoGlobal ["CUP_M136_M",1];
			_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",21];
			_target addMagazineCargoGlobal ["20Rnd_762x51_Mag",7];
			_target addMagazineCargoGlobal ["CUP_200Rnd_TE4_Red_Tracer_556x45_L110A1",4];
			_target addMagazineCargoGlobal ["CUP_17Rnd_9x19_glock17",8];
		};
		case (ADV_par_customWeap == 8): {
			//weapons
			_target addWeaponCargoGlobal ["UK3CB_BAF_AT4_AP_Launcher",1];
			//ammo
			_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",21];
			_target addMagazineCargoGlobal ["UK3CB_BAF_20Rnd",7];
			_target addMagazineCargoGlobal ["UK3CB_BAF_200Rnd_T",4];
			_target addMagazineCargoGlobal ["UK3CB_BAF_17Rnd_9mm",8];
		};
		case (ADV_par_customWeap == 9): {
			//weapons
			if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {
				_target addWeaponCargoGlobal ["rhs_weap_M136",1];
				if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _target addMagazineCargoGlobal ["rhs_m136_mag",1]; };
			} else {
				_target addWeaponCargoGlobal ["launch_NLAW_F",1];
				if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _target addMagazineCargoGlobal ["NLAW_F",1]; };
			};
			//ammo
			_target addMagazineCargoGlobal ["hlc_20rnd_762x51_b_G3",21];
			_target addMagazineCargoGlobal ["hlc_20rnd_762x51_b_fal",21];
			_target addMagazineCargoGlobal ["hlc_50rnd_762x51_M_FAL",7];
			if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
				_target addMagazineCargoGlobal ["RH_7Rnd_45cal_m1911",8];
			} else {
				_target addMagazineCargoGlobal ["11Rnd_45ACP_Mag",8];
			};
		};
		default {
			//weapons
			_target addWeaponCargoGlobal ["launch_NLAW_F",1];
			//ammo
			if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _target addMagazineCargoGlobal ["NLAW_F",1]; };
			_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag",21];
			_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",21];
			_target addMagazineCargoGlobal ["20Rnd_762x51_Mag",7];
			_target addMagazineCargoGlobal ["200Rnd_65x39_cased_Box",4];
			_target addMagazineCargoGlobal ["11Rnd_45ACP_Mag",8];
		};
	};
	//grenades
	switch (true) do {
		case (ADV_par_customWeap == 1): {
			_target addMagazineCargoGlobal ["BWA3_DM51A1",10];		
			_target addMagazineCargoGlobal ["BWA3_DM25",8];		
			_target addMagazineCargoGlobal ["BWA3_DM32_Orange",4];		
			_target addMagazineCargoGlobal ["BWA3_DM32_Yellow",4];		
		};
		case (ADV_par_customWeap == 2 || ADV_par_customWeap == 3 || ADV_par_customWeap == 4): {
			_target addMagazineCargoGlobal ["rhs_mag_m67",10];
			_target addMagazineCargoGlobal ["rhs_mag_an_m8hc",8];
			_target addMagazineCargoGlobal ["rhs_mag_m18_green",4];
			_target addMagazineCargoGlobal ["rhs_mag_m18_red",4];
		};
		default {
			_target addMagazineCargoGlobal ["HandGrenade",10];
			_target addMagazineCargoGlobal ["SmokeShell",8];
			_target addMagazineCargoGlobal ["SmokeShellGreen",4];
		};
	};
	_target addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",12];

	_ACE_fieldDressing = 16;
	_ACE_packingBandage = 24;
	_ACE_elasticBandage = 24;
	_ACE_quikclot = 32;
	_ACE_atropine = 0;
	_ACE_epinephrine = 2;
	_ACE_morphine = 8;
	_ACE_tourniquet = 8;
	_ACE_plasmaIV = 0;
	_ACE_plasmaIV_500 = 0;
	_ACE_plasmaIV_250 = 0;
	_ACE_salineIV = 0;
	_ACE_salineIV_500 = 0;
	_ACE_salineIV_250 = 0;
	_ACE_bloodIV = 0;
	_ACE_bloodIV_500 = 0;
	_ACE_bloodIV_250 = 0;
	_ACE_bodyBag = 2;
	_ACE_personalAidKit = 0;
	_ACE_surgicalKit = 0;
	
	_FAKs = 8;
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
		_ACE_CableTie = 2;
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
		_ACE_IR_Strobe = 0;
		_ACE_M84 = 0;
		_ACE_HandFlare_Green = 0;
		_ACE_HandFlare_Red = 4;
		_ACE_HandFlare_White = 0;
		_ACE_HandFlare_Yellow = 0;
		[_target] call ADV_fnc_addACEItems;
	};
} forEach _this;

if (true) exitWith {true;};
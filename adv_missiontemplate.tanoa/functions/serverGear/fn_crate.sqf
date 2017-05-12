/*
 * Author: Belbo
 *
 * Fills inventory of an object or objects with most items available in the mission for BLUFOR
 *
 * Arguments:
 * Array of vehicles - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [crate_1, crate_2, ..., crate_n] call adv_fnc_crate;
 *
 * Public: Yes
 */

if (!isServer) exitWith {};

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

{
	if !(_x isEqualTo objNull) then {
		private _target = _x;
		//makes the crates indestructible:
		_target allowDamage false;
		
		//weapons & ammo
		switch (true) do {
			//BWmod
			case (_par_customWeap == 1): {
				//weapons
				_target addWeaponCargoGlobal ["BWA3_Fliegerfaust",5];
				_target addWeaponCargoGlobal ["BWA3_Pzf3_Loaded",5];
				_target addWeaponCargoGlobal ["BWA3_RGW90_Loaded",5];
				//ammo
				_target addMagazineCargoGlobal ["BWA3_Fliegerfaust_Mag",6];
				if (isClass(configFile >> "CfgPatches" >> "hlcweapons_g36")) then {
					if (isClass(configFile >> "CfgPatches" >> "adv_hlcG36_bwmod")) then {
						_target addMagazineCargoGlobal ["BWA3_30Rnd_556x45_G36",40];
						_target addMagazineCargoGlobal ["BWA3_30Rnd_556x45_G36_Tracer",40];
					} else {
						_target addMagazineCargoGlobal ["hlc_30rnd_556x45_EPR_G36",40];
						_target addMagazineCargoGlobal ["hlc_30rnd_556x45_SOST_G36",20];
						_target addMagazineCargoGlobal ["hlc_30rnd_556x45_SPR_G36",20];
					};
					_target addItemCargoGlobal ["HLC_Optic_G36Dualoptic15x",5];
					_target addItemCargoGlobal ["HLC_Optic_G36dualoptic35x",5];
				} else {
					_target addMagazineCargoGlobal ["BWA3_30Rnd_556x45_G36",40];
					_target addMagazineCargoGlobal ["BWA3_30Rnd_556x45_G36_Tracer",40];
				};
				_target addMagazineCargoGlobal ["BWA3_200Rnd_556x45",20];
				_target addMagazineCargoGlobal ["BWA3_200Rnd_556x45_Tracer",20];
				if (isClass(configFile >> "CfgPatches" >> "hlcweapons_MG3s")) then {
					_target addMagazineCargoGlobal ["hlc_100Rnd_762x51_M_MG3",20];
					_target addMagazineCargoGlobal ["hlc_100Rnd_762x51_Barrier_MG3",20];
				} else {
					_target addMagazineCargoGlobal ["BWA3_120Rnd_762x51",20];
					_target addMagazineCargoGlobal ["BWA3_120Rnd_762x51_Tracer",20];
				};				
				_target addMagazineCargoGlobal ["BWA3_15Rnd_9x19_P8",20];
				_target addMagazineCargoGlobal ["BWA3_10Rnd_762x51_G28_LR",30];
				_target addMagazineCargoGlobal ["BWA3_10Rnd_127x99_G82",10];
				//items
				_target addItemCargoGlobal ["BWA3_acc_LLM01_irlaser",5];
				if (_par_optics == 1) then {
					_target addItemCargoGlobal ["BWA3_optic_RSAS",5];
					_target addItemCargoGlobal ["BWA3_optic_ZO4x30",5];
				};
			};
			//SeL RHS
			case (_par_customWeap == 2 || _par_customWeap == 3 || _par_customWeap == 4): {
				//weapons
				_target addWeaponCargoGlobal ["rhs_weap_M136",5];
				_target addWeaponCargoGlobal ["rhs_weap_M136_hedp",5];
				_target addWeaponCargoGlobal ["rhs_weap_M136_hp",5];
				_target addWeaponCargoGlobal ["rhs_weap_fgm148",2];
				//ammo
				_target addMagazineCargoGlobal ["rhs_fgm148_magazine_AT",4];
				if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then {  _target addMagazineCargoGlobal ["rhs_m136_mag",3];
					_target addMagazineCargoGlobal ["rhs_m136_hedp_mag",3];
					_target addMagazineCargoGlobal ["rhs_m136_hp_mag",3]; 
				};
				_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",40];
				_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red",40];
				_target addMagazineCargoGlobal ["rhsusf_20Rnd_762x51_m118_special_Mag",20];
				_target addMagazineCargoGlobal ["rhsusf_5Rnd_300winmag_xm2010",10];
				_target addMagazineCargoGlobal ["rhsusf_5Rnd_762x51_m118_special_Mag",10];
				_target addMagazineCargoGlobal ["rhsusf_100Rnd_762x51",20];
				_target addMagazineCargoGlobal ["rhsusf_100Rnd_762x51_m80a1epr",20];
				_target addMagazineCargoGlobal ["rhsusf_200Rnd_556x45_soft_pouch",20];
				if (_par_customWeap == 3) then {
					if (isClass(configFile >> "CfgPatches" >> "hlcweapons_m60e4")) then {
						_target addMagazineCargoGlobal ["hlc_100Rnd_762x51_M_M60E4",20];
					};
					_target addMagazineCargoGlobal ["rhsusf_mag_7x45acp_MHP",5];
				} else {
					_target addMagazineCargoGlobal ["rhsusf_mag_15Rnd_9x19_JHP",5];
				};
				if (isClass(configFile >> "CfgPatches" >> "hlcweapons_mp5")) then { _target addMagazineCargoGlobal ["hlc_30Rnd_9x19_B_MP5",10]; };
				//items
				_target addItemCargoGlobal ["rhsusf_acc_harris_bipod",3];
				if (_par_optics > 0) then {
					_target addItemCargoGlobal ["rhsusf_acc_compm4",5];
					_target addItemCargoGlobal ["rhsusf_acc_eotech_552",5];
					_target addItemCargoGlobal ["rhsusf_acc_ELCAN",5];
					_target addItemCargoGlobal ["rhsusf_acc_ACOG",5];
					_target addItemCargoGlobal ["rhsusf_acc_ACOG_pip",5];
					_target addItemCargoGlobal ["rhsusf_acc_LEUPOLDMK4",1];
					_target addItemCargoGlobal ["rhsusf_acc_LEUPOLDMK4_2",1];
					_target addItemCargoGlobal ["rhsusf_acc_premier",1];
					_target addItemCargoGlobal ["rhsusf_acc_SpecterDR_3d",5];
					_target addItemCargoGlobal ["rhsusf_acc_SpecterDR",5];
				};
			};
			//SeL CUP MK16
			case (_par_customWeap == 5 || _par_customWeap == 6): {
				//weapons
				_target addWeaponCargoGlobal ["CUP_launch_M136",5];
				_target addWeaponCargoGlobal ["CUP_launch_Javelin",2];
				//AT
				if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then {  _target addMagazineCargoGlobal ["CUP_M136_M",5]; };
				_target addMagazineCargoGlobal ["CUP_Javelin_M",4];
				//Rifles
				_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",40];
				_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red",40];
				if (_par_customWeap == 5) then {
					_target addMagazineCargoGlobal ["CUP_20Rnd_762x51_B_M110",40];
					_target addMagazineCargoGlobal ["CUP_20Rnd_762x51_B_SCAR",30];
				} else {
					_target addMagazineCargoGlobal ["20Rnd_762x51_Mag",40];
				};
				_target addMagazineCargoGlobal ["CUP_10Rnd_127x99_M107",10];
				//MG
				_target addMagazineCargoGlobal ["CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",10];
				_target addMagazineCargoGlobal ["CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M",10];
				_target addMagazineCargoGlobal ["CUP_200Rnd_TE4_Red_Tracer_556x45_M249",20];
				//Pistol+MP
				_target addMagazineCargoGlobal ["CUP_7Rnd_45ACP_1911",10];
				_target addMagazineCargoGlobal ["CUP_15Rnd_9x19_M9",10];
				_target addMagazineCargoGlobal ["CUP_18Rnd_9x19_Phantom",10];
				_target addMagazineCargoGlobal ["CUP_30Rnd_9x19_MP5",10];
				//items
				if (_par_optics > 0) then {
					_target addItemCargoGlobal ["CUP_optic_CompM4",5];
					_target addItemCargoGlobal ["CUP_optic_CompM2_Black",5];
					_target addItemCargoGlobal ["CUP_optic_CompM2_Woodland",5];
					_target addItemCargoGlobal ["CUP_optic_CompM2_Desert",5];
					_target addItemCargoGlobal ["CUP_optic_RCO",5];
					_target addItemCargoGlobal ["CUP_optic_RCO_desert",5];
				};
			};
			//SeL CUP L85
			case (_par_customWeap == 7): {
				//weapons
				_target addWeaponCargoGlobal ["CUP_launch_M136",5];
				_target addWeaponCargoGlobal ["CUP_launch_Javelin",2];
				//AT
				if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _target addMagazineCargoGlobal ["CUP_M136_M",5]; };
				_target addMagazineCargoGlobal ["CUP_Javelin_M",3];
				//Rifles
				_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",40];
				_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red",40];
				_target addMagazineCargoGlobal ["20Rnd_762x51_Mag",20];
				_target addMagazineCargoGlobal ["CUP_5Rnd_86x70_L115A1",10];
				//MG
				_target addMagazineCargoGlobal ["CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",10];
				_target addMagazineCargoGlobal ["CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M",10];
				_target addMagazineCargoGlobal ["CUP_200Rnd_TE4_Red_Tracer_556x45_L110A1",10];
				//Pistol+MP
				_target addMagazineCargoGlobal ["CUP_17Rnd_9x19_glock17",20];
				_target addMagazineCargoGlobal ["CUP_18Rnd_9x19_Phantom",10];
				_target addMagazineCargoGlobal ["CUP_30Rnd_9x19_MP5",10];
				//items
				if (_par_optics > 0) then {
					_target addItemCargoGlobal ["CUP_optic_SUSAT",5];
					_target addItemCargoGlobal ["CUP_optic_RCO_desert",5];
					_target addItemCargoGlobal ["CUP_optic_RCO",5];
					_target addItemCargoGlobal ["CUP_optic_LeupoldMk4",1];
				};
			};
			case (_par_customWeap == 8): {
				//weapons
				_target addWeaponCargoGlobal ["UK3CB_BAF_AT4_AP_Launcher",5];
				_target addWeaponCargoGlobal ["UK3CB_BAF_Javelin_Slung_Tube",3];
				_target addWeaponCargoGlobal ["UK3CB_BAF_Javelin_CLU",2];
				//Rifles
				_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",40];
				_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red",40];
				_target addMagazineCargoGlobal ["UK3CB_BAF_20Rnd",20];
				_target addMagazineCargoGlobal ["UK3CB_BAF_L115A3_Mag",10];
				//MG
				_target addMagazineCargoGlobal ["UK3CB_BAF_75Rnd_T",20];
				_target addMagazineCargoGlobal ["UK3CB_BAF_75Rnd",20];
				_target addMagazineCargoGlobal ["UK3CB_BAF_200Rnd_T",10];
				//Pistol+MP
				_target addMagazineCargoGlobal ["UK3CB_BAF_17Rnd_9mm",20];
				_target addMagazineCargoGlobal ["UK3CB_BAF_30Rnd_9mm",10];
				//items
				if (_par_optics > 0) then {
					_target addItemCargoGlobal ["UK3CB_BAF_SUSAT_3D",5];
					_target addItemCargoGlobal ["UK3CB_BAF_TA31F_3D",5];
					_target addItemCargoGlobal ["UK3CB_BAF_SpecterLDS_3D",5];
					_target addItemCargoGlobal ["UK3CB_BAF_Eotech",5];
				};
			};
			case (_par_customWeap == 9): {
				//HLC
				if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {
					//weapons
					_target addWeaponCargoGlobal ["rhs_weap_M136",5];
					_target addWeaponCargoGlobal ["rhs_weap_M136_hedp",5];
					_target addWeaponCargoGlobal ["rhs_weap_M136_hp",5];
					_target addWeaponCargoGlobal ["rhs_weap_fgm148",2];
					//ammo
					_target addMagazineCargoGlobal ["rhs_fgm148_magazine_AT",4];
					if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then {  _target addMagazineCargoGlobal ["rhs_m136_mag",3];
						_target addMagazineCargoGlobal ["rhs_m136_hedp_mag",3];
						_target addMagazineCargoGlobal ["rhs_m136_hp_mag",3]; 
					};
				} else {
					//weapons
					_target addWeaponCargoGlobal ["launch_NLAW_F",5];
					_target addWeaponCargoGlobal ["launch_B_Titan_F",5];
					_target addWeaponCargoGlobal ["launch_B_Titan_short_F",5];
					if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _target addMagazineCargoGlobal ["NLAW_F",5]; };
					_target addMagazineCargoGlobal ["Titan_AA",5];
					_target addMagazineCargoGlobal ["Titan_AT",5];
					_target addMagazineCargoGlobal ["Titan_AP",5];
				};
				_target addMagazineCargoGlobal ["hlc_20rnd_762x51_b_G3",40];
				_target addMagazineCargoGlobal ["hlc_20rnd_762x51_T_G3",20];
				_target addMagazineCargoGlobal ["hlc_20Rnd_762x51_B_fal",40];
				_target addMagazineCargoGlobal ["hlc_20Rnd_762x51_T_fal",20];
				_target addMagazineCargoGlobal ["hlc_100Rnd_762x51_M_M60E4",20];
				_target addMagazineCargoGlobal ["hlc_50rnd_762x51_M_FAL",20];
				_target addMagazineCargoGlobal ["hlc_30Rnd_9x19_B_MP5",20];
			};
			default {
				//weapons
				_target addWeaponCargoGlobal ["launch_NLAW_F",5];
				_target addWeaponCargoGlobal ["launch_B_Titan_F",5];
				_target addWeaponCargoGlobal ["launch_B_Titan_short_F",5];
				//ammo
				_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag",40];
				_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer",40];
				_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",40];
				_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red",40];
				_target addMagazineCargoGlobal ["20Rnd_762x51_Mag",40];
				_target addMagazineCargoGlobal ["130Rnd_338_Mag",10];
				if (_par_customWeap == 20) then {
					_target addMagazineCargoGlobal ["200Rnd_556x45_Box_Red_F",20];
				} else {
					//_target addMagazineCargoGlobal ["200Rnd_65x39_cased_Box",20];
					if (isClass(configFile >> "CfgPatches" >> "adv_configsVanilla")) then {
						_target addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_red",20];
						_target addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer_red",20];
					};
					_target addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag_Tracer",20];
				};
				_target addMagazineCargoGlobal ["11Rnd_45ACP_Mag",10];
				_target addMagazineCargoGlobal ["7Rnd_408_Mag",10];
				if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _target addMagazineCargoGlobal ["NLAW_F",5]; };
				_target addMagazineCargoGlobal ["Titan_AA",5];
				_target addMagazineCargoGlobal ["Titan_AT",5];
				_target addMagazineCargoGlobal ["Titan_AP",5];
				//items
				_target addItemCargoGlobal ["bipod_01_F_blk",3];
				if (_par_optics > 0) then {
					_target addItemCargoGlobal ["optic_MRD",5];
					_target addItemCargoGlobal ["optic_Aco",5];
					_target addItemCargoGlobal ["optic_Holosight",5];
					_target addItemCargoGlobal ["optic_HAMR",3];
				};
			};
		};
		_target addMagazineCargoGlobal ["DemoCharge_Remote_Mag",5];
		_target addMagazineCargoGlobal ["SatchelCharge_Remote_Mag",2];
		_target addMagazineCargoGlobal ["ATMine_Range_Mag",5];
		_target addMagazineCargoGlobal ["APERSTripMine_Wire_Mag",5];
		_target addMagazineCargoGlobal ["APERSMine_Range_Mag",5];
		//_target addItemCargoGlobal ["optic_LRPS",2];
		if ( _par_customUni isEqualTo 9 ) then {
			_target addMagazineCargoGlobal ["IEDUrbanSmall_Remote_Mag",5];
			_target addMagazineCargoGlobal ["IEDLandSmall_Remote_Mag",5];
			_target addMagazineCargoGlobal ["IEDUrbanBig_Remote_Mag",5];
			_target addMagazineCargoGlobal ["IEDLandBig_Remote_Mag",5];
		};
			
		//grenades
		switch (true) do {
			case (_par_customWeap == 1): {
				_target addMagazineCargoGlobal ["BWA3_DM51A1",20];		
				_target addMagazineCargoGlobal ["BWA3_DM25",20];		
				_target addMagazineCargoGlobal ["BWA3_DM32_Orange",20];		
				_target addMagazineCargoGlobal ["BWA3_DM32_Yellow",20];		
			};
			case (_par_customWeap == 2 || _par_customWeap == 3 || _par_customWeap == 4): {
				_target addMagazineCargoGlobal ["rhs_mag_m67",20];
				_target addMagazineCargoGlobal ["rhs_mag_an_m8hc",20];
				_target addMagazineCargoGlobal ["rhs_mag_m18_green",20];
				_target addMagazineCargoGlobal ["rhs_mag_m18_red",20];
				_target addMagazineCargoGlobal ["rhs_mag_m18_purple",20];
				_target addMagazineCargoGlobal ["rhs_mag_m18_yellow",20];
			};
			default {
				_target addMagazineCargoGlobal ["HandGrenade",20];
				_target addMagazineCargoGlobal ["MiniGrenade",20];
				_target addMagazineCargoGlobal ["SmokeShell",20];
				_target addMagazineCargoGlobal ["SmokeShellGreen",20];
				_target addMagazineCargoGlobal ["SmokeShellRed",20];
				_target addMagazineCargoGlobal ["SmokeShellBlue",20];
				_target addMagazineCargoGlobal ["SmokeShellYellow",20];
			};
		};
		if !(isClass (configFile >> "CfgPatches" >> "ACE_attach")) then {
			_target addMagazineCargoGlobal ["B_IR_Grenade",10];
		};
		_target addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",40];
		_target addMagazineCargoGlobal ["UGL_FlareYellow_F",20];
		_target addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell",20];
		_target addMagazineCargoGlobal ["1Rnd_SmokeRed_Grenade_shell",20];
		_target addMagazineCargoGlobal ["1Rnd_SmokeYellow_Grenade_shell",20];
		
		//uniform items
		switch (_par_customUni) do {
			//BWmod Tropen
			case 1: {
				_target addItemCargoGlobal ["BWA3_M92_Tropen",5];		
				_target addBackpackCargoGlobal ["taktisch_tropen",3];		
			};
			//BWmod Fleck
			case 2: {
				_target addItemCargoGlobal ["BWA3_M92_Fleck",5];
				_target addBackpackCargoGlobal ["taktisch_fleck",3];
			};
			//CUP BAF
			case 6: {
				_target addItemCargoGlobal ["CUP_H_BAF_Helmet_3_DPM",5];
				_target addBackpackCargoGlobal ["CUP_B_Bergen_BAF",3];
			};
			//uk3cb
			case 12: {
				_target addItemCargoGlobal ["UK3CB_BAF_H_Mk7_Camo_A",5];
				_target addBackpackCargoGlobal ["UK3CB_BAF_B_Bergen_MTP_Rifleman_L_A",3];	
			};
			default {
				_target addItemCargoGlobal ["H_HelmetSpecB",5];
				_target addBackpackCargoGlobal ["B_AssaultPack_rgr",3];
			};
		};

		//radios
		if (isClass (configFile >> "CfgPatches" >> "task_force_radio") && (_par_Radios == 1 || _par_Radios == 3)) then {
			_target addBackpackCargoGlobal ["tfar_rt1523g",2];
		};
		if (_par_Radios == 1 || _par_Radios == 3) then {
			_target addItemCargoGlobal ["ItemRadio",4];
		};

		//ACE items (if ACE is running on the server) - (integers)
		if (isClass (configFile >> "CfgPatches" >> "ACE_common")) then {
			_ACE_EarPlugs = 1;

			_ACE_atropine = 30;
			_ACE_adenosine = 30;
			_ACE_fieldDressing = 50;
			_ACE_packingBandage = 50;
			_ACE_elasticBandage = 50;
			_ACE_quikclot = 50;
			_ACE_bloodIV = 10;
			_ACE_bloodIV_500 = 10;
			_ACE_bloodIV_250 = 20;
			_ACE_bodyBag = 10;
			_ACE_epinephrine = 30;
			_ACE_morphine = 30;
			_ACE_plasmaIV = 10;
			_ACE_plasmaIV_500 = 10;
			_ACE_plasmaIV_250 = 20;
			_ACE_salineIV = 10;
			_ACE_salineIV_500 = 20;
			_ACE_salineIV_250 = 20;
			_ACE_surgicalKit = 10;
			_ACE_personalAidKit = 20;
			if (isClass(configFile >> "CfgPatches" >> "adv_aceCPR")) then {
				_ACE_personalAidKit = 5;
			};
			_ACE_tourniquet = 20;

			_ACE_SpareBarrel = 5;
			_ACE_tacticalLadder = 3;
			_ACE_UAVBattery = 5;
			_ACE_wirecutter = 5;
			_ACE_sandbag = 30;
			_ACE_Clacker = 0;
			_ACE_M26_Clacker = 0;
			_ACE_DeadManSwitch = 0;
			_ACE_DefusalKit = 0;
			_ACE_Cellphone = 5;
			_ACE_MapTools = 0;
			_ACE_CableTie = 20;
			_ACE_NonSteerableParachute = 0;
			_ACE_EntrenchingTool = 5;
			_ACE_gunbag = 3;
			_ACE_minedetector = 1;
			
			_ACE_sprayPaintBlack = 5;
			_ACE_sprayPaintBlue = 5;
			_ACE_sprayPaintGreen = 5;
			_ACE_sprayPaintRed = 5;

			_ACE_key_west = 0;
			_ACE_key_east = 0;
			_ACE_key_indp = 0;
			_ACE_key_civ = 0;
			_ACE_key_master = 0;
			_ACE_key_lockpick = 0;
			_ACE_kestrel = 0;
			_ACE_ATragMX = 0;
			_ACE_rangecard = 4;
			_ACE_altimeter = 0;
			_ACE_microDAGR = 0;
			_ACE_DAGR = 0;
			_ACE_RangeTable_82mm = 5;
			_ACE_rangefinder = 0;
			_ACE_NonSteerableParachute = 0;
			_ACE_IR_Strobe = 10;
			_ACE_M84 = 0;
			_ACE_HandFlare_Green = 10;
			_ACE_HandFlare_Red = 10;
			_ACE_HandFlare_White = 10;
			_ACE_HandFlare_Yellow = 10;
			[_target] call ADV_fnc_addACEItems;
		};
		if !(isClass (configFile >> "CfgPatches" >> "ACE_medical")) then {
		_target addItemCargoGlobal ["FirstAidKit",20];
		_target addItemCargoGlobal ["MediKit",5];	
		};
		switch ( _par_Tablets ) do {
			case 1: {
				if (isClass (configFile >> "CfgPatches" >> "cTab")) then {
					_target addItemCargoGlobal ["ItemAndroid",5];
					_target addItemCargoGlobal ["ItemcTab",5];
					_target addItemCargoGlobal ["ItemMicroDAGR",5];
					_target addItemCargoGlobal ["ItemcTabHCam",5];
				};
			};
			case 2: {
				if (isClass(configFile >> "CfgPatches" >> "ACE_DAGR")) then {
					_target addItemCargoGlobal ["ACE_DAGR",5];
				};
				if (isClass(configFile >> "CfgPatches" >> "ACE_microdagr")) then {
					_target addItemCargoGlobal ["ACE_microDAGR",5];
				};
			};
			case 99: {
				_target addItemCargoGlobal ["ItemGPS",5];
			};
		};
		
		//other stuff
		_target addItemCargoGlobal ["Toolkit",5];
		_target addItemCargoGlobal ["acc_flashlight",5];
	};
	nil;
} count _this;

true;
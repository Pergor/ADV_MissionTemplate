/*
 * Author: Belbo
 *
 * Fills inventory of an object or objects with most items available in the mission for OPFFOR
 *
 * Arguments:
 * Array of vehicles - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [crate_1, crate_2, ..., crate_n] call adv_opf_fnc_crate;
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
			//RHS
			case (_par_opfWeap == 1 || _par_opfWeap == 2): {
				//weapons
				_target addWeaponCargoGlobal ["rhs_weap_rpg7",5];
				_target addWeaponCargoGlobal ["rhs_weap_igla",3];
				//ammo
				_target addMagazineCargoGlobal ["rhs_30Rnd_545x39_AK",40];
				_target addMagazineCargoGlobal ["rhs_30Rnd_545x39_AK_green",40];
				_target addMagazineCargoGlobal ["rhs_45Rnd_545X39_AK",10];
				_target addMagazineCargoGlobal ["rhs_30Rnd_762x39mm",20];
				_target addMagazineCargoGlobal ["rhs_30Rnd_762x39mm_tracer",20];
				if (_par_opfSilencers > 0) then { _target addMagazineCargoGlobal ["rhs_20rnd_9x39mm_SP5",20]; };
				_target addMagazineCargoGlobal ["rhs_100Rnd_762x54mmR",20];
				_target addMagazineCargoGlobal ["rhs_100Rnd_762x54mmR_green",20];
				_target addMagazineCargoGlobal ["rhs_10Rnd_762x54mmR_7N1",20];
				_target addMagazineCargoGlobal ["rhs_mag_9x19_17",20];
				_target addMagazineCargoGlobal ["rhs_rpg7_PG7VL_mag",5];
				_target addMagazineCargoGlobal ["rhs_rpg7_PG7VR_mag",5];
				_target addMagazineCargoGlobal ["rhs_rpg7_OG7V_mag",5];
				_target addMagazineCargoGlobal ["rhs_rpg7_TBG7V_mag",5];
				_target addMagazineCargoGlobal ["rhs_mag_9k38_rocket",5];
				//items
				if (_par_opfOptics > 0) then {
					_target addItemCargoGlobal ["rhs_acc_pso1m2",5];
					_target addItemCargoGlobal ["rhs_acc_1p63",5];
					_target addItemCargoGlobal ["rhs_acc_ekp1",5];
				};
				_target addItemCargoGlobal ["rhs_acc_2dpZenit",5];
			};
			case (_par_opfWeap == 3): {
				//weapons
				_target addWeaponCargoGlobal ["CUP_launch_RPG7V",5];
				_target addWeaponCargoGlobal ["CUP_launch_Igla",3];
				//ammo
				_target addMagazineCargoGlobal ["CUP_30Rnd_545x39_AK_M",40];
				_target addMagazineCargoGlobal ["CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",40];
				_target addMagazineCargoGlobal ["CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",10];
				_target addMagazineCargoGlobal ["CUP_64Rnd_9x19_Bizon_M",20];
				_target addMagazineCargoGlobal ["CUP_10Rnd_762x54_SVD_M",20];
				_target addMagazineCargoGlobal ["CUP_5Rnd_127x108_KSVK_M",10];
				_target addMagazineCargoGlobal ["CUP_20Rnd_9x39_SP5_VSS_M",10];
				_target addMagazineCargoGlobal ["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M",20];
				_target addMagazineCargoGlobal ["CUP_8Rnd_9x18_Makarov_M",10];
				_target addMagazineCargoGlobal ["CUP_8Rnd_9x18_MakarovSD_M",10];
				_target addMagazineCargoGlobal ["CUP_PG7V_M",5];
				_target addMagazineCargoGlobal ["CUP_PG7VL_M",5];
				_target addMagazineCargoGlobal ["CUP_PG7VR_M",5];
				_target addMagazineCargoGlobal ["CUP_OG7_M",5];
				_target addMagazineCargoGlobal ["CUP_Igla_M",5];
				//items
				if (_par_opfOptics > 0) then {
					_target addItemCargoGlobal ["CUP_optic_PSO_1",5];
					_target addItemCargoGlobal ["CUP_optic_Kobra",5];
				};
			};
			default {
				//weapons
				switch (true) do {
					case (_par_opfWeap == 21): {
						_target addWeaponCargoGlobal ["launch_RPG32_ghex_F",5];
						_target addWeaponCargoGlobal ["launch_O_Titan_ghex_F",5];
						_target addWeaponCargoGlobal ["launch_O_Titan_short_ghex_F",5];
						//ammo
						_target addMagazineCargoGlobal ["30Rnd_762x39_Mag_F",40];
						_target addMagazineCargoGlobal ["30Rnd_762x39_Mag_Tracer_F",40];
						_target addMagazineCargoGlobal ["100Rnd_580x42_Mag_F",20];
					};
					case (worldName == "TANOA" || _par_opfWeap == 20): {
						_target addWeaponCargoGlobal ["launch_RPG32_ghex_F",5];
						_target addWeaponCargoGlobal ["launch_O_Titan_ghex_F",5];
						_target addWeaponCargoGlobal ["launch_O_Titan_short_ghex_F",5];
						//ammo
						_target addMagazineCargoGlobal ["30Rnd_580x42_Mag_F",40];
						_target addMagazineCargoGlobal ["30Rnd_580x42_Mag_Tracer_F",40];
						_target addMagazineCargoGlobal ["100Rnd_580x42_Mag_F",20];
					};
					default {
						_target addWeaponCargoGlobal ["launch_RPG32_F",5];
						_target addWeaponCargoGlobal ["launch_Titan_F",5];
						_target addWeaponCargoGlobal ["launch_Titan_short_F",5];
						//ammo
						_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_green",40];
						_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_green_mag_Tracer",40];
					};
				};
				_target addMagazineCargoGlobal ["5Rnd_127x108_Mag",10];
				_target addMagazineCargoGlobal ["5Rnd_127x108_APDS_Mag",10];
				_target addMagazineCargoGlobal ["16Rnd_9x21_Mag",20];
				_target addMagazineCargoGlobal ["30Rnd_9x21_Mag",10];
				_target addMagazineCargoGlobal ["150Rnd_762x51_Box",20];
				_target addMagazineCargoGlobal ["150Rnd_762x51_Box_Tracer",20];
				_target addMagazineCargoGlobal ["150Rnd_93x64_Mag",20];
				_target addMagazineCargoGlobal ["10Rnd_762x51_Mag",20];
				_target addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag",20];
				_target addMagazineCargoGlobal ["10Rnd_127x54_Mag",10];
				_target addMagazineCargoGlobal ["Titan_AA",5];
				_target addMagazineCargoGlobal ["Titan_AT",5];
				_target addMagazineCargoGlobal ["Titan_AP",5];
				_target addMagazineCargoGlobal ["RPG32_F",5];
				//items
				if (_par_opfOptics > 0) then {
					_target addItemCargoGlobal ["optic_Yorris",5];
					_target addItemCargoGlobal ["optic_ACO_grn",5];
					_target addItemCargoGlobal ["optic_DMS",2];
					_target addItemCargoGlobal ["optic_Arco",2];
				};
			};
		};
		
		_target addMagazineCargoGlobal ["DemoCharge_Remote_Mag",5];
		_target addMagazineCargoGlobal ["SatchelCharge_Remote_Mag",2];
		_target addMagazineCargoGlobal ["ATMine_Range_Mag",5];
		_target addMagazineCargoGlobal ["APERSTripMine_Wire_Mag",5];
		_target addMagazineCargoGlobal ["APERSMine_Range_Mag",5];		
		if (_par_opfUni isEqualTo 5 || _par_opfWeap isEqualTo 2) then {
			_target addMagazineCargoGlobal ["IEDUrbanSmall_Remote_Mag",5];
			_target addMagazineCargoGlobal ["IEDLandSmall_Remote_Mag",5];
			_target addMagazineCargoGlobal ["IEDUrbanBig_Remote_Mag",5];
			_target addMagazineCargoGlobal ["IEDLandBig_Remote_Mag",5];
		};
		//_target addItemCargoGlobal ["optic_LRPS",2];
		
		//grenades
		switch (true) do {
			//RHS
			case (_par_opfWeap isEqualTo 1 || _par_opfWeap isEqualTo 2): {
				_target addMagazineCargoGlobal ["rhs_mag_rgd5",20];
				_target addMagazineCargoGlobal ["rhs_mag_rdg2_white",20];
				_target addMagazineCargoGlobal ["rhs_mag_rdg2_black",20];
				_target addMagazineCargoGlobal ["rhs_VOG25",40];
				_target addMagazineCargoGlobal ["rhs_GRD40_White",20];
				_target addMagazineCargoGlobal ["rhs_GRD40_Green",20];
				_target addMagazineCargoGlobal ["rhs_GRD40_Red",20];
				_target addMagazineCargoGlobal ["rhs_VG40OP_white",20];
				_target addMagazineCargoGlobal ["rhs_VG40OP_green",20];
				_target addMagazineCargoGlobal ["rhs_VG40OP_red",20];
			};
			case (_par_opfWeap isEqualTo 3): {
				_target addMagazineCargoGlobal ["CUP_HandGrenade_RGD5",20];
				_target addMagazineCargoGlobal ["SmokeShell",20];
				_target addMagazineCargoGlobal ["SmokeShellGreen",20];
				_target addMagazineCargoGlobal ["SmokeShellRed",20];
				_target addMagazineCargoGlobal ["SmokeShellBlue",20];
				_target addMagazineCargoGlobal ["SmokeShellYellow",20];
				_target addMagazineCargoGlobal ["CUP_1Rnd_HE_GP25_M",40];
				_target addMagazineCargoGlobal ["CUP_1Rnd_SMOKE_GP25_M",20];
				_target addMagazineCargoGlobal ["CUP_1Rnd_SmokeRed_GP25_M",20];
				_target addMagazineCargoGlobal ["CUP_1Rnd_SmokeGreen_GP25_M",20];
				_target addMagazineCargoGlobal ["CUP_1Rnd_SmokeYellow_GP25_M",20];
				_target addMagazineCargoGlobal ["CUP_FlareYellow_GP25_M",20];
				_target addMagazineCargoGlobal ["CUP_FlareWhite_GP25_M",20];
				_target addMagazineCargoGlobal ["CUP_FlareGreen_GP25_M",20];
				_target addMagazineCargoGlobal ["CUP_FlareRed_GP25_M",20];
			};
			default {
				_target addMagazineCargoGlobal ["HandGrenade",20];
				_target addMagazineCargoGlobal ["MiniGrenade",20];
				_target addMagazineCargoGlobal ["SmokeShell",20];
				_target addMagazineCargoGlobal ["SmokeShellGreen",20];
				_target addMagazineCargoGlobal ["SmokeShellRed",20];
				_target addMagazineCargoGlobal ["SmokeShellBlue",20];
				_target addMagazineCargoGlobal ["SmokeShellYellow",20];
				_target addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",40];
				_target addMagazineCargoGlobal ["UGL_FlareRed_F",20];
				_target addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell",20];
				_target addMagazineCargoGlobal ["1Rnd_SmokeRed_Grenade_shell",20];
				_target addMagazineCargoGlobal ["1Rnd_SmokeYellow_Grenade_shell",20];
			};
		};
		
		if !(isClass (configFile >> "CfgPatches" >> "ACE_attach")) then {
			_target addMagazineCargoGlobal ["O_IR_Grenade",10];
		};
		
		//uniform items
		switch (_par_opfUni) do {
			case 1: {
				_target addItemCargoGlobal ["rhs_6b27m",5];		
				_target addBackpackCargoGlobal ["B_AssaultPack_sgg",3];		
			};
			case 2: {
				_target addItemCargoGlobal ["rhs_6b27m",5];		
				_target addBackpackCargoGlobal ["B_AssaultPack_sgg",3];		
			};
			case 3: {
				_target addItemCargoGlobal ["rhs_6b27m",5];		
				_target addBackpackCargoGlobal ["B_AssaultPack_sgg",3];		
			};
			case 5: {
				_target addBackpackCargoGlobal ["B_AssaultPack_cbr",3];
			};
			default {
				_target addItemCargoGlobal ["H_HelmetO_ocamo",5];
				_target addBackpackCargoGlobal ["B_AssaultPack_cbr",3];
			};
		};
		
		//radios
		if (isClass (configFile >> "CfgPatches" >> "task_force_radio") && (_par_Radios == 1 || _par_Radios == 3)) then {
			_target addBackpackCargoGlobal ["tfar_mr3000",2];
		};
		if (_par_Radios == 1 || _par_Radios == 3) then {
			_target addItemCargoGlobal ["ItemRadio",4];
		};
		_target addItemCargoGlobal ["BINOCULAR",5];

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
			
			_adv_aceCPR_AED = 5;
			_ACE_advACEsplint_splint = 20;
			
			if (isClass(configFile >> "CfgPatches" >> "adv_aceRefill")) then {
				_target addItemCargoGlobal ["adv_aceRefill_manualKit",5];
				_target addItemCargoGlobal ["adv_aceRefill_FAK",20];
			};

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
			_ACE_rangefinder = 5;
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
		_target addItemCargoGlobal ["Toolkit",2];
		_target addItemCargoGlobal ["acc_flashlight",5];
	};
	nil;
} count _this;

true;
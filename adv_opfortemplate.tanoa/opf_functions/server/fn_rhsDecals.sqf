/*
 * Author: Belbo
 *
 * Adds rhs decals to OPFOR vehicle
 *
 * Arguments:
 * 0: vehicle - <OBJECT>
 *
 * Return Value:
 * decal applied - <BOOL>
 *
 * Example:
 * [MRAP_1] call adv_opf_fnc_rhsDecals;
 *
 * Public: No
 */

if !(isClass(configFile >> "CfgPatches" >> "rhs_main")) exitWith {};

params [
	["_veh", objNull, [objNull]]
];

switch true do {
	case (_veh isKindOf "rhs_tigr_base"): {
		[_veh,[["Number", [5,6,7], "Default",537]]] spawn rhs_fnc_decalsInit; 
		[_veh,[["Label", [8,9,10], "Army", [19,0]]]] spawn rhs_fnc_decalsInit;
		true;
	};
	case (_veh isKindOf "rhs_gaz66_vmf" || _veh isKindOf "RHS_Ural_BaseTurret" || _veh isKindOf "RHS_UAZ_Base"): {
		[_veh,[["Number", [3,4,5], "Default",537]]] spawn rhs_fnc_decalsInit; 
		[_veh,[["Label", [2,6,7], "Army", [19,0]]]] spawn rhs_fnc_decalsInit;
		/*(verdeckt):
		_veh setObjectTextureGlobal [0,"rhsafrf\addons\rhs_a2port_car_camo\data\ural_kabina_sand_co.paa"];
		_veh setObjectTextureGlobal [1,"rhsafrf\addons\rhs_a2port_car_camo\data\ural_plachta_sand_co.paa"];
		//(offen):
		_veh setObjectTextureGlobal [0,"rhsafrf\addons\rhs_a2port_car_camo\data\ural_kabina_sand_co.paa"];
		_veh setObjectTextureGlobal [1,"rhsafrf\addons\rhs_a2port_car_camo\data\ural_plachta_sand_co.paa"];
		//(bm21):
		_veh setObjectTextureGlobal [0,"rhsafrf\addons\rhs_a2port_car_camo\data\ural_kabina_sand_co.paa"];
		_veh setObjectTextureGlobal [1,"rhsafrf\addons\rhs_a2port_car_camo\data\ural_bm21_sand_co.paa"];
		//(fuel):
		_veh setObjectTextureGlobal [0,"rhsafrf\addons\rhs_a2port_car_camo\data\ural_kabina_sand_co.paa"];
		_veh setObjectTextureGlobal [10,"rhsafrf\addons\rhs_a2port_car_camo\data\ural_fuel_sand_co.paa"];
		//(gaz66):
		_veh setObjectTextureGlobal [0,"rhsafrf\addons\rhs_gaz66_camo\data\gaz66_sand_co.paa"];
		*/
		true;
	};
	case (_veh isKindOf "rhs_btr_base"): {
		[_veh,[["Number", [10,11,12], "DefaultRed",537]]] spawn rhs_fnc_decalsInit; 
		[_veh,[["Label", [3,4,6,7,8], "Army", [19,0]]]] spawn rhs_fnc_decalsInit;
		/*
		if ((toUpper worldname) in adv_var_aridMaps) then {
			switch true do {
				case (_veh isKindOf "rhs_btr80_msv"): {
					_veh setObjectTextureGlobal [0,"rhsafrf\addons\rhs_btr80_camo\data\rhs_btr80_01_des_co.paa"];
					_veh setObjectTextureGlobal [1,"rhsafrf\addons\rhs_btr80_camo\data\rhs_btr80_02_des_co.paa"];
					_veh setObjectTextureGlobal [2,"rhsafrf\addons\rhs_btr80_camo\data\rhs_btr80_03_des_co.paa"];
				};
				case (_veh isKindOf "rhs_btr70_vmf"): {
					_veh setObjectTextureGlobal [0,"rhsafrf\addons\rhs_btr70_camo\data\btr70_1_sand_co.paa"];
				};
				case (_veh isKindOf "rhs_btr60_base"): {
					_veh setObjectTextureGlobal [0,"rhsafrf\addons\rhs_btr60_camo\data\btr60_1_sand_co.paa"];
				};
			};
		};
		*/
		true;
	};
	case (_veh isKindOf "rhs_bmp1tank_base"): {
		[_veh,[["Number", [6,7,8], "DefaultRed",537]]] spawn rhs_fnc_decalsInit; 
		[_veh,[["Label", [9,12,13], "Army", [19,0]]]] spawn rhs_fnc_decalsInit;
		/*
		_veh setObjectTextureGlobal [0,"rhsafrf\addons\rhs_bmp_camo\data\bmp_1_desert_co.paa"];
		_veh setObjectTextureGlobal [1,"rhsafrf\addons\rhs_bmp_camo\data\bmp_2_desert_co.paa"];
		_veh setObjectTextureGlobal [2,"rhsafrf\addons\rhs_bmp_camo\data\bmp_3_desert_co.paa"];
		_veh setObjectTextureGlobal [3,"rhsafrf\addons\rhs_bmp_camo\data\bmp_4_desert_co.paa"];
		_veh setObjectTextureGlobal [4,"rhsafrf\addons\rhs_bmp_camo\data\bmp_5_desert_co.paa"];
		_veh setObjectTextureGlobal [5,"rhsafrf\addons\rhs_bmp_camo\data\bmp_6_desert_co.paa"];
		*/
		true;
	};
	case (_veh isKindOf "rhs_a3t72tank_base" || _veh isKindOf "rhs_tank_base") : {
		//[_veh,[["Number", [5,6,7], "DefaultRed",537]]] spawn rhs_fnc_decalsInit;
		/*
		//t72
		_veh setObjectTextureGlobal [0,"rhsafrf\addons\rhs_t72_camo\data\rhs_t72b_01a_sand_co.paa"]; 
		_veh setObjectTextureGlobal [1,"rhsafrf\addons\rhs_t72_camo\data\rhs_t72b_02_sand_co.paa"]; 
		_veh setObjectTextureGlobal [2,"rhsafrf\addons\rhs_t72_camo\data\rhs_t72b_03_sand_co.paa"]; 
		_veh setObjectTextureGlobal [3,"rhsafrf\addons\rhs_t72_camo\data\rhs_t72b_04_sand_co.paa"]; 
		_veh setObjectTextureGlobal [4,"rhsafrf\addons\rhs_t72_camo\data\rhs_t72b_05_sand_co.paa"];
		_veh setObjectTextureGlobal [5,"rhsafrf\addons\rhs_t72_camo\data\rhs_t72b3_turret_sand_co.paa"];
		//t90 zusätzlich:
		_veh setObjectTextureGlobal [5,"rhsafrf\addons\rhs_t72_camo\data\rhs_t90parts__sand_co.paa"];
		
		true;
		*/
	};
	case (_veh isKindOf "rhs_2s3tank_base") : {
		[_veh,[["Number", [3,4,5], "DefaultRed",537]]] spawn rhs_fnc_decalsInit;
		/*
		_veh setObjectTextureGlobal [0,"rhsafrf\addons\rhs_2s3_camo\data\rhs_2s3_01_des_co.paa"];
		_veh setObjectTextureGlobal [1,"rhsafrf\addons\rhs_2s3_camo\data\rhs_2s3_02_des_co.paa"];
		_veh setObjectTextureGlobal [2,"rhsafrf\addons\rhs_2s3_camo\data\rhs_art_wheels_des_co.paa"];
		*/
		true;
	};
	case (_veh isKindOf "rhs_bmd_base") : {
		[_veh,[["Number", [3,4,5], "DefaultRed",537]]] spawn rhs_fnc_decalsInit;
		[_veh,[["Label", [6,7], "Army", [19,0]]]] spawn rhs_fnc_decalsInit;
		/*
		//bmd1&2:
		_veh setObjectTextureGlobal [0,"rhsafrf\addons\rhs_bmd_camo\data\sa_bmd2_01_rus1_co.paa"];
		_veh setObjectTextureGlobal [1,"rhsafrf\addons\rhs_bmd_camo\data\sa_bmd2_02_rus1_co.paa"];
		_veh setObjectTextureGlobal [2,"rhsafrf\addons\rhs_bmd_camo\data\sa_bmd2_03_rus1_co.paa"];
		*/
		true;
	};
	case (_veh isKindOf "rhs_a3spruttank_base") : {
		[_veh,[["Number", [5,6,7], "DefaultRed",537]]] spawn rhs_fnc_decalsInit;
		[_veh,[["Label", [8], "Army", [19,0]]]] spawn rhs_fnc_decalsInit;
		true;
	};
	case (_veh isKindOf "rhs_brm1k_vdv") : {
		[_veh,[["Number", [6,7,8], "DefaultRed",537]]] spawn rhs_fnc_decalsInit;
		[_veh,[["Label", [9], "Army", [19,0]]]] spawn rhs_fnc_decalsInit;
		true;
	};
	default {false};
};
/*
//bmp3
_veh setObjectTextureGlobal [0,"rhsafrf\addons\rhs_bmp3_camo\data\rhs_bmp3_01_sand_co.paa"];
_veh setObjectTextureGlobal [1,"rhsafrf\addons\rhs_bmp3_camo\data\rhs_bmp3_02_sand_co.paa"];
_veh setObjectTextureGlobal [2,"rhsafrf\addons\rhs_bmp3_camo\data\rhs_bmp3_03_sand_co.paa"];
_veh setObjectTextureGlobal [3,"rhsafrf\addons\rhs_bmp3_camo\data\rhs_bmp3_04_sand_co.paa"];
*/

true;
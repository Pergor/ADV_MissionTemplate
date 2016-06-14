if !(isClass(configFile >> "CfgPatches" >> "rhs_main")) exitWith {};

params [
	["_veh", objNull, [objNull]]
];

switch true do {
	case (_veh isKindOf "rhs_tigr_base"): {
		[_veh,[["Number", [5,6,7], "Default",537]]] spawn rhs_fnc_decalsInit; 
		[_veh,[["Label", [8,9,10], "Army", [19,0]]]] spawn rhs_fnc_decalsInit;
	};
	case (_veh isKindOf "rhs_gaz66_vmf" || _veh isKindOf "RHS_Ural_BaseTurret" || _veh isKindOf "RHS_UAZ_Base"): {
		[_veh,[["Number", [3,4,5], "Default",537]]] spawn rhs_fnc_decalsInit; 
		[_veh,[["Label", [2,6,7], "Army", [19,0]]]] spawn rhs_fnc_decalsInit;
	};
	case (_veh isKindOf "rhs_btr_base"): {
		[_veh,[["Number", [10,11,12], "DefaultRed",537]]] spawn rhs_fnc_decalsInit; 
		[_veh,[["Label", [3,4,6,7,8], "Army", [19,0]]]] spawn rhs_fnc_decalsInit;
	};
	case (_veh isKindOf "rhs_bmp1tank_base"): {
		[_veh,[["Number", [6,7,8], "DefaultRed",537]]] spawn rhs_fnc_decalsInit; 
		[_veh,[["Label", [9,12,13], "Army", [19,0]]]] spawn rhs_fnc_decalsInit;
	};
	case (_veh isKindOf "rhs_a3t72tank_base" || _veh isKindOf "rhs_tank_base") : {
		//[_veh,[["Number", [5,6,7], "DefaultRed",537]]] spawn rhs_fnc_decalsInit;
	};
	case (_veh isKindOf "rhs_2s3tank_base") : {
		[_veh,[["Number", [3,4,5], "DefaultRed",537]]] spawn rhs_fnc_decalsInit;
	};
	case (_veh isKindOf "rhs_bmd_base") : {
		[_veh,[["Number", [3,4,5], "DefaultRed",537]]] spawn rhs_fnc_decalsInit;
		[_veh,[["Label", [6,7], "Army", [19,0]]]] spawn rhs_fnc_decalsInit;
	};
	case (_veh isKindOf "rhs_a3spruttank_base") : {
		[_veh,[["Number", [5,6,7], "DefaultRed",537]]] spawn rhs_fnc_decalsInit;
		[_veh,[["Label", [8], "Army", [19,0]]]] spawn rhs_fnc_decalsInit;
	};
	case (_veh isKindOf "rhs_brm1k_vdv") : {
		[_veh,[["Number", [6,7,8], "DefaultRed",537]]] spawn rhs_fnc_decalsInit;
		[_veh,[["Label", [9], "Army", [19,0]]]] spawn rhs_fnc_decalsInit;
	};
	default {};
};

if (true) exitWith {};
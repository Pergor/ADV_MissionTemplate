/*
 * Author: Belbo
 *
 * Adds 40mm grenades to to unit depending on adv_missiontemplate-variables - has to be called by adv_fnc_gear;
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [player] call adv_fnc_add40mm;
 *
 * Public: No
 */

params [
	["_unit", player, [objNull]]
];

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

if (isNil "_40mmHeGrenadesAmmo") then {_40mmHeGrenadesAmmo = 0;};
if (isNil "_40mmSmokeGrenadesWhite") then {_40mmSmokeGrenadesWhite = 0;};
if (isNil "_40mmSmokeGrenadesGreen") then {_40mmSmokeGrenadesGreen = 0;};
if (isNil "_40mmSmokeGrenadesRed") then {_40mmSmokeGrenadesRed = 0;};
if (isNil "_40mmSmokeGrenadesYellow") then {_40mmSmokeGrenadesYellow = 0;};
if (isNil "_40mmSmokeGrenadesBlue") then {_40mmSmokeGrenadesBlue = 0;};
if (isNil "_40mmSmokeGrenadesOrange") then {_40mmSmokeGrenadesOrange = 0;};
if (isNil "_40mmSmokeGrenadesPurple") then {_40mmSmokeGrenadesPurple = 0;};
if (isNil "_40mmFlareWhite") then {_40mmFlareWhite = 0;};
if (isNil "_40mmFlareYellow") then {_40mmFlareYellow = 0;};
if (isNil "_40mmFlareGreen") then {_40mmFlareGreen = 0;};
if (isNil "_40mmFlareRed") then {_40mmFlareRed = 0;};
if (isNil "_40mmFlareIR") then {_40mmFlareIR = 0;};

_40mmGrens = switch ( true ) do {
	case ( (_par_opfWeap == 1 || _par_opfWeap == 2) && ( side ( group _unit ) == east ) ): {
		[
			["rhs_VOG25", _40mmHeGrenadesAmmo],
			["rhs_GRD40_White", _40mmSmokeGrenadesWhite],
			["rhs_GRD40_Green", _40mmSmokeGrenadesGreen+_40mmSmokeGrenadesYellow+_40mmSmokeGrenadesBlue],
			["rhs_GRD40_Red", _40mmSmokeGrenadesRed+_40mmSmokeGrenadesOrange+_40mmSmokeGrenadesPurple]
		];
	};
	case ( _par_opfWeap == 3 && ( side ( group _unit ) == east ) ): {
		[
			["CUP_1Rnd_HE_GP25_M", _40mmHeGrenadesAmmo],
			["CUP_1Rnd_SMOKE_GP25_M", _40mmSmokeGrenadesWhite],
			["CUP_1Rnd_SmokeGreen_GP25_M", _40mmSmokeGrenadesGreen+_40mmSmokeGrenadesBlue],
			["CUP_1Rnd_SmokeRed_GP25_M", _40mmSmokeGrenadesRed+_40mmSmokeGrenadesOrange+_40mmSmokeGrenadesPurple],
			["CUP_1Rnd_SmokeYellow_GP25_M", _40mmSmokeGrenadesYellow]
		];
	};
	case ( _par_opfWeap == 4 && ( side ( group _unit ) == east ) ): {
		[
			["hlc_VOG25_AK", _40mmHeGrenadesAmmo],
			["hlc_GRD_White", _40mmSmokeGrenadesWhite+_40mmSmokeGrenadesYellow],
			["hlc_GRD_green", _40mmSmokeGrenadesGreen],
			["hlc_GRD_red", _40mmSmokeGrenadesRed],
			["hlc_GRD_orange", _40mmSmokeGrenadesOrange],
			["hlc_GRD_purple", _40mmSmokeGrenadesPurple],
			["hlc_GRD_blue", _40mmSmokeGrenadesBlue]
		];
	};
	default {
		[
			["1Rnd_HE_Grenade_shell", _40mmHeGrenadesAmmo],
			["1Rnd_Smoke_Grenade_shell", _40mmSmokeGrenadesWhite],
			["1Rnd_SmokeGreen_Grenade_shell", _40mmSmokeGrenadesGreen],
			["1Rnd_SmokeRed_Grenade_shell", _40mmSmokeGrenadesRed],
			["1Rnd_SmokeYellow_Grenade_shell", _40mmSmokeGrenadesYellow],
			["1Rnd_SmokeOrange_Grenade_shell", _40mmSmokeGrenadesOrange],
			["1Rnd_SmokePurple_Grenade_shell", _40mmSmokeGrenadesPurple],
			["1Rnd_SmokeBlue_Grenade_shell", _40mmSmokeGrenadesBlue]
		];
	};
};

{ _unit addMagazines [_x select 0, _x select 1]; } forEach _40mmGrens;

if ( ( !(side (group _unit) == east) && _par_NVGs == 1 ) || (side (group _unit) == east && _par_opfNVGs == 1) ) then {
	_40mmFlares = switch ( true ) do {
		case ( (_par_opfWeap == 1 || _par_opfWeap == 2) && ( side ( group _unit ) == east ) ): {
			[
				["rhs_VG40OP_white", _40mmFlareWhite+_40mmFlareYellow],
				["rhs_VG40OP_green", _40mmFlareGreen],
				["rhs_VG40OP_red", _40mmFlareRed]
			];
		};
		case ( _par_opfWeap == 3 && ( side ( group _unit ) == east ) ): {
			[
				["CUP_FlareWhite_GP25_M", _40mmFlareWhite],
				["CUP_FlareGreen_GP25_M", _40mmFlareGreen],
				["CUP_FlareRed_GP25_M", _40mmFlareRed],
				["CUP_FlareYellow_GP25_M", _40mmFlareYellow]
			];
		};
		case ( _par_opfWeap == 4 && ( side ( group _unit ) == east ) ): {
		};
		default {
			[
				["UGL_FlareWhite_F", _40mmFlareWhite],
				["UGL_FlareYellow_F", _40mmFlareYellow],
				["UGL_FlareRed_F", _40mmFlareRed],
				["UGL_FlareGreen_F", _40mmFlareGreen]
			];
		};
	};
	{ _unit addMagazines [_x select 0, _x select 1]; } forEach _40mmFlares;
};

if ( ( !(side (group _unit) == east) && _par_NVGs == 2 ) || (side (group _unit) == east && _par_opfNVGs == 2 && !(_par_opfWeap > 0)) ) then {
	_40mmIR = [["UGL_FlareCIR_F", _40mmFlareIR]];
	{ _unit addMagazines [_x select 0, _x select 1]; } forEach _40mmIR;
};

true;
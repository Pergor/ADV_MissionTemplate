/*
 * Author: Belbo
 *
 * Adds grenades to to unit depending on adv_missiontemplate-variables - has to be called by adv_fnc_gear;
 *
 * Arguments:
 * 0: target - <OBJECT>
 * 1: Should a pre defined grenade set (2x HE, 1x Smoke White, 1x Smoke Green, 1x red chemlight) be added? - <NUMBER>
 * 2: Array of grenade types (not classnames!), can be "HE", "WHITE", "GREEN", "RED" etc. - <ARRAY> of <STRINGS>
 * 3: Array of chemlight types (not classnames!), can be "GREEN", "RED" etc. - <ARRAY> of <STRINGS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [player] call adv_fnc_addGrenades;
 *
 * Public: No
 */

params [
	["_unit", player, [objNull]],
	["_grenSet", 0, [0]],
	["_grenades", [""], [[]]],
	["_chemlights", [""], [[]]],
	["_IRgrenade", 0, [0]]
];

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

private _grenHE = { toUpper _x isEqualTo "HE" } count _grenades;
private _grenSmkWht = { toUpper _x isEqualTo "WHITE" } count _grenades;
private _grenSmkGrn = { toUpper _x isEqualTo "GREEN" } count _grenades;
private _grenSmkRd = { toUpper _x isEqualTo "RED" } count _grenades;
private _grenSmkYlw = { toUpper _x isEqualTo "YELLOW" } count _grenades;
private _grenSmkOrng = { toUpper _x isEqualTo "ORANGE" } count _grenades;
private _grenSmkBl = { toUpper _x isEqualTo "BLUE" } count _grenades;
private _grenSmkPrpl = { toUpper _x isEqualTo "PURPLE" } count _grenades;

private _chemRd = { toUpper _x isEqualTo "RED" } count _chemlights;
private _chemGrn = { toUpper _x isEqualTo "GREEN" } count _chemlights;
private _chemYlw = { toUpper _x isEqualTo "YELLOW" } count _chemlights;
private _chemBl = { toUpper _x isEqualTo "BLUE" } count _chemlights;

if (_grenSet > 0) then {
	switch ( side (group _unit) ) do {
		case east: {
			_grenHE = 2;
			_grenSmkWht = 1;
			_grenSmkYlw = 1;
			_grenSmkOrng = 1;
			_grenSmkRd = 0;
			_grenSmkPrpl = 0;
			_grenSmkBl = 0;
			_grenSmkGrn = 0;
			_chemRd = 1;
			_chemYlw = 0;
			_chemGrn = 0;
			_chemBl = 0;		
		};
		default {
			_grenHE = 2;
			_grenSmkWht = 1;
			_grenSmkYlw = 0;
			_grenSmkOrng = 1;
			_grenSmkRd = 0;
			_grenSmkPrpl = 0;
			_grenSmkBl = 0;
			_grenSmkGrn = 1;
			_chemRd = 1;
			_chemYlw = 0;
			_chemGrn = 0;
			_chemBl = 0;
		};
	};
};

private _grenArray = call {
	if ( _par_customWeap isEqualTo 1 && ( side ( group _unit ) isEqualTo west ) ) exitWith {
		[
			["BWA3_DM51A1",_grenHE],
			["BWA3_DM25", _grenSmkWht],
			["BWA3_DM32_Orange", _grenSmkOrng+_grenSmkGrn+_grenSmkRd],
			["BWA3_DM32_Yellow", _grenSmkYlw+_grenSmkPrpl+_grenSmkBl]
		]
	};
	if ( ((_par_customWeap isEqualTo 2 || _par_customWeap isEqualTo 3 || _par_customWeap isEqualTo 4) && ( side ( group _unit ) isEqualTo west )) || (_par_indWeap isEqualTo 2 && ( side ( group _unit ) isEqualTo independent )) ) exitWith {
		[
			["rhs_mag_m67", _grenHE],
			["rhs_mag_an_m8hc", _grenSmkWht],
			["rhs_mag_m18_yellow", _grenSmkYlw],
			["rhs_mag_m18_purple", _grenSmkPrpl],
			["rhs_mag_m18_green", _grenSmkGrn+_grenSmkBl],
			["rhs_mag_m18_red", _grenSmkRd+_grenSmkOrng]
		]
	};
	if ( (_par_opfWeap isEqualTo 1 || _par_opfWeap isEqualTo 2) && ( side ( group _unit ) isEqualTo east ) ) exitWith {
		[
			["rhs_mag_rgd5", _grenHE],
			["rhs_mag_rdg2_white", _grenSmkWht],
			["rhs_mag_rdg2_black", _grenSmkGrn+_grenSmkBl+_grenSmkPrpl],
			["rhs_mag_nspd", _grenSmkYlw+_grenSmkRd+_grenSmkOrng]
		]
	};
	[
		["MiniGrenade", _grenHE],
		["SmokeShell", _grenSmkWht],
		["SmokeShellBlue", _grenSmkBl],
		["SmokeShellGreen", _grenSmkGrn],
		["SmokeShellOrange", _grenSmkOrng],
		["SmokeShellPurple", _grenSmkPrpl],
		["SmokeShellRed", _grenSmkRd],
		["SmokeShellYellow", _grenSmkYlw]
	]
};
private _chemArray = call {
	if ( ( !(side (group _unit) isEqualTo east) && _par_NVGs > 0 ) || (side (group _unit) isEqualTo east && _par_opfNVGs > 0) ) exitWith {
		[
			["Chemlight_Yellow", _chemYlw],
			["Chemlight_Red", _chemRd],
			["Chemlight_Green", _chemGrn],
			["Chemlight_Blue", _chemBl]
		]
	};
	[["",0]]
};

private _IRArray = call {
	if ( !isClass(configFile >> "CfgPatches" >> "ACE_attach") && (( !(side (group _unit) isEqualTo east) && _par_NVGs isEqualTo 2 ) || (side (group _unit) isEqualTo east && _par_opfNVGs isEqualTo 2)) ) exitWith {
		switch (side (group _unit)) do {
			case west: { [["B_IR_Grenade",1]] };
			case east: { [["O_IR_Grenade",1]] };
			case independent: { [["I_IR_Grenade",1]] };
			default { [["I_IR_Grenade",1]] };
		};
	};
	[["",0]]
};

{ _unit addMagazines [_x select 0, _x select 1]; } count _grenArray+_chemArray+_IRArray;

true;
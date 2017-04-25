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

_grenHE = {_x == "HE"} count _grenades;
_grenSmkWht = {_x == "WHITE"} count _grenades;
_grenSmkGrn = {_x == "GREEN"} count _grenades;
_grenSmkRd = {_x == "RED"} count _grenades;
_grenSmkYlw = {_x == "YELLOW"} count _grenades;
_grenSmkOrng = {_x == "ORANGE"} count _grenades;
_grenSmkBl = {_x == "BLUE"} count _grenades;
_grenSmkPrpl = {_x == "PURPLE"} count _grenades;

_chemRd = {_x == "RED"} count _chemlights;
_chemGrn = {_x == "GREEN"} count _chemlights;
_chemYlw = {_x == "YELLOW"} count _chemlights;
_chemBl = {_x == "BLUE"} count _chemlights;

if (_grenSet > 0) then {
	switch ( side (group _unit) ) do {
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

_grenArray = call {
	if ( _par_customWeap == 1 && ( side ( group _unit ) == west ) ) exitWith {
		[
			["BWA3_DM51A1",_grenHE],
			["BWA3_DM25", _grenSmkWht],
			["BWA3_DM32_Orange", _grenSmkOrng+_grenSmkGrn+_grenSmkRd],
			["BWA3_DM32_Yellow", _grenSmkYlw+_grenSmkPrpl+_grenSmkBl]
		];
	};
	if ( ((_par_customWeap == 2 || _par_customWeap == 3 || _par_customWeap == 4) && ( side ( group _unit ) == west )) || (_par_indWeap == 2 && ( side ( group _unit ) == independent )) ) exitWith {
		[
			["rhs_mag_m67", _grenHE],
			["rhs_mag_an_m8hc", _grenSmkWht],
			["rhs_mag_m18_yellow", _grenSmkYlw],
			["rhs_mag_m18_purple", _grenSmkPrpl],
			["rhs_mag_m18_green", _grenSmkGrn+_grenSmkBl],
			["rhs_mag_m18_red", _grenSmkRd+_grenSmkOrng]
		];
	};
	if ( (_par_opfWeap == 1 || _par_opfWeap == 2) && ( side ( group _unit ) == east ) ) exitWith {
		[
			["rhs_mag_rgd5", _grenHE],
			["rhs_mag_rdg2_white", _grenSmkWht],
			["rhs_mag_rdg2_black", _grenSmkGrn+_grenSmkBl+_grenSmkPrpl],
			["rhs_mag_nspd", _grenSmkYlw+_grenSmkRd+_grenSmkOrng]
		];
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
	];
};
_chemArray = call {
	if ( ( !(side (group _unit) == east) && _par_NVGs > 0 ) || (side (group _unit) == east && _par_opfNVGs > 0) ) exitWith {
		[
			["Chemlight_Yellow", _chemYlw],
			["Chemlight_Red", _chemRd],
			["Chemlight_Green", _chemGrn],
			["Chemlight_Blue", _chemBl]
		];
	};
	[["",0]];
};

{ _unit addMagazines [_x select 0, _x select 1]; } count _grenArray+_chemArray;

if ( !isClass(configFile >> "CfgPatches" >> "ACE_attach") && (( !(side (group _unit) == east) && _par_NVGs == 2 ) || (side (group _unit) == east && _par_opfNVGs == 2)) ) then {
	_IR_GrenType = switch (side (group _unit)) do {
		case west: {"B_IR_Grenade"};
		case east: {"O_IR_Grenade"};
		case independent: {"I_IR_Grenade"};
		default {"I_IR_Grenade"};
	};
	_unit addMagazines [_IR_GrenType, _IRgrenade];
};

true;
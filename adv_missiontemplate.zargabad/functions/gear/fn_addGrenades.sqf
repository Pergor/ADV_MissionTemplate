/*
fn_addGrenades: adds grenades to a unit.
call like this:
[_unit,0,["HE","HE","WHITE"],["RED"]] call ADV_fnc_addGrenades;
_this select 0 = object
_this select 1 = define if a predefined grenade set of two HE grenades, one white and on coloured smoke grenade and a red chemlight should be added.
_this select 2 = array of grenades "HE" for HE-Grenades, "WHITE", "RED" etc. for coloured smoke.
_this select 3 = array of chemlights.
*/

params [
	["_unit", player, [objNull]],
	["_grenSet", 0, [0]],
	["_grenades", [""], [[]]],
	["_chemlights", [""], [[]]],
	["_IRgrenade", 0, [0]]
];

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
			_grenSmkOrng = 0;
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

_grenArray = switch ( true ) do {
	case ( ADV_par_customWeap == 1 && ( side ( group _unit ) == west ) ): {
		[
			["BWA3_DM51A1",_grenHE],
			["BWA3_DM25", _grenSmkWht],
			["BWA3_DM32_Orange", _grenSmkOrng+_grenSmkPrpl+_grenSmkRd],
			["BWA3_DM32_Yellow", _grenSmkYlw+_grenSmkGrn+_grenSmkBl]
		];
	};
	case ( ((ADV_par_customWeap == 2 || ADV_par_customWeap == 3 || ADV_par_customWeap == 4) && ( side ( group _unit ) == west )) || (ADV_par_indWeap == 2 && ( side ( group _unit ) == independent )) ): {
		[
			["rhs_mag_m67", _grenHE],
			["rhs_mag_an_m8hc", _grenSmkWht],
			["rhs_mag_m18_yellow", _grenSmkYlw],
			["rhs_mag_m18_purple", _grenSmkPrpl],
			["rhs_mag_m18_green", _grenSmkGrn+_grenSmkBl],
			["rhs_mag_m18_red", _grenSmkRd+_grenSmkOrng]
		];
	};
	case ( (ADV_par_opfWeap == 1 || ADV_par_opfWeap == 2) && ( side ( group _unit ) == east ) ): {
		[
			["rhs_mag_rgd5", _grenHE],
			["SmokeShell", _grenSmkWht],
			["rhs_mag_rdg2_black", _grenSmkGrn+_grenSmkBl+_grenSmkPrpl],
			["rhs_mag_nspd", _grenSmkYlw+_grenSmkRd+_grenSmkOrng]
		];
	};
	default {
		[
			["HandGrenade", _grenHE],
			["SmokeShell", _grenSmkWht],
			["SmokeShellBlue", _grenSmkBl],
			["SmokeShellGreen", _grenSmkGrn],
			["SmokeShellOrange", _grenSmkOrng],
			["SmokeShellPurple", _grenSmkPrpl],
			["SmokeShellRed", _grenSmkRd],
			["SmokeShellYellow", _grenSmkYlw]
		];
	};
};
_chemArray = if ( ( !(side (group _unit) == east) && ADV_par_NVGs > 0 ) || (side (group _unit) == east && ADV_par_opfNVGs > 0) ) then {
	[
		["Chemlight_Yellow", _chemYlw],
		["Chemlight_Red", _chemRd],
		["Chemlight_Green", _chemGrn],
		["Chemlight_Blue", _chemBl]
	];
} else {
	[["",0]];
};

{ _unit addMagazines [_x select 0, _x select 1]; } forEach _grenArray+_chemArray;

if ( !isClass(configFile >> "CfgPatches" >> "ACE_attach") && (( !(side (group _unit) == east) && ADV_par_NVGs == 2 ) || (side (group _unit) == east && ADV_par_opfNVGs == 2)) ) then {
	_IR_GrenType = switch (side (group _unit)) do {
		case west: {"B_IR_Grenade"};
		case east: {"O_IR_Grenade"};
		case independent: {"I_IR_Grenade"};
		default {"I_IR_Grenade"};
	};
	_unit addMagazines [_IR_GrenType, _IRgrenade];
};

true;
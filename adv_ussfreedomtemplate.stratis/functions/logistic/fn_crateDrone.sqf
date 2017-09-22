/*
 * Author: Belbo
 *
 * Fills a crate with regular ammunition for BLUFOR
 *
 * Arguments:
 * Array of objects - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [this] call adv_fnc_crateNormal;
 *
 * Public: Yes
 */
 
//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

{
	private _target = _x;

	//weapons & ammo
	switch (true) do {
		//BWmod
		case (_par_customWeap == 1): {
			//ammo
			if (isClass(configFile >> "CfgPatches" >> "hlcweapons_g36") && !(isClass(configFile >> "CfgPatches" >> "adv_hlcG36_bwmod"))) then {
				_target addMagazineCargoGlobal ["hlc_30rnd_556x45_EPR_G36",8];
			} else {
				_target addMagazineCargoGlobal ["BWA3_30Rnd_556x45_G36",8];
			};
		};
		//RHS
		case (_par_customWeap == 2 || _par_customWeap == 3 || _par_customWeap == 4): {
			//ammo
			_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",8];
		};
		//SeL CUP MK16
		case (_par_customWeap == 5 || _par_customWeap == 6 || _par_customWeap == 7): {
			//ammo
			_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",8];
		};
		case (_par_customWeap == 8): {
			//ammo
			_target addMagazineCargoGlobal ["30rnd_556x45_STANAG",8];
		};
		case (_par_customWeap == 9): {
			//ammo
			if (floor random 2 > 0) then {
				_target addMagazineCargoGlobal ["hlc_20rnd_762x51_b_G3",8];
			} else {
				_target addMagazineCargoGlobal ["hlc_20rnd_762x51_B_fal",15];
			};
		};
		default {
			call {
				if (_par_customWeap == 20) exitWith {
					_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_red",8];
				};
				_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag",8];
			};
		};
	};
	//grenades
	switch (_par_customWeap) do {
		case 1: {
			_target addMagazineCargoGlobal ["BWA3_DM51A1",2];
			_target addMagazineCargoGlobal ["BWA3_DM25",1];
			_target addMagazineCargoGlobal ["BWA3_DM32_Orange",1];
		};
		case 2: {
			_target addMagazineCargoGlobal ["rhs_mag_m67",2];
			_target addMagazineCargoGlobal ["rhs_mag_an_m8hc",1];
			_target addMagazineCargoGlobal ["rhs_mag_m18_green",1];
		};
		case 3: {
			_target addMagazineCargoGlobal ["rhs_mag_m67",2];
			_target addMagazineCargoGlobal ["rhs_mag_an_m8hc",1];
			_target addMagazineCargoGlobal ["rhs_mag_m18_green",1];
		};
		case 4: {
			_target addMagazineCargoGlobal ["rhs_mag_m67",2];
			_target addMagazineCargoGlobal ["rhs_mag_an_m8hc",1];
			_target addMagazineCargoGlobal ["rhs_mag_m18_green",1];
		};
		default {
			_target addMagazineCargoGlobal ["MiniGrenade",2];
			_target addMagazineCargoGlobal ["SmokeShell",1];
			_target addMagazineCargoGlobal ["SmokeShellGreen",1];
		};
	};
	
	_ACE_fieldDressing = 10;
	_ACE_packingBandage = 0;
	_ACE_elasticBandage = 2;
	_ACE_quikclot = 0;
	_ACE_atropine = 0;
	_ACE_epinephrine = 0;
	_ACE_morphine = 1;
	_ACE_tourniquet = 1;
	_ACE_bloodIV = 0;
	_ACE_bloodIV_500 = 0;
	_ACE_bloodIV_250 = 0;
	_ACE_plasmaIV = 0;
	_ACE_plasmaIV_500 = 0;
	_ACE_plasmaIV_250 = 0;
	_ACE_salineIV = 0;
	_ACE_salineIV_500 = 1;
	_ACE_salineIV_250 = 0;
	_ACE_personalAidKit = 0;
	_ACE_surgicalKit = 0;
	_ACE_bodyBag = 0;
	
	_FAKs = 2;
	_mediKit = 0;
	
	if !(isClass (configFile >> "CfgPatches" >> "ACE_Medical")) then {
		_target addItemCargoGlobal ["FirstAidKit",_FAKs];
		_target addItemCargoGlobal ["MediKit",_mediKit];	
	};
	//medical stuff
	if (isClass (configFile >> "CfgPatches" >> "ACE_common")) then {
		_ACE_EarPlugs = 0;

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
		_ACE_CableTie = 0;
		_ACE_NonSteerableParachute = 0;

		_ACE_key_west = 0;
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
		_ACE_HandFlare_Red = 0;
		_ACE_HandFlare_White = 0;
		_ACE_HandFlare_Yellow = 0;
		[_target] call ADV_fnc_addACEItems;
	};
	nil;
} count _this;

true;
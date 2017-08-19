/*
 * Author: Belbo
 *
 * Fills a crate with support equipment for OPFOR
 *
 * Arguments:
 * Array of objects - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [this] call adv_opf_fnc_crateSupport;
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
	//makes the crates indestructible:
	_target allowDamage false;

	//grenades
	switch (true) do {
		case ( _par_opfWeap == 1 || _par_opfWeap == 2): {
			_target addMagazineCargoGlobal ["rhs_mag_rdg2_white",2];
		};
		default {
			_target addMagazineCargoGlobal ["SmokeShell",2];
		};
	};
	
	if ( _par_opfNVGs == 2 && !(isClass (configFile >> "CfgPatches" >> "ACE_attach")) ) then {
		_target addMagazineCargoGlobal ["O_IR_Grenade",4];
	};	
	_target addItemCargoGlobal ["ToolKit",2];
	_target addItemCargoGlobal ["BINOCULAR",2];

	if ( _par_radios > 0 ) then {
		call {
			if ( isClass (configFile >> "CfgPatches" >> "tfar_core") ) exitWith {
				_target addItemCargoGlobal [TFAR_DefaultRadio_Personal_East,1];
			};
			if ( isClass (configFile >> "CfgPatches" >> "task_force_radio") ) exitWith {
				_target addItemCargoGlobal [TF_defaultEastPersonalRadio,1];
			};
			_target addItemCargoGlobal ["ItemRadio",1];
		};
	};	
	
	if ( _par_Tablets == 1 && isClass (configFile >> "CfgPatches" >> "cTab") ) then {
		_target addItemCargoGlobal ["ItemAndroid",1];
	};
	
	if ( _par_opfNVGs == 2 ) then {
		if ( isClass (configFile >> "CfgPatches" >> "ACE_nightvision") ) then {
			_target addItemCargoGlobal ["ACE_NVG_Wide",2];
		} else {
			_target addItemCargoGlobal ["NVGoggles_OPFOR",2];
		};
	};
	
	_ACE_fieldDressing = 0;
	_ACE_packingBandage = 0;
	_ACE_elasticBandage = 0;
	_ACE_quikclot = 0;
	_ACE_atropine = 0;
	_ACE_epinephrine = 0;
	_ACE_morphine = 0;
	_ACE_tourniquet = 0;
	_ACE_bloodIV = 0;
	_ACE_bloodIV_500 = 0;
	_ACE_bloodIV_250 = 0;
	_ACE_plasmaIV = 0;
	_ACE_plasmaIV_500 = 0;
	_ACE_plasmaIV_250 = 0;
	_ACE_salineIV = 0;
	_ACE_salineIV_500 = 0;
	_ACE_salineIV_250 = 0;
	_ACE_personalAidKit = 0;
	_ACE_surgicalKit = 0;
	_ACE_bodyBag = 5;
	
	_adv_aceCPR_AED = 1;
	
	_FAKs = 0;
	_mediKit = 0;
	
	if !(isClass (configFile >> "CfgPatches" >> "ACE_Medical")) then {
		_target addItemCargoGlobal ["FirstAidKit",_FAKs];
		_target addItemCargoGlobal ["MediKit",_mediKit];	
	};
	//medical stuff
	if (isClass (configFile >> "CfgPatches" >> "ACE_common")) then {
		_ACE_EarPlugs = 5;

		_ACE_SpareBarrel = 0;
		_ACE_tacticalLadder = 2;
		_ACE_UAVBattery = 2;
		_ACE_wirecutter = 1;
		_ACE_sandbag = 30;
		_ACE_Clacker = 0;
		_ACE_M26_Clacker = 0;
		_ACE_DeadManSwitch = 0;
		_ACE_DefusalKit = 1;
		_ACE_Cellphone = 0;
		_ACE_MapTools = 4;
		_ACE_CableTie = 10;
		_ACE_NonSteerableParachute = 0;
		_ACE_EntrenchingTool = 1;
		_ACE_minedetector = 1;

		_ACE_key_west = 1;
		_ACE_key_east = 0;
		_ACE_key_indp = 0;
		_ACE_key_civ = 0;
		_ACE_key_master = 0;
		_ACE_key_lockpick = 0;
		_ACE_kestrel = 1;
		_ACE_ATragMX = 1;
		_ACE_rangecard = 1;
		_ACE_altimeter = 0;
		_ACE_microDAGR = 0;
		_ACE_DAGR = 0;
		_ACE_RangeTable_82mm = 1;
		_ACE_rangefinder = 2;
		_ACE_NonSteerableParachute = 0;
		_ACE_IR_Strobe = 4;
		_ACE_M84 = 0;
		_ACE_HandFlare_Green = 0;
		_ACE_HandFlare_Red = 8;
		_ACE_HandFlare_White = 0;
		_ACE_HandFlare_Yellow = 0;
		[_target] call ADV_fnc_addACEItems;
	};
	nil;
} count _this;

true;
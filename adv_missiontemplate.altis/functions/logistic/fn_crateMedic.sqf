/*
 * Author: Belbo
 *
 * Fills a crate with medic equipment for BLUFOR
 *
 * Arguments:
 * Array of objects - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [this] call adv_fnc_crateMedic;
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
		case (_par_customWeap == 1): {
			_target addMagazineCargoGlobal ["BWA3_DM25",10];
		};
		case (_par_customWeap == 2 || _par_customWeap == 3 || _par_customWeap == 4): {
			_target addMagazineCargoGlobal ["rhs_mag_an_m8hc",10];
		};
		default {
			_target addMagazineCargoGlobal ["SmokeShell",10];
		};
	};
	if ( _par_NVGs == 2 && !(isClass (configFile >> "CfgPatches" >> "ACE_attach")) ) then {
		_target addMagazineCargoGlobal ["B_IR_Grenade",1];
	};
	
	if (isClass(configFile >> "CfgPatches" >> "adv_aceRefill")) then {
		_target addItemCargoGlobal ["adv_aceRefill_manualKit",1];
		_target addItemCargoGlobal ["adv_aceRefill_FAK",5];
	};
	
	_ACE_fieldDressing = 32;
	_ACE_packingBandage = 32;
	_ACE_elasticBandage = 32;
	_ACE_quikclot = 0;
	if (missionnamespace getVariable ["ace_medical_enableAdvancedWounds",false]) then {
		_ACE_quikclot = 32;
	};
	_ACE_adenosine = 5;
	_ACE_atropine = 5;
	_ACE_epinephrine = 12;
	_ACE_morphine = 12;
	_ACE_tourniquet = 8;
	_ACE_bloodIV = 0;
	_ACE_bloodIV_500 = 0;
	_ACE_bloodIV_250 = 0;
	_ACE_plasmaIV = 0;
	_ACE_plasmaIV_500 = 15;
	_ACE_plasmaIV_250 = 0;
	_ACE_salineIV = 0;
	_ACE_salineIV_500 = 15;
	_ACE_salineIV_250 = 0;
	_ACE_bodyBag = 5;
	_ACE_personalAidKit = 0;
	if ( (missionnamespace getVariable ["ace_medical_consumeItem_PAK",0]) > 0 ) then {
		_ACE_personalAidKit = 5;
		if (isClass(configFile >> "CfgPatches" >> "adv_aceCPR")) then {
			_ACE_personalAidKit = 2;
		};
	};
	_ACE_surgicalKit = 1;
	if ( (missionnamespace getVariable ["ace_medical_consumeItem_SurgicalKit",0]) > 0 ) then {
		_ACE_surgicalKit = 10;
	};
	_ACE_advACEsplint_splint = 12;
	
	_FAKs = 20;
	_mediKit = 1;
	
	if !(isClass (configFile >> "CfgPatches" >> "ACE_Medical")) then {
		_target addItemCargoGlobal ["FirstAidKit",_FAKs];
		_target addItemCargoGlobal ["MediKit",_mediKit];
	};
	//medical stuff
	if (isClass (configFile >> "CfgPatches" >> "ACE_common")) then {
		_ACE_EarPlugs = 2;

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
		_ACE_IR_Strobe = 1;
		_ACE_M84 = 0;
		_ACE_HandFlare_Green = 0;
		_ACE_HandFlare_Red = 2;
		_ACE_HandFlare_White = 0;
		_ACE_HandFlare_Yellow = 0;
		[_target] call ADV_fnc_addACEItems;
	};
	nil;
} count _this;

true;
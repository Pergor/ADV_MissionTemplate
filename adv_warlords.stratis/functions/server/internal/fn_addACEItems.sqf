/*
 * Author: Belbo
 *
 * Adds ace items to a crate or vehicle. Local variables have to be defined within script that calls this function.
 *
 * Arguments:
 * Array of vehicles - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [MRAP_1, MRAP_2, ..., MRAP_n] call adv_fnc_addACEItems;
 *
 * Public: Yes
 */

if !(isServer && (isClass(configFile >> "CfgPatches" >> "ACE_common"))) exitWith {};

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

{
	private _target = _x;
	if (isClass(configFile >> "CfgPatches" >> "ACE_medical")) then {
		call {
			if ( (missionnamespace getVariable ["ace_medical_level",2]) > 1 ) exitWith {
				if (!isNil "_ACE_fieldDressing") then {	_target addItemCargoGlobal ["ACE_fieldDressing", _ACE_fieldDressing]; };
				if (!isNil "_ACE_elasticBandage") then { _target addItemCargoGlobal ["ACE_elasticBandage", _ACE_elasticBandage]; };
				if (!isNil "_ACE_packingBandage") then { _target addItemCargoGlobal ["ACE_packingBandage", _ACE_packingBandage]; };
				if (!isNil "_ACE_quikclot") then { _target addItemCargoGlobal ["ACE_quikclot", _ACE_quikclot]; };
				if (!isNil "_ACE_morphine") then { _target addItemCargoGlobal ["ACE_morphine", _ACE_morphine]; };
				if (!isNil "_ACE_epinephrine") then { _target addItemCargoGlobal ["ACE_epinephrine", _ACE_epinephrine]; };
				if (!isNil "_ACE_atropine") then { _target addItemCargoGlobal ["ACE_atropine", _ACE_atropine]; };
				if (!isNil "_ACE_adenosine") then { _target addItemCargoGlobal ["ACE_adenosine", _ACE_adenosine]; };
				if (!isNil "_ACE_tourniquet") then { _target addItemCargoGlobal ["ACE_tourniquet", _ACE_tourniquet]; };
				if (!isNil "_ACE_bloodIV") then { _target addItemCargoGlobal ["ACE_bloodIV", _ACE_bloodIV]; };
				if (!isNil "_ACE_bloodIV_500") then { _target addItemCargoGlobal ["ACE_bloodIV_500", _ACE_bloodIV_500]; };
				if (!isNil "_ACE_bloodIV_250") then { _target addItemCargoGlobal ["ACE_bloodIV_250", _ACE_bloodIV_250]; };
				if (!isNil "_ACE_plasmaIV") then { _target addItemCargoGlobal ["ACE_plasmaIV", _ACE_plasmaIV]; };
				if (!isNil "_ACE_plasmaIV_500") then { _target addItemCargoGlobal ["ACE_plasmaIV_500", _ACE_plasmaIV_500]; };
				if (!isNil "_ACE_plasmaIV_250") then { _target addItemCargoGlobal ["ACE_plasmaIV_250", _ACE_plasmaIV_250]; };
				if (!isNil "_ACE_salineIV") then { _target addItemCargoGlobal ["ACE_salineIV", _ACE_salineIV]; };
				if (!isNil "_ACE_salineIV_500") then { _target addItemCargoGlobal ["ACE_salineIV_500", _ACE_salineIV_500]; };
				if (!isNil "_ACE_salineIV_250") then { _target addItemCargoGlobal ["ACE_salineIV_250", _ACE_salineIV_250]; };
				if (!isNil "_ACE_personalAidKit") then { _target addItemCargoGlobal ["ACE_personalAidKit", _ACE_personalAidKit]; };
				if (!isNil "_ACE_surgicalKit" && (missionnamespace getVariable ["ace_medical_enableAdvancedWounds",false])) then { _target addItemCargoGlobal ["ACE_surgicalKit", _ACE_surgicalKit]; };
				if (!isNil "_ACE_advACEsplint_splint" && isClass(configFile >> "CfgWeapons" >> "adv_aceSplint_splint") && !(missionnamespace getVariable ["ace_medical_healHitPointAfterAdvBandage",true]) ) then {
					_target addItemCargoGlobal ["adv_aceSplint_splint",_ACE_advACEsplint_splint];
				};
				if (!isNil "_adv_aceCPR_AED" && isClass(configFile >> "CfgWeapons" >> "adv_aceCPR_AED")) then {
					_target addItemCargoGlobal ["adv_aceCPR_AED",_adv_aceCPR_AED];
				};
			};
			_target addItemCargoGlobal ["ACE_fieldDressing", _ACE_fieldDressing+_ACE_elasticBandage+_ACE_packingBandage+_ACE_quikclot];
			_target addItemCargoGlobal ["ACE_bloodIV", _ACE_bloodIV+_ACE_plasmaIV+_ACE_salineIV];
			_target addItemCargoGlobal ["ACE_bloodIV_500", _ACE_bloodIV_500+_ACE_plasmaIV_500+_ACE_salineIV_500];
			_target addItemCargoGlobal ["ACE_bloodIV_250", _ACE_bloodIV_250+_ACE_plasmaIV_250+_ACE_salineIV_250];
			_target addItemCargoGlobal ["ACE_morphine", _ACE_morphine];
			_target addItemCargoGlobal ["ACE_epinephrine", _ACE_epinephrine];
		};
		if (!isNil "_ACE_bodyBag") then { _target addItemCargoGlobal ["ACE_bodyBag", _ACE_bodyBag]; };
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_hearing") && !isNil "_ACE_EarPlugs") then {
		_target addItemCargoGlobal ["ACE_EarPlugs", _ACE_EarPlugs];
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_overheating") && !isNil "_ACE_SpareBarrel") then {
		_target addItemCargoGlobal ["ACE_SpareBarrel", _ACE_SpareBarrel];
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_logistics_uavbattery") && !isNil "_ACE_UAVBattery") then {
		_target addItemCargoGlobal ["ACE_UAVBattery", _ACE_UAVBattery];
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_sandbag") && !isNil "_ACE_sandbag") then {
		//_target addItemCargoGlobal ["ACE_Sandbag_empty", _ACE_sandbag];
	};	
	if (isClass(configFile >> "CfgPatches" >> "ACE_logistics_wirecutter") && !isNil "_ACE_wirecutter") then {
		_target addItemCargoGlobal ["ACE_wirecutter", _ACE_wirecutter];
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_explosives")) then {
		if (!isNil "_ACE_clacker") then { _target addItemCargoGlobal ["ACE_clacker", _ACE_clacker]; };
		if (!isNil "_ACE_M26_clacker") then { _target addItemCargoGlobal ["ACE_M26_clacker", _ACE_M26_clacker]; };
		if (!isNil "_ACE_DefusalKit") then { _target addItemCargoGlobal ["ACE_DefusalKit", _ACE_DefusalKit]; };
		if (!isNil "_ACE_Cellphone") then { _target addItemCargoGlobal ["ACE_Cellphone", _ACE_Cellphone]; };
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_maptools") && !isNil "_ACE_MapTools") then {
		_target addItemCargoGlobal ["ACE_maptools", _ACE_MapTools];
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_captives") && !isNil "_ACE_CableTie") then {
		_target addItemCargoGlobal ["ACE_CableTie", _ACE_CableTie];
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_kestrel4500") && !isNil "_ACE_kestrel") then {
		_target addItemCargoGlobal ["ACE_kestrel4500", _ACE_kestrel];
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_ATragMX") && !isNil "_ACE_ATragMX") then {
		_target addItemCargoGlobal ["ACE_ATragMX", _ACE_ATragMX];
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_rangecard") && !isNil "_ACE_rangecard") then {
		_target addItemCargoGlobal ["ACE_rangecard", _ACE_rangecard];
	};
	if (_par_Tablets == 2) then {
		if (isClass(configFile >> "CfgPatches" >> "ACE_microDAGR") && !isNil "_ACE_microDAGR") then {
			_target addItemCargoGlobal ["ACE_microDAGR", _ACE_microDAGR];
		};
		if (isClass(configFile >> "CfgPatches" >> "ACE_DAGR") && !isNil "_ACE_DAGR") then {
			_target addItemCargoGlobal ["ACE_DAGR", _ACE_DAGR];
		};
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_mk6mortar") && !isNil "_ACE_RangeTable_82mm") then {
		_target addItemCargoGlobal ["ACE_RangeTable_82mm", _ACE_RangeTable_82mm];
	};
	if (!isNil "_ACE_rangefinder") then {
		if (!isNil "ADV_par_NVGs") then {
			call {
				if ( isClass(configFile >> "CfgPatches" >> "ACE_vector") ) exitWith {
					if (_par_NVGs > 0 || _par_opfNVGs > 0) exitWith {
						_target addItemCargoGlobal ["ACE_vector", _ACE_rangefinder];
					};
					_target addItemCargoGlobal ["ACE_VectorDay", _ACE_rangefinder];
				};
				if ( isClass(configFile >> "CfgPatches" >> "ACE_yardage450") ) exitWith {
					_target addItemCargoGlobal ["ACE_yardage450", _ACE_rangefinder];
				};
			};
		} else {
			if (isClass(configFile >> "CfgPatches" >> "ACE_vector")) then {
				_target addItemCargoGlobal ["ACE_vector", _ACE_rangefinder];
			};	
		};
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_parachute")) then {
		if (!isNil "_ACE_altimeter") then { _target addItemCargoGlobal ["ACE_Altimeter", _ACE_altimeter]; };
		if (!isNil "_ACE_NonSteerableParachute") then { _target addBackpackCargoGlobal ["ACE_NonSteerableParachute", _ACE_NonSteerableParachute]; };
	};
	if (isClass (configFile >> "CfgPatches" >> "ACE_attach") && !isNil "_ACE_IR_Strobe") then {
		if (!isNil "ADV_par_NVGs") then {
			if (_par_NVGs == 2) then {
				_target addItemCargoGlobal ["ACE_IR_Strobe_Item", _ACE_IR_Strobe];
			};
		} else {
			_target addItemCargoGlobal ["ACE_IR_Strobe_Item", _ACE_IR_Strobe];
		};
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_grenades")) then {
		if (!isNil "_ACE_HandFlare_Green") then {  _target addMagazineCargoGlobal ["ACE_HandFlare_Green", _ACE_HandFlare_Green]; };
		if (!isNil "_ACE_HandFlare_Red") then { _target addMagazineCargoGlobal ["ACE_HandFlare_Red", _ACE_HandFlare_Red]; };
		if (!isNil "_ACE_HandFlare_White") then { _target addMagazineCargoGlobal ["ACE_HandFlare_White", _ACE_HandFlare_White]; };
		if (!isNil "_ACE_HandFlare_Yellow") then { _target addMagazineCargoGlobal ["ACE_HandFlare_Yellow", _ACE_HandFlare_Yellow]; };
		if (!isNil "_ACE_M84") then { _target addMagazineCargoGlobal ["ACE_M84", _ACE_M84]; };
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_vehicleLock")) then {
		if (!isNil "_ACE_key_west") then { _target addItemCargoGlobal ["ACE_key_west", _ACE_key_west]; };
		if (!isNil "_ACE_key_east") then { _target addItemCargoGlobal ["ACE_key_east", _ACE_key_east]; };
		if (!isNil "_ACE_key_indp") then { _target addItemCargoGlobal ["ACE_key_indp", _ACE_key_indp]; };
		if (!isNil "_ACE_key_civ") then { _target addItemCargoGlobal ["ACE_key_civ", _ACE_key_civ]; };
		if (!isNil "_ACE_key_master") then { _target addItemCargoGlobal ["ACE_key_master", _ACE_key_master]; };
		if (!isNil "_ACE_key_lockpick") then { _target addItemCargoGlobal ["ACE_key_lockpick", _ACE_key_lockpick]; };
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_tacticalladder") && !isNil "_ACE_tacticalLadder") then {
		_target addBackpackCargoGlobal ["ACE_TacticalLadder_Pack",_ACE_tacticalLadder];
	};
	if ( isClass(configFile >> "CfgPatches" >> "ACE_trenches") && !isNil "_ACE_EntrenchingTool" ) then {
		_target addItemCargoGlobal ["ACE_EntrenchingTool", _ACE_EntrenchingTool];
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_tagging")) then {
		if (!isNil "_ACE_sprayPaintBlack") then { _target addItemCargoGlobal ["ACE_sprayPaintBlack", _ACE_sprayPaintBlack]; };
		if (!isNil "_ACE_sprayPaintBlue") then { _target addItemCargoGlobal ["ACE_sprayPaintBlue", _ACE_sprayPaintBlue]; };
		if (!isNil "_ACE_sprayPaintGreen") then { _target addItemCargoGlobal ["ACE_sprayPaintGreen", _ACE_sprayPaintGreen]; };
		if (!isNil "_ACE_sprayPaintRed") then { _target addItemCargoGlobal ["ACE_sprayPaintRed", _ACE_sprayPaintRed]; };
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_tagging")) then {
		if (!isNil "_ACE_gunbag") then {
			_target addBackpackCargoGlobal ["ACE_gunbag_tan", _ACE_gunbag];
		};
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_minedetector")) then {
		if (!isNil "_ACE_minedetector") then {
			_target addWeaponCargoGlobal ["ACE_VMH3", _ACE_minedetector];
		};
	};
	nil;
} count _this;

true;
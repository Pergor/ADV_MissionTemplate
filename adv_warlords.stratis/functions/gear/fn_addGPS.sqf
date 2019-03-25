/*
 * Author: Belbo
 *
 * Adds GPS items to to unit depending on adv_missiontemplate-variables - has to be called by adv_fnc_gear;
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [player] call adv_fnc_addGPS;
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

//gps is being removed as long it's not supposed to be in Inventory.
if ( _par_Tablets isEqualTo 99 ) exitWith { false };
private _removeGPS = {
	params ["_unit"];
	_unit unlinkItem "ItemGPS";_unit removeItems "ItemGPS";
};

if ( (side (group _unit) isEqualTo independent && (_par_indWeap isEqualTo 21 || _par_indUni isEqualTo 20))
|| 	{ side (group _unit) isEqualTo west && (_par_customUni isEqualTo 9) }
|| 	{ side (group _unit) isEqualTo east && (_par_opfWeap isEqualTo 2 || _par_opfUni isEqualTo 5 || _par_opfUni isEqualTo 6) } 
) exitWith { _unit unlinkItem "ItemGPS";_unit removeItems "ItemGPS"; false; };
//cTab-specials:
call {
	if ( _par_Tablets isEqualTo 1 && isClass (configFile >> "CfgPatches" >> "cTab") ) exitWith {
		[_unit] call _removeGPS;
		call {
			if ( _uavTisGiven ) exitWith {
				if ( _tablet ) then {_unit addItem "ItemcTab"};
				if ( _androidDevice ) then {_unit addItem "ItemAndroid";};
				if ( _microDagr) then {_unit addItem "ItemMicroDAGR";};
			};
			if ( _tablet ) exitWith {
				_unit linkItem "ItemcTab";
				if ( _androidDevice ) then {_unit addItem "ItemAndroid";};
				if ( _microDagr) then {_unit addItem "ItemMicroDAGR";};
			};
			if ( _androidDevice ) exitWith {
				_unit linkItem "ItemAndroid";
				if ( _microDagr) then {_unit addItem "ItemMicroDAGR";};
			};
			if ( _microDagr) exitWith {_unit linkItem "ItemMicroDAGR";};
		};
		if ( _helmetCam ) then { _unit addItem "ItemcTabHCam" };
	};

	//ace DAGRs:
	if ( _par_Tablets isEqualTo 2 ) exitWith {
		[_unit] call _removeGPS;
		if (isClass(configFile >> "CfgPatches" >> "ACE_microDAGR") && !isNil "_ACE_microDAGR") then {
			if (_ACE_microDAGR > 0) then { _unit addItem "ACE_microDAGR"; };
		};
		if (isClass(configFile >> "CfgPatches" >> "ACE_DAGR") && !isNil "_ACE_DAGR") then {
			if (_ACE_DAGR > 0) then { _unit addItem "ACE_DAGR"; };
		};
	};

	//BWmod Navipad
	if ( _par_Tablets isEqualTo 3 && isClass(configFile >> "CfgPatches" >> "bwa3_navipad") ) exitWith {
		[_unit] call _removeGPS;
		call {
			if !(_uavTisGiven) exitWith {
				_unit linkItem "BWA3_ItemNaviPad";
			};
			_unit addItem "BWA3_ItemNaviPad";
		};
	};
};
true;
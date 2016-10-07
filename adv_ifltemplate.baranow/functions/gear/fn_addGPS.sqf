/*
fn_addGPS: adds selected GPS to a unit.
call like this:
[_unit] call ADV_fnc_addGPS;
*/

params [
	["_unit", player, [objNull]]
];

//gps is being removed as long it's not supposed to be in Inventory.
if !( ADV_par_Tablets == 99 ) then {
	_unit unlinkItem "ItemGPS";_unit removeItems "ItemGPS";
};
//cTab-specials:
if ( ADV_par_Tablets == 1 && isClass (configFile >> "CfgPatches" >> "cTab") ) exitWith {
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
if (ADV_par_Tablets == 2) exitWith {
	if (isClass(configFile >> "CfgPatches" >> "ACE_microDAGR") && !isNil "_ACE_microDAGR") then {
		if (_ACE_microDAGR > 0) then { _unit addItem "ACE_microDAGR"; };
	};
	if (isClass(configFile >> "CfgPatches" >> "ACE_DAGR") && !isNil "_ACE_DAGR") then {
		if (_ACE_DAGR > 0) then { _unit addItem "ACE_DAGR"; };
	};
};

//BWmod Navipad
if ( ADV_par_Tablets == 3 && isClass(configFile >> "CfgPatches" >> "bwa3_navipad") ) exitWith {
	call {
		if !(_uavTisGiven) exitWith {
			_unit linkItem "BWA3_ItemNaviPad";
		};
		_unit addItem "BWA3_ItemNaviPad";
	};
};

nil;
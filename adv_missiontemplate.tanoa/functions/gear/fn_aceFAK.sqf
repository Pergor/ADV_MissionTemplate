/*
ADV_fnc_aceFAK by Belbo:

Adds a predefined amount of ace_medical-items to a unit.

Possible call - has to be executed on the client the unit is local to:

[player,1] call ADV_fnc_aceFAK;

_this select 0 = unit to add items to.
_this select 1 = set of items (1 - small amount (soldier's individual pack); 2 - large amount (medic equipment);)
*/

if !( isClass(configFile >> "CfgPatches" >> "ACE_medical") ) exitWith {};

params [
	["_unit", player, [objNull]],
	["_FAKtype", 1, [0]],
	"_ACE_Items","_ACE_fieldDressing","_ACE_packingBandage","_ACE_elasticBandage","_ACE_quikclot","_ACE_morphine","_ACE_tourniquet",
	"_ACE_epinephrine","_ACE_salineIV","_ACE_salineIV_500","_ACE_salineIV_250","_ACE_surgicalKit","_ACE_personalAidKit","_medicBack",
	"_ACE_bloodIV","_ACE_bloodIV_500","_ACE_bloodIV_250"
];

_ACE_Items = ["ACE_atropine","ACE_adenosine","ACE_fieldDressing","ACE_elasticBandage","ACE_quikclot","ACE_bloodIV","ACE_bloodIV_500","ACE_bloodIV_250","ACE_bodyBag","ACE_epinephrine","ACE_morphine","ACE_packingBandage","ACE_personalAidKit","ACE_plasmaIV","ACE_plasmaIV_500","ACE_plasmaIV_250","ACE_salineIV","ACE_salineIV_500","ACE_salineIV_250","ACE_surgicalKit","ACE_tourniquet"];
{ _unit removeItems _x } forEach _ACE_Items;

switch _FAKtype do {
	default {
		if ( (missionnamespace getVariable ["ace_medical_level",2]) > 1 ) then {
			_ACE_fieldDressing = 4;
			_ACE_elasticBandage = 4;
			_ACE_packingBandage = 6;
			_ACE_quikclot = 6;
			_ACE_morphine = 2;
			_ACE_tourniquet = 2;

			for "_i" from 1 to _ACE_fieldDressing do { _unit addItem "ACE_fieldDressing"; };
			for "_i" from 1 to _ACE_elasticBandage do { _unit addItem "ACE_elasticBandage"; };
			for "_i" from 1 to _ACE_packingBandage do { _unit addItem "ACE_packingBandage"; };
			for "_i" from 1 to _ACE_quikclot do { _unit addItem "ACE_quikclot"; };

			for "_i" from 1 to _ACE_morphine do { _unit addItem "ACE_morphine"; };

			for "_i" from 1 to _ACE_tourniquet do { _unit addItem "ACE_tourniquet"; };
		} else {
			_ACE_fieldDressing = 12;
			_ACE_morphine = 2;

			for "_i" from 1 to _ACE_fieldDressing do { _unit addItem "ACE_fieldDressing"; };
			for "_i" from 1 to _ACE_morphine do { _unit addItem "ACE_morphine"; };
		};
	};
	case 2: {
		if ( (missionnamespace getVariable ["ace_medical_level",2]) > 1 || (missionnamespace getVariable ["ace_medical_medicSetting",2]) > 1 ) then {
			_ACE_fieldDressing = 18;
			_ACE_elasticBandage = 18;
			_ACE_packingBandage = 36;
			_ACE_quikclot = 36;
			_ACE_atropine = 0;
			_ACE_adenosine = 10;
			_ACE_epinephrine = 12;
			_ACE_morphine = 12;
			_ACE_tourniquet = 6;
			_ACE_salineIV = 0;
			_ACE_salineIV_500 = 12;
			_ACE_salineIV_250 = 0;
			_ACE_personalAidKit = 1;
			if ( (missionnamespace getVariable ["ace_medical_consumeItem_PAK",0]) > 0 ) then {
				_ACE_personalAidKit = 4;
			};
			_ACE_surgicalKit = 1;
			if ( (missionnamespace getVariable ["ace_medical_consumeItem_SurgicalKit",0]) > 0 ) then {
				_ACE_surgicalKit = 4;
			};
			
			if !(_backpack == "") then {
				_mediBack = unitBackpack _unit;
				
				if ( missionnamespace getVariable ["ace_medical_enableAdvancedWounds",true] ) then {
					for "_i" from 1 to _ACE_surgicalKit do { _unit addItem "ACE_surgicalKit"; };
				};
				for "_i" from 1 to _ACE_personalAidKit do { _unit addItem "ACE_personalAidKit"; };
				
				_mediBack addItemCargoGlobal ["ACE_fieldDressing", _ACE_fieldDressing];
				_mediBack addItemCargoGlobal ["ACE_elasticBandage", _ACE_elasticBandage];
				_mediBack addItemCargoGlobal ["ACE_packingBandage", _ACE_packingBandage];
				_mediBack addItemCargoGlobal ["ACE_quikclot", _ACE_quikclot];
				
				_mediBack addItemCargoGlobal ["ACE_morphine", _ACE_morphine];
				_mediBack addItemCargoGlobal ["ACE_epinephrine", _ACE_epinephrine];
				_mediBack addItemCargoGlobal ["ACE_adenosine", _ACE_adenosine];
				_mediBack addItemCargoGlobal ["ACE_atropine", _ACE_atropine];
				_mediBack addItemCargoGlobal ["ACE_tourniquet", _ACE_tourniquet];
				
				_mediBack addItemCargoGlobal ["ACE_salineIV", _ACE_salineIV];
				_mediBack addItemCargoGlobal ["ACE_salineIV_500", _ACE_salineIV_500];
				_mediBack addItemCargoGlobal ["ACE_salineIV_250", _ACE_salineIV_250];
				
			} else {
				for "_i" from 1 to _ACE_fieldDressing do { _unit addItem "ACE_fieldDressing"; };
				for "_i" from 1 to _ACE_elasticBandage do { _unit addItem "ACE_elasticBandage"; };
				for "_i" from 1 to _ACE_packingBandage do { _unit addItem "ACE_packingBandage"; };
				for "_i" from 1 to _ACE_quikclot do { _unit addItem "ACE_quikclot"; };
				
				for "_i" from 1 to _ACE_morphine do { _unit addItem "ACE_morphine";};
				for "_i" from 1 to _ACE_epinephrine do { _unit addItem "ACE_epinephrine"; };
				for "_i" from 1 to _ACE_adenosine do { _unit addItem "ACE_adenosine"; };
				for "_i" from 1 to _ACE_atropine do { _unit addItem "ACE_atropine"; };
				
				for "_i" from 1 to _ACE_tourniquet do { _unit addItem "ACE_tourniquet"; };
				
				for "_i" from 1 to _ACE_salineIV do { _unit addItem "ACE_salineIV"; };
				for "_i" from 1 to _ACE_salineIV_500 do { _unit addItem "ACE_salineIV_500"; };
				for "_i" from 1 to _ACE_salineIV_250 do { _unit addItem "ACE_salineIV_250"; };
				
				if ( missionnamespace getVariable ["ace_medical_enableAdvancedWounds",true] ) then {
					for "_i" from 1 to _ACE_surgicalKit do { _unit addItem "ACE_surgicalKit"; };
				};
				for "_i" from 1 to _ACE_personalAidKit do { _unit addItem "ACE_personalAidKit"; };	
			};
		} else {
			_ACE_fieldDressing = 64;
			_ACE_epinephrine = 12;
			_ACE_morphine = 12;
			_ACE_bloodIV = 0;
			_ACE_bloodIV_500 = 8;
			_ACE_bloodIV_250 = 8;
			
			if !(_backpack == "") then {
				_mediBack = unitBackpack _unit;
				_mediBack addItemCargoGlobal ["ACE_fieldDressing", _ACE_fieldDressing];
				
				_mediBack addItemCargoGlobal ["ACE_morphine", _ACE_morphine];
				_mediBack addItemCargoGlobal ["ACE_epinephrine", _ACE_epinephrine];
				
				_mediBack addItemCargoGlobal ["ACE_bloodIV", _ACE_bloodIV];
				_mediBack addItemCargoGlobal ["ACE_bloodIV_500", _ACE_bloodIV_500];
				_mediBack addItemCargoGlobal ["ACE_bloodIV_250", _ACE_bloodIV_250];
			} else {
				for "_i" from 1 to _ACE_fieldDressing do { _unit addItem "ACE_fieldDressing"; };
				for "_i" from 1 to _ACE_morphine do { _unit addItem "ACE_morphine";};
				for "_i" from 1 to _ACE_epinephrine do { _unit addItem "ACE_epinephrine"; };
				
				for "_i" from 1 to _ACE_bloodIV do { _unit addItem "ACE_bloodIV"; };
				for "_i" from 1 to _ACE_bloodIV_500 do { _unit addItem "ACE_bloodIV_500"; };
				for "_i" from 1 to _ACE_bloodIV_250 do { _unit addItem "ACE_bloodIV_250"; };		
			};		
		};
	};
};

true;
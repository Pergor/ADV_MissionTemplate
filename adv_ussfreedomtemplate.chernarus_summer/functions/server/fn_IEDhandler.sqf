/*
 * Author: Belbo
 *
 * Changes editor placed IEDs into ACE³ IEDs with pressure plate detonator that might be defused by players.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [] call adv_fnc_IEDhandler;
 *
 * Public: Yes
 */

if !(isClass(configFile >> "CfgPatches" >> "ace_explosives")) exitWith {};

{
	if ( [typeOf _x,0,2] call BIS_fnc_trimString == "IED" || [typeOf _x,0,6] call BIS_fnc_trimString == "CUP_IED" ) then {
		private _mine = _x;
		private _pos = getPosATL _mine;
		private _vector = [vectorDir _mine,vectorUp _mine];
		private _type = toUpper (typeOf _mine);
		_replacementType = call {
			if ( _type isEqualTo "IEDLANDBIG_REMOTE_AMMO" ) exitWith { "ACE_IEDLANDBIG_RANGE" };
			if ( _type isEqualTo "IEDLANDSMALL_REMOTE_AMMO" || _type isEqualTo "CUP_IED_V3_AMMO" ) exitWith { "ACE_IEDLANDSMALL_RANGE" };
			if ( _type isEqualTo "IEDURBANBIG_REMOTE_AMMO" || _type isEqualTo "CUP_IED_V2_AMMO"  || _type isEqualTo "CUP_IED_V4_AMMO" ) exitWith { "ACE_IEDURBANBIG_RANGE" };
			if ( _type isEqualTo "IEDURBANSMALL_REMOTE_AMMO" || _type isEqualTo "CUP_IED_V1_AMMO" ) exitWith { "ACE_IEDURBANSMALL_RANGE" };
			"";
		};
		private _height = call {
			if ( toUpper _replacementType isEqualTo "ACE_IEDLANDBIG_RANGE"  ) exitWith { -0.115 };
			if ( toUpper _replacementType isEqualTo "ACE_IEDURBANBIG_RANGE"  ) exitWith { -0.025 };
			if ( toUpper _replacementType isEqualTo "ACE_IEDLANDSMALL_RANGE" ) exitWith { -0.115 };
			if ( toUpper _replacementType isEqualTo "ACE_IEDURBANSMALL_RANGE" ) exitWith { -0.008 };
			0
		};
		if !( _replacementType isEqualTo "" ) then {
			deleteVehicle _mine;
			_new = createMine [_replacementType, _pos, [], 0];
			_new setPosATL [_pos select 0, _pos select 1, _height];
			_new setVectorDirAndUp _vector;
			_new enableDynamicSimulation true;
		};
	};
	nil;
} count allMines;

true;
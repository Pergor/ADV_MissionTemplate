/*
 * Author: Belbo
 *
 * Raises the probability for jamming if a player picks up an enemy's weapon.
 * Won't be applied to INDFOR-players.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Has evh been added? - <BOOL>
 *
 * Example:
 * call adv_fnc_jamChance;
 *
 * Public: No
 */
 
private _side = side (group player);
if ( _side isEqualTo independent ) exitWith { false };

//base variable:
player setVariable ["adv_jc_hasWrongWeapon",false,true];

//forbidden and allowed weapons (important if players and enemies use same weapons):
private _varForbidden = format ["adv_jc_forbiddenWeapons_%1",_side];
private _varAllowed = format ["adv_jc_allowedWeapons_%1",_side];
private _forbiddenWeapons = missionNamespace getVariable [_varForbidden,[]];
private _allowedWeapons = missionNamespace getVariable [_varAllowed,["ARIFLE_SDAR_F","LMG_MK200_F","SRIFLE_EBR_F","LMG_03_F","SMG_05_F"]];
/*
//set up arrays for some modded weapons (with weird inheritances):
if ( _side isEqualTo west ) then {
	if ( isClass(configFile >> "CfgPatches" >> "rhsusaf_main") ) then {
		_allowedWeapons append ["rhs_weap_m4_Base","rhs_weap_saw_base","rhs_weap_M249_base","rhs_weap_m14ebrri","rhs_weap_M107_Base_F","rhs_weap_M590_5RD","rhs_weap_m32_Base_F","rhs_weap_M230"];
	};
};
if ( _side isEqualTo east ) then {
	if ( isClass(configFile >> "CfgPatches" >> "rhs_main") ) then {
		_allowedWeapons append ["rhs_weap_ak74m_Base_F","rhs_pkp_base"];
	};
};
*/

missionNamespace setVariable [_varForbidden,_forbiddenWeapons];
missionNamespace setVariable [_varAllowed,_allowedWeapons];

//weapons of side will be added to the allowed weapons after 60 seconds:
[{time > 30},{
	//get var names:
	private _side = side (group player);
	private _varForbidden = format ["adv_jc_forbiddenWeapons_%1",_side];
	private _varAllowed = format ["adv_jc_allowedWeapons_%1",_side];
	//get arrays:
	private _forbiddenWeapons = missionNamespace getVariable [_varForbidden,[]];
	private _allowedWeapons = missionNamespace getVariable [_varAllowed,[]];
	private _playerWeapon = toUpper ([primaryWeapon player] call adv_fnc_getBaseClass);
	private _playerWeapons = ( allPlayers select { (side (group _x)) isEqualTo _side && !(_x getVariable ["adv_jc_hasWrongWeapon",false]) } ) apply { [primaryWeapon _x] call adv_fnc_getBaseClass; };
	//add weapons to arrays:
	_allowedWeapons pushBackUnique _playerWeapon;
	private _forcedWeapons = _allowedWeapons arrayIntersect _forbiddenWeapons;
	{
		private _upperClass = toUpper _x;
		
		if !(_upperClass in _forbiddenWeapons || _upperClass in _forcedWeapons) then {
			_allowedWeapons pushBackUnique _upperClass;
		};
		nil;
	} count _playerWeapons;
	
	missionNamespace setVariable [_varAllowed,_allowedWeapons,true];
}] call cba_fnc_waitUntilAndExecute;

//code for the entity killed-evh:
adv_jamchance_scriptfnc_killedCode = {
	params ["_killed", "_killer", "_instigator"];
	//get vars:
	private _side = side (group player);
	private _varForbidden = format ["adv_jc_forbiddenWeapons_%1",_side];
	private _varAllowed = format ["adv_jc_allowedWeapons_%1",_side];
	//get arrays:
	private _forbiddenWeapons = missionNamespace getVariable [_varForbidden,[]];
	private _allowedWeapons = missionNamespace getVariable [_varAllowed,[]];
	
	_condition = ( (side (group _killed)) isEqualTo (side (group player)) );
	if !( _condition ) exitWith {
		private _baseClass = [(primaryWeapon _killed)] call adv_fnc_getBaseClass;
		private _upperClass = toUpper _baseClass;
		if ( _upperClass in _allowedWeapons ) exitWith {};
		_forbiddenWeapons pushBackUnique _upperClass;
		missionNamespace setVariable [_varForbidden,_forbiddenWeapons,true];
	};
};

//executes code every time someone is being killed - possibly adding his weapon to the forbidden weapons:
adv_evh_jamchance_entitykilled = addMissionEventHandler [
	"EntityKilled", {
		_this call adv_jamchance_scriptfnc_killedCode;
	}
];

//script fnc that adds and removes the evh if the new weapon is wrong:
adv_jamchance_scriptfnc_addEVH = {
	adv_jamchance_evh_fired = player addEventhandler ["fired", {
		params ["_unit","_weapon","_muzzle","_mode","_ammo","_magazine"];
		if (floor random 20 < 1) then {
			[_unit, currentWeapon _unit] call ace_overheating_fnc_jamWeapon;
		};
	}];
	[ { !(player getVariable ["adv_jc_hasWrongWeapon",false]) }, {
		player removeEventHandler ["fired",adv_jamchance_evh_fired];
		["You now have taken a weapon from your side again.", 2] call ace_common_fnc_displayTextStructured;
	}, []] call CBA_fnc_waitUntilAndExecute;
};

//player eventhandler:
[
	"weapon",
	{
		params ["_unit","_newSelectedWeapon"];
		//exit, if new weapon isn't his primary weapon:
		if !( _newSelectedWeapon isEqualTo (primaryWeapon _unit) ) exitWith {};
		//get var names:
		private _side = side (group _unit);
		private _varForbidden = format ["adv_jc_forbiddenWeapons_%1",_side];
		private _varAllowed = format ["adv_jc_allowedWeapons_%1",_side];
		//get arrays:
		private _forbiddenWeapons = missionNamespace getVariable [_varForbidden,[]];
		private _allowedWeapons = missionNamespace getVariable [_varAllowed,[]];
		private _forcedWeapons = _forbiddenWeapons arrayIntersect _allowedWeapons;
		//get if weapon is either forbidden or allowed:
		private _wrongWeapon = { (currentWeapon _unit) isKindOf [_x, configFile >> "CfgWeapons"] } count _forbiddenWeapons;
		private _rightWeapon = { (currentWeapon _unit) isKindOf [_x, configFile >> "CfgWeapons"] } count _forcedWeapons;
		//execute evh if weapon is wrong:
		if ( _wrongWeapon > 0 && _rightWeapon isEqualTo 0 ) then {
			_unit setVariable ["adv_jc_hasWrongWeapon",true,true];
			call adv_jamchance_scriptfnc_addEVH;
			["You have taken an enemy's weapon.<br/>Beware, they often misfire!", 2.5] call ace_common_fnc_displayTextStructured;
		} else {
			_unit setVariable ["adv_jc_hasWrongWeapon",false,true];
			//add weapons to arrays:
			private _playerWeapon = toUpper ([primaryWeapon _unit] call adv_fnc_getBaseClass);
			_allowedWeapons pushBackUnique _playerWeapon;
			missionNamespace setVariable [_varAllowed,_allowedWeapons,true];
		};
	}
] call CBA_fnc_addPlayerEventHandler;

true;
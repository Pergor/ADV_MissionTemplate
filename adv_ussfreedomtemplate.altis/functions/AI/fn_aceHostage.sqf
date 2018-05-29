/*
 * Author: Belbo
 *
 * Makes a unit a hostage. The unit will have unit getVariable "adv_aceHostage_isHostage" set to true as long as it's a hostage.
 * Will automaticalle revert to !(unit getVariable "adv_aceHostage_isHostage") if hostage has been brought to the safe location.
 * The amount of hostages that have been killed can be counted with missionNamespace getVariable "adv_aceHostage_dead".
 *
 * Arguments:
 * 0: target - <OBJECT>
 * 1: safe location to which the hostage has to be brought - <OBJECT>, <POSITION>, <MARKER>
 * 2: Radius around safe location in which the hostage can go (optional) - <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [hostage_1,"respawn_west",10] call adv_fnc_aceHostage;
 *
 * Public: Yes
 */
 
if ( (!isServer && hasInterface) || !isClass(configFile >> "CfgPatches" >> "ace_captives") ) exitWith {};

params [
	["_target", objNull, [objNull]]
	,["_safePos", [0,0,0], [[],objNull,""]]
	,["_radius", 10, [0]]
];

if (!local _target) exitWith {
	diag_log format ["%1 has been called with adv_fnc_aceHostage, but %1 is not local to caller.", _target];
};

private _pos = [_safePos] call adv_fnc_getPos;

private _removeWeapons = {
	params [
		["_target", objNull, [objNull]]
	];
	removeAllWeapons _target;
	removeHeadgear _target;
	removeBackpack _target;
	removeGoggles _target;
	{_target unlinkItem _x; nil} count [hmd _target,"ItemRadio","ItemMap","ItemGPS","ItemCompass"];
};

private _condition = {
	params [
		["_target", objNull, [objNull]]
		,["_pos", [0,0,0], [[]]]
		,["_radius", 10, [0]]
	];
	private _inPos = (getPosWorld _target) inArea [_pos, _radius, _radius, 0, false];
	private _return = (_inPos || !(alive _target));
	_return
};

private _statement = {
	params [
		["_target", objNull, [objNull]]
	];
	if !(alive _target) exitWith {
		missionNamespace setVariable ["adv_aceHostage_dead",(missionNamespace getVariable ["adv_aceHostage_dead",0])+1,true];
	};
	_target setVariable ["adv_aceHostage_isHostage",false,true];
};

private _addAction = {
	params [
		["_target", objNull, [objNull]]
	];
	
	private _action = ["adv_aceHostage_action",(format ["Admit %1 to your group",name _target]),"\z\ace\addons\interaction\UI\team\team_management_ca.paa",{
		[_target] joinSilent (group _player);
		[_target,0,["ACE_MainActions","adv_aceHostage_action"]] remoteExec ["ace_interact_menu_fnc_removeActionFromObject",0];
	},{ !((group _target) == (group _player)) }] call ace_interact_menu_fnc_createAction;
	
	[_target , 0, ["ACE_MainActions"],_action] call ace_interact_menu_fnc_addActionToObject;
};

_target call _removeWeapons;
[[_target,_addAction], {(_this select 0) call (_this select 1)}] remoteExec ["call", 0];
[_target, true] call ACE_captives_fnc_setHandcuffed;
_target setVariable ["adv_aceHostage_isHostage",true,true];
missionNamespace setVariable ["adv_aceHostage_dead",(missionNamespace getVariable ["adv_aceHostage_dead",0]),true];

[{_this call (_this select 3)}, {_this call (_this select 4)}, [_target,_pos,_radius,_condition,_statement]] call CBA_fnc_waitUntilAndExecute;

nil
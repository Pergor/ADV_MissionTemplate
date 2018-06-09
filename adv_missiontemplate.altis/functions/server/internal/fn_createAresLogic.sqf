/*
 * Author: Belbo
 *
 * Creates a game logic that can be referenced by custom ares modules.
 * The return array will be appended to adv_var_aresModulesLogics.
 * vehicleVarName OBJECT will be adv_aresLogic_1, adv_aresLogic_2, aresLogic_3 and so on.
 * str OBJECT will be "Location 1", "Location 2", "Location 3" and so on.
 *
 * Arguments:
 * 0: position the logic should be created at. <POSITION>
 *
 * Return Value:
 * created logic - <ARRAY> containing [<OBJECT>,<STRING>]
 *
 * Example:
 * _logicArray = [] call adv_fnc_createAresLogic;
 *
 * Public: Yes
 */
 
params ["_pos",["_grp",grpNull]];

if (isNull _grp) then {
	private _center = createCenter sideLogic;
	_grp = createGroup _center;
	_grp setGroupIDGlobal ["Locations"];
};

//get NR for the new name:
private _baseNr = missionNamespace getVariable ["adv_var_aresLogicName",0];
private _newNr = _baseNr+1;
//raise the counter:
missionNamespace setVariable ["adv_var_aresLogicName",_newNr,true];

//create name str:
private _name = format ["adv_aresLogic_%1",_newNr];
private _str = format ["Location %1",_newNr];

private _logic = [_pos,_str,_grp] call Ares_fnc_CreateLogic;
_logic setVariable ["adv_aresLogic_str",_str];

/*
//create logic:
private _logic = "Land_HelipadEmpty_F" createVehicle _pos;
*/

//change logic's vehicleVarname to adv_aresLogic_##_newNr
[_logic, _name] call adv_fnc_changeUnit;

//create logic array:
private _return = [_logic,_str];
//append logic array to adv_var_aresModulesLogics:
private _logicsArray = missionNamespace getVariable ["adv_var_aresModulesLogics",[[objNull,"No Location"]]];
_logicsArray pushBack _return;
missionNamespace setVariable ["adv_var_aresModulesLogics",_logicsArray, true];

{_x addCuratorEditableObjects [[_logic],true]; nil} count allCurators;

_logic addEventHandler ["deleted", {
	params ["_entity"];
	private _array = [_entity,_entity getVariable "adv_aresLogic_str"];
	private _logicsArray = missionNamespace getVariable "adv_var_aresModulesLogics";
	_logicsArray deleteAt (_logicsArray find _array);
	missionNamespace setVariable ["adv_var_aresModulesLogics",_logicsArray, true];
}];

//return
_return

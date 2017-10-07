/*
 * Author: Belbo
 *
 * Enables or disables all info components on a vehicle unless specifically excluded.
 *
 * Arguments:
 * 0: name of vehicle - <OBJECT>
 * 1: enable/disable component - <BOOL>
 * 2: Info component to exclude - <ARRAY> of <STRINGS>
 *
 * Return Value:
 * Array of disabled/enabled components - <ARRAY>
 *
 * Example:
 * _hiddenComponents = [vehicle player,false,["CrewDisplayComponent"]] call adv_fnc_enableInfoComponent;
 *
 * Public: Yes
 */

params [
	["_target",objNull,[objNull,[]]]
	,["_enable",false,[true]]
	,["_excluded",[],[[]]]
];

private _allComponents = ["MineDetectorDisplayComponent","MinimapDisplayComponent","CrewDisplayComponent","TransportFeedDisplayComponent","SensorsDisplayComponent","SlingLoadDisplayComponent"];
private _components = if (count _excluded > 0) then {_allComponents-_exclude} else {_allComponents};

{_target enableInfoPanelComponent ["left",_x,_enable]; nil;} count _components;
{_target enableInfoPanelComponent ["right",_x,_enable]; nil;} count _components;

_components;
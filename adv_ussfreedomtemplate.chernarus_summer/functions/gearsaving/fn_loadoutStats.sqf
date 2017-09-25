/*
 * Author: Belbo
 *
 * Returns statistic of loadouts for all player units.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Array of player's name, player's unit and loadout in Format [["NAME1",getUnitLoadout player1],["NAME2", getUnitLoadout player2],...]; - <ARRAY>
 *
 * Example:
 * copyToClipboard str (call adv_fnc_loadoutStats);
 *
 * Public: No
 */

private _getLoadoutArray = {
	params ["_unit"];
	private _name = name _unit;
	private _loadout = getUnitLoadout _unit;
	private _return = [_name, _unit, _loadout];
	_return;
};

private _allLoadouts = [];

{
	_allLoadouts pushBack ([_x] call _getLoadoutArray);
	nil;
} count (allPlayers - entities "HeadlessClient_F");

_allLoadouts;
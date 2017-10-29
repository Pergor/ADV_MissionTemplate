/*
 * Author: Belbo
 *
 * Returns classname of a weapon without any attachments (basically it's generic base class).
 *
 * Arguments:
 * 1: weapon - <STRING>
 *
 * Return Value:
 * weapons base class - <STRING>
 *
 * Example:
 * _baseClass = ["arifle_Katiba_ACO_pointer_F"] call adv_fnc_getBaseClass;		//will return "arifle_Katiba_F"
 *
 * Public: No
 */

params [
	["_weapon","",[""]]
];

private _baseCfg = (configFile >> "cfgWeapons");
private _cfg = _baseCfg >> _weapon;
private _hasItems = isClass (_cfg >> "LinkedItems");

while { isClass (_cfg >> "LinkedItems") } do {
	private _parent = configName (inheritsFrom (_cfg));
	private _exitCfg = _cfg;
	if (toUpper _parent in ["RIFLE_LONG_BASE_F","RIFLE_BASE_F","RIFLE"]) exitWith {
		_cfg = _exitCfg;
	};
	_hasItems = isClass (_cfg >> "LinkedItems");
	_cfg = _baseCfg >> _parent;
};

private _return = configname _cfg;

_return;

/*
for "_i" from 1 to 5 do {
	private _hasItems = isClass (_cfg >> "LinkedItems");
	private _hasOptic = isClass (_cfg >> "LinkedItems" >> "LinkedItemsOptic");
	private _hasAcc = isClass (_cfg >> "LinkedItems" >> "LinkedItemsAcc");
	private _hasUnder = isClass (_cfg >> "LinkedItems" >> "LinkedItemsUnd");
	
	if ( _hasItems ) then {
		private _parent = configName (inheritsFrom (_cfg));
		_cfg = _baseCfg >> _parent;
	};
	private _lastStraw = toUpper (configName _cfg);
	if (_lastStraw in ["RIFLE_LONG_BASE_F","RIFLE_BASE_F","RIFLE"]) exitWith {
		_cfg = _startCfg;
	};
};
*/
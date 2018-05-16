/*
ADV-aceRefill - by Belbo
*/

params ["_unit","_item"];

private _toUpper = {
	_this apply {toUpper _x};
};

private _ITEM = toUpper _item;
private _uItems = (uniformItems _unit) call _toUpper;
private _vItems = (vestItems _unit) call _toUpper;
private _bItems = (backpackItems _unit) call _toUpper;
private _assItems = (assignedItems _unit) call _toUpper;
private _allItems = (items _unit) call _toUpper;
private _weapons = (weapons _unit) call _toUpper;

if (_ITEM in _uItems) exitWith {
	[true,"UNIFORM",uniformContainer _unit]
};
if (_ITEM in _vItems) exitWith {
	[true,"VEST",vestContainer _unit]
};
if (_ITEM in _bItems) exitWith {
	[true,"BACKPACK",backpackContainer _unit]
};
if (_ITEM in _assItems) exitWith {
	[true,"ASSIGNED",_unit]
};
if (_ITEM in _weapons) exitWith {
	[true,"WEAPON",_unit]
};
if (_ITEM in _allItems) exitWith {
	[true,"ALL",_unit]
};

[false, "NONE", _unit]

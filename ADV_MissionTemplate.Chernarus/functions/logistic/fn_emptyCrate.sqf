if (isDedicated || !hasInterface) exitWith {};

{
	_target = _x;
	
	ADV_crateEmptyAction = _target addAction [("<t color=""#33FFFF"">" + ("Leere Box ausladen") + "</t>"),{
		_caller = _this select 1;
		_box = createVehicle ["Box_NATO_Ammo_F",getPos _caller,[],0,"CAN_COLLIDE"];
		clearWeaponCargoGlobal _box;clearMagazineCargoGlobal _box;clearBackpackCargoGlobal _box;clearItemCargoGlobal _box;
		if (isClass (configFile >> "CfgPatches" >> "AGM_Interaction")) then {
			[_box,false] call AGM_Drag_fnc_makeDraggable;
		};
	},nil,0.5,false,true,"","player distance cursortarget <5"];
	
} forEach _this;

if (true) exitWith {};
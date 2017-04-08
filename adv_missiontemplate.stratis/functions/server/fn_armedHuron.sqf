/*
 * Author: Belbo
 *
 * Adds HMG to the back ramp of a Huron.
 *
 * Arguments:
 * Arry of hurons - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [huron_1, huron_2, ..., huron_n] call adv_fnc_armedHuron;
 *
 * Public: Yes
 */

if (!isServer) exitWith {};
private ["_huron","_gun"];

{
	//selecting the hmg:
	_turret = "B_HMG_01_F";
	_huron = _x;
	//adding the hmg:
	_gun = createVehicle [_turret, getPos _huron, [], 0, "CAN_COLLIDE"];
	_gun attachto [_huron,[-0.15,-2,-0.8]];
	_gun setdir 180;
	_gun disableTIEquipment true;
	//switch to find the right magazines:
	ADV_fnc_reloadHuronGun = {
			{
				_x removemagazines "40Rnd_20mm_G_belt";
				_x addMagazine "40Rnd_20mm_G_belt";
				_x addMagazine "40Rnd_20mm_G_belt";
				_x addMagazine "40Rnd_20mm_G_belt";
				_x addMagazine "40Rnd_20mm_G_belt";
			} forEach _this;
		};
	//first loadout:
	[_gun] call ADV_fnc_reloadHuronGun;
	//addaction for the continous reloading:
	_gun addaction ["Reload HMG",{[(_this select 0)] call ADV_fnc_reloadHuronGun;}];
} forEach _this;

true;
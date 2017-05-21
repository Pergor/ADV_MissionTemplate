/*
 * Author: Belbo
 *
 * Adds action to show artillery setting (propellant setting) for all provided vehicles.
 *
 * Arguments:
 * Array of objects - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [arty_1, arty_2, ..., arty_n] call adv_fnc_showArtiSetting;
 *
 * Public: No
 */

{
	if (!isNil "_x") then {
		private _target = _x;
		_target addAction [
			"<t color='#00cc00'>Artillerie-Einstellung anzeigen</t>",
			{
				ADV_artiVar = 1;
				while {player == gunner (_this select 0) && ADV_artiVar isEqualTo 1} do {
					//hint str (getArtilleryComputerSettings select 0);
					hint format ["Currently selected range:\n %1 \n\nTo change the artillery-range press 'F'",getArtilleryComputerSettings select 0];
					sleep 0.5;
				};
				hint "";
				ADV_artiVar = 0;
			},nil,6,false,true,"","gunner _target == _this"
		];
		_target addAction [
			"<t color='#00cc00'>Artillerie-Einstellung ausblenden</t>",
			{
				hint "";
				ADV_artiVar = 0;
			},nil,6,false,true,"","gunner _target == _this"
		];
	};
	nil;
} count _this;

true;
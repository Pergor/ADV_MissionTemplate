/*
 * Author: Belbo
 *
 * Adds an EVH to all mortars that will create a lightpoint for Flare_82mm_AMOS_White that is visible in MP.
 * Has to be executed on every client and the server.
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * True if execut.0r is server - false if not - <BOOL>
 *
 * Example:
 * [] remoteExec ["adv_fnc_mortarFlare",0];
 *
 * Public: No
 */
 
if ( isClass(configFile >> "CfgPatches" >> "adv_configsVanilla") ) exitWith { false };

adv_mortarFlare_scriptfnc_setLight = {
	_this spawn {
		params ["_evhVars","_light","_flareSize","_flareBrightness","_flareIntensity","_flareColor"];
		_evhVars params ["_unit","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile","_gunner"];
		
		private _activationTime = 10;
		sleep _activationTime;
		if !(local _unit) exitWith {
			_light setLightUseFlare true;
			_light setLightFlareSize _flareSize;
			_light setLightFlareMaxDistance 12000;
			_light setLightBrightness _flareBrightness;
			_light setLightIntensity _flareIntensity;
			_light setLightColor _flareColor;
			_light setLightAmbient _flareColor;
			_light setLightDayLight true;
		};
		private _timeToLive = getNumber (configFile >> "CfgAmmo" >> _ammo >> "timeToLive");
		sleep _timeToLive-_activationTime;
		deleteVehicle _light;
	};
};

adv_mortarFlare_scriptfnc_EVH = {
	params ["_unit"];
	_index = _unit addEventHandler ["Fired",{
		params ["_unit","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile","_gunner"];
		if !(_ammo == "Flare_82mm_AMOS_White") exitWith {};
		private _light = createVehicle ["#lightpoint", getPos _projectile, [], 0, "NONE"];
		_light attachTo [_projectile];
		
		private _flareSize = getNumber (configFile >> "CfgAmmo" >> _ammo >> "flareSize");
		private _brightness = getNumber (configFile >> "CfgAmmo" >> _ammo >> "brightness");
		private _intensity = getNumber (configFile >> "CfgAmmo" >> _ammo >> "intensity");
		
		[[_this, _light, _flareSize, _brightness, _intensity, [0.95,0.95,1]],adv_mortarFlare_scriptfnc_setLight] remoteExec ["call",0];
	}];
	_index
};

if (!isServer) exitWith {false};

["Mortar_01_base_F", "init", { [_this select 0] call adv_mortarFlare_scriptfnc_EVH }, true, [], true] call CBA_fnc_addClassEventHandler;

true
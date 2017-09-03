/*
 * Author: Belbo
 *
 * Sets player on captive if he changes to an enemy uniform if param is set to true or additionally if he has no weapon equipped or isn't seated in an armed vehicle if set to false.
 * The player will be uncovered if he comes closer than 8 meters to an enemy unit.
 *
 * Arguments:
 * 0: Should only wearing an enemy uniform (vanilla/apex only) hide the player or should switching to no weapon make you captive? - <BOOL>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [true] call adv_fnc_undercover
 *
 * Public: Yes
 */

 //removing the evhs if called twice:
if (!isNil "adv_undercover_scriptevh_uniform") exitWith {
	["<t color='#ff0000' size = '.8'>Your cover has been permanently compromised!</t>",-1,0,5,1,0,789] spawn BIS_fnc_dynamicText;
	["loadout",adv_undercover_scriptevh_uniform] call CBA_fnc_removePlayerEventHandler;
	adv_undercover_scriptevh_uniform = nil;
	
	[player, false] call adv_undercover_scriptfnc_setCaptive;
	
	if (!isNil "adv_undercover_scriptevh_onFoot") exitWith {
		["weapon",adv_undercover_scriptevh_onFoot] call CBA_fnc_removePlayerEventHandler;
		["vehicle",adv_undercover_scriptevh_inVeh] call CBA_fnc_removePlayerEventHandler;
		adv_undercover_scriptevh_onFoot = nil;
		adv_undercover_scriptevh_inVeh = nil;
	};
};
 
params [
	["_uniformsOnly",true,[true]]
];

adv_undercover_isUniformsOnly = _uniformsOnly;

adv_undercover_uniforms_west = [
	"U_B_COMBATUNIFORM_MCAM","U_B_COMBATUNIFORM_MCAM_TSHIRT","U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3"
	,"U_B_GHILLIESUIT","U_B_HELIPILOTCOVERALLS","U_B_PILOTCOVERALLS","U_B_COMBATUNIFORM_MCAM_VEST","U_B_SURVIVAL_UNIFORM"
	,"U_I_G_STORY_PROTAGONIST_F","U_B_COMBATUNIFORM_MCAM_WORN","U_B_T_SOLDIER_F","U_B_T_SOLDIER_AR_F","U_B_CTRG_SOLDIER_F"
	,"U_B_CTRG_SOLDIER_3_F","U_B_CTRG_SOLDIER_2_F","U_B_CTRG_SOLDIER_URB_1_F","U_B_CTRG_SOLDIER_URB_3_F","U_B_CTRG_SOLDIER_URB_2_F"
	,"U_B_T_SNIPER_F","U_B_T_SOLDIER_SL_F"
];
adv_undercover_uniforms_east = [
	"U_O_COMBATUNIFORM_OCAMO","U_O_COMBATUNIFORM_OUCAMO","U_O_GHILLIESUIT","U_O_OFFICERUNIFORM_OCAMO","U_O_PILOTCOVERALLS","U_O_SPECOPSUNIFORM_OCAMO"
	,"U_O_T_SOLDIER_F","U_O_T_SNIPER_F","U_O_T_OFFICER_F","U_O_V_SOLDIER_VIPER_F","U_O_V_SOLDIER_VIPER_HEX_F"
];
adv_undercover_uniforms_independent = [
	"U_I_COMBATUNIFORM","U_I_OFFICERUNIFORM","U_I_COMBATUNIFORM_SHORTSLEEVE","U_I_GHILLIESUIT","U_I_HELIPILOTCOVERALLS","U_I_PILOTCOVERALLS"
	,"U_I_C_SOLDIER_PARA_2_F","U_I_C_SOLDIER_PARA_3_F","U_I_C_SOLDIER_PARA_5_F","U_I_C_SOLDIER_PARA_4_F","U_I_C_SOLDIER_PARA_1_F","U_I_C_SOLDIER_CAMO_F"
];

adv_undercover_uniforms = call {
	if (side (group player) isEqualTo west) exitWith {
		adv_undercover_uniforms_east+adv_undercover_uniforms_independent
	};
	if (side (group player) isEqualTo east) exitWith {
		adv_undercover_uniforms_west+adv_undercover_uniforms_independent
	};
	if (side (group player) isEqualTo independent) exitWith {
		adv_undercover_uniforms_west+adv_undercover_uniforms_east
	};
};

adv_undercover_scriptfnc_setCaptive = {
	params ["_unit","_captive"];
	if (_captive && !(captive _unit)) then {
		systemChat "You are now undercover.";
		["You are now undercover.", 4] call adv_fnc_timedHint;
	};
	if (!_captive && (captive _unit)) then {
		systemChat "You are no longer undercover.";
		["You are no longer undercover.", 4] call adv_fnc_timedHint;
	};
	_unit setCaptive _captive;
	call {
		if (!_captive) exitWith {
			_unit setVariable ["adv_undercover_tooClose",true];
		};
		_unit setVariable ["adv_undercover_tooClose",false];
	};
};

adv_undercover_scriptfnc_noEnemyClose = {
	private _nextEnemy = [player,60] call adv_fnc_findNearestEnemy;
	private _enemyInRadius = [player,400] call adv_fnc_findNearestEnemy;
	private _return = (_nextEnemy distance player > 50 && _enemyInRadius knowsAbout player < 1.5);
	_return;
};
adv_undercover_scriptfnc_noVisualWeapon = {
	private _weapon = currentWeapon player;
	private _isBinocular = ( _weapon isEqualTo (binocular player) );
	private _noWeapon = ( (primaryWeapon player) isEqualTo "" && (secondaryWeapon player) isEqualTo "" );
	private _noVisualWeapon = ( (_weapon isEqualTo "" || _isBinocular) && _noWeapon );
	_noVisualWeapon;
};

adv_undercover_scriptfnc_switch_tooclose = {
	if (player getVariable ["adv_undercover_tooClose_applied",false]) exitWith {};
	
	[ { ( !isNull ([player,8] call adv_fnc_findNearestEnemy) ) || (player getVariable ["adv_undercover_tooClose",false]) }, {
		params ["_unit"];
		[_unit, false] call adv_undercover_scriptfnc_setCaptive;
		_unit setVariable ["adv_undercover_tooClose_applied",false];
	},[player]] call CBA_fnc_waitUntilAndExecute;
	
	player setVariable ["adv_undercover_tooClose_applied",true];
};

adv_undercover_scriptfnc_switch_uniform = {
	params [
		["_unit", player, [objNull]]
	];
	if ( toUpper (uniform _unit) in adv_undercover_uniforms && call adv_undercover_scriptfnc_noEnemyClose ) exitWith {
		[_unit, true] call adv_undercover_scriptfnc_setCaptive;
		[_unit] call adv_undercover_scriptfnc_switch_tooclose;
	};
	if ( call adv_undercover_scriptfnc_noVisualWeapon && !adv_undercover_isUniformsOnly ) exitWith {
		[_unit, true] call adv_undercover_scriptfnc_setCaptive;
		[_unit] call adv_undercover_scriptfnc_switch_tooclose;
	};
	
	[_unit, false] call adv_undercover_scriptfnc_setCaptive;
};

adv_undercover_scriptevh_uniform = ["loadout", {[_this select 0] call adv_undercover_scriptfnc_switch_uniform}] call CBA_fnc_addPlayerEventHandler;

if (_uniformsOnly) exitWith {true};

if ( call adv_undercover_scriptfnc_noVisualWeapon ) then {
	[player, true] call adv_undercover_scriptfnc_setCaptive;
	["<t color='#ff0000' size = '.8'>From now on you are undercover,<br/>as long as you do not carry a rifle or a launcher or get inside an armed vehicle.<br/><br/>Carrying a pistol in the holster will not blow your cover.</t>",-1,0,10,1,0,789] spawn BIS_fnc_dynamicText;
};

adv_undercover_scriptfnc_switch_onFoot = {
	params [
		["_unit", player, [objNull]]
		,["_weapon", currentWeapon player, [""]]
	];
	
	if !( (vehicle player) isEqualTo player ) exitWith {};

	//private _isBinocular = ( _weapon isEqualTo (binocular _unit) );

	//if ( _isBinocular ) exitWith {};

	if ( toUpper (uniform _unit) in adv_undercover_uniforms ) exitWith {};

	if ( call adv_undercover_scriptfnc_noVisualWeapon && call adv_undercover_scriptfnc_noEnemyClose ) exitWith {
		[_unit, true] call adv_undercover_scriptfnc_setCaptive;
		[_unit] call adv_undercover_scriptfnc_switch_tooclose;
	};
	
	[_unit, false] call adv_undercover_scriptfnc_setCaptive;
};

adv_undercover_scriptfnc_switch_inVeh = {
	params [
		["_unit", player, [objNull]]
		,["_veh", vehicle player, [objNull]]
	];
	
	private _weapons = weapons _veh;
	//if !( count _weapons > 1 ) exitWith {};
	if ( { !(["Horn",_x] call BIS_fnc_inString) } count _weapons isEqualTo 0 ) exitWith {
		[_unit, true] call adv_undercover_scriptfnc_setCaptive;
	};
	if ( _veh isEqualTo _unit ) exitWith {
		[_unit, currentWeapon _unit] call adv_undercover_scriptfnc_switch_onFoot;
	};

	[_unit, false] call adv_undercover_scriptfnc_setCaptive;
};

adv_undercover_scriptevh_onFoot = ["weapon", {[_this select 0, _this select 1] call adv_undercover_scriptfnc_switch_onFoot}] call CBA_fnc_addPlayerEventHandler;
adv_undercover_scriptevh_inVeh = ["vehicle", {[_this select 0, _this select 1] call adv_undercover_scriptfnc_switch_inVeh}] call CBA_fnc_addPlayerEventHandler;

true;
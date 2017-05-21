/*
 * Author: Belbo
 *
 * Raises the probability for jamming if a player picks up the wrong weapon.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Has evh been added? - <BOOL>
 *
 * Example:
 * call adv_fnc_jamChance;
 *
 * Public: No
 */
 
//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

//exit, if no vanilla assets are used:
if ( side player isEqualTo west && !(_par_customWeap isEqualTo 0 || _par_customWeap isEqualTo 20) ) exitWith {false};
if ( side player isEqualTo east && !(_par_opfWeap isEqualTo 0 || _par_opfWeap isEqualTo 20 || _par_opfWeap isEqualTo 21) ) exitWith {false};
if ( side player isEqualTo independent && !(_par_indWeap isEqualTo 0 || _par_indWeap isEqualTo 1 || _par_indWeap isEqualTo 20 || _par_indWeap isEqualTo 21) ) exitWith {false};

//base variable:
adv_jamchance_isWrongWeapon = false;

//script fnc that adds and removes the evh if the new weapon is wrong:
adv_jamchance_scriptfnc_addEVH = {
	adv_jamchance_evh_fired = player addEventhandler ["fired", {
		params ["_unit","_weapon","_muzzle","_mode","_ammo","_magazine"];
		if (floor random 100 < 3) then {
			[_unit, currentWeapon _unit] call ace_overheating_fnc_jamWeapon;
		};
	}];
	[ { !adv_jamchance_isWrongWeapon }, {player removeEventHandler ["fired",adv_jamchance_evh_fired]}, []] call CBA_fnc_waitUntilAndExecute;
};

//call scriptfnc, if weapon is of the wrong class:
call {
	if (side (group player) isEqualTo west) exitWith {
		//player eventhandler:
		[
			"weapon",
			{
				params ["_unit","_newSelectedWeapon"];
				//exit, if new weapon isn't his primary weapon:
				if !( _newSelectedWeapon isEqualTo (primaryWeapon _unit) ) exitWith {};
				adv_jamchance_isWrongWeapon = true;
				//set base variable to false, as long as the new weapon is "right":
				call {
					if ( (currentWeapon _unit) isKindOf ["arifle_Katiba_Base_F", configFile >> "CfgWeapons"] ) exitWith {};
					if ( (currentWeapon _unit) isKindOf ["mk20_base_F", configFile >> "CfgWeapons"] ) exitWith {};
					if ( (currentWeapon _unit) isKindOf ["Tavor_base_F", configFile >> "CfgWeapons"] ) exitWith {};
					if ( (currentWeapon _unit) isKindOf ["arifle_AK12_base_F", configFile >> "CfgWeapons"] ) exitWith {};
					if ( (currentWeapon _unit) isKindOf ["arifle_AKS_base_F", configFile >> "CfgWeapons"] ) exitWith {};
					if ( (currentWeapon _unit) isKindOf ["arifle_AKM_base_F", configFile >> "CfgWeapons"] ) exitWith {};
					if ( (currentWeapon _unit) isKindOf ["arifle_CTAR_base_F", configFile >> "CfgWeapons"] ) exitWith {};
					if ( (currentWeapon _unit) isKindOf ["arifle_CTARS_base_F", configFile >> "CfgWeapons"] ) exitWith {};
					if ( (currentWeapon _unit) isKindOf ["arifle_ARX_base_F", configFile >> "CfgWeapons"] ) exitWith {};
					/*
					if ( (currentWeapon _unit) isKindOf ["LMG_Zafir_F", configFile >> "CfgWeapons"] ) exitWith {};
					if ( (currentWeapon _unit) isKindOf ["MMG_01_base_F", configFile >> "CfgWeapons"] ) exitWith {};
					if ( (currentWeapon _unit) isKindOf ["DMR_01_base_F", configFile >> "CfgWeapons"] ) exitWith {};
					if ( (currentWeapon _unit) isKindOf ["DMR_05_base_F", configFile >> "CfgWeapons"] ) exitWith {};
					if ( (currentWeapon _unit) isKindOf ["DMR_04_base_F", configFile >> "CfgWeapons"] ) exitWith {};
					if ( (currentWeapon _unit) isKindOf ["DMR_07_base_F", configFile >> "CfgWeapons"] ) exitWith {};
					*/
					adv_jamchance_isWrongWeapon = false;
				};
				//if base variable hasn't been set to true, the scriptfnc will be called:
				if (adv_jamchance_isWrongWeapon) then {
					call adv_jamchance_scriptfnc_addEVH;
				};
			}
		] call CBA_fnc_addPlayerEventHandler;
	};
};

true;
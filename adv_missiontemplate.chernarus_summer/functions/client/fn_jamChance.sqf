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
/*
if ( side player isEqualTo west && !(_par_customWeap isEqualTo 0 || _par_customWeap isEqualTo 20) ) exitWith {false};
if ( side player isEqualTo east && !(_par_opfWeap isEqualTo 0 || _par_opfWeap isEqualTo 20 || _par_opfWeap isEqualTo 21) ) exitWith {false};
if ( side player isEqualTo independent && !(_par_indWeap isEqualTo 0 || _par_indWeap isEqualTo 1 || _par_indWeap isEqualTo 20 || _par_indWeap isEqualTo 21) ) exitWith {false};
*/

//base variable:
adv_jamchance_isWrongWeapon = false;

//script fnc that adds and removes the evh if the new weapon is wrong:
adv_jamchance_scriptfnc_addEVH = {
	adv_jamchance_evh_fired = player addEventhandler ["fired", {
		params ["_unit","_weapon","_muzzle","_mode","_ammo","_magazine"];
		if (floor random 100 < 5) then {
			[_unit, currentWeapon _unit] call ace_overheating_fnc_jamWeapon;
		};
	}];
	[ { !adv_jamchance_isWrongWeapon }, {player removeEventHandler ["fired",adv_jamchance_evh_fired]}, []] call CBA_fnc_waitUntilAndExecute;
};

//weapons that are not allowed (base classes!):
adv_jamchance_forbiddenWeapons = call {
	if (side group player isEqualTo east) exitWith {
		[
			"arifle_MX_Base_F","EBR_base_F","LRR_base_F","LMG_Mk200_F","mk20_base_F","Tavor_base_F"
			,"arifle_SPAR_01_base_F","arifle_SPAR_02_base_F","arifle_SPAR_03_base_F"
			,"MMG_02_base_F","DMR_02_base_F","DMR_03_base_F"
			,"rhs_weap_m4_Base","rhs_weap_saw_base","rhs_weap_M249_base","rhs_weap_m14ebrri","rhs_weap_M107_Base_F","rhs_weap_M590_5RD","rhs_weap_m32_Base_F","rhs_weap_M230"
		];
	};
	if (side group player isEqualTo west) exitWith {
		[
			"arifle_Katiba_Base_F","mk20_base_F","Tavor_base_F","LMG_Zafir_F","GM6_base_F"
			,"arifle_AK12_base_F","arifle_AKS_base_F","arifle_AKM_base_F","arifle_CTAR_base_F","arifle_CTARS_base_F","arifle_ARX_base_F"
			,"MMG_01_base_F","DMR_01_base_F","DMR_04_base_F","DMR_05_base_F","DMR_07_base_F"
			,"rhs_weap_ak74m_Base_F","rhs_pkp_base"
		];
	};
	[""]
};

if ( adv_jamchance_forbiddenWeapons isEqualTo [""] ) exitWith { false };

//call scriptfnc, if weapon is of the wrong class:
//player eventhandler:
[
	"weapon",
	{
		params ["_unit","_newSelectedWeapon"];
		//exit, if new weapon isn't his primary weapon:
		if !( _newSelectedWeapon isEqualTo (primaryWeapon _unit) ) exitWith {};
		//get if player has a wrong weapon:
		private _wrongWeapon = { (currentWeapon _unit) isKindOf [_x, configFile >> "CfgWeapons"] } count adv_jamchance_forbiddenWeapons;
		//execute evh if weapon is wrong:
		if ( _wrongWeapon > 0 ) then {
			adv_jamchance_isWrongWeapon = true;
			call adv_jamchance_scriptfnc_addEVH;
		} else {
			adv_jamchance_isWrongWeapon = false;
		};
	}
] call CBA_fnc_addPlayerEventHandler;

true;
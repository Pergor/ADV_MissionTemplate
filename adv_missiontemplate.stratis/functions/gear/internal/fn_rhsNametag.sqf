/*
 * Author: Belbo
 *
 * Adds nametag to the RHS ACU.
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call adv_fnc_nametag;
 *
 * Public: Yes
 */

params [
	["_target", player, [objNull]]
];

if (!isPlayer _target) exitWith {};

private _textureName = switch (getPlayerUID player) do {
	case "76561197985568467": {"belbo"};
	case "76561198023477454": {"bountyhunta"};
	case "76561198015900317": {"buur"};
	case "76561198288460599": {"chris_darkside"};
	case "76561198029924112": {"deathbite"};
	case "76561198024923177": {"dragon"};
	case "76561197988529847": {"drkeil"};
	case "76561197977846769": {"dusty_fuchs"};
	case "76561198005572955": {"fly"};
	case "76561198027493613": {"freggel"};
	case "76561198027211536": {"kottn"};
	case "76561198006290101": {"lewarz"};
	case "76561197995073036": {"morgeneule"};
	case "76561198002621790": {"morpheusxaut"};
	case "76561197984990636": {"neronimus"};
	case "76561198060817496": {"nyaan"};
	case "76561198005602620": {"obelix"};
	case "76561198028881721": {"schneeflocke"};
	case "76561198122949698": {"shawalla"};
	case "76561198115689818": {"sinus"};
	case "76561197972154981": {"stonefall"};
	case "76561197978374503": {"tugger"};
	case "76561198056242715": {"zyklon"};
	default {"empty"};
};

private _texture = format ["adv_insignia\img\rhs_acu_tags\sel\%1.paa",_textureName];

_target setObjectTextureGlobal [3,_texture];

nil;
/*
 * Author: Belbo
 *
 * Spawns a flare at given height over object or marker.
 *
 * Arguments:
 * 0: Object/Objects at spawn location - ARRAY;
 * 1: color of the flare (optional) - STRING;
 * 2: spread of actual flare spawn (optional) - SCALAR;
 * 3: height (optional) - SCALAR;
 *
 * Return Value:
 * Function executed <BOOL>
 *
 * Example:
 * [[player,player],"red",30,120] call ADV_fnc_flare;
 *
 * Public: Yes
 */

params [
	["_spawn", [], [[]]]
	,["_color", "YELLOW", [""]]
	,["_spread", 50 , [0]]
	,["_height", 160, [0]]
];

{
	private _object = _x;
	if (count _spawn > 1) then {_height = _height + random 3;};
	
	private _spawnPos = [_object] call adv_fnc_getPos;
	//_spawnPos set [2,(_spawnPos select 2)+_height];
	_spawnPos set [2,_height];
	
	private _colorType = switch (toUpper _color) do {
		case "WHITE": {"F_40mm_White"};
		case "GREEN": {"F_40mm_Green"};
		case "RED": {"F_40mm_red"};
		case "YELLOW": {"F_40mm_Yellow"};
		case "CIR": {"F_40mm_CIR"};
		case "SIGNAL_GREEN": {"Sub_F_Signal_Green"};
		case "SIGNAL_RED": {"Sub_F_Signal_Red"};
		case "NONE": {str objNull};
		default {_color};
	};
	private _flare = createVehicle [_colorType, _spawnPos, [], _spread, "NONE"];
	_flare setVelocity [0,0,-0.2];
	private _sound = selectRandom ["flaregun_1.wss","flaregun_2.wss","flaregun_3.wss","flaregun_4.wss"];
	private _soundFile = format ["a3\missions_f_beta\data\sounds\Showcase_Night\%1",_sound];
	playSound3d [_soundFile,_flare];
	nil;
} count _spawn;

true;
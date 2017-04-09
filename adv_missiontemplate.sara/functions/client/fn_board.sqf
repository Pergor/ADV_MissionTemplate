/*
 * Author: Belbo
 *
 * Adds a predefined objectTexture to all given objects.
 *
 * Arguments:
 * Array of objects - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [board_1, board_2, ..., board_n] call adv_fnc_board;
 *
 * Public: Yes
 */

if (count _this == 0) exitWith {};

{
	if (!isNil "_x") then {
		private _board = _x;
		_board addEventHandler ["HandleDamage", {false}];
		_board allowDamage false;
		_board setObjectTextureGlobal [0,"img\00.paa"];

		/*
		_board addAction ["<t color='#ffff11'>Whiteboard -> Start</t>",{params ["_board"]; _board setObjectTextureGlobal [0,"img\00.jpg"];},nil,1,false,false,"","true",3];    
		_board addAction ["<t color='#ffff11'>Whiteboard -> Rufnamen</t>",{params ["_board"]; _board setObjectTextureGlobal [0,"img\01.jpg"];},nil,1,false,false,"","true",3];
		_board addAction ["<t color='#ffff11'>Whiteboard -> Bewegung 1</t>",{params ["_board"]; _board setObjectTextureGlobal [0,"img\02.jpg"];},nil,1,false,false,"","true",3];
		_board addAction ["<t color='#ffff11'>Whiteboard -> Bewegung 2</t>",{params ["_board"]; _board setObjectTextureGlobal [0,"img\03.jpg"];},nil,1,false,false,"","true",3];
		_board addAction ["<t color='#ffff11'>Whiteboard -> Bewegung 3</t>",{params ["_board"]; _board setObjectTextureGlobal [0,"img\04.jpg"];},nil,1,false,false,"","true",3];
		_board addAction ["<t color='#ffff11'>Whiteboard -> Viel Erfolg!</t>",{params ["_board"]; _board setObjectTextureGlobal [0,"img\05.jpg"];},nil,1,false,false,"","true",3];
		*/
	};
	nil;
} count _this;

true;
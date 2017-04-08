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
		ADV_board = _x;
		ADV_board addEventHandler ["HandleDamage", {false}];
		ADV_board allowDamage false;
		ADV_board setObjectTextureGlobal [0,"img\00.paa"];

		/*
		ADV_board addAction ["<t color='#ffff11'>Whiteboard -> Start</t>",{ADV_board setObjectTextureGlobal [0,"img\00.jpg"];},nil,1,false,false,"","player distance cursortarget <3"];    
		ADV_board addAction ["<t color='#ffff11'>Whiteboard -> Rufnamen</t>",{ADV_board setObjectTextureGlobal [0,"img\01.jpg"];},nil,1,false,false,"","player distance cursortarget <3"];
		ADV_board addAction ["<t color='#ffff11'>Whiteboard -> Bewegung 1</t>",{ADV_board setObjectTextureGlobal [0,"img\02.jpg"];},nil,1,false,false,"","player distance cursortarget <3"];
		ADV_board addAction ["<t color='#ffff11'>Whiteboard -> Bewegung 2</t>",{ADV_board setObjectTextureGlobal [0,"img\03.jpg"];},nil,1,false,false,"","player distance cursortarget <3"];
		ADV_board addAction ["<t color='#ffff11'>Whiteboard -> Bewegung 3</t>",{ADV_board setObjectTextureGlobal [0,"img\04.jpg"];},nil,1,false,false,"","player distance cursortarget <3"];
		ADV_board addAction ["<t color='#ffff11'>Whiteboard -> Viel Erfolg!</t>",{ADV_board setObjectTextureGlobal [0,"img\05.jpg"];},nil,1,false,false,"","player distance cursortarget <3"];
		*/
	};
	nil;
} count _this;

true;
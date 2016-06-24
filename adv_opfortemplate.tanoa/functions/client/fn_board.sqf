/*
ADV_fnc_board by Belbo

Adds a defined objectTexture to all given objects.

Possible call, has to be executed locally on each client (that's supposed to have control over the whiteboard): 
[WHITEBOARDNAME] call ADV_fnc_board;

_this = all boards this is applied to.
*/
if (count _this == 0) exitWith {};

{
	ADV_board = _x;
	ADV_board addEventHandler ["HandleDamage", {false}];
	ADV_board setObjectTextureGlobal [0,"img\00.paa"];

	/*
	ADV_board addAction ["<t color='#ffff11'>Whiteboard -> Start</t>",{ADV_board setObjectTextureGlobal [0,"img\00.jpg"];},nil,1,false,false,"","player distance cursortarget <3"];    
	ADV_board addAction ["<t color='#ffff11'>Whiteboard -> Rufnamen</t>",{ADV_board setObjectTextureGlobal [0,"img\01.jpg"];},nil,1,false,false,"","player distance cursortarget <3"];
	ADV_board addAction ["<t color='#ffff11'>Whiteboard -> Bewegung 1</t>",{ADV_board setObjectTextureGlobal [0,"img\02.jpg"];},nil,1,false,false,"","player distance cursortarget <3"];
	ADV_board addAction ["<t color='#ffff11'>Whiteboard -> Bewegung 2</t>",{ADV_board setObjectTextureGlobal [0,"img\03.jpg"];},nil,1,false,false,"","player distance cursortarget <3"];
	ADV_board addAction ["<t color='#ffff11'>Whiteboard -> Bewegung 3</t>",{ADV_board setObjectTextureGlobal [0,"img\04.jpg"];},nil,1,false,false,"","player distance cursortarget <3"];
	ADV_board addAction ["<t color='#ffff11'>Whiteboard -> Viel Erfolg!</t>",{ADV_board setObjectTextureGlobal [0,"img\05.jpg"];},nil,1,false,false,"","player distance cursortarget <3"];
	*/
} forEach _this;

if (true) exitWith {};
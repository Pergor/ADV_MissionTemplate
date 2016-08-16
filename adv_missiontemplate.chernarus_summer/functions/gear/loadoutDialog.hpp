﻿////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START
////////////////////////////////////////////////////////
#include "parentDialog.hpp"

// MACROS
#define IDC_adv_loadouts_LOADOUT_RSCTEXT_1000	6877
#define IDC_adv_loadouts_LOADOUT_RSCTEXT_1001	6878
#define IDC_adv_loadouts_LOADOUT_RSCLISTBOX_1500	7377
#define IDC_adv_loadouts_LOADOUT_RSCBUTTON_1600	7477
#define IDC_adv_loadouts_LOADOUT_RSCBUTTON_1601	7478
#define IDC_adv_loadouts_LOADOUT_RSCFRAME_1800	7677
#define IDC_adv_loadouts_LOADOUT_RSCCOMBO_2100	7977
#define IDC_adv_loadouts_LOADOUT_IGUIBACK_2200	8077

class adv_loadouts_mainDialog {

	idd = 11;
	movingEnable = true;
	enableSimulation = true; // does not freeze the game
	// lade init-Skript
	//onload = "(_this) execVM 'functions\gear\fn_dialogGearInit.sqf';";
	onload = "(_this) spawn ADV_fnc_dialogGearInit;";

	controls[] = { 
		IGUIBack_2200,	
		RscFrame_1800,
		RscListbox_1500,
		RscText_1000,
		//RscCombo_2100,
		//RscText_1001,
		RscButton_1600,
		RscButton_1601
	};

	class IGUIBack_2200: adv_loadouts_IGUIBack
	{
		idc = IDC_adv_loadouts_LOADOUT_IGUIBACK_2200;
		x = 0.06 * GUI_GRID_W + GUI_GRID_X;
		y = 0.99 * GUI_GRID_H + GUI_GRID_Y;
		w = 40 * GUI_GRID_W;
		h = 24 * GUI_GRID_H;
		moving = 1;
	};

	class RscFrame_1800: adv_loadouts_RscFrame
	{
		idc = IDC_adv_loadouts_LOADOUT_RSCFRAME_1800;
		text = "Loadout-Auswahlmenü"; //--- ToDo: Localize;
		x = 0 * GUI_GRID_W + GUI_GRID_X;
		y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 40 * GUI_GRID_W;
		h = 24.5 * GUI_GRID_H;
		sizeEx = 1 * GUI_GRID_H;
	};

	class RscListbox_1500: adv_loadouts_RscListbox
	{
		idc = IDC_adv_loadouts_LOADOUT_RSCLISTBOX_1500;
		text = "Loadouts"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 16 * GUI_GRID_W;
		h = 21 * GUI_GRID_H;
		
		colorSelectBackground[] = 
		{
			0.03,
			0.42,
			0.53,
			1
		};
	};

	class RscText_1000: adv_loadouts_RscText
	{
		idc = IDC_adv_loadouts_LOADOUT_RSCTEXT_1000;
		text = "Loadouts"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 15.5 * GUI_GRID_W;
		h = 2 * GUI_GRID_H;
	};
	
	/*
	class RscCombo_2100: adv_loadouts_RscCombo
	{
		idc = IDC_adv_loadouts_LOADOUT_RSCCOMBO_2100;
		x = 18 * GUI_GRID_W + GUI_GRID_X;
		y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 19.5 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
	};

	/*
	class RscText_1001: adv_loadouts_RscText
	{
		idc = IDC_adv_loadouts_LOADOUT_RSCTEXT_1001;
		text = "Optik"; //--- ToDo: Localize;
		x = 18 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 19 * GUI_GRID_W;
		h = 2 * GUI_GRID_H;
	};
	*/
	
	class RscButton_1600: adv_loadouts_RscButton
	{
		idc = IDC_adv_loadouts_LOADOUT_RSCBUTTON_1600;
		text = "OK"; //--- ToDo: Localize;
		x = 18 * GUI_GRID_W + GUI_GRID_X;
		y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		action = "[lbData [7377, lbCurSel 7377], lbData[7977, lbCurSel 7977]] call ADV_fnc_dialogLoadout;";
	};

	class RscButton_1601: adv_loadouts_RscButton
	{
		idc = IDC_adv_loadouts_LOADOUT_RSCBUTTON_1601;
		text = "Abbrechen"; //--- ToDo: Localize;
		x = 28.5 * GUI_GRID_W + GUI_GRID_X;
		y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		action = "closeDialog 2"; // CANCEL BUTTON
	};
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

/*
 *
 *	@File:		aapps_lottery.hpp
 *	@Author: 	AllianceApps
 *	@Date:		24.12.2017
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *  
 */
class aapps_lottery_config {
	class values {
		lowestvalue = 1; //Lowest value which is accepted
		highestvalue = 20; //highest value which is accepted
		amountofnumbers = 6; //amount of numbers at the code
	};
	price = 20000; //Ticketprice
	class lottery_drawings {
		MONDAY[] = {};
		TUESDAY[] = {};
		WEDNESDAY[] = {"15:00","18:00"};
		THURSDAY[] = {};
		FRIDAY[] = {};
		SATURDAY[] = {};
		SUNDAY[] = {"15:00","18:00"};
	};
	max_restart_time = 6; //how long can a restartperiod max last for
};
class aapps_lottery {
    name = "aapps_lottery";
    idd = 88088;
	movingEnable = false;
	enableSimulation = true;
	
	class controlsBackground {
		class background: Life_RscText
		{
			idc = -1;
			x = 0.423683 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.154694 * safezoneW;
			h = 0.3872 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class Life_RscText_1001: Life_RscText
		{
			idc = -1;
			text = "$STR_lottery_gui_title"; 
			x = 0.423683 * safezoneW + safezoneX;
			y = 0.3086 * safezoneH + safezoneY;
			w = 0.154694 * safezoneW;
			h = 0.0286 * safezoneH;
			colorBackground[] = {0.827,0.329,0,1};
			style = 2;
		};
		class Life_RscText_1002: Life_RscText
		{
			idc = -1;
			text = "$STR_lottery_gui_line1"; 
			x = 0.425758 * safezoneW + safezoneX;
			y = 0.3592 * safezoneH + safezoneY;
			w = 0.15055 * safezoneW;
			h = 0.0154 * safezoneH;
			sizeEx = 0.032;
			style = 2;
		};
		class Life_RscText_1003: Life_RscText
		{
			idc = -1;
			text = "$STR_lottery_gui_line2"; 
			x = 0.425724 * safezoneW + safezoneX;
			y = 0.382059 * safezoneH + safezoneY;
			w = 0.15055 * safezoneW;
			h = 0.0154 * safezoneH;
			sizeEx = 0.032;
			style = 2;
		};
		class Life_RscText_1004: Life_RscText
		{
			idc = -1;
			text = "$STR_lottery_gui_line3"; 
			x = 0.425493 * safezoneW + safezoneX;
			y = 0.40463 * safezoneH + safezoneY;
			w = 0.15055 * safezoneW;
			h = 0.0154 * safezoneH;
			sizeEx = 0.032;
			style = 2;
		};
		class Life_RscText_1005: Life_RscText
		{
			idc = -1;
			text = "$STR_lottery_gui_line4"; 
			x = 0.425947 * safezoneW + safezoneX;
			y = 0.4434 * safezoneH + safezoneY;
			w = 0.15055 * safezoneW;
			h = 0.0154 * safezoneH;
			sizeEx = 0.032;
			style = 2;
		};
		class Life_RscText_1006: Life_RscText
		{
			idc = -1;
			text = "$STR_lottery_gui_line5"; 
			x = 0.426001 * safezoneW + safezoneX;
			y = 0.467244 * safezoneH + safezoneY;
			w = 0.15055 * safezoneW;
			h = 0.0154 * safezoneH;
			sizeEx = 0.032;
			style = 2;
		};
		class Life_RscText_1007: Life_RscText
		{
			idc = -1;
			text = "$STR_lottery_gui_line6"; 
			x = 0.425745 * safezoneW + safezoneX;
			y = 0.510185 * safezoneH + safezoneY;
			w = 0.15055 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = 0.07;
			style = 2;
		};
		class Life_RscText_1008: Life_RscText
		{
			idc = -1;
			text = "$STR_lottery_gui_enter"; 
			x = 0.425203 * safezoneW + safezoneX;
			y = 0.572222 * safezoneH + safezoneY;
			w = 0.15055 * safezoneW;
			h = 0.0154 * safezoneH;
			sizeEx = 0.032;
			style = 2;
		};
		class Life_RscButton_1601: Life_RscButton
		{
			idc = -1;
			text = "$STR_lottery_gui_buy"; 
			x = 0.425678 * safezoneW + safezoneX;
			y = 0.660212 * safezoneH + safezoneY;
			w = 0.15055 * safezoneW;
			h = 0.0264 * safezoneH;
			colorBackground[] = {0,0,0,1};
			colorText[] = {255,255,255,1};
			colorActive[] = {0,0,0,1};
			colorBackgroundActive[] = {0.902,0.494,0.133,1};
			colorFocused[] = {0.902,0.494,0.133,1};
			action = "[2] call life_fnc_aapps_checklotteryinput";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
		};
		class Life_RscButton_1602: Life_RscButton
		{
			idc = -1;
			text = "$STR_lottery_gui_helpme"; 
			x = 0.425363 * safezoneW + safezoneX;
			y = 0.629741 * safezoneH + safezoneY;
			w = 0.15055 * safezoneW;
			h = 0.0264 * safezoneH;
			colorBackground[] = {0,0,0,1};
			colorText[] = {255,255,255,1};
			colorActive[] = {0,0,0,1};
			colorBackgroundActive[] = {0.902,0.494,0.133,1};
			colorFocused[] = {0.902,0.494,0.133,1};
			action = "[1] call life_fnc_aapps_checklotteryinput";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
		};
		class Life_RscButton_1600: Life_RscButton
		{
			idc = -1;
			text = "$STR_Global_Close"; 
			x = 0.425779 * safezoneW + safezoneX;
			y = 0.6914 * safezoneH + safezoneY;
			w = 0.15055 * safezoneW;
			h = 0.0264 * safezoneH;
			colorBackground[] = {0,0,0,1};
			colorText[] = {255,255,255,1};
			colorActive[] = {0,0,0,1};
			colorBackgroundActive[] = {0.902,0.494,0.133,1};
			colorFocused[] = {0.902,0.494,0.133,1};
			action = "closeDialog 0;";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
		};
	};
	class controls
	{
		class Life_RscEdit_1400: Life_RscEdit
		{
			idc = 88089;
			text = "";
			x = 0.428463 * safezoneW + safezoneX;
			y = 0.594082 * safezoneH + safezoneY;
			w = 0.146426 * safezoneW;
			h = 0.0308 * safezoneH;
			style = 2;
		};
	};
};


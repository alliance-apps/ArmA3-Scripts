#define KEYPRESETS {}
/*
 *
 *	@File:		aapps_keymapper_SA.hpp
 *	@Author: 	AllianceApps
 *	@Date:		14.02.2018
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *  
*/
class aapps_keymapper_config {
	/*			ACTION SECTIONS 		*/
	class sections {
		class section1 {
			displayName = "Aktionsgruppe 1";
			condition = "";
			keys[] = {
				{1,"Springen",""}, //Enter a valid name or a valid localizable STRING
				{2,"Ergeben",""},
				{3,"Holstern",""}
			};
		};
		class section2 {
			displayName = "Aktionsgruppe 2";
			condition = "";
			keys[] = {
				{4,"Festnehmen",""},
				{5,"Ausnocken",""},
				{6,"Kofferraum",""}
			};
		};
		class section3 {
			displayName = "Aktionsgruppe 3";
			condition = "";
			keys[] = {
				{7,"Sirenlichter",""},
				{8,"Radar",""},
				{9,"ZMenü",""},
				{10,"Sirene",""},
				{11,"Ohrenstöpsel",""},
				{12,"Aufschließen",""},
				{13,"Farmen",""}
			};
		};
	};
	/*			 ACTION PRESET			*/
	key_preset[] = KEYPRESETS;
};
	
class aapps_keymapper_SA {
	idd = 12341234;
	name = "aapps_keymapper_SA";
	movingEnable = false;
	enableSimulation = true;
	
	class controlsBackground {
		class RscText_1001: Life_RscText
		{
			idc = -1;
			text = "[AllianceApps] KeyMapper";
			x = 0.293732 * safezoneW + safezoneX;
			y = 0.2734 * safezoneH + safezoneY;
			w = 0.412427 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class RscText_1002: Life_RscText
		{
			idc = -1;
			text = "$STR_aapps_key_action";
			x = 0.293732 * safezoneW + safezoneX;
			y = 0.3614 * safezoneH + safezoneY;
			w = 0.205198 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class RscText_1004: Life_RscText
		{
			idc = -1;
			text = "$STR_aapps_keys";
			x = 0.501031 * safezoneW + safezoneX;
			y = 0.3614 * safezoneH + safezoneY;
			w = 0.205196 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class RscText_1000: Life_RscText 
		{
			idc = -1;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.412479 * safezoneW;
			h = 0.0396 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
		class RscText_1003: Life_RscText
		{
			idc = -1;
			text = "$STR_aapps_key_actionname"; 
			x = 0.294781 * safezoneW + safezoneX;
			y = 0.3152 * safezoneH + safezoneY;
			w = 0.0845625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class logo: Life_RscPicture
		{
			idc = -1;
			text = "core\keymapper\allianceapps_logo.paa";
			x = 0.778437 * safezoneW + safezoneX;
			y = 0.8762 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.132 * safezoneH;
		};
	};
	class controls {
		class RscEdit_1400: Life_RscEdit
		{
			idc = 12341234;
			text = ""; 
			x = 0.352529 * safezoneW + safezoneX;
			y = 0.3196 * safezoneH + safezoneY;
			w = 0.349558 * safezoneW;
			h = 0.0264 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
		class RscButton_1400: Life_RscButton
		{
			idc = 12341235;
			text = "$STR_aapps_key_search";
			x = 0.352529 * safezoneW + safezoneX;
			y = 0.3196 * safezoneH + safezoneY;
			w = 0.349558 * safezoneW;
			h = 0.0264 * safezoneH;
			action = "ctrlShow[12341235,false]; ctrlSetFocus ((findDisplay 12341234) displayCtrl 12341234)";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
            colorBackground[] = {1,1,1,0.2};
			colorBackgroundActive[] = {1,1,1,0.2};
			colorBackground2[] = {1,1,1,0.2};
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 0;
		};
		class RscText_1005: Life_RscText
		{
			idc = 12341236;
			x = 0.293729 * safezoneW + safezoneX;
			y = 0.4032 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.2904 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
		class RscListbox_1500: Life_RscListNBox
		{
			idc = 12341237;
			x = 0.296844 * safezoneW + safezoneX;
			y = 0.4076 * safezoneH + safezoneY;
			w = 0.406313 * safezoneW;
			h = 0.2794 * safezoneH;
			columns[] = {-0.005,0.03,0.5}; //columns[] = {-0.005,0.5};
			rowHeight = 0.03;
			drawSideArrows = "false";
			idcLeft = -1;
			idcRight = -1;
		};
		class RscText_1006: Life_RscStructuredText
		{
			idc = 12341238;
			text = "";
			x = 0.414407 * safezoneW + safezoneX;
			y = 0.4296 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		class RscButton_1600: Life_RscButton
		{
			idc = 12341239;
			text = "$STR_Global_Close"; 
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.7002 * safezoneH + safezoneY;
			w = 0.136126 * safezoneW;
			h = 0.033 * safezoneH;
			action = "closeDialog 0";
			type = 1; access = 0;
			colorBackground[] = {0,0,0,1};
			colorShadow[] = {0,0,0,0};
		};
		class RscButton_1601: Life_RscButton
		{
			idc = 12341240;
			text = "$STR_aapps_key_reset";
			x = 0.431938 * safezoneW + safezoneX;
			y = 0.7002 * safezoneH + safezoneY;
			w = 0.136332 * safezoneW;
			h = 0.033 * safezoneH;
			action = "";
			type = 1; access = 0;
			colorBackground[] = {0,0,0,1};
			colorShadow[] = {0,0,0,0};
		};
		class RscButton_1602: Life_RscButton
		{
			idc = 12341241;
			text = "$STR_aapps_key_savecode";
			x = 0.570125 * safezoneW + safezoneX;
			y = 0.7002 * safezoneH + safezoneY;
			w = 0.136126 * safezoneW;
			h = 0.033 * safezoneH;
			action = "";
			type = 1; access = 0;
			colorBackground[] = {0,0,0,1};
			colorShadow[] = {0,0,0,0};
		};
				/*			EXPORT		*/
		class RscText_10011: Life_RscText
		{
			idc = 12341242;
			text = "Copy this:";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.2316 * safezoneH + safezoneY;
			w = 0.412427 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
		};
		class RscEdit_14010: Life_RscEdit
		{
			idc = 12341243;
			text = ""; 
			x = 0.353562 * safezoneW + safezoneX;
			y = 0.2382 * safezoneH + safezoneY;
			w = 0.349593 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
			canModify = false;
		};
		class RscButton_16102: Life_RscButton
		{
			idc = 12341244;
			text = "EXPORT";
			x = 0.641281 * safezoneW + safezoneX;
			y = 0.2778 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
			action = "";
			type = 1; access = 0;
			colorBackground[] = {0,0,0,1};
			colorShadow[] = {0,0,0,0};
		};
	};
};
/*
 *
 *	@File:		aapps_admintool.hpp
 *	@Author: 	AllianceApps
 *	@Date:		31.01.2018
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *  
 */
class aapps_admintool
{
    idd = 9999991;
	name = "aapps_admintool";
	movingEnable = false;
	enableSimulation = true;
	
	class controlsBackground
	{
		class spielerlistebackground: Life_RscText
		{
			idc = -1;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.2668 * safezoneH + safezoneY;
			w = 0.113436 * safezoneW;
			h = 0.5082 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
		class beschreibungbackground: Life_RscText
		{
			idc = -1;
			x = 0.412344 * safezoneW + safezoneX;
			y = 0.2668 * safezoneH + safezoneY;
			w = 0.175296 * safezoneW;
			h = 0.4686 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
		class functionbackground: Life_RscText
		{
			idc = -1;
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.2668 * safezoneH + safezoneY;
			w = 0.113436 * safezoneW;
			h = 0.5082 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
		class spielerlisteheader: Life_RscText
		{
			idc = -1;
			text = "$STR_adm_aappsdialog_plist";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class functionheader: Life_RscText
		{
			idc = -1;
			text = "$STR_adm_aappsdialog_flist";
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class beschreibungheader: Life_RscText
		{
			idc = -1;
			text = "$STR_adm_aappsdialog_description";
			x = 0.412344 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.175297 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class Life_RscText_1014: Life_RscText
		{
			idc = -1;
			text = "[AllianceApps] Admintool";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.1832 * safezoneH + safezoneY;
			w = 0.412427 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class RscButton_1600: Life_RscButton
		{
			idc = -1;
			text = "$STR_Global_Close";
			x = 0.412344 * safezoneW + safezoneX;
			y = 0.742 * safezoneH + safezoneY;
			w = 0.175294 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			action = "closeDialog 0";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
		};
		class logo: Life_RscPicture
		{
			idc = -1;
			text = "textures\allianceapps_logo.paa";
			x = 0.778437 * safezoneW + safezoneX;
			y = 0.8762 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.132 * safezoneH;
		};
	};
	class controls
	{
		class spielerlistelist: Life_RscListBox
		{
			idc = 9999991;
			x = 0.296844 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.107248 * safezoneW;
			h = 0.4554 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			sizeEx = 0.03;
		};
		class functionlist: Life_RscListBox
		{
			idc = 9999992;
			x = 0.595906 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.107248 * safezoneW;
			h = 0.4554 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			sizeEx = 0.03;
		};
		class RscEdit_1400: Life_RscEdit
		{
			idc = 10000000;
			text = "";
			x = 0.296844 * safezoneW + safezoneX;
			y = 0.2756 * safezoneH + safezoneY;
			w = 0.107766 * safezoneW;
			h = 0.0308 * safezoneH;
		};
		class RscButton_1400: Life_RscButton
		{
			idc = 10000002;
			text = "$STR_adm_aappsdialog_search";
			x = 0.296844 * safezoneW + safezoneX;
			y = 0.2756 * safezoneH + safezoneY;
			w = 0.107766 * safezoneW;
			h = 0.0308 * safezoneH;
			action = "ctrlShow[10000002,false]; ctrlSetFocus ((findDisplay 9999991) displayCtrl 10000000)";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
            colorBackground[] = {1,1,1,0.2};
			colorBackgroundActive[] = {1,1,1,0.2};
			colorBackground2[] = {1,1,1,0.2};
			offsetPressedX = 0;
			offsetPressedY = 0;
		};
		class RscEdit_1401: Life_RscEdit
		{
			idc = 10000001;
			text = ""; 
			x = 0.596525 * safezoneW + safezoneX;
			y = 0.27714 * safezoneH + safezoneY;
			w = 0.10725 * safezoneW;
			h = 0.0308 * safezoneH;
		};
		class RscButton_1401: RscButton_1400
		{
			idc = 10000003;
			x = 0.596525 * safezoneW + safezoneX;
			y = 0.27714 * safezoneH + safezoneY;
			w = 0.10725 * safezoneW;
			h = 0.0308 * safezoneH;
			action = "ctrlShow[10000003,false]; ctrlSetFocus ((findDisplay 9999991) displayCtrl 10000001)";
		};
		class RscText_1011: Life_RscText
		{
			idc = 9999997;
			x = 0.293727 * safezoneW + safezoneX;
			y = 0.8256 * safezoneH + safezoneY;
			w = 0.413455 * safezoneW;
			h = 0.0418 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
		class RscText_1007: Life_RscText
		{
			idc = 9999995;
			text = "$STR_adm_aappsdialog_extented";
			x = 0.293703 * safezoneW + safezoneX;
			y = 0.784607 * safezoneH + safezoneY;
			w = 0.412427 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class RscEdit_1402: Life_RscEdit
		{
			idc = 9999996;
			text = "";
			x = 0.296859 * safezoneW + safezoneX;
			y = 0.8324 * safezoneH + safezoneY;
			w = 0.407269 * safezoneW;
			h = 0.0308 * safezoneH;
		};
		class CtrlGrp: Life_RscControlsGroup
		{
			idc = -1;
			x = 0.415522 * safezoneW + safezoneX;
			y = 0.2734 * safezoneH + safezoneY;
			w = 0.169108 * safezoneW;
			h = 0.4554 * safezoneH;
			class Controls
			{
				class Textoutput: Life_RscStructuredText
				{
					idc = 9999994;
					x = 0;
					y = 0;
					w = 0.169108 * safezoneW;
					h = 0;
					text = "";
					colorBackground[] = {0,0,0,0.6};
				};
			};
		};
	};
};
class aapps_adminlogs {
	idd = 9999997;
	name = "aapps_adminlogs";
	movingEnable = false;
	enableSimulation = true;

	class controlsBackground
	{
		class idliste: Life_RscText
		{
			idc = -1;
			text = "ID";
			x = 0.2195 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0391906 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class background: Life_RscText
		{
			idc = -1;
			x = 0.2195 * safezoneW + safezoneX;
			y = 0.2668 * safezoneH + safezoneY;
			w = 0.558902 * safezoneW;
			h = 0.5104 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
		class Life_RscText_1014: Life_RscText
		{
			idc = -1;
			text = "[AllianceApps] Adminlogs";
			x = 0.2195 * safezoneW + safezoneX;
			y = 0.1832 * safezoneH + safezoneY;
			w = 0.557798 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class Life_RscText_1003: Life_RscText
		{
			idc = -1;
			text = "Adminname";
			x = 0.262812 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.106222 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class RscText_1002: Life_RscText
		{
			idc = -1;
			text = "$STR_adm_aappsdialog_playername";
			x = 0.373259 * safezoneW + safezoneX;
			y = 0.22456 * safezoneH + safezoneY;
			w = 0.106222 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class Life_RscText_1004: Life_RscText
		{
			idc = -1;
			text = "Log";
			x = 0.484531 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.292842 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class logo: Life_RscPicture
		{
			idc = -1;
			text = "textures\allianceapps_logo.paa";
			x = 0.778437 * safezoneW + safezoneX;
			y = 0.8762 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.132 * safezoneH;
		};
	};
	class controls
	{
		class Life_RscListbox_1500: Life_RscListNBox
		{
			idc = 9999998;
			x = 0.223625 * safezoneW + safezoneX;
			y = 0.2756 * safezoneH + safezoneY;
			w = 0.550687 * safezoneW;
			h = 0.4928 * safezoneH;
			columns[] = {0,0.065,0.265,0.47};
			rowHeight = 0.03;
			drawSideArrows = "false";
			idcLeft = -1;
			idcRight = -1;
		};
	};
};
class aapps_develop_dialog
{
    idd = 3961500;
	name = "aapps_develop_dialog";
    movingEnable = false;
    enableSimulation = true;
	
	class controlsBackground {
		class mainbackground: Life_RscText
		{
			idc = -1;
			x = 0.172069 * safezoneW + safezoneX;
			y = 0.0886 * safezoneH + safezoneY;
			w = 0.537281 * safezoneW;
			h = 0.62084 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
		class background_players: Life_RscText
		{
			idc = -1;
			x = 0.00396872 * safezoneW + safezoneX;
			y = 0.0886 * safezoneH + safezoneY;
			w = 0.163969 * safezoneW;
			h = 0.9042 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
        class RscText_10084: Life_RscText
        {
            idc = -1;
            x = 0.71347 * safezoneW + safezoneX;
            y = 0.0886 * safezoneH + safezoneY;
            w = 0.280485 * safezoneW;
            h = 0.2354 * safezoneH;
            colorBackground[] = {0,0,0,0.6};
        };
		class RscText_1000: Life_RscText
		{
			idc = -1;
            text = "$STR_adm_aappsdev_title";
			x = 0.00396875 * safezoneW + safezoneX;
			y = 0.016 * safezoneH + safezoneY;
			w = 0.99 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
		};
		class RscText_1001: Life_RscText
		{
			idc = -1;
			text = "FPS: ";
			x = 0.939116 * safezoneW + safezoneX;
			y = 0.0171 * safezoneH + safezoneY;
			w = 0.0495 * safezoneW;
			h = 0.0308 * safezoneH;
		};
		class RscText_1003: Life_RscText
		{
			idc = -1;
			text = "$STR_adm_aappsdialog_playername";
			x = 0.0039687 * safezoneW + safezoneX;
			y = 0.0556 * safezoneH + safezoneY;
			w = 0.163403 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
            style = 2;
		};
		class RscText_1005: Life_RscText
		{
			idc = -1;
			text = "$STR_adm_aappsdialog_console";
			x = 0.172062 * safezoneW + safezoneX;
			y = 0.0556 * safezoneH + safezoneY;
			w = 0.537293 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
            style = 2;
		};
		class RscText_1006: Life_RscText
		{
			idc = -1;
			text = "Variableviewer";
			x = 0.713497 * safezoneW + safezoneX;
			y = 0.0556 * safezoneH + safezoneY;
			w = 0.281452 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
            style = 2;
		};
		class RscText_1009: Life_RscText
		{
			idc = -1;
			text = "Code-Presets";
			x = 0.71347 * safezoneW + safezoneX;
			y = 0.3372 * safezoneH + safezoneY;
			w = 0.281452 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
            style = 2;
            sizeEx = 0.04;
		};
		class RscText_1010: Life_RscText
		{
			idc = -1;
			x = 0.713468 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.280485 * safezoneW;
			h = 0.242 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
		class RscText_1011: Life_RscText
		{
			idc = -1;
			text = "Running Scriptsviewer";
			x = 0.172063 * safezoneW + safezoneX;
			y = 0.7222 * safezoneH + safezoneY;
			w = 0.537293 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
		};
		class RscText_1012: Life_RscText
		{
			idc = -1;
			x = 0.172064 * safezoneW + safezoneX;
			y = 0.7552 * safezoneH + safezoneY;
			w = 0.537281 * safezoneW;
			h = 0.2376 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
		class RscText_1014: Life_RscText
		{
			idc = -1;
			text = "$STR_adm_aappsdialog_codef";
			x = 0.714116 * safezoneW + safezoneX;
			y = 0.623948 * safezoneH + safezoneY;
			w = 0.281452 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
            style = 2;
		};
		class RscText_1015: Life_RscText
		{
			idc = -1;
			x = 0.714308 * safezoneW + safezoneX;
			y = 0.657504 * safezoneH + safezoneY;
			w = 0.280485 * safezoneW;
			h = 0.2222 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
		class RscText_1016: Life_RscText
		{
			idc = -1;
			text = "$STR_adm_aappsdialog_clickinfo";
			x = 0.715242 * safezoneW + safezoneX;
			y = 0.854728 * safezoneH + safezoneY;
			w = 0.20 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class logo: Life_RscPicture
		{
			idc = -1;
			text = "textures\allianceapps_logo.paa";
			x = 0.778437 * safezoneW + safezoneX;
			y = 0.8762 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.132 * safezoneH;
		};
	};
	class controls {
        class tree_view {
			idc = 3961523;
			x = 0.175157 * safezoneW + safezoneX;
			y = 0.7618 * safezoneH + safezoneY;
			w = 0.531094 * safezoneW;
			h = 0.1936 * safezoneH;
			type = 12;
			style = 2;
			default = 0;
			blinkingPeriod = 0;
			colorBackground[] = {0,0,0,0.7};
			colorText[] = {1,1,1,1};
			sizeEx = 0.04;
			colorBorder[] = {0,0,0,0};
			colorSelect[] = {1,1,1,0.5};
			colorMarked[] = {0,0,0,0};
			colorMarkedSelected[] = {0,0,0,0};
			font = "RobotoCondensed";
			shadow = 0;
			colorSelectText[] = {1,1,1,1};
			colorMarkedText[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
			tooltipColorText[] = {1,1,1,1};
			tooltipColorBox[] = {1,1,1,1};
			multiselectEnabled = 0;
			expandOnDoubleclick = 1;
			hiddenTexture = "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa";
			expandedTexture = "A3\ui_f\data\gui\rsccommon\rsctree\expandedTexture_ca.paa";
			maxHistoryDelay = 1;
			picture = "";
			colorPicture[] = {1,1,1,1};
			colorPictureSelected[] = {1,1,1,1};
			colorPictureDisabled[] = {1,1,1,1};
			colorPictureRight[] = {1,1,1,1};
			colorPictureRightSelected[] = {1,1,1,1};
			colorPictureRightDisabled[] = {1,1,1,1};
			colorPictureLeft[] = {1,1,1,1};
			colorPictureLeftSelected[] = {1,1,1,1};
			colorPictureLeftDisabled[] = {1,1,1,1};
			class ScrollBar
			{
				width = 0;
				height = 0;
				scrollSpeed = 0.01;
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				color[] = {1,1,1,1};
			};
			colorDisabled[] = {0,0,0,0};
			colorArrow[] = {0,0,0,0};
		};
		class RscText_1002: Life_RscText
		{
			idc = 3961500;
			text = ""; //FPS
			x = 0.959936 * safezoneW + safezoneX;
			y = 0.01732 * safezoneH + safezoneY;
			w = 0.0309379 * safezoneW;
			h = 0.0308 * safezoneH;
            style = 1;
		};
        class RscListbox_1500: tree_view //PLAYERLISTBOX --> TREE
        {
            idc = 3961501;
            x = 0.00757806 * safezoneW + safezoneX;
            y = 0.1326 * safezoneH + safezoneY;
            w = 0.156751 * safezoneW;
            h = 0.7106 * safezoneH;
        };
        class RscEdit_1400: Life_RscEdit
		{
			idc = 3961502;
			text = "$STR_adm_aappsdialog_search";
			x = 0.00809372 * safezoneW + safezoneX;
			y = 0.0974 * safezoneH + safezoneY;
			w = 0.130176 * safezoneW;
			h = 0.0308 * safezoneH;
            maxChars = 25;
            colorBackground[] = {0,0,0,0.6};
		};
		class RscButton_1601: Life_RscButton
		{
			idc = 3961503;
			text = "$STR_adm_aappsdialog_toggle";
			x = 0.00768125 * safezoneW + safezoneX;
			y = 0.9598 * safezoneH + safezoneY;
			w = 0.155926 * safezoneW;
			h = 0.0264 * safezoneH;
			action = "";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
            colorBackground[] = {0,0,0,1};
		};
		class RscButton_1600: Life_RscButton
		{
			idc = 3961504;
			x = 0.14102 * safezoneW + safezoneX;
			y = 0.0974 * safezoneH + safezoneY;
			w = 0.0228982 * safezoneW;
			h = 0.0308 * safezoneH;
            action = "";
			type = 1;
            access = 0;
			colorShadow[] = {0,0,0,0};
            color[] = {1,1,1,1};
            colorActive[] = {1,1,1,1};
            colorBackground[] = {0,0,0,1};
            colorBackgroundFocused[] = {0,0,0,1};
			style = 48 + 0x800;
			text = "\a3\3den\data\displays\display3den\search_start_ca.paa";
		};

        class RscEdit_1401: Life_RscEdit //Consoleedit
		{
			idc = 3961506;
            text = "hint ""Arma sucks"";";
			x = 0.175156 * safezoneW + safezoneX;
			y = 0.0974 * safezoneH + safezoneY;
			w = 0.531094 * safezoneW;
			h = 0.57024 * safezoneH;
            autocomplete = "scripting";
            style = 16;
			lineSpacing = 1;
            colorBackground[] = {0,0,0,0.6};
		};
        class RscListbox_1501: Life_RscListbox
		{
			idc = 3961507;
			x = 0.716561 * safezoneW + safezoneX;
			y = 0.3746 * safezoneH + safezoneY;
			w = 0.273281 * safezoneW;
			h = 0.187 * safezoneH;
            sizeEx = 0.04;
		};
		class RscEdit_1402: Life_RscEdit
		{
			idc = 3961508;
			text = "Name...";
			x = 0.717595 * safezoneW + safezoneX;
			y = 0.5704 * safezoneH + safezoneY;
			w = 0.144369 * safezoneW;
			h = 0.033 * safezoneH;
            colorBackground[] = {0,0,0,0.6};
		};
		class RscButton_1603: Life_RscButton
		{
			idc = 3961509;
			text = "$STR_adm_aappsdialog_savecode";
			x = 0.931062 * safezoneW + safezoneX;
			y = 0.56908 * safezoneH + safezoneY;
			w = 0.0587812 * safezoneW;
			h = 0.033 * safezoneH;
            action = "";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
            colorBackground[] = {0,0,0,1};
		};
		class RscButton_1604: Life_RscButton
		{
			idc = 3961510;
			text = "$STR_adm_aappsdialog_loadcode";
			x = 0.867121 * safezoneW + safezoneX;
			y = 0.5693 * safezoneH + safezoneY;
			w = 0.0587812 * safezoneW;
			h = 0.033 * safezoneH;
            action = "";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
            colorBackground[] = {0,0,0,1};
		};
		class RscEdit_1403: Life_RscEdit
		{
			idc = 3961511;
			text = "";
			x = 0.717594 * safezoneW + safezoneX;
			y = 0.0974 * safezoneH + safezoneY;
			w = 0.273285 * safezoneW;
			h = 0.0242 * safezoneH;
            colorBackground[] = {0,0,0,0.6};
            autocomplete = "scripting";
		};
		class RscEdit_1404: Life_RscEdit
		{
			idc = 3961512;
			text = "";
			x = 0.717594 * safezoneW + safezoneX;
			y = 0.1216 * safezoneH + safezoneY;
			w = 0.273285 * safezoneW;
			h = 0.0242 * safezoneH;
			colorBackground[] = {0,0,0,1};
            style = 16 + 512;
            canModify = false;
		};
		class RscEdit_1405: Life_RscEdit
		{
			idc = 3961513;
			text = "";
			x = 0.717594 * safezoneW + safezoneX;
			y = 0.1546 * safezoneH + safezoneY;
			w = 0.273285 * safezoneW;
			h = 0.0242 * safezoneH;
            colorBackground[] = {0,0,0,0.6};
            autocomplete = "scripting";
		};
		class RscEdit_1406: Life_RscEdit
		{
			idc = 3961514;
			text = "";
			x = 0.717594 * safezoneW + safezoneX;
			y = 0.1788 * safezoneH + safezoneY;
			w = 0.273285 * safezoneW;
			h = 0.0242 * safezoneH;
			colorBackground[] = {0,0,0,1};
            style = 16 + 512;
            canModify = false;
		};
		class RscEdit_1407: Life_RscEdit
		{
			idc = 3961515;
			text = "";
			x = 0.717594 * safezoneW + safezoneX;
			y = 0.2118 * safezoneH + safezoneY;
			w = 0.273285 * safezoneW;
			h = 0.0242 * safezoneH;
            colorBackground[] = {0,0,0,0.6};
            autocomplete = "scripting";
		};
		class RscEdit_1408: Life_RscEdit
		{
			idc = 3961516;
			text = "";
			x = 0.717594 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.273285 * safezoneW;
			h = 0.0242 * safezoneH;
			colorBackground[] = {0,0,0,1};
            style = 16 + 512;
            canModify = false;
		};
		class RscEdit_1409: Life_RscEdit
		{
			idc = 3961517;
			text = "";
			x = 0.717772 * safezoneW + safezoneX;
			y = 0.269326 * safezoneH + safezoneY;
			w = 0.273285 * safezoneW;
			h = 0.0242 * safezoneH;
            colorBackground[] = {0,0,0,0.6};
            autocomplete = "scripting";
		};
		class RscEdit_1410: Life_RscEdit
		{
			idc = 3961518;
			text = "";
			x = 0.717879 * safezoneW + safezoneX;
			y = 0.293052 * safezoneH + safezoneY;
			w = 0.273285 * safezoneW;
			h = 0.0242 * safezoneH;
			colorBackground[] = {0,0,0,1};
            style = 16 + 512;
            canModify = false;
		};
        class RscStructuredText_1101: Life_RscStructuredText
		{
			idc = 3961519;
			text = "$STR_adm_aappsdialog_count";
			x = 0.17016 * safezoneW + safezoneX;
			y = 0.963237 * safezoneH + safezoneY;
			w = 0.175849 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscButton_1605: Life_RscButton
		{
			idc = 3961520;
			text = "$STR_adm_aappsdialog_stats";
			x = 0.349947 * safezoneW + safezoneX;
			y = 0.961808 * safezoneH + safezoneY;
			w = 0.175515 * safezoneW;
			h = 0.0264 * safezoneH;
            action = "";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
            colorBackground[] = {0,0,0,1};
		};
		class RscButton_1606: Life_RscButton
		{
			idc = 3961521;
			text = "$STR_adm_aappsdialog_stats_other";
			x = 0.531303 * safezoneW + safezoneX;
			y = 0.962421 * safezoneH + safezoneY;
			w = 0.174484 * safezoneW;
			h = 0.0264 * safezoneH;
            action = "";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
            colorBackground[] = {0,0,0,1};
		};
		class RscText_1013: Life_RscText
		{
			idc = 3961522;
			text = "";
			x = 0.560066 * safezoneW + safezoneX;
			y = 0.724185 * safezoneH + safezoneY;
			w = 0.149519 * safezoneW;
			h = 0.0308 * safezoneH;
            style = 1;
		};
        class RscListbox_1503: Life_RscListbox
		{
			idc = 3961524;
			x = 0.717595 * safezoneW + safezoneX;
			y = 0.6628 * safezoneH + safezoneY;
			w = 0.273281 * safezoneW;
			h = 0.187 * safezoneH;
            sizeEx = 0.04;
            onLBDblClick = "call compile (lbData[3961524,(_this select 1)])";
		};
		class RscButton_1607: Life_RscButton
		{
			idc = 3961527;
			text = "$STR_adm_aappsdialog_exec_local";
            x = 0.174575 * safezoneW + safezoneX;
        	y = 0.676156 * safezoneH + safezoneY;
        	w = 0.102853 * safezoneW;
        	h = 0.0264 * safezoneH;
            action = "";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
            colorBackground[] = {0,0,0,1};
		};
		class RscButton_1608: Life_RscButton
		{
			idc = 3961528;
			text = "$STR_adm_aappsdialog_exec_global";
            x = 0.281465 * safezoneW + safezoneX;
        	y = 0.676156 * safezoneH + safezoneY;
        	w = 0.102853 * safezoneW;
        	h = 0.0264 * safezoneH;
            action = "";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
            colorBackground[] = {0,0,0,1};
		};
		class RscButton_1609: Life_RscButton
		{
			idc = 3961529;
			text = "$STR_adm_aappsdialog_exec_server";
            x = 0.388396 * safezoneW + safezoneX;
        	y = 0.676156 * safezoneH + safezoneY;
        	w = 0.102853 * safezoneW;
        	h = 0.0264 * safezoneH;
            action = "";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
            colorBackground[] = {0,0,0,1};
		};
		class RscButton_1610: Life_RscButton
		{
			idc = 3961530;
			text = "$STR_adm_aappsdialog_exec_target";
            x = 0.495581 * safezoneW + safezoneX;
        	y = 0.676156 * safezoneH + safezoneY;
        	w = 0.102853 * safezoneW;
        	h = 0.0264 * safezoneH;
            action = "";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
            colorBackground[] = {0,0,0,1};
		};
        class RscStructuredText_1100: Life_RscStructuredText
		{
			idc = 3961531;
            text = "";
			x = 0.00427834 * safezoneW + safezoneX;
			y = 0.8558 * safezoneH + safezoneY;
			w = 0.163477 * safezoneW;
			h = 0.0852 * safezoneH;
		};
        class RscButton_1611: Life_RscButton
        {
        	idc = 3961532;
        	text = "$STR_adm_aappsdialog_exec_group";
        	x = 0.603784 * safezoneW + safezoneX;
        	y = 0.676156 * safezoneH + safezoneY;
        	w = 0.102853 * safezoneW;
        	h = 0.0264 * safezoneH;
            action = "";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
            colorBackground[] = {0,0,0,1};
        };
	};
};
class aapps_adminspawner {
	idd = 9999933;
	name = "aapps_adminspawner";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "";
	class controlsBackground
	{
		class background: Life_RscText
		{
			idc = 9999933;
			x = 0.2195 * safezoneW + safezoneX;
			y = 0.2668 * safezoneH + safezoneY;
			w = 0.5578 * safezoneW;
			h = 0.5104 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
		class Life_RscText_1014: Life_RscText
		{
			idc = -1;
			text = "[AllianceApps] Spawner";
			x = 0.2195 * safezoneW + safezoneX;
			y = 0.1832 * safezoneH + safezoneY;
			w = 0.557798 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
		};
		class Life_RscText_1003: Life_RscText
		{
			idc = -1;
			text = "$STR_adm_aappsdialog_classname";
			x = 0.21951 * safezoneW + safezoneX;
			y = 0.2272 * safezoneH + safezoneY;
			w = 0.214477 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class logo: Life_RscPicture
		{
			idc = -1;
			text = "textures\allianceapps_logo.paa";
			x = 0.778437 * safezoneW + safezoneX;
			y = 0.8762 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.132 * safezoneH;
		};
	};
	class controls {
		class RscText_1000: Life_RscText
		{
			idc = 9999934;
			text = "Name";
			x = 0.439153 * safezoneW + safezoneX;
			y = 0.2272 * safezoneH + safezoneY;
			w = 0.214477 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class RscText_1004: Life_RscText
		{
			idc = 9999935;
			text = "$STR_adm_aappsdialog_weight";
			x = 0.659435 * safezoneW + safezoneX;
			y = 0.226596 * safezoneH + safezoneY;
			w = 0.117563 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.129,0.451,1,1};
			style = 2;
		};
		class Life_RscListbox_1500: Life_RscListNBox
		{
			idc = 9999936;
			x = 0.223625 * safezoneW + safezoneX;
			y = 0.2756 * safezoneH + safezoneY;
			w = 0.550687 * safezoneW;
			h = 0.4928 * safezoneH;
			columns[] = {-0.005,0.39,0.79};
			rowHeight = 0.03;
			drawSideArrows = "false";
			idcLeft = -1;
			idcRight = -1;
		};
		class RscEdit_1400: Life_RscEdit
		{
			idc = 9999937;
			text = "";
			x = 0.659122 * safezoneW + safezoneX;
			y = 0.1876 * safezoneH + safezoneY;
			w = 0.115505 * safezoneW;
			h = 0.0242 * safezoneH;
			colorBackground[] = {0,0,0,0.3};
		};
		class RscButton_1400: Life_RscButton
		{
			idc = 9999945;
			text = "$STR_adm_aappsdialog_search";
			x = 0.659122 * safezoneW + safezoneX;
			y = 0.1876 * safezoneH + safezoneY;
			w = 0.115505 * safezoneW;
			h = 0.0242 * safezoneH;
			action = "ctrlShow[9999945,false]; ctrlSetFocus ((findDisplay 9999933) displayCtrl 9999937)";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
            colorBackground[] = {1,1,1,0.2};
			colorBackgroundActive[] = {1,1,1,0.2};
			colorBackground2[] = {1,1,1,0.2};
			offsetPressedX = 0;
			offsetPressedY = 0;
		};
		class RscButton_1601: Life_RscButton
		{
			idc = 9999939;
			text = "Spawnen";
			x = 0.2195 * safezoneW + safezoneX;
			y = 0.7838 * safezoneH + safezoneY;
			w = 0.557795 * safezoneW;
			h = 0.033 * safezoneH;
			action = "";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
            colorBackground[] = {0,0,0,1};
		};
		class RscEdit_1401: Life_RscEdit
		{
			idc = 9999940;
			text = "1";
			x = 0.223567 * safezoneW + safezoneX;
			y = 0.78446 * safezoneH + safezoneY;
			w = 0.0330003 * safezoneW;
			h = 0.02816 * safezoneH;
			style = 1;
		};
		class Combobox: Life_RscCombo
		{
			idc = 9999941;
			x = 0.659122 * safezoneW + safezoneX;
			y = 0.1865 * safezoneH + safezoneY;
			w = 0.115505 * safezoneW;
			h = 0.0264 * safezoneH;
		};
		class texturecombo: Life_RscCombo
		{
			idc = 9999942;
			x = 0.223624 * safezoneW + safezoneX;
			y = 0.7794 * safezoneH + safezoneY;
			w = 0.121697 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};

class aapps_keymapper {
	idd = 9999700;
	name = "aapps_keymapper";
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
			text = "$STR_adm_aappsdialog_action";
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
			text = "$STR_adm_aappsdialog_keys";
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
			text = "$STR_adm_aappsdialog_actionname"; 
			x = 0.294781 * safezoneW + safezoneX;
			y = 0.3152 * safezoneH + safezoneY;
			w = 0.0845625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class logo: Life_RscPicture
		{
			idc = -1;
			text = "textures\allianceapps_logo.paa";
			x = 0.778437 * safezoneW + safezoneX;
			y = 0.8762 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.132 * safezoneH;
		};
	};
	class controls {
		class RscEdit_1400: Life_RscEdit
		{
			idc = 9999700;
			text = ""; 
			x = 0.352529 * safezoneW + safezoneX;
			y = 0.3196 * safezoneH + safezoneY;
			w = 0.349558 * safezoneW;
			h = 0.0264 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
		class RscButton_1400: Life_RscButton
		{
			idc = 9999703;
			text = "$STR_adm_aappsdialog_search";
			x = 0.352529 * safezoneW + safezoneX;
			y = 0.3196 * safezoneH + safezoneY;
			w = 0.349558 * safezoneW;
			h = 0.0264 * safezoneH;
			action = "ctrlShow[9999703,false]; ctrlSetFocus ((findDisplay 9999700) displayCtrl 9999700)";
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
			idc = 9999704;
			x = 0.293729 * safezoneW + safezoneX;
			y = 0.4032 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.2904 * safezoneH;
			colorBackground[] = {0,0,0,0.6};
		};
		class RscListbox_1500: Life_RscListNBox
		{
			idc = 9999701;
			x = 0.296844 * safezoneW + safezoneX;
			y = 0.4076 * safezoneH + safezoneY;
			w = 0.406313 * safezoneW;
			h = 0.2794 * safezoneH;
			columns[] = {-0.005,0.5};
			rowHeight = 0.03;
			drawSideArrows = "false";
			idcLeft = -1;
			idcRight = -1;
		};
		class RscText_1006: Life_RscStructuredText
		{
			idc = 9999702;
			text = "";
			x = 0.414407 * safezoneW + safezoneX;
			y = 0.4296 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		class RscButton_1600: Life_RscButton
		{
			idc = 9999705;
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
			idc = 9999706;
			text = "$STR_adm_aappsdialog_reset";
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
			idc = 9999707;
			text = "$STR_adm_aappsdialog_save";
			x = 0.570125 * safezoneW + safezoneX;
			y = 0.7002 * safezoneH + safezoneY;
			w = 0.136126 * safezoneW;
			h = 0.033 * safezoneH;
			action = "";
			type = 1; access = 0;
			colorBackground[] = {0,0,0,1};
			colorShadow[] = {0,0,0,0};
		};
	};
};
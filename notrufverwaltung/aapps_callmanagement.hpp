/*
 *
 *	@File:		aapps_callmanagement.hpp
 *	@Author: 	AllianceApps
 *	@Date:		21.10.2017
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *  
 */

class aapps_calls {
	cop_call_messages[] = {
		{"$STR_DC_MSG_cop_onmyway_title","$STR_DC_MSG_cop_onmyway"},
		{"$STR_DC_MSG_cop_wquestions_title","$STR_DC_MSG_cop_wquestions"},
		{"$STR_DC_MSG_cop_understaffed_title","$STR_DC_MSG_cop_understaffed"},
		{"$STR_DC_MSG_cop_terrorist_title","$STR_DC_MSG_cop_terrorist"}
	};
	med_call_messages[] = {
		{"$STR_DC_MSG_cop_onmyway_title","$STR_DC_MSG_cop_onmyway"},
		{"$STR_DC_MSG_cop_wquestions_title","$STR_DC_MSG_cop_wquestions"},
		{"$STR_DC_MSG_cop_understaffed_title","$STR_DC_MSG_cop_understaffed"},
		{"$STR_DC_MSG_cop_terrorist_title","$STR_DC_MSG_cop_terrorist"}
	};
};



class aapps_callmanagement {
    name = "aapps_callmanagement";
    idd = 1011001;
	movingEnable = false;
	enableSimulation = true;
	onLoad = "";
	
	class controlsBackground {
		class background: Life_RscText
		{
			idc = -1;
			x = 0.293777 * safezoneW + safezoneX;
			y = 0.3108 * safezoneH + safezoneY;
			w = 0.412444 * safezoneW;
			h = 0.3982 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class Life_RscText_1001: Life_RscText
		{
			idc = -1;
			text = "$STR_DC_dispatchcenter";
			x = 0.293777 * safezoneW + safezoneX;
			y = 0.2844 * safezoneH + safezoneY;
			w = 0.412444 * safezoneW;
			h = 0.0286 * safezoneH;
			colorBackground[] = {0.827,0.329,0,1};
			style = 2;
		};
		class Life_RscText_1002: Life_RscText
		{
			idc = -1;
			text = "$STR_DC_availabledispatches";
			x = 0.296885 * safezoneW + safezoneX;
			y = 0.3196 * safezoneH + safezoneY;
			w = 0.103144 * safezoneW;
			h = 0.0242 * safezoneH;
			colorBackground[] = {0.827,0.329,0,1};
			style = 2;
		};
		class Life_RscText_1004: Life_RscText
		{
			idc = -1;
			text = "$STR_DC_information";
			x = 0.403083 * safezoneW + safezoneX;
			y = 0.3196 * safezoneH + safezoneY;
			w = 0.301096 * safezoneW;
			h = 0.0242 * safezoneH;
			colorBackground[] = {0.827,0.329,0,1};
			style = 2;
		};
		class Life_RscText_1005: Life_RscText
		{
			idc = -1;
			text = "$STR_DC_answer";
			x = 0.403081 * safezoneW + safezoneX;
			y = 0.5352 * safezoneH + safezoneY;
			w = 0.301096 * safezoneW;
			h = 0.0242 * safezoneH;
			colorBackground[] = {0.827,0.329,0,1};
			style = 2;
		};
		class Life_RscText_1003: Life_RscText
		{
			idc = -1;
			text = "Name:";
			x = 0.39997 * safezoneW + safezoneX;
			y = 0.3482 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.0264 * safezoneH;
			font = "RobotoCondensedBold";
		};
		class Life_RscText_1007: Life_RscText
		{
			idc = -1;
			text = "Position:";
			x = 0.400117 * safezoneW + safezoneX;
			y = 0.375111 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.0264 * safezoneH;
			font = "RobotoCondensedBold";
		};
		class Life_RscText_1009: Life_RscText
		{
			idc = -1;
			text = "$STR_DC_assigned";
			x = 0.400606 * safezoneW + safezoneX;
			y = 0.415741 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.0264 * safezoneH;
			font = "RobotoCondensedBold";
		};
		class Life_RscText_1011: Life_RscText
		{
			idc = -1;
			text = "$STR_DC_distance";
			x = 0.400734 * safezoneW + safezoneX;
			y = 0.441311 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.0264 * safezoneH;
			font = "RobotoCondensedBold";
		};
		class Life_RscText_1013: Life_RscText
		{
			idc = -1;
			text = "$STR_DC_unfinished";
			x = 0.400638 * safezoneW + safezoneX;
			y = 0.468511 * safezoneH + safezoneY;
			w = 0.0639374 * safezoneW;
			h = 0.0264 * safezoneH;
			font = "RobotoCondensedBold";
		};
		
		class Life_RscButton_1600: Life_RscButton
		{
			idc = -1;
			text = "$STR_DC_seedispatch";
			x = 0.402764 * safezoneW + safezoneX;
			y = 0.500111 * safezoneH + safezoneY;
			w = 0.152612 * safezoneW;
			h = 0.0264 * safezoneH;
			colorBackground[] = {0,0,0,1};
			colorText[] = {255,255,255,1};
			colorActive[] = {0,0,0,1};
			colorBackgroundActive[] = {0.902,0.494,0.133,1};
			colorFocused[] = {0.902,0.494,0.133,1};
			action = "0 spawn life_call_showcall";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
		};
		class Life_RscText_1015: Life_RscText
		{
			idc = -1;
			text = "$STR_DC_sendposition";
			x = 0.572189 * safezoneW + safezoneX;
			y = 0.5682 * safezoneH + safezoneY;
			w = 0.0928124 * safezoneW;
			h = 0.0198 * safezoneH;
		};
		class Life_RscButton_1603: Life_RscButton
		{
			idc = -1;
			text = "$STR_DC_send";
			x = 0.403605 * safezoneW + safezoneX;
			y = 0.678007 * safezoneH + safezoneY;
			w = 0.152612 * safezoneW;
			h = 0.0264 * safezoneH;
			colorBackground[] = {0,0,0,1};
			colorText[] = {255,255,255,1};
			colorActive[] = {0,0,0,1};
			colorBackgroundActive[] = {0.902,0.494,0.133,1};
			colorFocused[] = {0.902,0.494,0.133,1};
			action = "0 call life_call_sendmessage";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
		};
		class Life_RscButton_1604: Life_RscButton
		{
			idc = -1;
			text = "$STR_Global_Close";
			x = 0.560937 * safezoneW + safezoneX;
			y = 0.677422 * safezoneH + safezoneY;
			w = 0.141271 * safezoneW;
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
		class eintraege: Life_RscListbox
		{
			idc = 1011002;
			x = 0.296862 * safezoneW + safezoneX;
			y = 0.3438 * safezoneH + safezoneY;
			w = 0.103124 * safezoneW;
			h = 0.297 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			onLBSelChanged = "0 spawn life_call_lbchange";
			sizeEx = 0.04;
		};
		class mapcontrol: Life_RscMapControl
		{
			idc = 1011003;
			x = 0.559309 * safezoneW + safezoneX;
			y = 0.348741 * safezoneH + safezoneY;
			w = 0.144364 * safezoneW;
			h = 0.17666 * safezoneH;
			maxSatelliteAlpha = 0.75;
            alphaFadeStartScale = 1.15;
            alphaFadeEndScale = 1.29;
		};
		class Life_RscEdit_1400: Life_RscEdit
		{
			idc = 1011004;
			text = "";
			x = 0.404366 * safezoneW + safezoneX;
			y = 0.598859 * safezoneH + safezoneY;
			w = 0.297983 * safezoneW;
			h = 0.0748 * safezoneH;
			lineSpacing = 1;
			style = 16;
		};
		class Life_RscCheckbox_2800: Life_Checkbox
		{
			idc = 1011005;
			x = 0.557939 * safezoneW + safezoneX;
			y = 0.564963 * safezoneH + safezoneY;
			w = 0.0175315 * safezoneW;
			h = 0.0264 * safezoneH;
			sizeEx = 0.04;
		};
		class Life_RscCombo_2100: Life_RscCombo
		{
			idc = 1011006;
			x = 0.403062 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.152612 * safezoneW;
			h = 0.0264 * safezoneH;
			onLBSelChanged = "0 call life_call_msgchange";
		};
		class Life_RscText_1014: Life_RscText
		{
			idc = 1011007;
			text = ""; //zeitinput
			x = 0.460651 * safezoneW + safezoneX;
			y = 0.468282 * safezoneH + safezoneY;
			w = 0.0938435 * safezoneW;
			h = 0.0264 * safezoneH;
			style = 1;
		};
		class Life_RscText_1012: Life_RscText
		{
			idc = 1011008;
			text = ""; //distanzinput
			x = 0.445366 * safezoneW + safezoneX;
			y = 0.44143 * safezoneH + safezoneY;
			w = 0.108279 * safezoneW;
			h = 0.0264 * safezoneH;
			style = 1;
		};
		class Life_RscText_1010: Life_RscText
		{
			idc = 1011009;
			text = ""; //bearbeiterinput
			x = 0.445398 * safezoneW + safezoneX;
			y = 0.415687 * safezoneH + safezoneY;
			w = 0.108279 * safezoneW;
			h = 0.0264 * safezoneH;
			style = 1;
		};
		class Life_RscText_1006: Life_RscText
		{
			idc = 1011010;
			text = ""; //nameinput
			x = 0.436682 * safezoneW + safezoneX;
			y = 0.348259 * safezoneH + safezoneY;
			w = 0.117558 * safezoneW;
			h = 0.0264 * safezoneH;
			style = 1;
		};
		class Life_RscText_1008: Life_RscText
		{
			idc = 1011011;
			text = ""; //positioninput
			x = 0.436578 * safezoneW + safezoneX;
			y = 0.37526 * safezoneH + safezoneY;
			w = 0.0969334 * safezoneW;
			h = 0.0264 * safezoneH;
			style = 1;
		};
		class Picture_Button: Life_RscButton
		{
			idc = 1011012;
			x = 0.539806 * safezoneW + safezoneX;
			y = 0.37746 * safezoneH + safezoneY;
			w = 0.012375 * safezoneW;
			h = 0.022 * safezoneH;
			action = "";
			type = 1;
			access = 0;
			colorShadow[] = {0,0,0,0};
			color[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
			style = 48 + 0x800;
			text = "";
		};
		class Life_RscButton_1602: Life_RscButton
		{
			idc = 1011013;
			text = "$STR_DC_accept";
			x = 0.297035 * safezoneW + safezoneX;
			y = 0.645615 * safezoneH + safezoneY;
			w = 0.103124 * safezoneW;
			h = 0.0264 * safezoneH;
			colorBackground[] = {0,0,0,1};
			colorText[] = {255,255,255,1};
			colorActive[] = {0,0,0,1};
			colorBackgroundActive[] = {0.902,0.494,0.133,1};
			colorFocused[] = {0.902,0.494,0.133,1};
			action = "0 spawn life_call_accept";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorDisabled[] = {1,1,1,0.5};
		};
		class Life_RscButton_1601: Life_RscButton
		{
			idc = 1011014;
			text = "$STR_DC_delete";
			x = 0.297003 * safezoneW + safezoneX;
			y = 0.67777 * safezoneH + safezoneY;
			w = 0.103124 * safezoneW;
			h = 0.0264 * safezoneH;
			colorBackground[] = {0,0,0,1};
			colorText[] = {255,255,255,1};
			colorActive[] = {0,0,0,1};
			colorBackgroundActive[] = {0.902,0.494,0.133,1};
			colorFocused[] = {0.902,0.494,0.133,1};
			action = "0 spawn life_call_delete";
			type = 1;access = 0;
			colorShadow[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorDisabled[] = {1,1,1,0.5};
		};
	};
};
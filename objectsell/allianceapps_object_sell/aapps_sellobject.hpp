/*
 *
 *	@File:		aapps_sellobject.hpp
 *	@Author: 	AllianceApps
 *	@Date:		17.12.2017
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *  
 */
class aapps_sell_object {
	idd = 198802;
	name = "aapps_sell_object";
	movingEnable = 1;
	
	class controlsBackground {
		class Life_RscTextabc: Life_RscText
		{
			idc = -1;
			text = "$STR_trade_gui_title";
			x = 0.417494 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.165001 * safezoneW;
			h = 0.023 * safezoneH;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			style = 2;
		};
		class RscText_1000: Life_RscText //Background
		{
			idc = -1;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.4384 * safezoneH + safezoneY;
			w = 0.164984 * safezoneW;
			h = 0.1122 * safezoneH;
			moving = 1;
			colorBackground[] = {0,0,0,0.8};
		};
		class RscText_1001: Life_RscText
		{
			idc = -1;
			text = "$STR_trade_gui_players";
			x = 0.420594 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.0176 * safezoneH;
		};
		class RscText_1002: Life_RscText
		{
			idc = -1;
			text = "$STR_trade_gui_price";
			x = 0.420593 * safezoneW + safezoneX;
			y = 0.5022 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.0176 * safezoneH;
		};
		class RscText_1003: Life_RscText
		{
			idc = -1;
			text = "€";
			x = 0.564852 * safezoneW + safezoneX;
			y = 0.500089 * safezoneH + safezoneY;
			w = 0.0113438 * safezoneW;
			h = 0.0264 * safezoneH;
			style = 2;
		};
	};
	class controls {
		class RscCombo_2100: Life_RscCombo
		{
			idc = 1988020;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.110354 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscEdit_1400: Life_RscEdit
		{
			idc = 1988021;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0989998 * safezoneW;
			h = 0.0264 * safezoneH;
			text = "";
			style = 1;
		};
		class RscButton_1600: Life_RscButton
		{
			idc = -1;
			text = "$STR_trade_gui_cancel";
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.0814734 * safezoneW;
			h = 0.02354 * safezoneH;
			action = "closeDialog 0";
			type = 1;
			access = 0;
			colorShadow[] = {0,0,0,0};
		};
		class RscButton_1601: Life_RscButton
		{
			idc = -1;
			text = "$STR_trade_gui_request";
			x = 0.502063 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.0804422 * safezoneW;
			h = 0.02354 * safezoneH;
			action = "0 spawn life_fnc_makeSellRequest";
			type = 1;
			access = 0;
			colorShadow[] = {0,0,0,0};
		};
	};
};
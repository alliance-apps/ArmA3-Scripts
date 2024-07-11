/*
 *
 *	@File:		idcard_anzeie.hpp
 *	@Author: 	AllianceApps
 *	@Date:		01.10.2017
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *  
 */
class idcard_show {
    idd = -1;
	name = "idcard_show";
    duration = 10;
    movingEnable = 0;
    fadein = 0;
    fadeout = 1;
    onLoad = "uiNamespace setVariable ['idcard_show',_this select 0]";
	
	class controlsBackground {
		class RscPicture_1200: Life_RscPicture
		{
			idc = 2765;
			text = "";
			x = 0.0153126 * safezoneW + safezoneX;
			y = 0.6276 * safezoneH + safezoneY;
			w = 0.266057 * safezoneW;
			h = 0.242 * safezoneH;
		};
	};
	class controls {
		class RscText_1001: Life_RscText
		{
			idc = 2750;
			text = "";
			x = 0.091625 * safezoneW + safezoneX;
			y = 0.69162 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.0088 * safezoneH;
			sizeEx = 0.028;
		};
		class RscText_1002: Life_RscText
		{
			idc = 2751;
			text = "";
			x = 0.0913157 * safezoneW + safezoneX;
			y = 0.70416 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.0088 * safezoneH;
			sizeEx = 0.028;
		};
		class RscText_1003: Life_RscText
		{
			idc = 2752;
			text = "";
			x = 0.0916253 * safezoneW + safezoneX;
			y = 0.7156 * safezoneH + safezoneY;
			w = 0.100031 * safezoneW;
			h = 0.011 * safezoneH;
			sizeEx = 0.028;
		};
		class RscText_1004: Life_RscText
		{
			idc = 2753;
			text = "";
			x = 0.0916251 * safezoneW + safezoneX;
			y = 0.72836 * safezoneH + safezoneY;
			w = 0.100031 * safezoneW;
			h = 0.011 * safezoneH;
			sizeEx = 0.028;
		};
		class RscText_1005: Life_RscText
		{
			idc = 2754;
			text = "";
			x = 0.091625 * safezoneW + safezoneX;
			y = 0.7398 * safezoneH + safezoneY;
			w = 0.100031 * safezoneW;
			h = 0.011 * safezoneH;
			sizeEx = 0.028;
		};
		class RscText_1006: Life_RscText
		{
			idc = 2755;
			text = "";
			x = 0.0916253 * safezoneW + safezoneX;
			y = 0.75344 * safezoneH + safezoneY;
			w = 0.100031 * safezoneW;
			h = 0.011 * safezoneH;
			sizeEx = 0.028;
		};
		class RscText_1007: Life_RscText
		{
			idc = 2756;
			text = "";
			x = 0.091625 * safezoneW + safezoneX;
			y = 0.76642 * safezoneH + safezoneY;
			w = 0.100031 * safezoneW;
			h = 0.011 * safezoneH;
			sizeEx = 0.028;
		};
		class RscText_1008: Life_RscText
		{
			idc = 2757;
			text = "";
			x = 0.091625 * safezoneW + safezoneX;
			y = 0.77764 * safezoneH + safezoneY;
			w = 0.100031 * safezoneW;
			h = 0.011 * safezoneH;
			sizeEx = 0.028;
		};
		class RscText_1009: Life_RscText
		{
			idc = 2758;
			text = "";
			x = 0.091625 * safezoneW + safezoneX;
			y = 0.7915 * safezoneH + safezoneY;
			w = 0.100031 * safezoneW;
			h = 0.011 * safezoneH;
			sizeEx = 0.028;
		};
		class RscText_1000: Life_RscText
		{
			idc = 2759;
			text = "";
			x = 0.070175 * safezoneW + safezoneX;
			y = 0.82406 * safezoneH + safezoneY;
			w = 0.0433125 * safezoneW;
			h = 0.0154 * safezoneH;
			style = 2;
		};
		class RscText_1010: Life_RscText
		{
			idc = 2760;
			text = "";
			x = 0.137074 * safezoneW + safezoneX;
			y = 0.82406 * safezoneH + safezoneY;
			w = 0.00928135 * safezoneW;
			h = 0.0154 * safezoneH;
		};
		class RscText_1011: Life_RscText
		{
			idc = 2761;
			text = "";
			x = 0.182406 * safezoneW + safezoneX;
			y = 0.82406 * safezoneH + safezoneY;
			w = 0.0680624 * safezoneW;
			h = 0.0154 * safezoneH;
			style = 2;
		};
		class RscText_1012: Life_RscText
		{
			idc = 2762;
			text = "";
			x = 0.0483988 * safezoneW + safezoneX;
			y = 0.84452 * safezoneH + safezoneY;
			w = 0.0515627 * safezoneW;
			h = 0.0154 * safezoneH;
			style = 2;
		};
		class RscText_1013: Life_RscText
		{
			idc = 2763;
			text = "";
			x = 0.118522 * safezoneW + safezoneX;
			y = 0.8443 * safezoneH + safezoneY;
			w = 0.0360941 * safezoneW;
			h = 0.0154 * safezoneH;
		};
		class RscText_1015: Life_RscText
		{
			idc = 2764;
			text = "";
			x = 0.203603 * safezoneW + safezoneX;
			y = 0.843867 * safezoneH + safezoneY;
			w = 0.00928135 * safezoneW;
			h = 0.0154 * safezoneH;
		};
	};
};
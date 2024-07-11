/*
 *
 *	@File:		fn_animtext.sqf
 *	@Author: 	AllianceApps
 *	@Date:		31.07.2019
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *
 */
params [
    ["_title", "", [""]],
    ["_titlecolor", "#FFFFFF", [""]],
    ["_subtitle", "", [""]],
    ["_subtitlecolor", "#FFFFFF", [""]]
];
if((_title isEqualTo "") || {_subtitle isEqualTo ""}) exitWith {};
[parseText format
	["<t align='center'><t color='%1' font='PuristaBold' size='2'>%2<br/></t><t font='PuristaMedium' color='%3' size='1.5'>%4</t>",_titlecolor,_title,_subtitlecolor, _subtitle],
	[0.324759 * safezoneW + safezoneX,0.3856 * safezoneH + safezoneY,0.350625 * safezoneW,0.286 * safezoneH],
	nil,5,0.7,0
] spawn BIS_fnc_textTiles;

#include "..\..\script_macros.hpp"
scriptName "fn_idcardNameCheck";
/*
 *
 *	@File:		fn_idcardCreated.sqf
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
if(isNil "life_idcard_data") exitWith {hint "Error prevention";false};
if((count life_idcard_data) isEqualTo 0) exitWith {true};
_name = life_idcard_data param [0, "", [""]];
if(!(profileName isEqualto _name)) exitWith {
	hint parseText format[localize "STR_capps_wrongname",_name];
	["end1",false,true,true,true] spawn BIS_fnc_endMission;
	false
};
true

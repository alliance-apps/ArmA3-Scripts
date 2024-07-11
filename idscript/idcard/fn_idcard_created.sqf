#include "..\..\script_macros.hpp"
scriptName "fn_idcardCreated";
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
_type = param [0, -1, [0]];
if(_type isEqualTo -1) exitWith {};
if(_type isEqualTo 0) then {
	hint (localize "STR_capps_already_db");
	_side = switch(playerSide) do {
		case WEST: {"COP"};
		case CIVILIAN: {"CIV"};
		case INDEPENDENT: {"MED"};
		case OPFOR: {"OPFOR"};
		default{"UNKNOWN"};
	};
	if(life_idcard_data isEqualTo []) then {
		CASH = CASH + getNumber(missionConfigFile >> "aapps_idcard_config" >> (_side + "_price_new"));
	} else {
		CASH = CASH + getNumber(missionConfigFile >> "aapps_idcard_config" >> (_side + "_price_change"));
	};
} else {
	[] call SOCK_fnc_updateRequest;
	hint (localize "STR_capps_success");
	closeDialog 0;
	life_idcard_data = param [1, [], [[]]];
	0 call life_fnc_idcard_NameCheck;
};

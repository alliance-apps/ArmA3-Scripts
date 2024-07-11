#include "..\..\script_macros.hpp"
scriptName "fn_show_idcard";
/*
 *
 *	@File:		fn_show_idcard.sqf
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
params [
	["_data", [], [[]]],
	["_uid", "", [""]],
	["_playerside", civilian, [civilian]]
];
if((_data isEqualTo []) OR {_uid isEqualTo ""}) exitWith {};
if(!alive player) exitWith {};
disableSerialization;
"idcard_show" cutRsc ["idcard_show","PLAIN"];
_display = uiNamespace getVariable "idcard_show";
_language = if(language in ["English","German"]) then {language} else {getText(missionConfigFile >> "aapps_idcard_config" >> "cfgPrimaryLanguage")};
_namearr = ((_data select 0) splitString " ");
_lastname = _namearr select ((count _namearr) -1);
if(_playerside isEqualTo CIVILIAN) exitWith {
	if((_data select 4) isEqualTo "STR_capps_gender_male") then {
		(_display displayCtrl 2765) ctrlSetText format["core\idcard\textures\idcard_male_%1.paa",_language];
	} else {
		(_display displayCtrl 2765) ctrlSetText format["core\idcard\textures\idcard_female_%1.paa",_language];
	};
	_type = (_data select 2) splitString ".";
	reverse _type;
	if((parseNumber (_type joinString "")) < 19800000) then {
		_type = "A";
	} else {
		_type = "B";
	};
	(_display displayCtrl 2750) ctrlSetText _type; //TYPE
	(_display displayCtrl 2764) ctrlSetText _type; //TYPE
	(_display displayCtrl 2751) ctrlSetText (_uid select [13,17]); //ID
	(_display displayCtrl 2752) ctrlSetText (_data select 0); //Name
	(_display displayCtrl 2753) ctrlSetText (_data select 5); //anschrift1
	(_display displayCtrl 2754) ctrlSetText (_data select 6); //anschrift2
	(_display displayCtrl 2755) ctrlSetText (_data select 1); //Geburtsdatum
	(_display displayCtrl 2756) ctrlSetText format["%1, %2",_data select 2,_data select 3]; //Geburtsort
	(_display displayCtrl 2757) ctrlSetText (localize (_data select 4)); //Geschlecht
	(_display displayCtrl 2758) ctrlSetText (_data select 7); //Blutgruppe
	(_display displayCtrl 2759) ctrlSetText toUpper(_namearr select 0);
	(_display displayCtrl 2760) ctrlSetText toUpper(_lastname select [0,1]);
	(_display displayCtrl 2761) ctrlSetText toUpper(_lastname);
	(_display displayCtrl 2762) ctrlSetText toUpper(_data select 3);
	(_display displayCtrl 2763) ctrlSetText (_uid select [11,17]);
};
if((_data select 4) isEqualTo "STR_capps_gender_male") then {
	(_display displayCtrl 2765) ctrlSetText format["core\idcard\textures\%1_male_%2.paa",_playerside,_language];
} else {
	(_display displayCtrl 2765) ctrlSetText format["core\idcard\textures\%1_female_%2.paa",_playerside,_language];
};
(_display displayCtrl 2752) ctrlSetText _lastname;
_namearr deleteAt ((count _namearr) -1);
(_display displayCtrl 2751) ctrlSetText (_namearr joinString " ");
_rank = param [3, 0, [0]];
_rank = getText(missionConfigFile >> "aapps_idcard_config" >> format["rank_names_%1",_playerside] >> format["rank_%1",_rank]);
if(_rank isEqualTo "") then {_rank = "Error not defined"};
(_display displayCtrl 2755) ctrlSetText _rank;
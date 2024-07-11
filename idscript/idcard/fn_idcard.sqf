#include "..\..\script_macros.hpp"
scriptName "fn_idcard";
/*
 *
 *	@File:		fn_idcard.sqf
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
	["_type", -1, [0]],
	["_fakeid", false, [false]]
];
if(_type isEqualTo -1) exitWith {};
disableSerialization;
_display = findDisplay 4689200;
_name = _display displayCtrl 4689201;
_birthday = _display displayCtrl 4689202;
_birthmonth = _display displayCtrl 4689203;
_birthyear = _display displayCtrl 4689204;
_birthplace = _display displayCtrl 4689205;
_birthcountry = _display displayCtrl 4689206;
_gender = _display displayCtrl 4689207;
_address = _display displayCtrl 4689208;
_ZIP = _display displayCtrl 4689209;
_place = _display displayCtrl 4689210;
_bloodtype = _display displayCtrl 4689211;
_access_btn = _display displayCtrl 4689212;
if(_type isEqualTo 0) exitWith {//ONLOAD
	_name ctrlSetText profileName;		
	for "_i" from 1 to 31 do {
		if(_i < 10) then {
			_birthday lbAdd format["0%1",_i];
		} else {
			_birthday lbAdd str _i;
		};
	};
	for "_i" from 1 to 12 do {
		if(_i < 10) then {
			_birthmonth lbAdd format["0%1",_i];
		} else {
			_birthmonth lbAdd str _i;
		};
	};
	for "_i" from 1950 to 2001 do {
		_birthyear lbAdd str _i;
	};
	{
		_birthcountry lbadd _x;
	} forEach getArray(missionConfigFile >> "aapps_idcard_config" >> "cfgIslands");
	_gender lbAdd (localize "STR_capps_gender_female");
	_gender lbSetData[(lbsize _gender)-1,"STR_capps_gender_female"];
	_gender lbAdd (localize "STR_capps_gender_male");
	_gender lbSetData[(lbsize _gender)-1,"STR_capps_gender_male"];
	{
		_bloodtype lbAdd _x;
	} forEach getArray(missionConfigFile >> "aapps_idcard_config" >> "cfgBloodtypes");
	if((!isNil "life_idcard_fake") && {life_idcard_fake}) then {
		life_idcard_fake = false;
		_access_btn ctrlSetEventHandler
		[
			"ButtonDown",
			"
				[1,true] spawn life_fnc_idcard
			"
		];
	} else {
		_access_btn ctrlSetEventHandler
		[
			"ButtonDown",
			"
				[1] spawn life_fnc_idcard
			"
		];
	};
};
if(_type isEqualTo 1) exitWith {
	if(count(ctrlText _name) < 5) exitWith {
		hint (localize "STR_capps_name_too_short");
	};
	_bad = false;
	{
		if([_x, (tolower(ctrlText _name))] call BIS_fnc_inString) then {
			_bad = true;
		};
	} foreach getArray(missionConfigFile >> "aapps_idcard_config" >> "cfgNameBlacklist");
	if(_bad) exitWith {
		hint (localize "STR_capps_name_not_valid");
	};
	if((lbCurSel _birthday) isEqualTo -1) exitWith {
		hint (localize "STR_capps_birth_not_valid_day");
	};
	if((lbCurSel _birthmonth) isEqualTo -1) exitWith {
		hint (localize "STR_capps_birth_not_valid_month");
	};
	if((lbCurSel _birthyear) isEqualTo -1) exitWith {
		hint (localize "STR_capps_birth_not_valid_years");
	};
	if(((parseNumber (_birthmonth lbtext (lbcursel _birthmonth))) isEqualTo 2) && {(parseNumber (_birthday lbtext (lbcursel _birthday))) > 28}) exitWith {
		hint (localize "STR_capps_birth_february");
	};
	if(count(ctrlText _birthplace) < 5) exitWith {
		hint (localize "STR_capps_birth_place");
	};
	if(tolower(ctrlText _birthplace) in ["gebort","geburtort","geburtsort","birthplace"]) exitWith {
		hint (localize "STR_capps_birth_place_not_valid");
	};
	if((lbCurSel _birthcountry) isEqualto -1) exitWith {
		hint (localize "STR_capps_birth_country");
	};
	if((lbCurSel _gender) isEqualTo -1) exitWith {
		hint (localize "STR_capps_no_gender");
	};
	if(count(ctrlText _address) < 5) exitWith {
		hint (localize "STR_capps_short_address");
	};
	_count = count(ctrlText _ZIP);
	if((!(count(str(parseNumber(ctrlText _ZIP))) isEqualTo _count)) || {!(_count in [3,4,5])}) exitWith {
		hint (localize "STR_capps_wrong_zip");
	};
	if(count(ctrlText _place) < 5) exitWith {
		hint (localize "STR_capps_short_place");
	};
	if((lbCurSel _bloodtype) isEqualTo -1) exitWith {
		hint (localize "STR_capps_wrong_blood_type");
	};
	_result = false;
	{
		if((count(ctrlText _x)) > 20) then {
			_result = true;
		};
	} forEach [_birthplace,_address,_place];
	if(_result) exitWith {
		hint (localize "STR_capps_some_inputs_too_long");
	};
	_result = false;
	if(_fakeid) then {
		_result = [localize "STR_capps_gui_question_fake", localize "STR_capps_gui_title", localize "STR_capps_gui_accept", localize "STR_capps_gui_decline"] call BIS_fnc_guiMessage;
		if(_result) then {
			if ([false,"fakeidcard",1] call life_fnc_handleInv) then {
				life_idcard_data = [(ctrlText _name),([(_birthday lbText (lbcursel _birthday)),(_birthmonth lbtext (lbcursel _birthmonth)),(_birthyear lbtext (lbcursel _birthyear))] joinString "."),(ctrlText _birthplace),(_birthcountry lbtext (lbcursel _birthcountry)),(_gender lbData (lbcursel _gender)),(ctrlText _address),([(ctrlText _ZIP),(ctrlText _place)] joinString " "),(_bloodtype lbText (lbcursel _bloodtype))];
				hint format[localize "STR_capps_fake_done", (ctrlText _name)];
				closeDialog 0;
			} else {
				hint localize "STR_Item_fakeidcard_notgiven";
			};
		};
	} else {
		_money = 0;
		_side = switch(playerSide) do {
			case WEST: {"COP"};
			case CIVILIAN: {"CIV"};
			case INDEPENDENT: {"MED"};
			case OPFOR: {"OPFOR"};
			default{"UNKNOWN"};
		};
		if(life_idcard_data isEqualTo []) then {
			_money = getNumber(missionConfigFile >> "aapps_idcard_config" >> (_side + "_price_new"));
		} else {
			_money = getNumber(missionConfigFile >> "aapps_idcard_config" >> (_side + "_price_change"));
		};
		_result = [format[localize "STR_capps_gui_question",[_money] call life_fnc_numberText], localize "STR_capps_gui_title", localize "STR_capps_gui_accept", localize "STR_capps_gui_decline"] call BIS_fnc_guiMessage;
		if(!_result) exitWith {};
		if(CASH < _money) exitWith {
			hint format[localize "STR_capps_not_enough",[_money] call life_fnc_numberText];
		};
		CASH = CASH - _money;
		_access_btn ctrlShow false;
		_data = [(ctrlText _name),([(_birthday lbText (lbcursel _birthday)),(_birthmonth lbtext (lbcursel _birthmonth)),(_birthyear lbtext (lbcursel _birthyear))] joinString "."),(ctrlText _birthplace),(_birthcountry lbtext (lbcursel _birthcountry)),(_gender lbData (lbcursel _gender)),(ctrlText _address),([(ctrlText _ZIP),(ctrlText _place)] joinString " "),(_bloodtype lbText (lbcursel _bloodtype))];
		[player,getplayeruid player,playerside,_data] remoteExecCall ["ton_fnc_updateidcard",2];
		[_access_btn] spawn {
			disableSerialization;
			uisleep 3;
			(_this select 0) ctrlShow true;
		};
	};
};

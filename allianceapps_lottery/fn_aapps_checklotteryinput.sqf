#include "..\..\script_macros.hpp"
/*
 *
 *	@File:		fn_aapps_checklotteryinput.sqf
 *	@Author: 	AllianceApps
 *	@Date:		24.12.2017
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *  
 */
scriptName "fn_aapps_checklotteryinput";
_type = [_this, 0, -1] call bis_fnc_param;
if(_type isEqualTo -1) exitWith {};
if(_type isEqualTo 0) exitWith {
	closeDialog 0;
	createDialog "aapps_lottery";
	if(isNil "lottery_example_code") then {
		_numbers = [];
		for "_i" from getNumber(missionConfigFile >> "aapps_lottery_config" >> "values" >> "lowestvalue") to getNumber(missionConfigFile >> "aapps_lottery_config" >> "values" >> "highestvalue") do {
			_enumber = str _i;
			if((count _enumber) isEqualTo 1) then {
				_enumber = format["0%1",_i];
			};
			_numbers pushBack _enumber;
		};
		_lotterynumbers = [];
		for "_i" from 1 to getNumber(missionConfigFile >> "aapps_lottery_config" >> "values" >> "amountofnumbers") do {
			_lotterynumbers pushBack (selectRandom _numbers);
		};
		lottery_example_code = _lotterynumbers joinString "-";
	};
	ctrlSetText[88089,lottery_example_code];
};
if(_type isEqualTo 1) exitWith {
	hint parseText format[localize "STR_lottery_helpme_text",getNumber(missionConfigFile >> "aapps_lottery_config" >> "values" >> "amountofnumbers"),lottery_example_code,getNumber(missionConfigFile >> "aapps_lottery_config" >> "values" >> "lowestvalue"),getNumber(missionConfigFile >> "aapps_lottery_config" >> "values" >> "highestvalue")];
};
if(_type isEqualTo 2) exitWith {
	disableSerialization;
	_editbox = (findDisplay 88088) displayCtrl 88089;
	_input = ctrlText _editbox;
	_numbers = [];
	for "_i" from getNumber(missionConfigFile >> "aapps_lottery_config" >> "values" >> "lowestvalue") to getNumber(missionConfigFile >> "aapps_lottery_config" >> "values" >> "highestvalue") do {
		_enumber = str _i;
		if((count _enumber) isEqualTo 1) then {
			_enumber = format["0%1",_i];
		};
		_numbers pushBack _enumber;
	};
	_amount = getNumber(missionConfigFile >> "aapps_lottery_config" >> "values" >> "amountofnumbers");
	_charsamount = (_amount *2) + (_amount -1);
	if(!((count _input) isEqualto _charsamount)) exitWith {hint format[localize "STR_lottery_wrong_format",_amount]};
	_valid = true;
	for "_i" from 0 to (_amount -1) do {
		_number = _input select [_i*3,2];
		if(!(_number in _numbers)) exitWith {hint format[localize "STR_lottery_not_valid",_i+1,_numbers select 0, _numbers select ((count _numbers)-1)];_valid = false;};
	};
	if(!_valid) exitWith {};
	_price = getNumber(missionConfigFile >> "aapps_lottery_config" >> "price");
	if(CASH < _price) exitWith {hint format[localize "STR_lottery_not_enough",[_price] call life_fnc_numberText]};
	CASH = CASH - _price;
	[0,getplayeruid player,profileName,_input] remoteExec ["ton_fnc_aapps_lottery_action",2];
	closeDialog 0;
	titleText[localize "STR_lottery_bought","PLAIN"];
};
if(_type isEqualTo 3) exitWith {
	if(isNil "life_lottery_timer") then {life_lottery_timer = -120};
	if(time < (life_lottery_timer +120)) exitWith {titleText[localize "STR_lottery_antispam","PLAIN"]};
	titletext [localize "STR_lottery_check_win","PLAIN"];
	[1,getplayeruid player, player] remoteExec ["ton_fnc_aapps_lottery_action",2];
	life_lottery_timer = time;
};
if(_type isEqualTo 4) exitWith {
	_amount = [_this, 1, 0] call bis_fnc_param;
	if(_amount isEqualTo 0) exitWith {titleText [localize "STR_lottery_no_win","PLAIN"]};
	sleep 4;
	titleText [localize "STR_lottery_win_found","PLAIN"];
	sleep 4;
	CASH = CASH + _amount;
	titleText [format[localize "STR_lottery_done", _amount],"PLAIN"];
};
if(_type isEqualTo 5) exitWith {
	_code = [_this, 1, ""] call bis_fnc_param;
	_amount = [_this, 2, 0] call bis_fnc_param;
	_jackpot = [_this, 3, 0] call bis_fnc_param;
	if(_code isEqualTo "") exitWith {};
	hint parseText format[localize "STR_lottery_win_msg",[_amount] call life_fnc_numberText, [_jackpot] call life_fnc_numberText, _code];
	playsound "zoomin";
};

scriptName "fn_aapps_lottery_fetchWinners";
/*
 *
 *	@File:		fn_aapps_lottery_fetchWinners.sqf
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
_diag_fnc = {
	diag_log format[">>> AllianceApps Lottery: %1",_this];
};
"Starting..." call _diag_fnc;
if(isNil "life_server_isReady") then {life_server_isReady = false};
waitUntil{life_server_isReady};
_value = "extDB3" callExtension "9:LOCAL_TIME";
_value = (call compile _value) select 1;
_dayname = format["SELECT DAYNAME('%1-%2-%3')",_value select 0, _value select 1, _value select 2];
_dayname = [_dayname,2] call DB_fnc_asyncCall;
_dayname = toupper (_dayname select 0);
if(!(_dayname in ["MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY","SUNDAY"])) exitWith {format["Wrong Dayindex. Info: %1|%2",_dayname,_value] call _diag_fnc};
_timearr = getArray(missionConfigFile >> "aapps_lottery_config" >> "lottery_drawings" >> _dayname);
if(_timearr isEqualTo []) exitWith {format["Today is %1 -> No Lottery!",_dayname] call _diag_fnc};
_time = 999999;
_time_index = -1;
_curtime = parseNumber format["%1%2",_value select 3,_value select 4];

for "_i" from 0 to ((count _timearr)-1) do {
	_selecttime = _timearr select _i;
	_selecttime = _selecttime splitString ":";
	_selecttime = parseNumber (_selecttime joinString "");
	_dif = _selecttime - _curtime;
	if((_dif > 0) && {_dif < _time}) then {
		_time = _dif;
		_time_index = _i;
	};
};
if(_time > (getNumber(missionConfigFile >> "aapps_lottery_config" >> "max_restart_time") * 100)) exitWith {"There is no lottery during this restart period!" call _diag_fnc};
if(_time_index isEqualTo -1) exitWith {"No more lotteries today." call _diag_fnc};
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

format["Lotterycode generated! Code: %1",_lotterynumbers joinString "-"] call _diag_fnc;
["CALL lotterydelwin",1] call DB_fnc_asyncCall;
_result = ["SELECT pid, code FROM lottery_tickets WHERE deleted_at IS NULL",2,true] call DB_fnc_asyncCall;
_winners = [];
{
	_level = 0;
	_code = (_x select 1) splitString "-";
	
	for "_i" from 0 to (getNumber(missionConfigFile >> "aapps_lottery_config" >> "values" >> "amountofnumbers")-1) do {
		if(!((_code select _i) isEqualTo (_lotterynumbers select _i))) exitWith {};
		_level = _level + 1;
	};
	
	if(_level > 1) then {
		_winners pushBack [(_x select 0),_level];
	};
} forEach _result;
_jackpot = count _result;
_jackpot = _jackpot * getNumber(missionConfigFile >> "aapps_lottery_config" >> "price");
_oldjackpot = ["SELECT value FROM lottery_info WHERE name='lottery_jackpot'",2] CALL DB_fnc_asyncCall;
_jackpot = (_oldjackpot select 0) + _jackpot;
_levelbonus = ["SELECT value FROM lottery_info WHERE name like 'lottery_lvl%'",2,true] call DB_fnc_asyncCall;
for "_i" from 0 to ((count _levelbonus)-1) do {
	_levelbonus set [_i,(_levelbonus select _i) select 0];
};
_levelvalues = [0,0];
_levelvalues append _levelbonus;
//Fetch winamount
["CALL lotterydeltickets",1] call DB_fnc_asyncCall;
_gone = 0;
{
	_uid = _x select 0;
	_lvl = _x select 1;
	_money = _jackpot * ((_levelvalues select _lvl)/100);
	_gone = _gone + _money;
	_temp = missionNamespace getVariable [format["lottery_win_%1",_uid],0];
	_temp = _temp + _money;
	missionNamespace setVariable [format["lottery_win_%1",_uid],_temp];
} forEach _winners;
_jackpot = _jackpot - _gone;
if(_jackpot >= 0) then {
	format["Amount of jackpot remains at %1€!",_jackpot] call _diag_fnc;
} else {
	format["Jackpot is negative. Value: %1 -> Resetting to 0",_jackpot] call _diag_fnc;
	_jackpot = 0;
};
_updatejackpot = format["UPDATE lottery_info SET value='%1' WHERE name='lottery_jackpot'",_jackpot];
[_updatejackpot,1] call DB_fnc_asyncCall;
_buildquery = "";
{
	_uid = _x select 0;
	_amount = missionNamespace getVariable [format["lottery_win_%1",_uid],0];
	if(_amount > 0) then {
		_buildquery = _buildquery + format["UPDATE players SET lottery_win='%1' WHERE pid='%2';",_amount,_uid];
	};
} forEach _winners;
[_buildquery,1] call DB_fnc_asyncCall;
format["%1 players won at the lottery. | New Jackpot: %2 | Look into your database for more information!",count _winners, _jackpot] call _diag_fnc;
//time correction
_convert_to_seconds = {
	_hours = [_this, 0, 0] call bis_fnc_param;
	_mins = [_this, 1, 0] call bis_fnc_param;
	_secs = [_this, 2, 0] call bis_fnc_param;
	_seconds = (_hours * (60*60)) + (_mins * 60) + _secs;
	_seconds
};

_timestamp = (_timearr select _time_index) splitString ":";
_timetostart = [parseNumber (_timestamp select 0), parseNumber (_timestamp select 1),0] call _convert_to_seconds;
_value = "extDB3" callExtension "9:LOCAL_TIME";
_value = (call compile _value) select 1;
_value = [_value select 3,_value select 4,_value select 5] call _convert_to_seconds;
format["Waiting for %1 seconds to reopen the lotterysystem.",_timetostart - _value] call _diag_fnc;
for '_i' from 0 to 1 step 0 do {
	_value = _value + 1;
	if(_value isEqualTo _timetostart) exitWith {};
	uiSleep 1;
};
[5,_lotterynumbers joinString "-",count _winners, _jackpot] remoteExec ["life_fnc_aapps_checklotteryinput",-2];
"The lotterysystem is open again!." call _diag_fnc;
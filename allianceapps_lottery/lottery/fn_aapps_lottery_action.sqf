scriptName "fn_aapps_lottery_action";
/*
 *
 *	@File:		fn_aapps_lottery_action.sqf
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
_type = [_this, 0, -1] call bis_fnc_param;
_uid = [_this, 1, "-1"] call bis_fnc_param;
if((_type isEqualto -1) OR {_uid isEqualTo "-1"}) exitWith {};
if(_type isEqualTo 0) exitWith {
	_name = [_this, 2, ""] call bis_fnc_param;
	_input = [_this, 3, ""] call bis_fnc_param;
	if((_name isEqualTo "") OR {_input isEqualTo ""}) exitWith {};
	_query = format ["INSERT INTO lottery_tickets (pid, name, code) VALUES('%1', '%2', '%3')",_uid,_name,_input];
	[_query,1] call DB_fnc_asyncCall;
};
if(_type isEqualTo 1) exitWith {
	_obj = [_this, 2, objNull] call bis_fnc_param;
	if(isNull _obj) exitWith {};
	_query = format ["SELECT lottery_win FROM players WHERE pid='%1'",_uid];
	_result = [_query,2] call DB_fnc_asyncCall;
	_query = format["UPDATE players SET lottery_win='0' WHERE pid='%1'",_uid];
	[_query,1] call DB_fnc_asyncCall;
	[4,_result select 0] remoteExec ["life_fnc_aapps_checklotteryinput",(owner _obj)];
};
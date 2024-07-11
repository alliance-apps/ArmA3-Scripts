scriptName "fn_updateidcard";
/*
 *
 *	@File:		fn_updateidcard.hpp
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
	["_player", objNull, [objNull]],
	["_uid", "", [""]],
	["_side", sideUnknown, [sideUnknown]],
	["_data", [], [[]]]
];
if((isNull _player) OR {_uid isEqualTo ""} OR {_side isEqualTo sideUnknown} OR {_data isEqualTO []}) exitWith {};
_name = _data select 0;

_datamres = [_data] call DB_fnc_mresArray;

_query = format["SELECT name FROM players WHERE name='%1' AND pid!='%2'",_name,_uid];
_queryResult = [_query,2,true] call DB_fnc_asyncCall;
if(!((count _queryResult) isEqualTo 0)) exitWith {
	[0] remoteExecCall ["life_fnc_idcard_Created",_player];
};
_query = "";
switch(_side) do {
	case civilian: {
		_query = format["UPDATE players SET idcard_data_civ='%1' WHERE pid='%2'",_datamres,_uid];
	};
	case west: {
		_query = format["UPDATE players SET idcard_data_cop='%1' WHERE pid='%2'",_datamres,_uid];
	};
	case independent: {
		_query = format["UPDATE players SET idcard_data_med='%1' WHERE pid='%2'",_datamres,_uid];
	};
};
[_query,1] call DB_fnc_asyncCall;
[1,_data] remoteExecCall ["life_fnc_idcard_Created",_player];
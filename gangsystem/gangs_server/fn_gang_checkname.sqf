scriptName "fn_gang_checkname";
/*
 *
 *	@File:		fn_gang_checkname.sqf
 *	@Author: 	AllianceApps
 *	@Date:		11.05.2018
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *
 */
params [
	["_name", "", [""]],
	["_noRemote", false, [false]],
	["_qry", false, [false]]
];
if(_name isEqualTo "") exitWith {};
_query = format["SELECT id FROM gangs WHERE name='%1' AND active='1'",_name];
_queryResult = [_query,2] call DB_fnc_asyncCall;
_bool = _queryResult isEqualTo [];
if(_noRemote) exitWith {_bool}; //isRemoteExecuted is always true, thx bughemia
if(_qry) exitWith {
    life_gangname_available = _bool;
    remoteExecutedOwner publicVariableClient "life_gangname_available";
};
if(_bool) then {
    [1,"STR_aapps_gang_name_isavailable",true,[]] remoteExecCall ["life_fnc_broadcast",remoteExecutedOwner];
} else {
    [1,"STR_aapps_gang_different_gn",true,[]] remoteExecCall ["life_fnc_broadcast",remoteExecutedOwner];
};

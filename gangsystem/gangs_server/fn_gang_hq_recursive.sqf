scriptName "fn_gang_hq_recursive";
/*
 *
 *	@File:		fn_gang_hq_recursive.sqf
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
	["_hqid", -1, [0]],
	["_bool", false, [false]]
];
if(_hqid isEqualTo -1) exitWith {};
if(_bool) then {
	_gangid = format["SELECT id FROM gangs WHERE hq='%1'",_hqid];
	_gangid = [_gangid,2]call DB_fnc_asyncCall;
	if(_gangid isEqualTo []) exitWith {};
	_query = format["UPDATE gangs SET hq='-1', hq_upgrades='""[]""', hq_garage='[]' WHERE id='%1'",_gangid];
    [_query,1] call DB_fnc_asyncCall;
	_query = format["UPDATE locker SET active='0' WHERE uid='%1' AND side='GANG' AND active='1'",_gangid];
    [_query,1] call DB_fnc_asyncCall;
} else {
	_query = format["UPDATE gangs SET hq='-1', hq_garage='[]' WHERE hq='%1'",_hqid];
    [_query,1] call DB_fnc_asyncCall;
};
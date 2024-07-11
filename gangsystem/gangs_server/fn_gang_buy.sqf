scriptName "fn_gang_buy";
/*
 *
 *	@File:		fn_gang_buy.sqf
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
	["_type", -1, [0]],
	["_name", "", [""]],
	["_player", objNull, [objNull]]
];
if((isNull _player) OR {_type isEqualTo -1} OR {_name isEqualTo ""}) exitWith {};
_uid = getPlayerUID _player;
_cur = group _player;
_bool = [_name,true] call TON_fnc_gang_checkname;
if(!_bool) exitWIth {[_type] remoteExecCall ["life_fnc_gang_readdmoney",remoteExecutedOwner]};

_cur setVariable ["gang_name",_name,true];
_cur setVariable ["gang_owner",_uid,true];
_cur setVariable ["gang_members",[[_uid,0,name _player,_player]],true];
_cur setVariable ["gang_tag","",true];
_cur setVariable ["gang_hq_id",-1,true];
_cur setVariable ["gang_description","",true];
_cur setVariable ["gang_tax",0,true];
_cur setVariable ["gang_type",_type,true];
_cur setVariable ["gang_level",1,true];
_cur setVariable ["gang_perm_int",1,true];
_cur setVariable ["gang_tax_sum",0,true];
_cur setVariable ["gang_garage_info",[],true];
_permissions = [];
if(_type isEqualTo 0) then {//TEMP
    _permissions = getArray(missionConfigFile >> "gang_config" >> "defaultpermission" >> "temp");
    _cur setVariable ["gang_permissions",_permissions,true];
    _cur setVariable ["gang_bank",0,true];
} else {//PERM
    _permissions = getArray(missionConfigFile >> "gang_config" >> "defaultpermission" >> "perm");
    _cur setVariable ["gang_permissions",_permissions,true];
    _cur setVariable ["gang_bank",getNumber(missionConfigFile >> "gang_config" >> "default_bank_cash"),true];
};
_query = format ["INSERT INTO gangs (owner, name, description, hq_upgrades, permission, type) VALUES('%1', '%2', '""""', '""[]""', '%3', '%4')",_uid,[_name] call DB_fnc_mresString,[_permissions] call DB_fnc_mresArray,_type];
[_query,1] call DB_fnc_asyncCall;
[_cur] remoteExec ["life_fnc_gang_remmoney",remoteExecutedOwner];
_queryResult = [];
for '_i' from 1 to 81 step 3 do {
    sleep _i;
    _query = format["SELECT id FROM gangs WHERE name='%1' AND owner='%2' AND active='1'",_name,_uid];
    _queryResult = [_query,2] call DB_fnc_asyncCall;
    if(!(_queryResult isEqualTo [])) exitWith {};
};
_queryResult = _queryResult select 0;

[10,_cur,_uid,[_queryResult,0]] call ton_fnc_gang_update;
_cur setVariable ["gang_id",_queryResult,true];
[_queryResult, 0] remoteExecCall ["life_fnc_gang_var",remoteExecutedOwner];

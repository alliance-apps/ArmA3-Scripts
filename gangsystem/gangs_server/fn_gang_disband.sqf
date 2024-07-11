scriptName "fn_gang_disband";
/*
 *
 *	@File:		fn_gang_disband.sqf
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
	["_group", grpNull, [grpNull]],
	["_obj", objNull, [objNull]],
	["_uid", "", [""]],
	["_bool", false, [false]]
];
if((isNull _group) OR {isNull _obj} OR {_uid isEqualTo ""}) exitWith {};
_members = _group getVariable ["gang_members",[]];
_name = _group getVariable ["gang_name",""];
_id = _group getVariable ["gang_id",-1];
if(_bool) then {
    _group setVariable ["gang_members",[],true]; //cleanup
    {
        _member = _x select 3;
        if((_x select 0) isEqualTo (getPlayerUID _member)) then {
            [-1,-1] remoteExecCall ["life_fnc_gang_var",_member];
            [1,"STR_aapps_gang_disbanded",true,[_name]] remoteExecCall ["life_fnc_broadcast",_member];
            [_member] joinSilent grpNull;
        };
    } forEach _members;
    _query = format ["UPDATE gangs SET active='0' WHERE id='%1'",_id];
    [_query,1] call DB_fnc_asyncCall;
    _query = format ["UPDATE players SET gang_id='-1',gang_perm_id='-1' WHERE gang_id='%1'",_id];
    [_query,1] call DB_fnc_asyncCall;
} else {
    {
        if((_x select 0) isEqualTo _uid) exitWith {_members deleteAt _foreachindex};
    } forEach _members;
    _group setVariable ["gang_members",_members,true];
    [10,_group,_uid,[-1,-1]] call ton_fnc_gang_update;
    [_obj] joinSilent (createGroup civilian);
};

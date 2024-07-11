scriptName "fn_gang_load";
/*
 *
 *	@File:		fn_gang_load.sqf
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
	["_gangid", -1, [0]],
	["_group", grpNull, [grpNull]],
	["_player", objNull, [objNull]]
];
if((isNull _group) OR {_gangid isEqualTo -1} OR {isNull _player}) exitWith {};

_query = format["SELECT id,owner,name,level,tag,description,hq,hq_upgrades,permission,bank,tax,type,perm_int,tax_sum,hq_garage FROM gangs WHERE id='%1' AND active='1'",_gangid];
_queryResult = [_query,2] call DB_fnc_asyncCall;
if(_queryResult isEqualTo []) exitWith {
    [-1,-1] remoteExecCall ["life_fnc_gang_var",remoteExecutedOwner];
	_player setVariable ["gang_init_done",true,true];
};
_group setVariable ["gang_id", _queryResult select 0,true];
_group setVariable ["gang_owner",_queryResult select 1,true];
_group setVariable ["gang_name",_queryResult select 2,true];
_group setVariable ["gang_level",_queryResult select 3,true];
_group setVariable ["gang_tag",_queryResult select 4,true];
if(getNumber(missionConfigFile >> "gang_config" >> "show_defined_gangtags") isEqualTo 1) then {
	if(!((_queryResult select 4) isEqualTo "")) then {
		_player setVariable ["realname", format["[%1] %2",_queryResult select 4,name _player],true];
	} else {
		_player setVariable ["realname", name _player, true];
	};
};
_group setVariable ["gang_description",[_queryResult select 5, "''","'"] call KRON_Replace,true];
_houseid = _queryResult select 6;
if(!(_houseid isEqualTo -1)) then {
    _hq = format["SELECT pos FROM houses WHERE owned='1' AND id='%1'",_houseid];
    _hqResult = [_hq,2] call DB_fnc_asyncCall;
    if(_hqResult isEqualTo []) then {
        _group setVariable ["gang_hq_id",-1,true];
    } else {
        _group setVariable ["gang_hq_id",_houseid,true];
        _pos = call compile format ["%1",_hqResult select 0];
        _hq = nearestObject [_pos, "House"];
        _group setVariable ["gang_hq",_hq,true];
    };
};
_player setVariable ["gang_init_done",true,true];
_group setVariable ["gang_hq_upgrades",[_queryResult select 7] call DB_fnc_mresToArray,true];
_group setVariable ["gang_permissions",[_queryResult select 8] call DB_fnc_mresToArray,true];
_group setVariable ["gang_bank",_queryResult select 9,true];
_group setVariable ["gang_tax",_queryResult select 10,true];
_group setVariable ["gang_type",_queryResult select 11,true];
_group setVariable ["gang_perm_int",_queryResult select 12,true];
_group setVariable ["gang_tax_sum",_queryResult select 13,true];
_group setVariable ["gang_garage_info",call compile(_queryResult select 14),true];

_uid = getplayeruid _player;
if((_queryResult select 0) isEqualTo _uid) then {
    _group selectLeader _player;
};

//fetch players
_query = format["SELECT pid, gang_perm_id, name from players WHERE gang_id='%1'",_gangid];
_queryResult = [_query,2,true] call DB_fnc_asyncCall;
if(_queryResult isEqualTo []) exitWith {};
{
    if((_x select 0) isEqualTo _uid) then {
        _x set[3,_player];
        if((_x select 1) isEqualTo 0) then {
            _player setRank "COLONEL";
        } else {
            _player setRank "PRIVATE";
        };
    } else {
        _x set[3,objNull];
    };
} forEach _queryResult;
_group setVariable ["gang_members",_queryResult,true];

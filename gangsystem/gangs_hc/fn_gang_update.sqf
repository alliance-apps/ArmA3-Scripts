scriptName "fn_gang_update";
/*
 *
 *	@File:		fn_gang_update.sqf
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
	["_sel", -1, [0]],
	["_group", grpNull, [grpNull]]
];
if((isNull _group) OR {_sel isEqualTo -1}) exitWith {};
_id = _group getVariable ["gang_id",-1];
if(_sel isEqualTo 0) exitWith { //owner
    _query = format["UPDATE gangs SET owner='%1' WHERE id='%2'",_group getVariable ["gang_owner","-1"],_id];
    [_query,1] call HC_fnc_asynccall;
};
if(_sel isEqualTo 1) exitWIth { //name
    _query = format["UPDATE gangs SET name='%1' WHERE id='%2'",[_group getVariable ["gang_name",""]] call HC_fnc_mresString,_id];
    [_query,1] call HC_fnc_asynccall;
};
if(_sel isEqualTo 2) exitWith { //level
    _query = format["UPDATE gangs SET level='%1' WHERE id='%2'",_group getVariable ["gang_level",1],_id];
    [_query,1] call HC_fnc_asynccall;
};
if(_sel isEqualTO 3) exitWith { //bank
    _query = format["UPDATE gangs SET bank='%1' WHERE id='%2'",_group getVariable ["gang_bank",0],_id];
    [_query,1] call HC_fnc_asynccall;
};
if(_sel isEqualTo 4) exitWith { //desc
    _desc = _group getVariable ["gang_description",""];
    _desc = [_desc, "'", "''"] call KRON_Replace;
    _query = format["UPDATE gangs SET description=%1 WHERE id='%2'",str (str _desc),_id]; //STR STR looks stupid but is needed <3 strings
    [_query,1] call HC_fnc_asynccall;
};
if(_sel isEqualTo 5) exitWIth { //hq
    _query = format["UPDATE gangs SET hq='%1' WHERE id='%2'",_group getVariable ["gang_hq_id",-1],_id];
    [_query,1] call HC_fnc_asynccall;
};
if(_sel isEqualTO 6) exitWith { //permission
    _query = format["UPDATE gangs SET permission='%1',perm_int='%2' WHERE id='%3'",[_group getVariable ["gang_permissions",[]]] call HC_fnc_mresArray,_group getVariable ["gang_perm_int",1],_id];
    [_query,1] call HC_fnc_asynccall;
};
if(_sel isEqualTo 7) exitWith { //tag
	_tag = _group getVariable ["gang_tag",""];
    _query = format["UPDATE gangs SET tag='%1' WHERE id='%2'",_tag,_id];
    [_query,1] call HC_fnc_asynccall;
	{
		[_id, _tag] remoteExecCall ["life_fnc_gang_tag",_x];
	} forEach (units _group);
};
if(_sel isEqualTo 8) exitWith { //tax
    _query = format["UPDATE gangs SET tax='%1' WHERE id='%2'",_group getVariable ["gang_tax",0],_id];
    [_query,1] call HC_fnc_asynccall;
};
if(_sel isEqualTo 9) exitWIth { //type
    _query = format["UPDATE gangs SET type='%1' WHERE id='%2'",_group getVariable ["gang_type",0],_id];
    [_query,1] call HC_fnc_asynccall;
};
if(_sel isEqualTo 10) exitWIth { //member
    _pid = param [2, "", [""]];
    _gang_info = param [3, [], [[]]];
    if(_pid isEqualTo "") exitWith {};
    _query = format ["UPDATE players SET gang_id='%1',gang_perm_id='%2' WHERE pid='%3'",_gang_info select 0, _gang_info select 1,_pid];
    [_query,1] call HC_fnc_asynccall;
};
if(_sel isEqualTo 11) exitWIth { //memberS
    _arr = param [2, [], [[]]];
    _name = param [3, "", [""]];
    _gang_info = [_id,-1];
    if(_arr isEqualTo []) exitWith {};
    {
        _obj = _x select 3;
        _gang_info set[1,_x select 1];
        if((getplayeruid _obj) isEqualTo (_x select 0)) then {
            [1, "STR_aapps_gang_changed_rank", true, [_name, _x select 2]] remoteExecCall ["life_fnc_broadcast",_obj];
            _gang_info remoteExecCall ["life_fnc_gang_var",_obj];
        };
        [10,_group,(_x select 0),_gang_info] call hc_fnc_gang_update;
    } forEach _arr;
};
if(_sel isEqualTo 12) exitWith { //ganghideout
    _key = param [2, "", [""]];
    if(_key isEquaLTo "") exitWith {};
    _query = format["UPDATE gang_info SET value='%1' WHERE name='%2'",_id,_key];
    [_query,1] call HC_fnc_asynccall;
};
if(_sel isEqualTo 13) exitWith { //hq
	_bool = param [2, false, [false]];
    _query = format["UPDATE gangs SET hq='%1', hq_upgrades='%2', hq_garage='%3' WHERE id='%4'",_group getVariable ["gang_hq_id",-1],[_group getVariable ["gang_hq_upgrades",[]]] call HC_fnc_mresArray,_group getVariable ["gang_garage_info",[]],_id];
    [_query,1] call HC_fnc_asynccall;
	if(_bool) then {
		_query = format["UPDATE locker SET active='0' WHERE uid='%1' AND side='GANG' AND active='1'",_id];
		[_query,1] call HC_fnc_asynccall;
	};
};
if(_sel isEqualTo 15) exitWith { //tax_sum
    _query = format["UPDATE gangs SET tax_sum='%1' WHERE id='%2'",_group getVariable ["gang_tax_sum",0],_id];
    [_query,1] call HC_fnc_asynccall;
};

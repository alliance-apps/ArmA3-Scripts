scriptName "fn_gang_leave";
/*
 *
 *	@File:		fn_gang_leave.sqf
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
_bool = param [0, false, [false]];
_group = group player;
_uid = getplayeruid player;
_owner = false;
_result = false;
if((_uid isEqualTo (_group getVariable ["gang_owner",""]))) then {
    _result = [localize "STR_aapps_gang_disband_owner", "Gangsystem", true, true] call BIS_fnc_guiMessage;
    _owner = true;
} else {
    if(_bool) then {
        _result = [localize "STR_aapps_gang_disband","Gangsystem",true,true] call BIS_fnc_guiMessage;
        _owner = true;
    } else {
        _result = [localize "STR_aapps_gang_leave_question", "Gangsystem", true, true] call BIS_fnc_guiMessage;
    };
};
if(!_result) exitWith {};
player setVariable ["realname", profilename, true];
if(_owner) then {
    if(life_HC_isActive) then {
        [_group,player,_uid,true] remoteExecCall ["hc_fnc_gang_disband",hc_life];
    } else {
        [_group,player,_uid,true] remoteExecCall ["ton_fnc_gang_disband",2];
    };
} else {
    life_gangdata = [-1,-1];
    hint format[localize "STR_aapps_gang_left",_group getVariable ["gang_name",""]];
    if(life_HC_isActive) then {
        [_group,player,_uid,false] remoteExecCall ["hc_fnc_gang_disband",hc_life];
    } else {
        [_group,player,_uid,false] remoteExecCall ["ton_fnc_gang_disband",2];
    };
};
closeDialog 0;

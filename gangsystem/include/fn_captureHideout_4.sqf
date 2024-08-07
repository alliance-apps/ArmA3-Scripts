#include "..\..\script_macros.hpp"
/*
    File: fn_captureHideout.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Blah blah.
*/
private["_group","_hideout","_action","_cpRate","_cP","_progressBar","_title","_titleText","_ui","_flagTexture"];
_hideout = (nearestObjects[getPosATL player,["Land_u_Barracks_V2_F","Land_i_Barracks_V2_F"],25]) select 0;
_group = _hideout getVariable ["gangOwner",-1];
_owngroup = group player;

if (isNil {_owngroup getVariable "gang_id"}) exitWith {titleText[localize "STR_GNOTF_CreateGang","PLAIN"];};
if (_group isEqualTo (_ownGroup getVariable ["gang_id",-1])) exitWith {titleText[localize "STR_GNOTF_Controlled","PLAIN"]};
if ((_hideout getVariable ["inCapture",FALSE])) exitWith {hint localize "STR_GNOTF_onePersonAtATime";};
if (!(_group isEqualTo -1)) then {
    _gangName = _hideout getVariable ["gangOwnerName", "ERROR REPORT TO ADMIN"];
    _action = [
        format[localize "STR_GNOTF_AlreadyControlled",_gangName],
        localize "STR_GNOTF_CurrentCapture",
        localize "STR_Global_Yes",
        localize "STR_Global_No"
    ] call BIS_fnc_guiMessage;

    _cpRate = 0.0045;
} else {
    _cpRate = 0.0075;
};

if (!isNil "_action" && {!_action}) exitWith {titleText[localize "STR_GNOTF_CaptureCancel","PLAIN"];};
life_action_inUse = true;

//Setup the progress bar
disableSerialization;
_title = localize "STR_GNOTF_Capturing";
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

for "_i" from 0 to 1 step 0 do {
    if (animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
        [player,"AinvPknlMstpSnonWnonDnon_medic_1",true] remoteExecCall ["life_fnc_animSync",RCLIENT];
        player switchMove "AinvPknlMstpSnonWnonDnon_medic_1";
        player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
    };
    sleep 0.26;
    if (isNull _ui) then {
        5 cutRsc ["life_progress","PLAIN"];
        _ui = uiNamespace getVariable "life_progress";
        _progressBar = _ui displayCtrl 38201;
        _titleText = _ui displayCtrl 38202;
    };
    _cP = _cP + _cpRate;
    _progressBar progressSetPosition _cP;
    _titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
    _hideout setVariable ["inCapture",true,true];
    if (_cP >= 1 || !alive player) exitWith {_hideout setVariable ["inCapture",false,true];};
    if (life_istazed) exitWith {_hideout setVariable ["inCapture",false,true];}; //Tazed
    if (life_isknocked) exitWith {_hideout setVariable ["inCapture",false,true];}; //Knocked
    if (life_interrupted) exitWith {_hideout setVariable ["inCapture",false,true];};
};

//Kill the UI display and check for various states
5 cutText ["","PLAIN"];
player playActionNow "stop";
if (!alive player || life_istazed || life_isknocked) exitWith {life_action_inUse = false;_hideout setVariable ["inCapture",false,true];};
if (player getVariable["restrained",false]) exitWith {life_action_inUse = false;_hideout setVariable ["inCapture",false,true];};
if (life_interrupted) exitWith {life_interrupted = false; titleText[localize "STR_GNOTF_CaptureCancel","PLAIN"]; life_action_inUse = false;_hideout setVariable ["inCapture",false,true];};
life_action_inUse = false;

titleText[localize "STR_GNOTF_Captured","PLAIN"];
_flagTexture = [
        "\A3\Data_F\Flags\Flag_red_CO.paa",
        "\A3\Data_F\Flags\Flag_green_CO.paa",
        "\A3\Data_F\Flags\Flag_blue_CO.paa",
        "\A3\Data_F\Flags\Flag_white_CO.paa",
        "\A3\Data_F\Flags\flag_fd_red_CO.paa",
        "\A3\Data_F\Flags\flag_fd_green_CO.paa",
        "\A3\Data_F\Flags\flag_fd_blue_CO.paa",
        "\A3\Data_F\Flags\flag_fd_orange_CO.paa"
    ] call BIS_fnc_selectRandom;
_this select 0 setFlagTexture _flagTexture;
[[0,1],"STR_GNOTF_CaptureSuccess",true,[name player,_ownGroup getVariable "gang_name"]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
_hideout setVariable ["inCapture",false,true];
_name = _ownGroup getVariable ["gang_name","ERROR REPORT TO ADMIN"];
_hideout setVariable ["gangOwner",_ownGroup getVariable ["gang_id",-1],true];
_hideout setVariable ["gangOwnerName",_name,true];
_number = _hideout getVariable ["hideoutnr",-1];
if(_number isEqualTo -1) exitWith {};
[12,_ownGroup,format["hideout%1",_number]] remoteExecCall ["ton_fnc_gang_update",2];
format["gh_marker_%1",_number] setMarkerText format["%1 %2",getText(missionconfigfile >> "gang_config" >> "hideouts" >> "hideout_markername"),_name];

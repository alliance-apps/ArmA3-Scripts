scriptName "fn_gang_hqupgrades";
/*
 *
 *	@File:		fn_gang_hqupgrades.sqf
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
closeDialog 0;
disableSerialization;
createDialog "life_gang_hqupgrades";
_display = findDisplay 220400;

_actions = "true" configClasses (missionConfigFile >> "gang_config" >> "hqupgrades");
_count = count _actions;
if(_count > 5) then {
    _actions resize 5;
    _count = 5;
};

_count = (_count-1) * 2;
_bought =+ ((group player) getVariable ["gang_hq_upgrades",[]]);

for '_i' from 0 to _count step 2 do {
    _x = _actions select (_i/2);
    _ctrlval = 220410 + _i;
    _ctrl = _display displayCtrl _ctrlval;
    _sub_ctrl = _display displayCtrl (220411 + _i);
    _configname = configName (_x);
    _ctrl ctrlSetText getText (_x >> "displayName");
    _ctrl ctrlSetEventhandler ["ButtonClick",getText(_x >> "action")];
    if(_configname in _bought) then {
        _sub_ctrl ctrlShow false;
    } else {
        _ctrl ctrlEnable false;
        _sub_ctrl ctrlSetEventHandler ["ButtonClick",format["['%1',%2] spawn life_fnc_gang_hqup_buy",_configname,_ctrlval]];
    };
};
_count = _count + 2;
for '_i' from _count to 8 step 2 do {
    ctrlShow [220410 + _i, false];
    ctrlShow [220411 + _i, false];
};

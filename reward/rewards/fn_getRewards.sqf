/*
 *
 *	@File:		reward.hpp
 *	@Author: 	AllianceApps
 *	@Date:		31.07.2019
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *
 */
life_rewarddays = param [1, -1, [0]];
if(!param[2, false, [true]]) exitWith {}; //no reward or already got one
waitUntil {sleep 0.2; !life_firstSpawn};
sleep 5;
_val = 0;
{
    if([getText(_x >> "condition")] call life_fnc_levelCheck) then {
        _sound = getText(_x >> "sound");
        _statement = getText(_x >> "statement");
        _rewards = getArray(_x >> "rewards");
        {
            _x call life_fnc_addReward;
            _val = _val + 1;
        } forEach _rewards;
        if(!(_sound isEqualTo "")) then {
            playSound _sound;
        };
        if(!(_statement isEqualTo "")) then {
            call compile _statement;
        };
        _namecolor = getText(_x >> "namecolor");
        if(_namecolor isEqualTo "") then {_namecolor = "#D35400"};
        _desccolor = getText(_x >> "descriptioncolor");
        if(_desccolor isEqualTo "") then {_desccolor = "#FFFFFF"};
        [getText(_x >> "name"), _namecolor, getText(_x >> "description"), _desccolor] call life_fnc_animtext;
        [2] call BIS_fnc_earthquake;
        sleep 10;
    };
} foreach ("true" configClasses (missionConfigFile >> "aapps_reward_config"));
if(!(_val isEqualTo 0)) then {
    [] call SOCK_fnc_updateRequest; //do not spam the server with multiple requests
};

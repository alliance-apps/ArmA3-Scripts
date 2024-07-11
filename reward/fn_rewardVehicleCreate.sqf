/*
 *
 *	@File:		fn_rewardVehicleCreate.sqf
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
params [
    ["_uid", "", [""]],
    ["_playerside",sideUnknown, [sideUnknown]],
    ["_classname", "", [""]],
    ["_color", -1, [0]]
];
if((_uid isEqualTo "") || {_playerSide isEqualTo sideUnknown} || {_classname isEqualto ""} || {_color isequalTo -1}) exitWith {};

_type = call {
    if(_classname isKindOf "Car") exitWith {"Car"};
    if(_classname isKindof "Air") exitWith {"Air"};
    "Ship";
};

_side = call {
    if(_playerside isEqualto WEST) exitWith {"cop"};
    if(_playerside isEqualto CIVILIAN) exitWith {"civ"};
    if(_playerside isEqualto INDEPENDENT) exitWith {"med"};
    "east";
};
_plate = round(random(1000000));

_query = format ["INSERT INTO vehicles (side, classname, type, pid, alive, active, inventory, color, plate, gear, damage) VALUES ('%1', '%2', '%3', '%4', '1','0','""[[],0]""', '%5', '%6','""[]""','""[]""')",_side,_className,_type,_uid,_color,_plate];
[_query,1] call DB_fnc_asyncCall;

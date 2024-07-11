/*
 *
 *	@File:		fn_addReward.sqf
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
private _type = toUpper(param [0, "", [""]]);
if(_type isEqualTo "") exitWith {};
if(_type isEquaLto "VEHICLE") exitWith {
    params [
        "",
        ["_classname","",["",[]]],
        ["_color","",["",0]]
    ];
	if(_classname isEqualType []) then {_classname = selectRandom _classname};
    if((_classname isEqualTo "") || {!(isClass(configFile >> "CfgVehicles" >> _classname))} || {_color isEqualTo ""}) exitWith {};
    if(_color isEqualType "") then {
        //findindex
        _color = tolower _color;
        {
            if((tolower(_x select 0)) isEqualTo _color) then {_color = _foreachindex};
        } forEach getArray (missionConfigFile >> "LifeCfgVehicles" >> _classname >> "textures");
        if(_color isEqualType "") then {_color = 0};
    };
    if (life_HC_isActive) then {
        [(getPlayerUID player),playerSide,_classname,_color] remoteExecCall ["HC_fnc_RewardVehicleCreate",HC_Life];
    } else {
        [(getPlayerUID player),playerSide,_classname,_color] remoteExecCall ["TON_fnc_RewardVehicleCreate",2];
    };
};
if(_type isEquaLto "MONEY") exitWith {
    _amount = param [1, 0, [0]];
    if(_amount isEqualto 0) exitWith {};
    life_cash = life_cash + _amount;
};
if(_type isEquaLto "BANK") exitWith {
    _amount = param [1, 0, [0]];
    if(_amount isEqualto 0) exitWith {};
    life_atmbank = life_atmbank + _amount;
};
if(_type isEquaLto "LICENSE") exitWith {
    _classname = param [1, "", ["",[]]];
	if(_classname isEqualType []) then {_classname = selectRandom _classname};
    if((_classname isEqualTo "") || {!(isClass (missionConfigFile >> "Licenses" >> _classname))}) exitWith {};
    missionnamespace setVariable [format ["license_%1_%2",getText(missionconfigFile >> "Licenses" >> _classname >> "side"),getText(missionConfigFile >> "Licenses" >> _classname >> "variable")], true];
};
if(_type isEquaLto "VITEM") exitWith {
    params [
        "",
        ["_classname", "", ["",[]]],
        ["_amount", 0, [0]]
    ];
	if(_classname isEqualType []) then {_classname = selectRandom _classname};
    if((_classname isEqualTo "") || {!(isClass (missionConfigFile >> "VirtualItems" >> _classname))} || {_amount isEquaLTo 0}) exitWIth {};
    _weight = ([_classname] call life_fnc_itemWeight) * _amount;
    _varname = format ["life_inv_%1",getText(missionConfigFile >> "VirtualItems" >> _classname >> "variable")];
    _value = missionNamespace getVariable [_varname,0];
    missionNamespace setVariable [_varname,(_value + _amount)];
    life_carryWeight = life_carryWeight + _weight; //add it without handleinv, else inv size could border or task.
};
if(_type isEquaLto "ITEM") exitWith {
    params [
        "",
        ["_classname", "", ["",[]]],
        ["_amount", 0, [0]]
    ];
	if(_classname isEqualType []) then {_classname = selectRandom _classname};
    if((_classname isEqualTo "") || {_amount isEquaLTo 0}) exitWIth {};
    _bad = 0;
    for '_i' from 1 to _amount do {
        if(player canAdd _classname) then {
            player addItem _classname;
        } else {_bad = _bad + 1};
    };
    if(!(_bad isEqualTo 0)) then {
        if((backpack player) isEqualTo "") then {
            _holder = "groundweaponHolder" createVehicleLocal (getPos player);
            _holder addweaponcargo [_classname, _bad];
            _holder setposatl (getposatl player);
            _holder setdir (random 360);
        } else {
            (unitBackpack player) addItemCargoGlobal [_classname,_bad];
        };
    };
};

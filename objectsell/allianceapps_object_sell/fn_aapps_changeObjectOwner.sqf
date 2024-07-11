scriptName "fn_aapps_sellObject";
/*
 *
 *	@File:		fn_aapps_changeObjectOwner.sqf
 *	@Author: 	AllianceApps
 *	@Date:		17.12.2017
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *  
 */
_type = [_this, 0, -1] call bis_fnc_param;
_newuid = [_this, 1, -1] call bis_fnc_param;
_newside = [_this, 2, sideUnknown] call bis_fnc_param;
_olduid = [_this, 3, -1] call bis_fnc_param;
_oldside = [_this, 4, sideUnknown] call bis_fnc_param;
_index = [_this, 5, -1] call bis_fnc_param;
_object = [_this, 6, objNull] call bis_fnc_param;
if((_type isEqualTo -1) OR {_newUid isEqualTo -1} OR {sideUnknown isEqualTo _newside} OR {_olduid isEqualTo -1} OR {sideUnknown isEqualTo _oldside} OR {_index isEqualTo -1}) exitWith {diag_log format["Object_sell: Error - serverside parameters are wrong. Info: %1",_this]};

_query = format["INSERT INTO sold_objects (olduid, newuid, index_value, object_classname) VALUES('%1','%2','%3','%4')",_olduid,_newuid,_index,typeof _object];
[_query,1] call DB_fnc_asyncCall;
if(_type isEqualTo 0) then {
	_query = format["UPDATE houses SET pid='%1' WHERE pid='%2' AND id='%3';",_newuid,_olduid,_index];
	[_query,1] call DB_fnc_asyncCall;
	_container = _object getVariable ["containers",[]];
	_query = "";
	{
		_id = _x getVariable ["container_id",-1];
		_owner = _x getVariable ["container_owner",[]];
		if(!(_id isEqualTo -1) && {!(_owner isEqualTo [])}) then {
			_query = format["UPDATE containers SET pid='%1' WHERE id='%2';",_newuid,_id];
			[_query,1] call DB_fnc_asyncCall;
			_x setVariable ["container_owner",[_newuid],true];
		};
	} forEach _container;
} else {
	_query = format["UPDATE vehicles SET pid='%1' WHERE pid='%2' AND plate='%3';",_newuid,_olduid,_index];
	[_query,1] call DB_fnc_asyncCall;
};
if(isNull _object) exitWith {};
_arr = missionNamespace getVariable [format ["%1_KEYS_%2",_olduid,_oldside],[]];
_arr = _arr - [_object];
missionNamespace setVariable [format ["%1_KEYS_%2",_olduid,_oldside],_arr];
_arr = missionNamespace getVariable [format ["%1_KEYS_%2",_olduid,_oldside],[]];
_arr pushBack _object;
missionNamespace setVariable [format ["%1_KEYS_%2",_newuid,_newside],_arr];

scriptName "fn_copcallmanagement";
/*
 *
 *	@File:		fn_copcallmanagement.sqf
 *	@Author: 	AllianceApps
 *	@Date:		21.10.2017
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *  
 */
life_call_task = taskNull;
life_call_random = 0;
life_call_start = compileFinal '
	if(!(playerSide isEqualto WEST)) exitWith {hint localize "STR_DC_noaccess"};
	createDialog "aapps_callmanagement";
	disableSerialization;
	_display = findDisplay 1011001;
	_playerslb = _display displayCtrl 1011002;
	_msglb = _display displayCtrl 1011006;
	lbClear _playerslb;
	if((count life_cop_calls) > 0) then {
		{
			_playerslb lbAdd (_x select 0);
			_index = (lbSize _playerslb) -1;
			if((_x select 4) isEqualto "") then {
				_playerslb lbSetPicture [_index, "icons\ico_notset.paa"];
			} else {
				_playerslb lbSetPicture [_index, "icons\ico_set.paa"];
			};
		} forEach life_cop_calls;
	} else {
		_playerslb lbAdd (localize "STR_DC_nodispatches");
		_playerslb lbSetData [0, "-1"];
	};
	_cfgmsg = getArray(missionConfigFile >> "aapps_calls" >> "cop_call_messages");
	_messages = [[localize "STR_DC_MSG_own_message_title",""]] + _cfgmsg;
	{
		_msglb lbAdd (_x select 0);
		_msglb lbSetData [(lbSize _msglb)-1, (_x select 1)];
	} forEach _messages;
	_msglb lbSetCurSel 0;
	ctrlShow[1011012,false];
	ctrlEnable[1011013,false];
	ctrlEnable[1011014,false];
';
life_call_lbchange = compileFinal '
	disableSerialization;
	_display = findDisplay 1011001;
	_playerslb = _display displayCtrl 1011002;
	_time = _display displayCtrl 1011007;
	_distance = _display displayCtrl 1011008;
	_bearb = _display displayCtrl 1011009;
	_name = _display displayCtrl 1011010;
	_grid = _display displayCtrl 1011011;
	_map = _display displayCtrl 1011003;
	_cur = lbCurSel _playerslb;
	if(_cur isEquaLTo -1) exitWith {};
	if((_playerslb lbData 0) isEqualto "-1") exitWith {};
	if(((count life_cop_calls)-1) < _cur) exitwith {
		_playerslb lbDelete _cur;
		{
			_x ctrlSetText "";
		} forEach [_time,_distance,_bearb,_name,_grid];
		ctrlShow[1011012,false];
		ctrlEnable[1011013,false];
		ctrlEnable[1011014,false];
		if((lbSize _playerslb) isEqualTo 0) then {
			_playerslb lbAdd (localize "STR_DC_nodispatches");
			_playerslb lbSetData [0, "-1"];
		};
	};
	_playerdata = life_cop_calls select _cur;
	if(!((_playerdata select 0) isEqualto (_playerslb lbText _cur))) exitWith {
		_playerslb lbDelete _cur;
		{
			_x ctrlSetText "";
		} forEach [_time,_distance,_bearb,_name,_grid];
		ctrlShow[1011012,false];
		ctrlEnable[1011013,false];
		ctrlEnable[1011014,false];
		if((lbSize _playerslb) isEqualTo 0) then {
			_playerslb lbAdd (localize "STR_DC_nodispatches");
			_playerslb lbSetData [0, "-1"];
		};
	};
	ctrlShow[1011012,true];
	_bool = false;
	if(isNull life_call_task) then {
		_bool = true;
	} else {
		if(!(((taskDescription life_call_task) select 0) isEqualTo (_playerData select 2))) then {
			_bool = true;
		};
	};
	if(_bool) then {
		ctrlSetText[1011012,"a3\3den\data\cfgwrapperui\cursors\3denplacewaypointmulti_ca.paa"];
		buttonSetAction[1011012,"0 call life_call_addWaypoint"];
	} else {
		ctrlSetText[1011012,"a3\3den\data\cfgwrapperui\cursors\3denplacewaypoint_ca.paa"];
		buttonSetAction[1011012,"0 call life_notruf_removeWaypoint"];
	};
	_name ctrlSetText (_playerdata select 0);
	_gridpos = mapGridPosition (_playerdata select 1);
	if((count _gridpos) isEqualTo 6) then {_gridpos = format["%1 %2",_gridpos select [0,3],_gridpos select [3,3]]};
	_grid ctrlSetText _gridpos;
	if((_playerdata select 4) isEqualTo "") then {
		_bearb ctrlSetText (localize "STR_DC_notassigned");
		ctrlSetText [1011013,(localize "STR_DC_accept")];
		ctrlEnable[1011013,true];
	} else {
		_bearb ctrlSetText (_playerdata select 4);
		if((_playerdata select 4) isEqualTo (name player)) then {
			ctrlEnable[1011013,false];
		} else {
			ctrlEnable[1011013,true];
		};
		ctrlSetText [1011013,(localize "STR_DC_take_dispatch")];
	};
	ctrlEnable[1011014,true];
	_distanceval = round(player distance (_playerdata select 1));
	if(_distanceval > 1000) then {
		_distanceval = format["%1km",round(_distanceval/1000)];
	} else {
		_distanceval = format["%1m",_distanceval];
	};
	_distance ctrlSetText _distanceval;
	_map ctrlMapAnimAdd [1,0.3, _playerdata select 1];
	ctrlMapAnimCommit _map;
	life_call_random = floor random 10000;
	_tempvar = life_call_random;
	while {life_call_random isEqualTo _tempvar} do {
		_timeval = serverTime - (_playerdata select 3);
		if(_timeval > 60) then {
			_timeval = round (_timeval/60);
			if(_timeval isEqualTo 1) then {
				_time ctrlSetText ("1 " + (localize "STR_DC_minute"));
			} else {
				_time ctrlSetText format["%1 " + (localize "STR_DC_minutes"),_timeval];
			};
		} else {
			_time ctrlSetText format["%1 " + (localize "STR_DC_secondes"),round (_timeval)];
		};
		sleep 1;
	};
';
life_call_accept = compileFinal '
	disableSerialization;
	_display = findDisplay 1011001;
	_playerslb = _display displayCtrl 1011002;
	_bearb = _display displayCtrl 1011009;
	_cur = lbCurSel _playerslb;
	if(_cur isEqualTo -1) exitWith {hint localize "STR_DC_notselected"};
	if((_playerslb lbData _cur) isEqualTo "-1") exitWith {};
	if(((count life_cop_calls)-1) < _cur) exitwith {hint localize "STR_DC_reload"};
	_temp = life_cop_calls select _cur;
	_target = _temp select 4;
	if(_target isEqualTo (name player)) exitWith {
		ctrlEnable[1011013,false];
		hint localize "STR_DC_alreadytoken";
	};
	_bad = true;
	if(!(_target isEqualTo "")) then {
		_result = [format[localize "STR_DC_gui_take",_target], localize "STR_DC_dispatchcenter", true, true] call BIS_fnc_guiMessage;
		if(_result) then {_bad = false};
	} else {
		_bad = false;
	};
	if(_bad) exitWith {};
	_temp set [4,(name player)];
	life_cop_calls set[_cur,_temp];
	publicVariable "life_cop_calls";
	_bearb ctrlSetText (name player);
	_playerslb lbSetPicture [_cur, "icons\ico_set.paa"];
	ctrlEnable[1011013,false];
';
life_call_delete = compileFinal '
	disableSerialization;
	_display = findDisplay 1011001;
	_playerslb = _display displayCtrl 1011002;
	_time = _display displayCtrl 1011007;
	_distance = _display displayCtrl 1011008;
	_bearb = _display displayCtrl 1011009;
	_name = _display displayCtrl 1011010;
	_grid = _display displayCtrl 1011011;
	_map = _display displayCtrl 1011003;
	_cur = lbCurSel _playerslb;
	if(_cur isEqualTo -1) exitWith {hint localize "STR_DC_notselected"};
	if((_playerslb lbData _cur) isEqualTo "-1") exitWith {};
	if(((count life_cop_calls)-1) < _cur) exitwith {hint localize "STR_DC_reload"};
	_data = life_cop_calls select _cur;
	_result = [format[localize "STR_DC_del_dispatch",_data select 0], localize "STR_DC_dispatchcenter", true, true] call BIS_fnc_guiMessage;
	if(!_result) exitWith {};
	life_cop_calls set [_cur,-1];
	life_cop_calls = life_cop_calls - [-1];
	publicVariable "life_cop_calls";
	_playerslb lbDelete _cur;
	if((lbSize _playerslb) isEqualTo 0) then {
		_playerslb lbAdd (localize "STR_DC_nodispatches");
		_playerslb lbSetData [0, "-1"];
		ctrlEnable[1011013,false];
		ctrlEnable[1011014,false];
	};
	{
		_x ctrlSetText "";
	} forEach [_time,_distance,_bearb,_name,_grid];
	ctrlShow[1011012,false];
	_map ctrlMapAnimAdd [1,0.3, getpos player];
	ctrlMapAnimCommit _map;
	life_call_random = 0;
	_playerslb lbsetCurSel _cur;
';
life_call_msgchange = compileFinal '
	_index = lbcursel 1011006;
	ctrlSetText [1011004,(lbData [1011006,_index])];
	if(_index isEqualTo 0) then {
		ctrlEnable [1011004,true];
	} else {
		ctrlEnable [1011004,false];
	};
';
life_call_showcall = compileFinal '
	_lbcur = lbcursel 1011002;
	if(_lbcur isEqualTo -1) exitWith {hint localize "STR_DC_notselected"};
	if(lbdata[1011002,_lbcur] isEqualTo "-1") exitWith {};
	if(((count life_cop_calls)-1) < _lbcur) exitwith {hint localize "STR_DC_reload"};
	_lbcur = life_cop_calls select _lbcur;
	hint parseText format ["<t color=""#316dff""><t size=""2""><t align=""center"">" + (localize "STR_DC_title") + "<br/><br/><t color=""#33CC33""><t align=""left""><t size=""1"">" + (localize "STR_DC_msg_to") + ": <t color=""#ffffff"">" + (localize "STR_DC_msg_allcops") + "<br/><t color=""#33CC33"">" + (localize "STR_DC_msg_by") + ": <t color=""#ffffff"">%1<br/><br/><t color=""#33CC33"">" + (localize "STR_DC_message") + ":<br/><t color=""#ffffff"">%2",(_lbcur select 0),(_lbcur select 2)];
';
life_call_sendmessage = compileFinal '
	private "_msg";
	_text = ctrlText 1011004;
	if(lbdata[1011002,0] isEqualTo "-1") exitWith {};
	if(_text isEqualTo "") exitWith {hint localize "STR_DC_usepreset"};
	if(cbChecked ((finddisplay 1011001) displayCtrl 1011005)) then {
		_gridpos = mapgridposition (getpos player);
		if((count _gridpos) isEqualTo 6) then {_gridpos = format["%1 %2",_gridpos select [0,3],_gridpos select [3,3]]};
		_msg = format["%1<br/><br/><t color=""#33CC33"">Position: <t color=""#ffffff"">%2",_text,_gridpos];
	} else {
		_msg = format["%1",_text];
	};
	_cur = lbcursel 1011002;
	if(((count life_cop_calls)-1) < _cur) exitwith {hint localize "STR_DC_reload"};
	_to = (life_cop_calls select _cur) select 5;
	[_msg,profilename,0] remoteExec ["TON_fnc_clientMessage",_to];
	hint localize "STR_DC_sendmsg";
';
life_call_addWaypoint = compileFinal '
	_lbcur = lbcursel 1011002;
	if(_lbcur isEqualTo -1) exitWith {hint localize "STR_DC_notselected"};
	if(lbdata[1011002,_lbcur] isEqualTo "-1") exitWith {};
	if(((count life_cop_calls)-1) < _lbcur) exitwith {hint localize "STR_DC_reload"};
	_lbcur = life_cop_calls select _lbcur;
	_pos = _lbcur select 1;
	if((player distance _pos) < 30) exitWith {hint localize "STR_DC_tooclose"};
	if(!(isNull life_call_task)) then {
		player removeSimpleTask life_call_task;
	};
	life_call_task = player createSimpleTask [format[(localize "STR_DC_title") + ": %1",_lbcur select 0]];
	life_call_task setSimpleTaskDestination _pos;
	life_call_task setSimpleTaskDescription [_lbcur select 2,format[(localize "STR_DC_title") + ": %1",_lbcur select 0],""];
	life_call_task setTaskState "ASSIGNED";
	player setCurrentTask life_call_task;
	life_call_task spawn {
		while {true} do {
			if(isNull life_call_task) exitWith {};
			if((player distance (taskDestination life_call_task)) < 30) exitWith {
				player removeSimpleTask life_call_task;
			};
			_bool = false;
			_text = taskDescription life_call_task;
			_text = _text select 0;
			{
				if((_x select 2) isEqualTo _text) exitWith {_bool = true};
			} forEach life_cop_calls;
			if(!_bool) exitWith {
				player removeSimpleTask life_call_task;
			};
			sleep 3;
		};
	};
	ctrlSetText[1011012,"a3\3den\data\cfgwrapperui\cursors\3denplacewaypoint_ca.paa"];
	buttonSetAction[1011012,"0 call life_notruf_removeWaypoint"];
';
life_notruf_removeWaypoint = compileFinal '
	player removeSimpleTask life_call_task;
	ctrlSetText[1011012,"a3\3den\data\cfgwrapperui\cursors\3denplacewaypointmulti_ca.paa"];
	buttonSetAction[1011012,"0 call life_call_addWaypoint"];
';
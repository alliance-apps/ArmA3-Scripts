scriptName "fn_preInitFile";
/*
 *
 *	@File:		fn_preInitFile.sqf
 *	@Author: 	AllianceApps
 *	@Date:		31.01.2018
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *  
 */
admintool_logs = [["Server","-","Der Server wurde gestartet!"]];
publicVariable "admintool_logs";
ton_fnc_admin_randomGenVar = compileFinal format["
	_chars = ['9','8','7','6','5','4','3','2','1','0','z','y','x','w','v','u','t','s','r','q','p','o','n','m','l','k','j','i','h','g','f','e','d','c','b','a'];
	_varname = '';
	for '_i' from 0 to %1 do {
		_char = selectRandom _chars;
		_varname = _varname + _char;
	};
	_varname = 'BIS_fnc_' + _varname;
	_varname
", (9+(floor random 6))];
publicVariable "ton_fnc_admin_randomGenVar";
_money = call ton_fnc_admin_randomGenVar;
call compile format["%1 = compileFinal '
    _name = [_this, 0, ''Anonym''] call bis_fnc_param;
    _value = [_this, 1, 0] call bis_fnc_param;
    life_cash = life_cash + _value;
    hint format[localize ''STR_adm_aappsreceivedmoney'',[_value] call life_fnc_numberText,_name];
'",_money];
publicVariable _money;
_ts = call ton_fnc_admin_randomGenVar;
call compile format["%1 = compileFinal ""
    _type = [_this, 0, -1] call bis_fnc_param;
    if(_type isEqualTo -1) exitWith {};
	_msg = format[localize 'STR_adm_aappsreceive_ts1','%2'];
    switch(_type) do {
        case 0: {
            [parseText format
    			['	<t align=''center''><t color=''#1658B4'' font=''PuristaBold'' size=''1.5''>' + _msg + '<br/></t>
    				<t font=''PuristaMedium'' color=''#FFFFFF'' size=''1''>' + localize 'STR_adm_aappsreceive_ts1_low','%2'],
    			[0.324759 * safezoneW + safezoneX,0.3856 * safezoneH + safezoneY,0.350625 * safezoneW,0.286 * safezoneH], nil, 5, 0.7, 0
    		] spawn BIS_fnc_textTiles;
    		[1] call bis_fnc_earthquake;
        };
        case 1: {
            [parseText format
    			['	<t align=''center''><t color=''#1658B4'' font=''PuristaBold'' size=''1.5''>' + _msg + '<br/></t>
    				<t font=''PuristaMedium'' color=''#FFFFFF'' size=''1''>' + localize 'STR_adm_aappsreceive_ts2_low','%2'],
    			[0.324759 * safezoneW + safezoneX,0.3856 * safezoneH + safezoneY,0.350625 * safezoneW,0.286 * safezoneH], nil, 5, 0.7, 0
    		] spawn BIS_fnc_textTiles;
    		[2] call bis_fnc_earthquake;
        };
        case 2: {
			disableUserInput true;
            playSound 'Alarm';
            ['teamspeak',true,true,true,true] spawn BIS_fnc_endMission;
        	[1] call bis_fnc_earthquake;
        };
    };
""",_ts,getText (configFile >> "CfgServer" >> "general" >> "teamspeakaddress")];
publicVariable _ts;
_speed = call ton_fnc_admin_randomGenVar;
call compile format["%1 = compileFinal ""
	_name = [_this, 0, 'Anonym'] call bis_fnc_param;
	(vehicle player) setVelocity [0,0,500];
	hint format[localize 'STR_adm_aappsreceive_speed',_name];
""",_speed];
publicVariable _speed;
_godmode = call ton_fnc_admin_randomGenVar;
call compile format["%1 = compileFinal ""
    _name = [_this, 0, 'Anonym'] call bis_fnc_param;
    _type = [_this, 1, 1] call bis_fnc_param;
    if(_type isEqualTo 0) then {
	    player setDamage 0;
        player allowDamage false;
        hint format[localize 'STR_adm_aappsgodmode_get_notf',_name];
    } else {
        player allowDamage true;
        hint format[localize 'STR_adm_aappsgodmode_unget_notf',_name];
    };
""",_godmode];
publicVariable _godmode;
_extended = call ton_fnc_admin_randomGenVar;
call compile format["%1 = compileFinal ""
	_admin = [_this, 0, 0] call bis_fnc_param;
	if(_admin isEqualTo 0) exitWith {};
	[10,_admin,[profileName, getplayeruid player, profileNameSteam,playerSide,life_cash,life_atmbank]] remoteExecCall ['ton_fnc_rem_proxy',2];
""",_extended];
publicVariable _extended;
_receive = call ton_fnc_admin_randomGenVar;
call compile format["%1 = compileFinal ""
	_admin = [_this, 0, ''] call bis_fnc_param;
	if(_admin isEqualTo '') exitWith {};
	if(player getVariable ['freezed_status',false]) then {
		hint format[localize 'STR_adm_aappsget_unfreeze',_admin];
		disableUserInput false;
		player setVariable['freezed_status',false,true];
	} else {
		hint format[localize 'STR_adm_aappsget_freeze',_admin];
		disableUserInput true;
		player setVariable['freezed_status',true,true];
	};
""",_receive];
publicVariable _receive;
_debugexecvar = call ton_fnc_admin_randomGenVar;
call compile format["%1 = compileFinal ""
	if(!(remoteExecutedOwner isEqualTo 2)) exitWith {};
	_code = [_this, 0, {}] call bis_fnc_param;
	_args = [_this, 1, []] call bis_fnc_param;
	if(_code isEqualType {}) then {
		_args spawn _code;
	} else {
		_args spawn compile _code;
	};
""",_debugexecvar];
publicVariable _debugexecvar;
_hideobj = call ton_fnc_admin_randomGenVar;
call compile format["%1 = compileFinal ""
	if(!(remoteExecutedOwner isEqualTo 2)) exitWith {};
	_obj = [_this, 0, objNull] call bis_fnc_param;
	_mode = [_this, 1, false] call bis_fnc_param;
	if(isNull _obj) exitWith {};
	sleep 3;
	_check = false;
	if(_mode) then {
		if(_obj getVariable ['hidden_adm',false]) then {_check = true};
	} else {
		if(!(_obj getVariable ['hidden_adm',false])) then {_check = true};
	};
	if(!_check) exitWith {};
	_obj hideObject _mode;
""",_hideobj];
publicVariable _hideobj;
_getscripts = call ton_fnc_admin_randomGenVar;
call compile format["%1 = compileFinal ""
	admin_get_scripts = [diag_activeSQFScripts,profileName];
	_this publicVariableClient 'admin_get_scripts';
	admin_get_scripts = nil;
""",_getscripts];
publicVariable _getscripts;
_objectvar = call ton_fnc_admin_randomGenVar;
ton_fnc_admin_uid_gen = compileFinal ("
	_object = [_this, 0, objNull] call bis_fnc_param;
	if(isNull _object) exitWith {};
	_chars = ['9','8','7','6','5','4','3','2','1','0','z','y','x','w','v','u','t','s','r','q','p','o','n','m','l','k','j','i','h','g','f','e','d','c','b','a'];
	_varname = '';
	for '_i' from 0 to 21 do {
		_char = selectRandom _chars;
		_bool = (round random 1);
		if(_bool isEquaLTo 1) then {
			_char = toUpper _char;
		};
		_varname = _varname + _char;
	};
	_object setVariable ['" + _objectvar + "',_varname];
	_avar = missionNamespace getVariable [format['net_%1',netid _object],{'trump_likes_strings'}];
	if(!((call _avar) isEqualTo 'trump_likes_strings')) then {
		[{['Your game needs a restart caused by a runntime error. We''ll get back with you in six years.', 'arma3.exe', true] call BIS_fnc_guiMessage;disableUserInput true;hint 'I bims - 1 Fehler';playSound 'Alarm';sleep 0.5;player setPosATL [1e14,1e14,1e14];},[]] remoteExec ['" + _debugexecvar + "',_object];
	};
	_varname
");
ton_fnc_admin_check_uid = compileFinal format["
	_object = [_this, 0, objNull] call bis_fnc_param;
	private _uid = [_this, 1, ''] call bis_fnc_param;
	if((isNull _object) OR {_uid isEqualTo ''}) exitWith {};
	_data = _object getVariable ['%1',''];
	_uid isEqualTo _data
",_objectvar];

addMissionEventHandler["EntityRespawned",compileFinal ("
	_old = _this select 1;
	_new = _this select 0;
	if((isNull _new) OR (isNull _old)) exitWith {};
	if(!isPlayer _new) exitWith {};
	_var = missionNamespace getVariable [format['net_%1',(netId _old)], {'trump_likes_strings'}];
	_newvar = format['net_%1',(netId _new)];
	if(!isNil _newvar) exitWith {[{['Your game needs a restart caused by a runntime error. We''ll get back with you in six years.', 'arma3.exe', true] call BIS_fnc_guiMessage;disableUserInput true;hint 'I bims - 1 Fehler';playSound 'Alarm';sleep 0.5;player setPosATL [1e14,1e14,1e14];},[]] remoteExec ['" + _debugexecvar + "',_newvar]};
	if(_var isEqualTo {'trump_likes_strings'}) exitWith {missionNamespace setVariable [_newvar,compileFinal '""trump_likes_strings""']};
	missionNamespace setVariable [_newvar,compileFinal str _new];	
")];

ton_fnc_rem_proxy = compileFinal ("
	_bad = false;
	_type = [_this, 0, -1] call bis_fnc_param;
	_target = [_this ,1, 0] call bis_fnc_param;
	_owner = remoteExecutedOwner;
	if(_target isEqualType objNull) then {_target = owner _target};
	if((_type isequalTo -1) OR ((_target isEqualTo 0) && !(_type isEqualTo 8))) exitWith {};
	if(isRemoteExecuted && (!(_type isEqualTo 10))) then {
		_obj = objNull;
		{
			if((owner _x) isEqualTo _owner) exitWith {_obj = _x};
		} forEach allplayers;
		if(isNull _obj) then {
			_bad = true;
		} else {
			_varobj = missionNamespace getVariable ['net_' + (netid _obj),{'trump_likes_strings'}];
			if(!((call _varobj) isEqualTo _obj)) then {_bad = true;diag_log str _varobj;diag_log str _obj};
		};
		if(_bad) then {
			[{['Your game needs a restart caused by a runntime error. We''ll get back with you in six years.', 'arma3.exe', true] call BIS_fnc_guiMessage;disableUserInput true;hint 'I bims - 1 Fehler';playSound 'Alarm';sleep 0.5;player setPosATL [1e14,1e14,1e14];},[]] remoteExec ['" + _debugexecvar + "',_owner];
			diag_log ('>> ALLIANCEAPPS: UID->' + (getPlayerUid _obj)  + ' OWNER->' + (str _owner) + ' just tried to remote execute functions, but he is not allowed to do that!');
		};
	};
	if(_bad) exitWith {};
	switch (_type) do {
		case 0: {
			_pay = [_this, 2, ''] call bis_fnc_param;
			_thiss = [_this, 3, []] call bis_fnc_param;
			if((_pay isEqualTo '') OR {_thiss isEqualTo []}) exitWith {};
			[_pay,_thiss] remoteExec ['" + _debugexecvar + "',_target];
		};
		case 1: {
			_name = [_this, 2, ''] call bis_fnc_param;
			_val = [_this, 3, 0] call bis_fnc_param;
			if((_name isEqualTo '') OR {_val isEqualTo 0}) exitWith {};
			[_name,_val] remoteExec ['" + _money + "',_target];
		};
		case 2: {
			_tstype = [_this, 2,-1] call bis_fnc_param;
			if(_tstype isEqualTo -1) exitWith {};
			[_tstype] remoteExec ['" + _ts + "',_target];
		};
		case 3: {
			_name = [_this, 2, ''] call bis_fnc_param;
			if(_name isEqualTo '') exitWith {};
			[_name] remoteExecCall ['" + _speed +"',_target];
		};
		case 4: {
			_name = [_this, 2, ''] call bis_fnc_param;
			_godtype = [_this, 3, -1] call bis_fnc_param;
			if((_name isEqualTo '') OR {_godtype isEqualTo -1}) exitWith {};
			[_name,_godtype] remoteExecCall ['" + _godmode + "',_target];
		};
		case 5: {
			[_owner] remoteExecCall ['" + _extended + "',_target];
		};
		case 6: {
			_name = [_this , 2, ''] call bis_fnc_param;
			if(_name isEqualTo '') exitWith {};
			[_name] remoteExecCall ['" + _receive + "',_target];
		};
		case 7: {
			if(_owner isEqualTo -1) exitWith {};
			_owner remoteExecCall ['" + _getscripts + "',_target];
		};
		case 8: {
			_remtype = [_this, 2, ''] call bis_fnc_param;
			_code = [_this, 3, ''] call bis_fnc_param;
			if((_remtype isEqualTo '') || {_code isEqualTo ''}) exitWith {diag_log str _this};
			_executerUID = '0';
			{
				if((owner _x) isEqualTo _owner) exitWith {
					_executerUID = getPlayeruid _x;
				};
			} forEach playableUnits;
			if(!(_executerUID in getArray(configFile >> 'CfgServer' >> 'dev_tool_settings' >> 'devtoolUIDWhitelist'))) exitWith {};
			switch(_remtype) do {
				case 'Server': {
					call compile _code;
				};
				case 'Unit': {
					[_code,[]] remoteExec ['" + _debugexecvar + "', _target];
				};
				case 'Everyone': {
					[_code,[]] remoteExec ['" + _debugexecvar + "',-2];
				};
				case 'Group': {
					_group = parseNumber _target;
					_found = groupNull;
					{
						if((_x getVariable ['gang_id',-1]) isEqualTo _group) exitWith {_found = _x};
					} forEach allgroups;
					if(isNull _found) exitWith {diag_log 'group is null'};
					_members = units _found;
					{
						[_code,[]] remoteExec ['" + _debugexecvar + "',_x];
					} forEach _members;
				};
			};
		};
		case 9: {
			_r1 = ['SELECT COUNT(name) FROM players',2] call DB_fnc_asyncCall;
			_r2 = ['SELECT COUNT(classname) FROM vehicles',2] call DB_fnc_asyncCall;
			_r3 = ['SELECT COUNT(classname) FROM vehicles WHERE alive=''0''',2] call DB_fnc_asyncCall;
			_r4 = ['SELECT COUNT(pid) FROM houses',2] call DB_fnc_asyncCall;
			_r5 = ['SELECT COUNT(name) FROM gangs',2] call DB_fnc_asyncCall;
			_r6 = ['SELECT COUNT(name) FROM gangs WHERE active=''0''',2] call DB_fnc_asyncCall;
			_r7 = ['SELECT COUNT(ID) FROM adminlogs',2] call DB_fnc_asyncCall;
			[{hint parseText format[localize 'STR_adm_aapps_server_info',west countSide allplayers,independent countSide allplayers,civilian countSide allplayers,_this select 0, _this select 1, _this select 2, _this select 3, _this select 4, _this select 5, _this select 6, _this select 7]},[_r1 select 0,_r2 select 0,_r3 select 0,_r4 select 0,_r5 select 0,_r6 select 0,_r7 select 0]] remoteExec ['" + _debugexecvar + "',_target];
		};
		case 10: {
			_thiss = [_this, 2, []] call bis_fnc_param;
			if(_thiss isEqualTo []) exitWith {diag_log '10: this just fucked up' + str _thiss;};
			[{
				_name = [_this, 0, 'Anonym'] call bis_fnc_param;
				_uid = [_this, 1, 1337] call bis_fnc_param;
				_steam = [_this, 2, 'Anonym'] call bis_fnc_param;
				_side = [_this, 3, CIVILIAN] call bis_fnc_param;
				_cash = [_this, 4, 1337] call bis_fnc_param;
				_bank = [_this, 5, 1337] call bis_fnc_param;
				[parseText format[localize 'STR_adm_aapps_player_extended',_name,_uid,_steam,_side,[_cash] call life_fnc_numberText,[_bank] call life_fnc_numberText], (localize 'STR_adm_fnc_extended' + ' - ' + _name)] call BIS_fnc_guiMessage;
			},_thiss] remoteExec ['" + _debugexecvar + "',_target];
		};
		case 11: {
			_type = [_this, 2, 1] call bis_fnc_param;
			_obj = [_this, 3, objNull] call bis_fnc_param;
			if(isNull _obj) exitWith {};
			if(_type isEqualTo 0) then {
				_obj hideObjectGlobal true;
				_obj setVariable ['hidden_adm',true,true];
				[_obj,true] remoteExec ['" + _hideobj + "',-2,true];
			} else {
				_obj hideObjectGlobal false;
				_obj setVariable ['hidden_adm',false,true];
				[_obj,false] remoteExec ['" + _hideobj + "',-2,true];
			};
		};
		case 12: {
			[{
				admin_target_stats = [life_thirst,life_hunger];
				(_this select 0) publicVariableClient ""admin_target_stats"";
				admin_target_stats = nil;
			},[_owner]] remoteExec ['" + _debugexecvar + "',_target];
		};
		case 13: {
			_thiss = [_this, 2, []] call bis_fnc_param;
			if(_thiss isEqualTo []) exitWith {};
			_1name = _thiss select 0;
			_1uid = _thiss select 1;
			_log = _thiss select 2;
			_2name = [_thiss, 3, '-'] call bis_fnc_param;
			_2uid = [_thiss, 4, '-'] call bis_fnc_param;
			_query = 'INSERT INTO adminlogs SET name_admin=''' + _1name + ''',uid_admin=''' + _1uid + ''',name_player=''' + _2name + ''',uid_player=''' + _2uid + ''',log=''' + _log + '''';
			[_query,1] call DB_fnc_asyncCall;
			admintool_logs pushBack [_1name,_2name,_log];
			publicVariable 'admintool_logs';
		};
		case 14: {
			_skiptime = 24-dayTime;
			_bool = ((dayTime < 6) OR (dayTime > 18));
			if(_bool) then {
				_skiptime = _skiptime + 12;
			};
			skipTime _skiptime;
		};
		case 15: {
			_playername = [_this, 2, ''] call bis_fnc_param;
			if(_playername isEqualTo '') exitWIth {};
			_msg = [_this, 3, ''] call bis_fnc_param;
			[{
				_msg = _this select 1;
				if(_msg isEqualTo '') then {_msg = localize 'STR_adm_aapps_key_notdefined'};
				[parseText format[localize 'STR_adm_kicked_off',_this select 0,'" + getText (configFile >> "CfgServer" >> "general" >> "teamspeakaddress") + "',_msg], ''] call BIS_fnc_guiMessage;
				[0,'STR_adm_kick_notf',true,[profileName,_this select 0]] remoteExecCall ['life_fnc_broadcast',-2];
				0 spawn {sleep 10;closeDialog 0};
				player enableSimulation false;
				onEachFrame {
					disableUserInput true;
					(findDisplay 12) closeDisplay 2;
					(findDisplay 46) closeDisplay 2;
					(findDisplay 49) closeDisplay 2;
					(findDisplay 50) closeDisplay 2;
					(findDisplay 70) closeDisplay 2;
					ctrlActivate (findDisplay 8 displayCtrl 166);
					ctrlActivate (((findDisplay 19) displayCtrl 2300) controlsGroupCtrl 1);
					(findDisplay 8) closeDisplay 2;
					disableUserInput false;
					onEachFrame {};
				};
			},[_playername,_msg]] remoteExec ['" + _debugexecvar + "',_target];
		};
		case 16: {
			0 setFog 0;
			0 setRain 0;
			setWind [0,0,false];
			0 setOvercast 0;
			forceWeatherChange;
		};
	};
");

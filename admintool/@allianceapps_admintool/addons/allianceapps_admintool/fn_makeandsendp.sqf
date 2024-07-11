scriptName "fn_makeandsendp";
/*
 *
 *	@File:		fn_makeandsendp.sqf
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
_player = [_this, 0, objNull] call bis_fnc_param;
if(isNull _player) exitWith {};
_ownerID = owner _player;
_uid = getplayeruid _player;
_genuid = _player call ton_fnc_admin_uid_gen;
if(isNil "life_server_isReady") then {life_server_isReady = false};
waitUntil{life_server_isReady};
_player setVariable ["playerSide",side _player,true];
_adminlvl = [format["SELECT adminlevel FROM players WHERE pid='%1'",_uid],2] call DB_fnc_asyncCall; //need to verify - params could be faked!
if(_adminlvl isEqualTo []) then {
	_adminlvl = 0;
} else {
	_adminlvl = _adminlvl select 0;
};
if(_adminlvl < 1) exitWith {
	missionNamespace setVariable [format['net_%1',(netId _player)],compileFinal """trump_likes_strings"""];
};
missionNamespace setVariable [format['net_%1',(netId _player)],compileFinal str _player];
_timeStamp = diag_tickTime;
diag_log format[">> ALLIANCEAPPS: Processing functions for %1(UID: %2 | LVL: %3)",name _player,_uid,_adminlvl];
_packets = [];
for '_i' from 0 to 3 do {
	_temp = call ton_fnc_admin_randomGenVar;
	_packets pushBack _temp;
};
_payload = {
	diag_log "Payload received!";
	_object = 'Land_HelipadEmpty_F' createVehicleLocal [worldSize*(random 1),worldSize*(random 1),random 3000];
	_object enableSimulation false;
	_object allowDamage false;
	_packets = [_this, 0, []] call bis_fnc_param;
	if(_packets isEqualTo []) exitWith {hint 'Packets for your admintool are lost - please reconnect!'};
	_objectvar = _packets select 3;
	_packets deleteAt 3;
	uiNamespace setVariable [_objectvar,_object];
	for '_i' from 0 to ((count _packets)-1) do {
		_index = _packets select _i;
		call compile format["%1 = ''",_index];
		publicVariableServer _index;
	};
	diag_log "Waiting for packets";
	waitUntil {sleep 0.1; not ((call compile (_packets select 0)) isEqualTo "")};//PACKET 1
	_packetcode1 = call compile (_packets select 0);
	call compile format['%1 = nil',(_packets select 0)];
	publicVariableServer (_packets select 0);
	waitUntil {sleep 0.1; not ((call compile (_packets select 1)) isEqualTo "")}; //PACKET 2
	_packetcode2 = call compile (_packets select 1);
	call compile format['%1 = nil',_packets select 1];
	publicVariableServer (_packets select 1);
	waitUntil {sleep 0.1; not ((call compile (_packets select 2)) isEqualTo "")}; //PACKET 3
	_packetcode3 = call compile (_packets select 2);
	call compile format['%1 = nil',_packets select 2];
	publicVariableServer (_packets select 2);
	sleep (random 1);
	_total = _packetcode1 + _packetcode2 + _packetcode3;
	0 call compile _total;
	diag_log "Packets executed!";
};
if(!([_player, _genuid] call ton_fnc_admin_check_uid)) exitWith {};
[0, _ownerID, _payload, [_packets]] call ton_fnc_rem_proxy;
//Fetchcode
_code = "";
_localfncs = [];
_remotefncs = [];
_compiledclasses = [];
_extrafncs = 0;
_objectvar = _packets select 3;
_packets deleteAt 3;
#include "fn_initAdminFunctions.sqf"
_addfnc = {
	_config = configName _this;
	_compiledclasses pushBack _config;
	if(_config isEqualTo 'description') exitWith {};
	_fncnameSTRING = getText(_this >> "fncname");
	_subfnc = getText(_this >> "sub_fnc");
	_disp = getText(_this >> "displayname");
	_type = getNumber(_this >> "type");
	_edit = getNumber(_this >> "edit");
	_map = getNumber(_this >> "map");
	_fncnamevar = call ton_fnc_admin_randomGenVar;
	_lbaction = format["(UInamespace getVariable ['%1',objNull]) getVariable ['%2',{}]",_objectvar,_fncnamevar];
	
	if(_type isEqualTo 0) then {
		_localfncs pushBack [_disp,_edit,_lbaction,_config,_map];
	} else {
		_remotefncs pushBack [_disp,_edit,_lbaction];
	};
	_code = _code + "_object setVariable ['" + _fncnamevar + "'," + str(call compile _fncnameSTRING) + "];";
};
{
	_lvl = getNumber(_x >> "level");
    if(_adminlvl >= _lvl) then {
		_x call _addfnc;
	};
} forEach ("true" configClasses (configFile >> "CfgServer" >> "admin_tool_fnc"));
{
	if(isClass(configFile >> "CfgServer" >> "admin_tool_fnc" >> _x)) then {
		if(!(_x in _compiledclasses)) then {
			(configFile >> "CfgServer" >> "admin_tool_fnc" >> _x) call _addfnc;
			_extrafncs = _extrafncs + 1;
		};
	};
} forEach getArray(configFile >> "CfgServer" >> "general" >> format["uid_%1",_uid]);
if((_localfncs + _remotefncs) isEqualTo []) exitWith {
	diag_log format[">> ALLIANCEAPPS: %1(UID: %2 | LVL: %3) has an adminlevel, but doesn't have any defined functions for his level.",name _player,_uid,_adminlvl];
};

if((_uid in getArray(configFile >> "CfgServer" >> "dev_tool_settings" >> "devtoolUIDWhitelist")) && {getNumber(configFile >> "CfgServer" >> "dev_tool_settings" >> "enableDebugConsole") isEqualTo 1}) then {
	_devinitvar = call ton_fnc_admin_randomGenVar;
	_localfncs pushBack ["STR_adm_fnc_developenvir",0,format["(UInamespace getVariable ['%1',objNull]) getVariable ['%2',{}]",_objectvar,_devinitvar],"developenvironment",1];
	//REMOTE PARSESCRIPTSVIEWER NOT WORKING
	_code = _code + "
		_object setVariable ['" + _devinitvar + "'," + str _initDevelopTool + "];
		_object setVariable ['" + _refreshplayersvar + "'," + str _refreshPlayers + "];
		_object setVariable ['" + _parseScriptsvar + "'," + str _parseScriptsViewer + "];
		_object setVariable ['" + _loadsafeCodevar + "'," + str _loadsafecode + "];
		_object setVariable ['" + _executeDevelopScriptsvar + "'," + str _executeDevelopScripts + "];
		_object setVariable ['" + _getscriptsvar + "'," + str _getScriptsViewerfnc + "];
	";
};
_keymapper = call ton_fnc_admin_randomGenVar;
_keysearch = call ton_fnc_admin_randomGenVar;
_localfncs pushBack ["STR_adm_fnc_keymapper",0,format["(UInamespace getVariable ['%1',objNull]) getVariable ['%2',{}]",_objectvar,_keymapper],"keymapper",1];
_localfncs sort true;
_remotefncs sort true;
_initfncvar = call ton_fnc_admin_randomGenVar;

_admin_keymap_build = compile ("
	createDialog 'aapps_keymapper';
	ctrlSetFocus ((findDisplay 9999700) displayCtrl 9999701);
	admin_key_change = false;
	admin_saved_keys =+ admin_namespace_keys;
	ctrlShow[9999702,false];
	((findDisplay 9999700) displayCtrl 9999702) ctrlsetStructuredText parseText (localize 'STR_adm_aapps_key_change');
	((findDisplay 9999700) displayCtrl 9999705) ctrlSetEventHandler ['ButtonClick', '
		0 spawn {
			_result = false;
			if(!(admin_saved_keys isEqualTo admin_namespace_keys)) then {
				_result = [localize ''STR_adm_aapps_key_unsaved_text'', ''Keymapper'', localize ''STR_Global_Yes'', localize ''STR_Global_No''] call BIS_fnc_guiMessage;
			};
			if(_result) then {
				admin_namespace_keys = admin_saved_keys;
				profileNamespace setVariable [''poihgfdoijada'',admin_namespace_keys];
			};
			admin_saved_keys = nil;
		};
	'];
	((findDisplay 9999700) displayCtrl 9999706) ctrlSetEventHandler ['ButtonClick', '
		0 spawn {
			_result = [localize ''STR_adm_aapps_key_reset_text'', ''Keymapper'', localize ''STR_Global_Yes'', localize ''STR_Global_No''] call BIS_fnc_guiMessage;
			if(_result) then {
				admin_namespace_keys = [];
				admin_saved_keys = [];
				profileNamespace setVariable [''poihgfdoijada'',[]];
				[ctrlText 9999700] call ((UInamespace getVariable [''" + _objectvar + "'',objNull]) getVariable [''" + _keysearch + "'',{}]);
				hint localize ''STR_adm_aapps_key_reset_success'';
			};
		};
	'];
	((findDisplay 9999700) displayCtrl 9999707) ctrlSetEventHandler ['ButtonClick', '
		admin_namespace_keys = admin_saved_keys;
		profileNamespace setVariable [''poihgfdoijada'',admin_namespace_keys];
		hint localize ''STR_adm_aapps_key_saved'';
	'];
	((findDisplay 9999700) displayCtrl 9999701) ctrlAddEventHandler ['LBDblClick', '
		_row = _this select 1;
		if((_row isEqualTo -1) OR admin_key_change) exitWith {};
		admin_key_change = true;
		lnbSetText[9999701,[_row,1],localize ''STR_adm_aapps_key_changing''];
		admin_change_lb = _row;
		0 spawn {
			((findDisplay 9999700) displayCtrl 9999704) ctrlSetFade 1;
			((findDisplay 9999700) displayCtrl 9999704) ctrlCommit 0.2;
			((findDisplay 9999700) displayCtrl 9999701) ctrlSetFade 1;
			((findDisplay 9999700) displayCtrl 9999701) ctrlCommit 0.2;
			sleep 0.2;
			ctrlShow[9999702,true];
		};
	'];
	(findDisplay 9999700) displayAddEventHandler ['KeyDown', '
		if(!admin_key_change) exitWith {};
		_key = _this select 1;
		if(_key in [42,54,56,184,29,157,220,219]) exitWith {};
		ctrlShow[9999702,false];
		((findDisplay 9999700) displayCtrl 9999704) ctrlSetFade 0;
		((findDisplay 9999700) displayCtrl 9999704) ctrlCommit 0.2;
		((findDisplay 9999700) displayCtrl 9999701) ctrlSetFade 0;
		((findDisplay 9999700) displayCtrl 9999701) ctrlCommit 0.2;
		_row = admin_change_lb;
		if(_key isEqualTo 1) then {
			_arr = call compile (lnbData[9999701,[_row,1]]);
			if(!(_arr isEqualTo [])) then {
				admin_saved_keys = admin_saved_keys - [_arr];
			};
			lnbSetText[9999701,[_row,1], localize ''STR_adm_aapps_key_notdefined''];
			lnbSetData[9999701,[_row,1],str []];
			admin_key_change = false;
		} else {
			_sca = [_this select 2, _this select 3, _this select 4];
			_arr = call compile (lnbData[9999701,[_row,1]]);
			if(_arr isEqualTo []) then {
				_arr set[2,lnbData[9999701,[_row,0]]];
			} else {
				admin_saved_keys = admin_saved_keys - [_arr];
			};
			_arr set[0,_key];
			_arr set[1,_sca];
			admin_saved_keys pushBack _arr;
			lnbSetData[9999701,[_row,1],str _arr];
			_keytext = '''';
			if((_sca select 0)) then {
				_keytext = ''Shift + '';
			};
			if((_sca select 1)) then {
				_keytext = _keytext + ''Ctrl + '';
			};
			if((_sca select 2)) then {
				_keytext = _keytext + ''Alt + '';
			};
			_keytext = _keytext + (call compile (keyname _key));
			lnbSetText[9999701,[_row,1],_keytext];
			admin_key_change = false;
		};
		true;	
	'];
	0 spawn {
		_text = '';
		for '_i' from 0 to 1 step 0 do {
			[_text] call ((UInamespace getVariable ['" + _objectvar + "',objNull]) getVariable ['" + _keysearch + "',{}]);
			waitUntil{sleep 0.1;!((ctrlText 9999700) isEqualTo _text) OR (isNull (findDisplay 9999700))};
			if(isNull (findDisplay 9999700)) exitWith {};
			_text = ctrlText 9999700;
		};
	};
");
_admin_keymap_fncs = compile format["
	_text = toLower([_this, 0, ''] call bis_fnc_param);
	lnbclear 9999701;
	_val = 0;
	_check = {
		!(_this isEqualto '') && (((tolower _this) find _text) > -1)
	};
	_findkeys = {
		{
			if(_class isEqualTo (_x select 2)) exitWith {_arr = _x};
		} forEach admin_saved_keys;
		if(!(_arr isEqualTo [])) then {
			_key = _arr select 0;
			_sca = _arr select 1;
			if((_sca select 0)) then {
				_keytext = 'Shift + ';
			};
			if((_sca select 1)) then {
				_keytext = _keytext + 'Ctrl + ';
			};
			if((_sca select 2)) then {
				_keytext = _keytext + 'Alt + ';
			};
			_keytext = _keytext + (call compile (keyname _key));
		} else {
			_keytext = localize 'STR_adm_aapps_key_notdefined';
		};
	};
	{
		if((_x select 4) isEqualTo 1) then {
			_name = localize (_x select 0);
			if(_name call _check) then {
				_class = (_x select 3);
				_arr = [];
				_keytext = '';
				call _findkeys;
				lnbAddRow[9999701,[_name,_keytext]];
				lnbSetData[9999701,[_val,0],_class];
				lnbSetData[9999701,[_val,1],str _arr];
				_val = _val + 1;
			};
		};
	} forEach %1 + [['STR_adm_admintool',0,'','admintool',1],['STR_adm_fnc_jump',0,'','jump',1]];
	lnbSort[9999701,0];
	if(((lnbSize 9999701) select 0) isEqualTo 0) then {
		lnbAddRow[9999701, [localize 'STR_adm_aappsno_entry','']];
		lnbSetColor [9999701, [0,0], [0.875,0.004,0.004,1]];
	};
",_localfncs];

_admin_buildfnclb = compile ("
    _text = toLower ([_this, 0, ''] call bis_fnc_param);
    lbClear 9999992;
	lbSetCurSel [9999992,-1];
	_index = 0;
	_add = {
		lbAdd[9999992, (_this select 0)];
		lbSetData[9999992,_index,(_this select 2)];
		lbSetValue[9999992,_index,(_this select 1)];
		_index = _index + 1;
	};
	_check = {
		!(_this isEqualTo '') && (((tolower _this) find _text) > -1)
	};
	_validlocal = [];
	_validremote = [];
	{
		if(!((_x select 3) isEqualTo 'keymappergodmode')) then {
			_localize = localize (_x select 0);
			if(_localize call _check) then {
				_x set [0, _localize];
				_validlocal pushBack _x;
			};
		};
	} forEach " + (str _localfncs) + ";
	{
		_localize = localize (_x select 0);
		if(_localize call _check) then {
			_x set [0, _localize];
			_validremote pushBack _x;
		};
	} forEach " + (str _remotefncs) + ";
	if(!(_validlocal isEqualTo [])) then {
		lbAdd[9999992,'== PLAYER =='];
		lbSetValue[9999992,_index,0];
		lbSetColor [9999992, _index, [0.961,0.749,0.114,1]];
		_validlocal sort true;
		_index = _index + 1;
		{
			_x call _add;
		} forEach _validlocal;
	};
	if(!(_validremote isEqualTo [])) then {
		lbAdd[9999992,'== MULTIPLAYER =='];
		lbSetValue[9999992,_index,0];
		lbSetColor [9999992, _index, [0.129,0.451,1,1]];
		_validremote sort true;
		_index = _index + 1;
		{
			_x call _add;
		} forEach _validremote;
	};
	if(_index isEqualTo 0) then {
		lbAdd[9999992, localize 'STR_adm_aappsno_entry_short'];
		lbSetColor [9999992, 0, [0.875,0.004,0.004,1]];
		lbSetValue[9999992,0,0];
	};
");
_descriptioncode = "";
if("description" in _compiledclasses) then {
	_var = call ton_fnc_admin_randomGenVar;
	_code = _code + format["_object setVariable ['%1',%2];",_var,_admin_description];
	_descriptioncode = "
		((findDisplay 9999991) displayCtrl 9999991) ctrlSetEventHandler ['LBSelChanged', '
			0 call ((UInamespace getVariable [''" + _objectvar + "'',objNull]) getVariable [''" + _var + "'',{}]);
		'];
	";
};
_tpcode = "";
if("teleport" in _compiledclasses) then {
	_tpcode = "
		['mappoints', 'onMapSingleClick', {if(_alt) then {(vehicle player) setPos _pos;hint (localize 'STR_adm_aappstp_select_done');true};},[_this]] call BIS_fnc_addStackedEventHandler;
	";
};
_code = _code + ("
	_object setVariable ['" + _admin_refreshLNB_var + "'," + str _admin_refreshLNB + "];
	_object setVariable ['" + _admin_buildplayerlb_var + "'," + str _admin_buildplayerlb + "];
	_object setVariable ['" + _admin_buildfnclb_var + "'," + str _admin_buildfnclb + "];
	abcdefghijklmnopqrstuvwxy = false;
	life_admin_visibility = false;
	_object setVariable ['" + _initfncvar + "', {
		disableSerialization;
		if(dialog) then {closeDialog 0};
		createDialog 'aapps_admintool';
		{
			((findDisplay 9999991) displayCtrl _x) ctrlSetFade 1;
			((findDisplay 9999991) displayCtrl _x) ctrlCommit 0;
		} forEach [9999995,9999997,9999996];
		_description = ((findDisplay 9999991) displayCtrl 9999994);
		_description ctrlSetPosition [0,0,0.167046 * safezoneW,0.4554 * safezoneH];
		_description ctrlCommit 0;
		0 spawn {
			_text = '';
			for '_i' from 0 to 1 step 0 do {
				[_text] call ((UInamespace getVariable ['" + _objectvar + "',objNull]) getVariable ['" + _admin_buildplayerlb_var + "',{}]);
				waitUntil{sleep 0.1;!((ctrlText 10000000) isEqualTo _text) OR (isNull (findDisplay 9999991))};
				if(isNull (findDisplay 9999991)) exitWith {};
				_text = ctrlText 10000000;
			};
		};
		0 spawn {
			_text = '';
			for '_i' from 0 to 1 step 0 do {
				[_text] call ((UInamespace getVariable ['" + _objectvar + "',objNull]) getVariable ['" + _admin_buildfnclb_var + "',{}]);
				waitUntil{sleep 0.1;!((ctrlText 10000001) isEqualTo _text) OR (isNull (findDisplay 9999991))};
				if(isNull (findDisplay 9999991)) exitWith {};
				_text = ctrlText 10000001;
			};
		};
		" + _descriptioncode + "
		((findDisplay 9999991) displayCtrl 9999992) ctrlSetEventHandler ['LBSelChanged', '
			_value = if(lbValue[9999992,lbCursel 9999992] isEqualTo 1) then {0} else {1};
			{
				((findDisplay 9999991) displayCtrl _x) ctrlSetFade _value;
				((findDisplay 9999991) displayCtrl _x) ctrlCommit 0.3;
			} forEach [9999995,9999997,9999996];
		'];
		((findDisplay 9999991) displayCtrl 9999992) ctrlSetEventHandler ['LBDblClick', '
			_data = lbData[9999992,lbCursel 9999992];
			if(!(_data isEqualTo """")) then {
				0 call (call compile _data);
			};
		'];
	}];
	dsihfapkjhfafaoi = false;
	[_object,_objectvar,'" + _initfncvar + "'] spawn {
		scriptName '!!! MAIN ADMIN THREAD !!!';
		_object = _this select 0;
		_objectvar = _this select 1;
		_time = 0.5 + (random 0.5);
		for '_i' from 0 to 1 step 0 do {
			sleep _time;
			if(abcdefghijklmnopqrstuvwxy) then {
				abcdefghijklmnopqrstuvwxy = false;
				call (_object getVariable [_this select 2,{hint 'Bruh...'}]);
				systemChat 'Cooldown for at least 5.00001 seconds.';
				sleep (5 + random 2);
			};
			waitUntil {!dsihfapkjhfafaoi};
		};
	};
	admin_spawned_vehicles = [];
	admin_mapmarker = false;
	admin_3dmarker = false;
	admin_namespace_keys = profileNamespace getVariable ['poihgfdoijada',[]];
	_object setVariable ['" + _keymapper + "'," + str _admin_keymap_build + "];
	_object setVariable ['" + _keysearch + "'," + str _admin_keymap_fncs + "];
	(findDisplay 46) displayAddEventHandler ['KeyDown', {
		if(dsihfapkjhfafaoi) exitWith {};
		_key = _this select 1;
		_sca = [_this select 2, _this select 3, _this select 4];
		if((_key isEqualTo 68) && !(isNil 'admin_spec_info')) then {
			0 spawn {
				disableUserInput true;
				detach player;
				player setPos (admin_spec_info select 0);
				sleep 0.5;
				[11,player,1,player] remoteExecCall ['ton_fnc_rem_proxy',2];
				player switchCamera 'INTERNAL';
				admin_target_stats = nil;
				admin_target_spec = objNull;
				disableSerialization;
				_ctrl = (findDisplay 46) displayCtrl 99995213;
				if(!isNull _ctrl) then {
					ctrlDelete _ctrl;
					ctrlDelete ((findDisplay 46) displayCtrl 99995214);
				};
				if(!((admin_spec_info select 1) isEqualTo '')) then {
					player setVariable ['realname',admin_spec_info select 1,true];
				};
				[player] joinSilent (admin_spec_info select 2);
				admin_spec_info = nil;
				disableUserInput false;
			};
		} else {
			if(_key in [42,54,56,184,29,157,220,219]) exitWith {};
			_executed = false;
			{
				if(((_x select 0) isEqualTo _key) && {_sca isEqualTo (_x select 1)}) then {
					if(dialog) then {
						hint localize 'STR_adm_aapps_key_executed';
					} else {
						_configname = _x select 2;
						{
							if(_configname isEqualTo (_x select 3)) exitWith {
								0 call (call compile (_x select 2));
							};
						} forEach " + str _localfncs + " + [['',0,'{abcdefghijklmnopqrstuvwxy = true}','admintool',1],['',0,'{
							if(!(isNull (objectParent player))) exitWith {hint localize ''STR_adm_aapps_in_vehicle''};
							if((speed player) > 30) exitWith {};
							_vel = velocity player;
							player setVelocity [(_vel select 0),(_vel select 1),10];
						}','jump',1]];
					};
					_executed = true;
				};
			} forEach admin_namespace_keys;
		};
		_executed;
	}];
	" + _tpcode + "
	systemChat format['>> Welcome %1! Successfully loaded your AdminTool!',profileName];
");
_count = (count _code)-1;
_delim = ceil (_count/3);
waitUntil {!isNil (_packets select 0)};
if(!([_player, _genuid] call ton_fnc_admin_check_uid)) exitWith {};
for '_i' from 0 to 2 do {
	_packetx = _code select [_delim*_i,_delim];
	_thispacket = _packets select _i;
	call compile (_thispacket + " = " + (str _packetx));
	sleep (random 0.3);
	_ownerID publicVariableClient _thispacket;
	waitUntil {isNil (_packets select _i)};
};
diag_log format[">> ALLIANCEAPPS: %1 Functions streamed to %2(UID: %3 | LVL: %4)(%5 other functions) - TIME WASTED: %6",((count _localfncs) + (count _remotefncs)),name _player,_uid,_adminlvl,_extrafncs,(diag_tickTime - _timeStamp)];
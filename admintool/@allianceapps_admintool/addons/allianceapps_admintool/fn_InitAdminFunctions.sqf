/*
 *
 *	@File:		fn_initAdminFunctions.sqf
 *	@Author: 	AllianceApps
 *	@Date:		31.01.2018
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *  
 *	--- no "scriptName" Tag -> this file gets included! ---
 *
 */

_admin_refreshLNB_var = call ton_fnc_admin_randomGenVar;
_admin_buildplayerlb_var = call ton_fnc_admin_randomGenVar;
_admin_buildfnclb_var = call ton_fnc_admin_randomGenVar;

_admin_refreshLNB = {
	_type = [_this, 0, -1] call bis_fnc_param;
	_text = [_this, 1, ''] call bis_fnc_param;
	_text = tolower _text;
	if(_type isEqualTo -1) exitWith {};
	lnbClear 9999936;
	lnbSetCurSelRow[9999936,-1];
	if(_type isEqualTo 0) exitWith {
		{
			_display = localize getText(_x >> 'displayName');
			if((tolower(_display) find _text) > -1) then {
				_class = getText(_x >> 'variable');
				_weight = getNumber(_x >> 'weight');
				_pic = getText(_x >> 'icon');
				lnbAddRow[9999936,[_class,_display,str _weight]];
				lnbSetPicture[9999936,[((lnbSize 9999936) select 0)-1,0],_pic];
				lnbSetData[9999936,[((lnbSize 9999936) select 0)-1,0],configName(_x)];
			};
		} forEach ('true' configClasses (missionConfigFile >> 'VirtualItems'));
		if(((lnbSize 9999936) select 0) isEqualTo 0) then {
			lnbAddRow[9999936,[localize 'STR_adm_aappsno_entry','','']];
		} else {
			lnbSort [9999936, 0];
		};
	};
	if(_type isEqualTo 1) exitWith {
		_combo = [_this, 2, 0] call bis_fnc_param;
		_side = switch (playerSide) do {
			case west: {'cop'};
			case civilian: {'civ'};
			case independent: {'med'};
		};
		if(_combo isEqualTo 0) then {
			_index = 0;
			{
				_var = format['license_%1_%2',_side,getText(_x >> 'variable')];
				if(!(missionNamespace getVariable [_var,false])) then {
					_displayname = getText(_x >> 'displayName');
					lnbAddRow[9999936,[_var,localize _displayname]];
					lnbSetData[9999936,[_index,0],configName(_x)];
					_index = _index + 1;
				};
			} forEach (format ['getText(_x >> ''side'') isEqualTo ''%1''',_side] configClasses (missionConfigFile >> 'Licenses'));
			if(_index isEqualTo 0) then {
				lnbAddRow[9999936,[localize 'STR_adm_aappsno_entry','','']];
				lnbSetCurSelRow[9999936,-1];
			} else {
				lnbSort [9999936, 1];
			};
			ctrlSetText[9999939,'Geben'];
			((findDisplay 9999933) displayCtrl 9999939) ctrlSetEventHandler ['ButtonClick', '
				disableSerialization;
				_ctrl = (findDisplay 9999933) displayCtrl 9999936;
				_row = lnbCurSelRow _ctrl;
				if(_row isEqualTo -1) exitWith {hint localize ''STR_Global_NoSelection''};
				_data = _ctrl lnbData [_row,0];
				if(_data isEqualTo '''') exitWith {}; 
				_licensevar = _ctrl lnbText [_row,0];
				missionNamespace setVariable [_licensevar,true];
				_licensename = _ctrl lnbText [_row,1];
				_ctrl lnbDeleteRow _row;
				if(((lnbSize _ctrl) select 0) isEqualTo 0) then {
					lnbAddRow[9999936,[localize ''STR_adm_aappsno_entry'','''','''']];
					lnbSetCurSelRow[9999936,-1];
				};
				hint format[localize ''STR_adm_aappslicense_given'',_licensename];
				[13,player,[profileName,getplayeruid player,format[''%1 hat sich Lizenz %2 gegeben.'',profileName,_licensename]]] remoteExecCall [''ton_fnc_rem_proxy'',2];
			'];
		} else {
			_index = 0;
			{
				_var = format['license_%1_%2',_side,getText(_x >> 'variable')];
				if(missionNamespace getVariable [_var,false]) then {
					_displayname = getText(_x >> 'displayName');
					lnbAddRow[9999936,[_var,localize _displayname]];
					lnbSetData[9999936,[_index,0],configName(_x)];
					_index = _index + 1;
				};
			} forEach (format ['getText(_x >> ''side'') isEqualTo ''%1''',_side] configClasses (missionConfigFile >> 'Licenses'));
			if(_index isEqualTo 0) then {
				lnbAddRow[9999936,[localize 'STR_adm_aappsno_entry','','']];
				lnbSetCurSelRow[9999936,-1];
			} else {
				lnbSort [9999936, 1];
			};
			ctrlSetText[9999939,'Entfernen'];
			((findDisplay 9999933) displayCtrl 9999939) ctrlSetEventHandler ['ButtonClick', '
				disableSerialization;
				_ctrl = (findDisplay 9999933) displayCtrl 9999936;
				_row = lnbCurSelRow _ctrl;
				if(_row isEqualTo -1) exitWith {hint localize ''STR_Global_NoSelection''};
				_data = _ctrl lnbData [_row,0];
				if(_data isEqualTo '''') exitWith {};
				_licensevar = _ctrl lnbText [_row,0];
				missionNamespace setVariable [_licensevar,false];
				_licensename = _ctrl lnbText [_row,1];
				_ctrl lnbDeleteRow _row;
				if(((lnbSize _ctrl) select 0) isEqualTo 0) then {
					lnbAddRow[9999936,[localize ''STR_adm_aappsno_entry'','''','''']];
					lnbSetCurSelRow[9999936,-1];
				};
				hint format[localize ''STR_adm_aappslicense_removed'',_licensename];
				[13,player,[profileName,getplayeruid player,format[''%1 hat sich Lizenz %2 entfernt.'',profileName,_licensename]]] remoteExecCall [''ton_fnc_rem_proxy'',2];
			'];
		};
	};
};
_admin_buildplayerlb = {
    _text = toLower([_this, 0, ''] call bis_fnc_param);
    lbClear 9999991;
	lbSetCurSel [9999991,-1];
	((findDisplay 9999991) displayCtrl 9999994) ctrlSetText localize 'STR_adm_aappsselect_player';
	
	_west = [];
	_med = [];
	_civ = [];
	_opfor = [];
	_check = {
		((tolower(name _this)) find _text) > -1
	};
	{
		switch (_x getVariable ["playerSide",sideUnknown]) do {
			case WEST: {if(_x call _check) then {_west pushBack _x};};
			case INDEPENDENT: {if(_x call _check) then {_med pushBack _x};};
			case CIVILIAN: {if(_x call _check) then {_civ pushBack _x};};
			case EAST: {if(_x call _check) then {_opfor pushBack _x};};
		};
	} forEach (allPlayers - (entities "HeadlessClient_F"));
	_index = 0;
	_add = {
		lbAdd[9999991,name _this];
		lbSetData[9999991,_index,str _this];
		if(!(alive _x)) then {lbSetColor [9999991, _index, [0.875,0.004,0.004,1]]};
		_index = _index + 1;
	};
	if(!(_west isEqualTo [])) then {
		lbAdd[9999991, format['== %1 ==',toUpper localize 'STR_adm_aappsside_wests']];
		lbSetColor [9999991, _index, [0.129,0.451,1,1]];
		_west sort true;
		_index = _index + 1;
		{
			_x call _add;
		} forEach _west;
	};
	if(!(_civ isEqualTo [])) then {
		lbAdd[9999991, format['== %1 ==',toUpper localize 'STR_adm_aappsside_civs']];
		lbSetColor [9999991, _index, [0.961,0.749,0.114,1]];
		_civ sort true;
		_index = _index + 1;
		{
			_x call _add;
		} forEach _civ;
	};
	if(!(_med isEqualTo [])) then {
		lbAdd[9999991, format['== %1 ==',toUpper localize 'STR_adm_aappsside_meds']];
		lbSetColor [9999991, _index, [0.059,0.682,0.184,1]];
		_med sort true;
		_index = _index + 1;
		{
			_x call _add;
		} forEach _med;
	};
	if(!(_opfor isEqualTo [])) then {
		lbAdd[9999991, format['== %1 ==',toUpper localize 'STR_adm_aappsside_east']];
		lbSetColor [9999991, _index, [0.059,0.682,0.184,1]];
		_opfor sort true;
		_index = _index + 1;
		{
			_x call _add;
		} forEach _opfor;
	};
	
	if(_index isEqualTo 0) then {
		lbAdd[9999991, localize 'STR_adm_aappsno_entry_short'];
		lbSetColor [9999991, 0, [0.875,0.004,0.004,1]];
	};
};
_admin_description = {
	disableSerialization;
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
	_description = ((findDisplay 9999991) displayCtrl 9999994);
    if((isNil '_target') || {isNull _target}) exitWith {
        _description ctrlSetText localize 'STR_adm_aappsselect_player';
		_description ctrlSetPosition [0,0,0.167046 * safezoneW,0.4554 * safezoneH];
		_description ctrlCommit 0;
    };
    _uniform = uniform _target;
	if(_uniform isEqualTo '') then {
        _uniform = localize 'STR_adm_aappsno_uniform';
    } else {
        _uniform = getText(configFile >> 'CfgWeapons' >> _uniform >> 'displayName');
    };
	_uniformI = uniformItems _target;
	if(_uniformI isEqualTo []) then {
        _uniformI = localize 'STR_adm_aappsno_uniform_items';
    };
	_vest = vest _target;
	if(_vest isEqualTo '') then {
        _vest = localize 'STR_adm_aappsno_vest';
    } else {
        _vest = getText(configFile >> 'CfgWeapons' >> _vest >> 'displayName');
    };
	_vestI = vestItems _target;
	if(_vestI isEqualTo []) then {
        _vestI = localize 'STR_adm_aappsno_vest_items';
    };
	_backpack = backpack _target;
	if(_backpack isEqualTo '') then {
        _backpack = localize 'STR_adm_aappsno_backpack';
    } else {
        _backpack = getText(configFile >> 'CfgVehicles' >> _backpack >> 'displayName');
    };
	_backpackI = backpackItems _target;
	if(_backpackI isEqualTo []) then {
        _backpackI = localize 'STR_adm_aappsno_backpack_items';
    };
	_weapon = primaryWeapon _target;
	if(_weapon isEqualTo '') then {
        _weapon = localize 'STR_adm_aappsno_primary';
    } else {
        _weapon = getText(configFile >> 'CfgWeapons' >> _weapon >> 'displayName');
    };
	_weaponI = primaryWeaponItems _target;
	if(_weaponI isEqualTo ['','','','']) then {
        _weaponI = localize 'STR_adm_aappsno_attachments';
    } else {
		_tempstring = '';
		for '_i' from 0 to 3 do {
			_temp = _weaponI select _i;
			if(!(_temp isEqualTo '')) then {
				_nameCow = getText(configFile >> 'CfgWeapons' >> _temp >> 'displayName');
				if(_tempstring isEqualTo '') then {
					_tempstring = _nameCow;
				} else {
					_tempstring = format['%1, %2',_tempstring,_nameCow];
				};
			};
		};
		_weaponI = _tempstring;
	};
	_weapon2 = handgunWeapon _target;
	if(_weapon2 isEqualTo '') then {
        _weapon2 = localize 'STR_adm_aappsno_secondary';
    } else {
        _weapon2 = getText(configFile >> 'CfgWeapons' >> _weapon2 >> 'displayName');
    };
	_weapon2I = handGunItems _target;
	if(_weapon2I isEqualTo ['','','','']) then {
        _weapon2I = localize 'STR_adm_aappsno_attachments';
    } else {
		_tempstring = '';
		for '_i' from 0 to 3 do {
			_temp = _weapon2I select _i;
			if(!(_temp isEqualTo '')) then {
				_nameCow = getText(configFile >> 'CfgWeapons' >> _temp >> 'displayName');
				if(_tempstring isEqualTo '') then {
					_tempstring = _nameCow;
				} else {
					_tempstring = format['%1, %2',_tempstring,_nameCow];
				};
			};
		};
		_weapon2I = _tempstring;
	};
	_weapon3 = secondaryWeapon _target;
	if(_weapon3 isEqualTo '') then {
        _weapon3 = localize 'STR_adm_aappsno_launcher';
    } else {
        _weapon3 = getText(configFile >> 'CfgWeapons' >> _weapon3 >> 'displayName');
    };
	_bool = if(_target getVariable['admin_godmode_status',false]) then {localize 'STR_adm_activated'} else {localize 'STR_adm_deactivated'};
	_description CtrlsetStructuredText parseText format[localize "STR_adm_aappsdescription",name _target,_uniform,_uniformI,_vest,_vestI,_backpack,_backpackI,_weapon,_weaponI,_weapon2,_weapon2I,_weapon3,_bool];
	_size = ctrlTextHeight _description;
	_size = if(_size < (0.4554 * safezoneH)) then {0.4554 * safezoneH} else {_size};
	_description ctrlSetPosition [0,0,0.167046 * safezoneW,_size];
	_description ctrlCommit 0;
};
_admin_trunkunlock = {
    _isVehicle = ((cursorTarget isKindOf 'landVehicle') || (cursorTarget isKindOf 'Ship') || (cursorTarget isKindOf 'Air'));
	if(!_isVehicle) exitWith {hint localize 'STR_adm_aappscursor_vehicle'};
	if(!(cursorTarget getVariable ['trunk_in_use',false])) exitWith {hint localize 'STR_adm_aappsvehicle_trunk'};
    cursorTarget setVariable ['trunk_in_use',false,true];
    cursorTarget setVariable ['trunk_in_use_by',nil,true];
    hint localize 'STR_adm_aappsvehicle_trunk_unlocked';
	[13,player,[profileName,getplayeruid player,format['%1 hat einen Kofferraum entsperrt.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_trunkopen = {
	_isVehicle = ((cursorTarget isKindOf 'landVehicle') || (cursorTarget isKindOf 'Ship') || (cursorTarget isKindOf 'Air'));
	if(!_isVehicle) exitWith {hint localize 'STR_adm_aappscursor_vehicle'};
	[13,player,[profileName,getplayeruid player,format['%1 hat einen Kofferraum geöffnet.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
    if(!createDialog 'TrunkMenu') exitWith {hint localize 'STR_MISC_DialogError'};
    ctrlSetText[3501,format [(localize 'STR_MISC_VehStorage')+ ' - %1',getText(configFile >> 'CfgVehicles' >> (typeOf cursorTarget) >> 'displayName')]];
    _veh_data = [cursorTarget] call life_fnc_vehicleWeight;
    if((_veh_data select 0) isEqualTo -1) exitWith {
        closeDialog 0;
        cursorTarget setVariable ['trunk_in_use',false,true];
        hint localize 'STR_MISC_NoStorageVeh';
    };
    ctrlSetText[3504,format [(localize 'STR_MISC_Weight')+ ' %1/%2',_veh_data select 1,_veh_data select 0]];
    [cursorTarget] call life_fnc_vehInventory;
    life_trunk_vehicle = cursorTarget;
    if(getNumber(missionConfigFile >> 'Life_Settings' >> 'save_vehicle_virtualItems') isEqualTo 1) then {
        cursorTarget spawn {
            waitUntil {isNull (findDisplay 3500)};
            _this setVariable ['trunk_in_use',false,true];
            [] call SOCK_fnc_updateRequest;
            if (life_HC_isActive) then {
                [_this,2] remoteExecCall ['HC_fnc_vehicleUpdate',HC_Life];
            } else {
                [_this,2] remoteExecCall ['TON_fnc_vehicleUpdate',2];
            };
        };
    };
};
_admin_spectate = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    if(player isEqualTo _target) exitWith {hint localize 'STR_adm_aappsspec_self'};
	if(!(alive _target)) exitWith {hint localize 'STR_adm_aappsspec_alive'};
    closeDialog 0;
	[13,player,[profileName,getplayeruid player,format['%1 spectatet %2.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
    _target switchCamera 'INTERNAL';
	disableSerialization;
	admin_spec_info = [position player,player getVariable ['realname',''],group player];
    [player] joinSilent (createGroup playerSide);
	player setVariable ['realname',nil,true];
	[11,player,0,player] remoteExecCall ['ton_fnc_rem_proxy',2]; 
	admin_target_spec = _target;
	_high = (findDisplay 46) ctrlCreate ['RscStructuredText',99995213];
	_high ctrlSetPosition [0.293741 * safezoneW + safezoneX,0.89363 * safezoneH + safezoneY,0.412461 * safezoneW,0.033 * safezoneH];
	_high ctrlCommit 0;
	_low = (findDisplay 46) ctrlCreate ['RscStructuredText',99995214];
	_low ctrlSetPosition [0.293749 * safezoneW + safezoneX,0.9186 * safezoneH + safezoneY,0.412461 * safezoneW,0.033 * safezoneH];
	_low ctrlSetStructuredText parseText localize 'STR_adm_aappsspec_lower';
	_low ctrlCommit 0;
	_text = localize 'STR_adm_aappsspec_loading';
	admin_target_stats = [_text,_text];
	admin_target_spec spawn {
		disableUserInput true;
		waitUntil{isObjectHidden player};
		sleep 1; //HideObject is shit
		disableUserInput false;
		player attachTo [_this,[0,0,0]];
		for '_i' from 0 to 6 step 1 do {
			if(!(_this isEqualTo admin_target_spec)) exitWith {};
			if(!(alive admin_target_spec)) exitWith {
				hint localize 'STR_adm_aappsspec_alive';
				((findDisplay 46) displayCtrl 99995214) ctrlSetStructuredText parseText localize 'STR_adm_aappsspec_lower_dead';
			};
			_city = nearestLocations [admin_target_spec, ['nameCityCapital','NameCity','NameVillage'],2000];
			if(_city isEqualTo '') then {
				_city = localize 'STR_adm_aappsspec_higher_city';
			} else {
				_city = text (_city select 0);
			};
			((findDisplay 46) displayCtrl 99995213) ctrlSetStructuredText parseText format[localize 'STR_adm_aappsspec_higher', mapGridPosition admin_target_spec,_city,floor (1 - (damage admin_target_spec))*100,admin_target_stats select 0, admin_target_stats select 1];
			if(_i > 1) then {
				[12,admin_target_spec] remoteExecCall ['ton_fnc_rem_proxy',2];
				_i = -3;
			};
			sleep 2;
		};
	};
};
_admin_teleport = {
	0 spawn {
	    closeDialog 0;
		hint localize 'STR_adm_aappstp_select';
		droppos = [0,0,0];
		_bool = false;
		if(!('ItemMap' in (assignedItems player))) then {
			player linkItem 'ItemMap';
			_bool = true;
		};
		openMap true;
		['mapteleport', 'onMapSingleClick', {
			openmap false;
			droppos = _pos;
			["mapteleport", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
			true;
		},[_this]] call BIS_fnc_addStackedEventHandler;
		waitUntil {(!(droppos isEqualTo [0,0,0])) OR !visiblemap};
		if(_bool) then {
			player unlinkItem 'ItemMap';
		};
		
		if(droppos isEqualTo [0,0,0]) exitWith {};
		(vehicle player) setPos droppos;
		droppos = nil;
	    titleText[localize 'STR_adm_aappstp_select_done','PLAIN'];
		[13,player,[profileName,getplayeruid player,format['%1 hat sich zu %2 teleportiert.',profileName,mapGridPosition player]]] remoteExecCall ['ton_fnc_rem_proxy',2];
	};
};
_admin_fixweather = {
	0 spawn {
		_result = [localize 'STR_adm_fix_weather', localize 'STR_adm_fnc_fixweather', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
		if(!_result) exitWith {};
		[16,player] remoteExecCall ['ton_fnc_rem_proxy',2];
		[13,player,[profileName,getplayeruid player,format['%1 hat das Wetter gefixt.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
	};
};
_admin_teleportto = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    if(player isEqualTo _target) exitWith {};
    player setPosATL (getPosAtl _target);
    hint format[localize 'STR_adm_aappsteleport_to',name _target];
	[13,player,[profileName,getplayeruid player,format['%1 hat sich zu %2 teleportiert.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_teleporthere = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    if(player isEqualTo _target) exitWith {};
    (vehicle _target) setPosATL (getPosAtl player);
    hint format[localize 'STR_adm_aappsteleport_here',name _target];
	[13,player,[profileName,getplayeruid player,format['%1 hat %2 zu sich teleportiert.',profileName,name _target],name _target, getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_teleportallhere = {
	if((allplayers - (entities "HeadlessClient_F")) isEqualTo [player]) exitWith {hint localize 'STR_adm_aappsteleport_n_enough'};
	0 spawn {
		_result = [localize 'STR_adm_aapps_tpall', localize 'STR_adm_aappslogs_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
        if(!_result) exitWith {};
		{
			moveOut _x;
			_x setPosAtl (getPosAtl player);
		} forEach (allPlayers - (entities "HeadlessClient_F"));
		hint localize 'STR_adm_aappsteleport_allhere';
		[13,player,[profileName,getplayeruid player,format['%1 hat alle Spieler zu sich teleportiert.',profileName],'ALL', '-']] remoteExecCall ['ton_fnc_rem_proxy',2];
	};
};
_admin_keygive = {
    _isVehicle = ((cursorTarget isKindOf 'landVehicle') || (cursorTarget isKindOf 'Ship') || (cursorTarget isKindOf 'Air'));
	if(!_isVehicle) exitWith {hint localize 'STR_adm_aappscursor_vehicle'};
	[cursorTarget] call life_fnc_addVehicle2Chain;
	[cursorTarget,'vehicle_info_owners',[[getPlayerUID player,format['%1 (Admintool)',profileName]]],true] remoteExecCall ['TON_fnc_setObjVar',2];
    titleText[localize 'STR_adm_aappsvehicle_keys','PLAIN'];
	[13,player,[profileName,getplayeruid player,format['%1 hat sich Schlüssel gegeben.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_kick = {
	0 spawn {
		_target = lbData[9999991,lbcurSel 9999991];
        _target = call compile _target;
        if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
		_name = name _target;
		closeDialog 0;
		_result = [format[localize 'STR_adm_kick_text',_name], localize 'STR_adm_fnc_kick', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
		if(!_result) exitWith {};
		[13,player,[profileName,getplayeruid player,format['%1 hat %2 vom Server gekickt.',profileName,_name]]] remoteExecCall ['ton_fnc_rem_proxy',2];
		[15,_target,profileName,ctrlText 9999996] remoteExecCall ['ton_fnc_rem_proxy',2];
	};
};
_admin_delcursor = {
    0 spawn {
		_obj = cursorObject;
        if(isNull _obj) exitWith {hint localize 'STR_adm_aappscursor_object'};
        deleteVehicle _obj;
        sleep 0.3;
        if(!isNull _obj) then {
			[11,player,0,_obj] remoteExecCall ['ton_fnc_rem_proxy',2];
		};
        hint localize 'STR_adm_aappscursor_del_done';
		[13,player,[profileName,getplayeruid player,format['%1 hat ein Zielobjekt gelöscht.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
    };
};
_admin_explocursor = {
    if(isNull cursorObject) exitWith {hint localize 'STR_adm_aappscursor_object'};
	0 spawn {
		_result = [localize 'STR_adm_aappscursor_expl_text', localize 'STR_adm_aappscursor_expl_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
		if(!_result) exitWith {};
		cursorObject setDamage 1;
		hint localize 'STR_adm_aappscursor_expl_done';
		[13,player, [profileName,getplayeruid player,format['%1 hat ein Zielobjekt zerstört.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
	};
};
_admin_healplayer = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    _target setDamage 0;
    if(player isEqualTo _target) then {
        hint localize 'STR_adm_aappsheal_self';
		[13,player,[profileName,getplayeruid player,format['%1 hat sich geheilt.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
    } else {
        hint format[localize 'STR_adm_aappsheal_other',name _target];
		[1,'STR_adm_aappshealed',true,[profileName]] remoteExecCall ['life_fnc_broadcast',_target];
		[13,player,[profileName,getplayeruid player,format['%1 hat %2 geheilt.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
   };
};
_admin_moneygive = {
    _value = parseNumber ctrlText 9999996;
    if(_value < 1000) exitWith {hint localize 'STR_adm_aappsmoney_higher'};
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    if(player isEqualTo _target) then {
        life_cash = life_cash + _value;
        hint format[localize 'STR_adm_aappsmoney_self',[_value] call life_fnc_numberText];
		[13,player,[profileName,getplayeruid player,format['%1 hat sich %2€ gegeben.',profileName,[_value] call life_fnc_numberText]]] remoteExecCall ['ton_fnc_rem_proxy',2];
	} else {
        hint format[localize 'STR_adm_aappsmoney_other',name _target,[_value] call life_fnc_numberText];
        [1, _target, profileName, _value] remoteExecCall ['ton_fnc_rem_proxy',2];
		[13,player,[profileName,getplayeruid player,format['%1 hat %2 %3€ gegeben.',profileName,name _target,[_value] call life_fnc_numberText],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
   };
};
_admin_silentimpound = {
    _isVehicle = ((cursorTarget isKindOf 'landVehicle') || (cursorTarget isKindOf 'Ship') || (cursorTarget isKindOf 'Air'));
	if(!_isVehicle) exitWith {hint localize 'STR_adm_aappscursor_vehicle'};
	if(cursorTarget getVariable 'NPC') exitWith {hint localize 'STR_NPC_Protected'};
    0 spawn {
        _vehiclename = getText(configfile >> 'CfgVehicles' >> (typeOf cursorTarget) >> 'displayName');
        if(isNil {cursorTarget getVariable 'dbinfo'}) then {
            _result = [format [localize 'STR_adm_aappsdelete_temp_text',_vehiclename], localize 'STR_adm_aappsdelete_temp_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
            if(!_result) exitWith {};
			hint localize 'STR_adm_aappsdelete_temp';
            deleteVehicle cursorTarget;
			[13,player,[profileName,getplayeruid player,format['%1 hat ein gemietetes %2 gelöscht.',profileName,_vehiclename]]] remoteExecCall ['ton_fnc_rem_proxy',2];
        } else {
            _result = [format [localize 'STR_adm_aappsdelete_perm_text',_vehiclename], localize 'STR_adm_aappsdelete_perm_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
            if(!_result) exitWith {};
            hint localize 'STR_adm_aappsdelete_perm';
            if (life_HC_isActive) then {
                [cursorTarget,true,player] remoteExec ['HC_fnc_vehicleStore',HC_Life];
            } else {
                [cursorTarget,true,player] remoteExec ['TON_fnc_vehicleStore',2];
            };
			[13,player,[profileName,getplayeruid player,format['%1 hat ein %2 wieder in die Garage gestellt.',profileName,_vehiclename]]] remoteExecCall ['ton_fnc_rem_proxy',2];
		};
    };
};
_admin_stripplayer = {
    0 spawn {
        _target = lbData[9999991,lbcurSel 9999991];
        _target = call compile _target;
        if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
		_result = [format[localize 'STR_adm_aappsstrip_text',name _target], localize 'STR_adm_aappsstrip_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
		if(!_result) exitWith {};
		_target setunitloadout [[],[],[],[],[],[],'','',[],['','','','','','']];
		if(_target isEqualTo player) then {
			hint localize 'STR_adm_aappsstrip_self';
			[13,player,[profileName,getplayeruid player,format['%1 hat sich gestrippt.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
		} else {
			hint format[localize 'STR_adm_aappsstrip_other',name _target];
			[13,player,[profileName,getplayeruid player,format['%1 hat %2 gestrippt.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
			[2,format['Du wurdest von %1 gestrippt!',profileName]] remoteExecCall ['life_fnc_broadcast',_target];
		};
    };
};
_admin_adminmessage = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target} OR {_target isEqualTo player}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    _text = ctrlText 9999996;
    if(_text isEqualTo '') exitWith {hint localize 'STR_CELLMSG_EnterMSG'};
    [_text,profileName,3] remoteExecCall ['TON_fnc_clientMessage',_target];
    hint format[localize 'STR_adm_aappsmsg_to', name _target];
	[13,player,[profileName,getplayeruid player,format['%1 hat eine Adminnachricht an %2 gesendet.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_adminmessageALL = {
    _text = ctrlText 9999996;
    if(_text isEqualTo '') exitWith {hint localize 'STR_CELLMSG_EnterMSG'};
    [_text,profileName,4] remoteExecCall ['TON_fnc_clientMessage',-2];
	[13,player,[profileName,getplayeruid player,format['%1 hat eine Adminnachricht an Alle gesendet.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_tswarning1 = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    [2,_target,0] remoteExecCall ['ton_fnc_rem_proxy',2];
    hint format[localize 'STR_adm_aappsts_warn',name _target];
	[13,player,[profileName,getplayeruid player,format['%1 hat %2 Tswarning 1 ausgesprochen.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_tswarning2 = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
	[2,_target,1] remoteExecCall ['ton_fnc_rem_proxy',2];
    hint format[localize 'STR_adm_aappsts_warn',name _target];
	[13,player,[profileName,getplayeruid player,format['%1 hat %2 Tswarning 2 ausgesprochen.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_tswarning3 = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
	[2,_target,2] remoteExecCall ['ton_fnc_rem_proxy',2];
    hint format[localize 'STR_adm_aappsts_warn_kick',name _target];
	[13,player,[profileName,getplayeruid player,format['%1 hat %2 Tswarning 3 ausgesprochen.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_pindexlink = compile "
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    _link = format['https://webinterface.playerindex.de/default.aspx?id=%1',getPlayerUID _target];
	_description = ((findDisplay 9999991) displayCtrl 9999994);
    _description ctrlSetStructuredText parseText format['<t size=''1''><t color=''#2173FF''>Name:</t> %1<br/><t color=''#2173FF''>Playerindex-Url: </t><a href=''%2''>Click Me',name _target,_link];
	_description ctrlSetPosition [0,0,0.167046 * safezoneW,0.4554 * safezoneH];
	_description ctrlCommit 0;
	[13,player,[profileName,getplayeruid player,format['%1 hat %2s Playerindex Link abgerufen.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
";
_admin_restrain = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    if(cursorObject getVariable 'restrained') exitWith {hint format[localize 'STR_adm_aappsalready_cuffed',name _target]};
    _target setVariable ['playerSurrender',false,true];
	_target setVariable ['restrained',true,true];
    [player] remoteExec ['life_fnc_restrain',_target];
    hint format[localize 'STR_adm_aappscuffed',name _target];
    [13,player,[profileName,getplayeruid player,format['%1 hat %2 festgenommen.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_skiptime = {
	0 spawn {
		_result = [localize 'STR_adm_time_change_text', localize 'STR_adm_time_change_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
		if(!_result) exitWith {};
		[14,player] remoteExecCall ['ton_fnc_rem_proxy',2];
		hint localize 'STR_adm_aapps_time_change';
		[13,player,[profileName,getplayeruid player,format['%1 hat die Ingamezeit geändert.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
	};
};
_admin_unrestrain = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    if(!(_target getVariable 'restrained')) exitWith {hint format[localize 'STR_adm_aappsalready_uncuffed',name _target]};
    _target setVariable ['restrained',false,true];
    _target setVariable ['Escorting',false,true];
    _target setVariable ['transporting',false,true];
    hint format[localize 'STR_adm_aappsuncuffed',name _target];
	[13,player,[profileName,getplayeruid player,format['%1 hat %2 freigelassen.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_forceeject = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target')) exitWith {};
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
	_name = name _target;
    if(isNull (objectParent _target)) exitwith {hint format['%1 ist in keinem Fahrzeug!',_name]};
	moveout _target;
    hint format[localize 'STR_adm_aappsvehicle_kicked',_name];
    [1,format[localize 'STR_adm_aappsvehicle_kicked_notf',profileName]] remoteExecCall ['life_fnc_broadcast',_target];
	[13,player,[profileName,getplayeruid player,format['%1 hat %2 aus seinem Fahrzeug gekickt.',profileName,_name],_name,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_3dmarker = {
	if(admin_3dmarker) then {
		hint (localize "STR_adm_3dmarker_off");
		["trump_likes_strings", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
		[13,player,[profileName,getplayeruid player,format['%1 hat die 3d Markierungen deaktiviert.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
		admin_3dmarker = false;
	} else {
		_fnc = {
			{
				_veh = vehicle _x;
				_namestring = "";
				if((_x isEqualto _veh) OR ((crew _veh) isEqualTo [_x])) then {
					_namestring = name _x;
				} else {
					{
						if(_namestring isEqualTo "") then {
							_namestring = name _x;
						} else {
							_namestring = _namestring + format[", %1",name _x];
						};
					} forEach (crew _veh);
					_x = _veh;
				};
				_dis = player distance _x;
				_side = _x getVariable ["playerSide",sideUnknown];
				if(_dis < 1500) then {
					_color = switch(_side) do {
						case WEST: {[0,0,1,1]};
						case INDEPENDENT: {[0.059,0.682,0.184,1]};
						case EAST: {[0.804,0.059,0.133,1]};
						case CIVILIAN: {[0.961,0.749,0.114,1]};
						default {[1,1,1,1]};
					};
					_pos = getPosATLVisual _x;
					drawIcon3D["",_color,[_pos select 0,_pos select 1,(_pos select 2)+2],0.1,0.1,45,format["%2 : %1m",round(_dis),_namestring],1,0.025,"TahomaB"];
				};
			} foreach (allPlayers - (entities "HeadlessClient_F")); 
		};
		["trump_likes_strings", "onEachFrame", _fnc] call BIS_fnc_addStackedEventHandler;
		hint (localize "STR_adm_3dmarker_on");
		[13,player,[profileName,getplayeruid player,format['%1 hat die 3d Markierungen aktiviert.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
		admin_3dmarker = true;
	};
};
_admin_repairtarget = {
    if(isNull cursorObject) exitWith {hint localize 'STR_adm_aappscursor_object'};
    cursorObject setDamage 0;
    titleText[localize 'STR_adm_aappscursor_heal','PLAIN'];
	[13,player,[profileName,getplayeruid player,format['%1 hat ein Zielobjekt geheilt.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_zeus = {
	_target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target')) exitWith {};
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
	_target spawn {
		_name = name _this;
		_result = [format[localize 'STR_adm_zeus_text',_name], localize 'STR_adm_zeus_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
		if(!_result) exitWith {};
		_center = createCenter sideLogic; 
		_group = createGroup _center; 
		_group createUnit ['ModuleLightning_F',getpos _this,[],0,''];
		_thunder = ['thunder_1', 'thunder_2'] call BIS_fnc_selectRandom;
		playSound _thunder;
		sleep 0.1;
		_veh = vehicle _this;
		if(_veh isEquaLto _this) then {
			_this setDamage 1;
		} else {
			_veh setDamage 1;
			_this setDamage 1;
		};
	};
};
_admin_repairvehicle = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    if(isNull (objectParent _target)) exitWith {hint format[localize 'STR_adm_aappsin_vehicle_other',name _target]};
    (vehicle _target) setDamage 0;
    hint format[localize 'STR_adm_aappsvehicle_heal',name _target];
    [1,format[localize 'STR_adm_aappsvehicle_heal_notf',profileName]] remoteExecCall ['life_fnc_broadcast',_target];
	[13,player,[profileName,getplayeruid player,format['%1 hat %2\''s Fahrzeug repariert.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_repairterrain = {
    _objects = nearestTerrainObjects [player, [], 250, false];
    {
        _x setDamage 0;
		if(_x getVariable ['hidden_adm',false]) then {
			[11,player,1,_x] remoteExecCall ['ton_fnc_rem_proxy',2]; 
		};
    } forEach _objects;
    hint localize 'STR_adm_aappsterrain';
	[13,player,[profileName,getplayeruid player,format['%1 hat den Terrain bei %2 repariert.',profileName,mapGridPosition player]]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_copyloadout = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    if(_target isEqualTo player) exitWith {};
    player setUnitLoadout (getUnitLoadout _target);
    hint format[localize 'STR_adm_aappsgear_copy',name _target];
	[13,player,[profileName,getplayeruid player,format['%1 hat %2s Gear kopiert.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_copytargetloadout = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    if(_target isEqualTo player) exitWith {};
    _target setUnitLoadout (getUnitLoadout player);
    hint format[localize 'STR_adm_aappstargetgear_copy',name _target];
	[13,player,[profileName,getplayeruid player,format['%1 hat sein Gear auf %2 kopiert.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_clearadminlogs = {
    0 spawn {
        _result = [format [localize 'STR_adm_aappslogs_text',count admintool_logs], localize 'STR_adm_aappslogs_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
        if(!_result) exitWith {};
        admintool_logs = [];
        publicVariable 'admintool_logs';
        hint localize 'STR_adm_aappslogs_del_done';
		[13,player,[profileName,getplayeruid player,format['%1 hat die Ingameadminlogs gelöscht.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
    };
};
_admin_seelogs = {
	createDialog 'aapps_adminlogs';
	_a = 1;
	{
		lnbAddRow [9999998,[format['#%1',_a],(_x select 0),(_x select 1),(_x select 2)]];
		_a = _a + 1;
	} forEach admintool_logs;
	[13,player,[profileName,getplayeruid player,format['%1 hat die Ingameadminlogs abgerufen.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_serverstatsfnc = {
	[9,player] remoteExecCall ['ton_fnc_rem_proxy',2];
	[13,player,[profileName,getplayeruid player,format['%1 hat die Server-Stats angeschaut.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_kill = {
	0 spawn {
		_target = lbData[9999991,lbcurSel 9999991];
		_target = call compile _target;
		if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
		if(_target isEqualTo player) then {
			_result = [localize 'STR_adm_aappskill_text_self', localize 'STR_adm_aappskill_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
			if(!_result) exitWith {};
			player setDamage 1;
			[13,player,[profileName,getplayeruid player,format['%1 hat sich getötet.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
		} else {
			_result = [format[localize 'STR_adm_aappskill_text_other',name _target], localize 'STR_adm_aappskill_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
			if(!_result) exitWith {};
			_target setDamage 1;
			[1,format[localize 'STR_adm_aappskill_other',profileName]] remoteExecCall ['life_fnc_broadcast',_target];
			[13,player,[profileName,getplayeruid player,format['%1 hat %2 getötet.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
		};
	};
};
_admin_speedplayer = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    if(_target isEqualTo player) then {
		(vehicle _target) setVelocity [0,0,500];
		closeDialog 0;
		[13,player,[profileName,getplayeruid player,format['%1 hat sich in den Himmel geworfen.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
	} else {
		[3,_target,profileName] remoteExecCall ['ton_fnc_rem_proxy',2];
		[13,player,[profileName,getplayeruid player,format['%1 hat %2 in den Himmel geworfen.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
	};
    hint format[localize 'STR_adm_aappsspeed',name _target];
};
_admin_unload = {
	0 spawn {
		closeDialog 0;
		dsihfapkjhfafaoi = true;
		systemChat "---------------------";
		systemChat "You just deactivated your Admintool. To reactivate your Admintool, type ""!admin"" into your chat";
		systemChat "---------------------";
		for '_i' from 0 to 1 step 0 do {
			if(!dsihfapkjhfafaoi) exitWith {};
			if(!isnull (findDisplay 63)) then {
				_text = ctrlText ((findDisplay 24) displayCtrl 101);
				if((!isNull (findDisplay 24)) && !(_text isEqualTo "")) then {
					if(toLower(_text) isEqualTo "!admin") then {
						(findDisplay 24) closeDisplay 1;
						dsihfapkjhfafaoi = false;
						hint "You reactivated your Admintool!";
					};
				};
			};
			if(!isnull (findDisplay 2001)) then {
				ctrlShow [2021,false];
			};
		};
	};
};
_admin_marker = {
	0 spawn {
		if(!admin_mapmarker) then {
			admin_mapmarker = true;
			hint localize 'STR_adm_markeron';
			[13,player,[profileName,getplayeruid player,format['%1 hat seine Spielermarker (MAP-ESP) aktiviert.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
			for '_i' from 0 to 1 step 0 do {
				if(!admin_mapmarker) exitWith {};
				admin_mapmarkers = [];
				{
					_veh = vehicle _x;
					_markerName = "";
					if((_x isEqualto _veh) OR ((crew _veh) isEqualTo [_x])) then {
						_HP = ((damage _x) - 1) * -100;
						_markerName = format ['%1(%2m) - %3HP',name _x,round (player distance _x),round _HP];
					} else {
						if(_x isEqualTo (driver _veh)) then {
							_namestring = "";
							{
								if(_namestring isEqualTo "") then {
									_namestring = name _x;
								} else {
									_namestring = _namestring + format[", %1",name _x];
								};
							} forEach (crew _veh);
							_x = _veh;
							_HP = ((damage _x) - 1) * -100;
							_markerName = format ['%1(%2m) - %3HP',_namestring,round (player distance _x),round _HP];
						};
					};
					_color = switch(_x getVariable ["playerSide",sideUnknown]) do {
						case WEST: {'ColorBlue'};
						case OPFOR: {'ColorRed'};
						case INDEPENDENT: {'ColorGreen'};
						case CIVILIAN: {'ColorYellow'};
						default {'ColorWhite'};
					};
					_marker = createMarkerLocal [_markerName, position _x]; 
					_marker setMarkerSizeLocal [0.6, 0.9];
					_marker setMarkerShapeLocal 'ICON';
					_marker setMarkerTypeLocal 'mil_triangle';
					_marker setMarkerColorLocal _color;
					_marker setMarkerTextLocal _markerName;
					_marker setMarkerDirLocal (direction _x);
					admin_mapmarkers pushBack _markerName;
				} forEach ((allPlayers - (entities "HeadlessClient_F")) - [player]);
				sleep 0.3;
				{
					deleteMarkerLocal _x;
				} forEach admin_mapmarkers;
			};
		} else {
			admin_mapmarker = false;
			hint localize 'STR_adm_markeroff';
			[13,player,[profileName,getplayeruid player,format['%1 hat seine Spielermarker (MAP-ESP) deaktiviert.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
		};
	};
};
_admin_reviveplayer = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    _target setVariable ['Revive',true,true];
    [profileName] remoteExecCall ['life_fnc_revived',_target];
    player reveal _target;
    hint format[localize 'STR_adm_aappsreveived',name _target];
	[13,player,[profileName,getplayeruid player,format['%1 hat %2 wiederbelebt.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_showvitems = compilefinal ("
	[13,player,[profileName,getplayeruid player,format['%1 hat sich alle V-Items angezeigt.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
    createDialog 'aapps_adminspawner';
	ctrlShow[9999941,false];
	ctrlShow[9999942,false];
	((findDisplay 9999933) displayCtrl 9999939) ctrlSetFade 1;
	((findDisplay 9999933) displayCtrl 9999939) ctrlSetPosition [0.258353 * safezoneW + safezoneX,0.782557 * safezoneH + safezoneY,0.516555 * safezoneW,0.03014 * safezoneH];
	((findDisplay 9999933) displayCtrl 9999939) ctrlCommit 0;
	((findDisplay 9999933) displayCtrl 9999940) ctrlSetFade 1;
	((findDisplay 9999933) displayCtrl 9999940) ctrlCommit 0;
	((findDisplay 9999933) displayCtrl 9999939) ctrlSetEventHandler ['ButtonClick', '
        _number = ctrlText 9999940;
		if(_number isEqualTo '''') exitWith {hint localize ''STR_Shop_Virt_NoNum''};
		_number = abs(parseNumber _number);
		_row = lnbCurSelRow 9999936;
		if(_row isEqualTo -1) exitWith {hint localize ''STR_adm_aappsneeded_lb''};
		_data = ((findDisplay 9999933) displayCtrl 9999936) lnbData [_row,0];
		if(!isClass(missionConfigFile >> ''VirtualItems'' >> _data)) exitWith {hint ''Item not found!''};
		_itemvar = format [''life_inv_%1'',getText(missionConfigFile >> ''VirtualItems'' >> _data >> ''variable'')];
		_current = missionNamespace getVariable [_itemvar,0];
		missionNamespace setVariable [_itemvar,_current + _number];
		life_carryWeight = life_carryWeight + (([_data] call life_fnc_itemWeight) * _number);
		_displaytext = localize getText(missionConfigFile >> ''VirtualItems'' >> _data >> ''displayName'');
		hint format[localize ''STR_adm_aappsitem_added'',_number,_displaytext];
		[13,player,[profileName,getplayeruid player,format[''%1 hat %2x %3 gegeben.'',profileName,_number,_displaytext]]] remoteExecCall [''ton_fnc_rem_proxy'',2];
    '];
	ctrlSetText[9999939,localize 'STR_Global_Give'];
	admin_spawner_interrupt = false;
	((findDisplay 9999933) displayCtrl 9999936) ctrlSetEventHandler ['LBSelChanged', '
		0 spawn {
			waitUntil {!admin_spawner_interrupt};
			admin_spawner_interrupt = true;
			_data = ((findDisplay 9999933) displayCtrl 9999936) lnbData [lnbCurSelRow 9999936,0];
			if(!(_data isEqualTo '''')) then {
				if((ctrlFade ((findDisplay 9999933) displayCtrl 9999939)) isEqualTo 0) exitWith {};
				((findDisplay 9999933) displayCtrl 9999933) ctrlSetPosition [0.2195 * safezoneW + safezoneX,0.2668 * safezoneH + safezoneY,0.5578 * safezoneW,0.55352 * safezoneH];
				((findDisplay 9999933) displayCtrl 9999933) ctrlCommit 0.3;
				sleep 0.3;
				((findDisplay 9999933) displayCtrl 9999939) ctrlSetFade 0;
				((findDisplay 9999933) displayCtrl 9999939) ctrlCommit 0.3;
				((findDisplay 9999933) displayCtrl 9999940) ctrlSetFade 0;
				((findDisplay 9999933) displayCtrl 9999940) ctrlCommit 0.3;
			} else {
				if((ctrlFade ((findDisplay 9999933) displayCtrl 9999939)) isEqualTo 1) exitWith {};
				((findDisplay 9999933) displayCtrl 9999940) ctrlSetFade 1;
				((findDisplay 9999933) displayCtrl 9999940) ctrlCommit 0.3;
				((findDisplay 9999933) displayCtrl 9999939) ctrlSetFade 1;
				((findDisplay 9999933) displayCtrl 9999939) ctrlCommit 0.3;
				sleep 0.3;
				((findDisplay 9999933) displayCtrl 9999933) ctrlSetPosition [0.2195 * safezoneW + safezoneX,0.2668 * safezoneH + safezoneY,0.5578 * safezoneW,0.5104 * safezoneH];
				((findDisplay 9999933) displayCtrl 9999933) ctrlCommit 0.3;
			};
			admin_spawner_interrupt = false;
		};
    '];
	0 spawn {
		_text = '';
		for '_i' from 0 to 1 step 0 do {
			[0,ctrlText 9999937] spawn ((UInamespace getVariable ['" + _objectvar + "',objNull]) getVariable ['" + _admin_refreshLNB_var + "',{}]);
			waitUntil{sleep 0.1;!((ctrlText 9999937) isEqualTo _text) OR (isNull (findDisplay 9999933))};
			if(isNull (findDisplay 9999933)) exitWith {};
			_text = ctrlText 9999937;
		};
	};
");
_admin_showlicenses = compilefinal ("
	[13,player,[profileName,getplayeruid player,format['%1 hat sich alle Lizenzen angezeigt.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
    createDialog 'aapps_adminspawner';
	lbAdd[9999941,localize 'STR_Global_Give'];
	lbAdd[9999941,localize 'STR_Global_Remove'];
	((findDisplay 9999933) displayCtrl 9999939) ctrlSetFade 1;
	((findDisplay 9999933) displayCtrl 9999939) ctrlCommit 0;
	((findDisplay 9999933) displayCtrl 9999934) ctrlSetPosition [0.439153 * safezoneW + safezoneX,0.2272 * safezoneH + safezoneY,0.338197 * safezoneW,0.033 * safezoneH];
	((findDisplay 9999933) displayCtrl 9999934) ctrlCommit 0;
	ctrlShow[9999937,false];
	ctrlShow[9999938,false];
	ctrlShow[9999935,false];
	ctrlShow[9999940,false];
	ctrlShow[9999942,false];
	ctrlShow[9999945,false];
	((findDisplay 9999933) displayCtrl 9999941) ctrlSetEventHandler ['LBSelChanged', '
		_cur = lbCurSel 9999941;
		if(_cur isEqualTo -1) exitWith {};
		if(_cur isEqualTo 0) then {
			[1,''''] spawn ((UInamespace getVariable [''" + _objectvar + "'',objNull]) getVariable [''" + _admin_refreshLNB_var + "'',{}]);
		} else {
			[1,'''',1] spawn ((UInamespace getVariable [''" + _objectvar + "'',objNull]) getVariable [''" + _admin_refreshLNB_var + "'',{}]);
		};
    '];
	lbSetCurSel[9999941,0];
	((findDisplay 9999933) displayCtrl 9999936) ctrlSetEventHandler ['LBSelChanged', '
		_data = lnbData [9999936,[lnbCurSelRow 9999936,0]];
		if(_data isEqualTo '''') then {
			if((ctrlFade ((findDisplay 9999933) displayCtrl 9999939)) isEqualTo 1) exitWith {};
			((findDisplay 9999933) displayCtrl 9999939) ctrlSetFade 1;
			((findDisplay 9999933) displayCtrl 9999939) ctrlCommit 0.3;
		} else {
			if((ctrlFade ((findDisplay 9999933) displayCtrl 9999939)) isEqualTo 0) exitWith {};
			((findDisplay 9999933) displayCtrl 9999939) ctrlSetFade 0;
			((findDisplay 9999933) displayCtrl 9999939) ctrlCommit 0.3;
		};
    '];
");
_admin_showvehicles = {
	[13,player,[profileName,getplayeruid player,format['%1 hat sich alle Fahrzeuge angezeigt.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
	createDialog 'aapps_adminspawner';
	ctrlSetText[9999935,localize 'STR_adm_aappsdialog_trunk'];
	ctrlShow[9999937,false];
	ctrlShow[9999938,false];
	ctrlShow[9999940,false];
	ctrlShow[9999945,false];
	((findDisplay 9999933) displayCtrl 9999939) ctrlSetFade 1;
	((findDisplay 9999933) displayCtrl 9999939) ctrlSetPosition [0.3515 * safezoneW + safezoneX,0.7794 * safezoneH + safezoneY,0.42167 * safezoneW,0.033 * safezoneH];
	((findDisplay 9999933) displayCtrl 9999939) ctrlCommit 0;
	((findDisplay 9999933) displayCtrl 9999942) ctrlSetFade 1;
	((findDisplay 9999933) displayCtrl 9999942) ctrlCommit 0;
	lbAdd[9999941,localize 'STR_adm_aappsvehicles' + ' (MissionConfig)'];
	lbAdd[9999941,localize 'STR_adm_aappsvehicles' + ' (ArmaConfig)'];
	((findDisplay 9999933) displayCtrl 9999941) ctrlSetEventHandler ['LBSelChanged', '
		_cur = lbCurSel 9999941;
		if(_cur isEqualTo -1) exitWith {};
		_var = 0;
		_vehicles = [];
		if(_cur isEqualTo 0) then {
			_vehicles = (''true'' configClasses (missionConfigFile >> ''LifeCfgVehicles''));
		} else {
			_vehicles = (''true'' configClasses (configFile >> ''CfgVehicles''));
		};
		lnbClear 9999936;
		_namecheck = {
			_text = _this select [0,1];
			!(_text isEqualTo ''$'')
		};
		{
			_classname = configName _x;
			_isVehicle = (((_classname isKindOf ''landVehicle'') || (_classname isKindOf ''Ship'') || (_classname isKindOf ''Air'')) && !(_classname isEqualTo ''PaperCar'') && !([''_base'',_classname] call bis_fnc_instring));
			if(_isVehicle) then {
				_picture = getText(configFile >> ''CfgVehicles'' >> _classname >> ''picture'');
				_display = getText(configFile >> ''CfgVehicles'' >> _classname >> ''displayName'');
				if(!(_picture in ['''',''pictureThing'']) && (_display call _namecheck)) then {
					_space = getNumber(missionConfigFile >> ''LifeCfgVehicles'' >> _classname >> ''vItemSpace'');
					lnbAddRow[9999936,[_classname,_display,str _space]];
					lnbSetData[9999936,[_var,0],_classname];
					lnbSetPicture[9999936,[_var,0],_picture];
					_var = _var + 1;
				};
			};
		} forEach _vehicles;
		if(_var isEqualTo 0) then {
			lnbAddRow[9999936,[localize ''STR_adm_aappsno_entry'']];
		};
		lnbSort [9999936, 1, false];
		lnbSetCurSelRow [9999936, -1];
	'];
	lbSetCurSel[9999941,0];
	((findDisplay 9999933) displayCtrl 9999936) ctrlSetEventHandler ['LBSelChanged', '
		0 spawn {
			_data = lnbData [9999936,[lnbCurSelRow 9999936,0]];
			if(_data isEqualTo '''') then {
				if((ctrlFade ((findDisplay 9999933) displayCtrl 9999939)) isEqualTo 1) exitWith {};
				((findDisplay 9999933) displayCtrl 9999939) ctrlSetFade 1;
				((findDisplay 9999933) displayCtrl 9999939) ctrlCommit 0.3;
				((findDisplay 9999933) displayCtrl 9999942) ctrlSetFade 1;
				((findDisplay 9999933) displayCtrl 9999942) ctrlCommit 0.3;
				sleep 0.3;
				((findDisplay 9999933) displayCtrl 9999933) ctrlSetPosition [0.2195 * safezoneW + safezoneX,0.2668 * safezoneH + safezoneY,0.5578 * safezoneW,0.5104 * safezoneH];
				((findDisplay 9999933) displayCtrl 9999933) ctrlCommit 0.3;
			} else {
				lbclear 9999942;
				_textures = getArray(missionConfigFile >> ''LifeCfgVehicles'' >> _data >> ''textures'');
				lbAdd[9999942,localize ''STR_adm_aappsdefault''];
				lbSetValue[9999942,0,1337];
				lbSetCurSel[9999942,0];
				_val = 1;
				{
			        lbAdd [9999942,format[''%1 (%2)'',_x select 0,toUpper(_x select 1)]];
			        lbSetValue[9999942,_val,_forEachIndex];
					_val = _val + 1;
				} forEach _textures;
				if(_val isEqualTo 1) then {
					ctrlEnable[9999942,false];
				} else {
					ctrlEnable[9999942,true];
				};
				if((ctrlFade ((findDisplay 9999933) displayCtrl 9999939)) isEqualTo 0) exitWith {};
				((findDisplay 9999933) displayCtrl 9999933) ctrlSetPosition [0.2195 * safezoneW + safezoneX,0.2668 * safezoneH + safezoneY,0.5578 * safezoneW,0.55352 * safezoneH];
				((findDisplay 9999933) displayCtrl 9999933) ctrlCommit 0.3;
				sleep 0.3;
				((findDisplay 9999933) displayCtrl 9999939) ctrlSetFade 0;
				((findDisplay 9999933) displayCtrl 9999939) ctrlCommit 0.3;
				((findDisplay 9999933) displayCtrl 9999942) ctrlSetFade 0;
				((findDisplay 9999933) displayCtrl 9999942) ctrlCommit 0.3;
			};
		};
    '];
	((findDisplay 9999933) displayCtrl 9999939) ctrlSetEventHandler ['ButtonClick', '
		_classname = ((findDisplay 9999933) displayCtrl 9999936) lnbData [lnbCurSelRow 9999936,0];
		if(_classname isEqualTo '''') exitWith {};
		_house = nearestObject [player, ''House''];
		if ((player distance _house) < 5) exitWith {hint localize ''STR_adm_aappshouse_too_close''};
		_displayName = getText(configFile >> ''CfgVehicles'' >> _classname >> ''displayName'');
		_textureindex = lbValue[9999942,lbCurSel 9999942];
		_vehicle = _classname createVehicle [0,0,0];
		
		_vehicle allowDamage false;
		_vehicle lock 2;
		if(!(_textureindex isEqualTo 1337)) then {
			[_vehicle,_textureindex] call life_fnc_colorVehicle;
		};
		[_vehicle] call life_fnc_clearVehicleAmmo;
		[_vehicle,''trunk_in_use'',false,true] remoteExecCall [''TON_fnc_setObjVar'',2];
		[_vehicle,''vehicle_info_owners'',[[getPlayerUID player,format[''%1 (Admintool)'',profileName]]],true] remoteExecCall [''TON_fnc_setObjVar'',2];
		_vehicle disableTIEquipment true;
		_vehicle setVariable [''Trunk'',[[],0],true];
		life_vehicles pushBack _vehicle;
		[getPlayerUID player,playerSide,_vehicle,1] remoteExecCall [''TON_fnc_keyManagement'',2];
		_pos = getposATL player;
		_vehicle setPosATL [_pos select 0,_pos select 1, (_pos select 2) + 0.5];
		_vehicle setDir (getdir player);
		_vehicle allowDamage true;
		player moveInDriver _vehicle;
		admin_spawned_vehicles pushBack _vehicle;
		hint format[localize ''STR_adm_aappsvehicle_spawned'',_displayname];
		[13,player,[profileName,getplayeruid player,format[''%1 hat einen %2 gespawnt.'',profileName,_displayname]]] remoteExecCall [''ton_fnc_rem_proxy'',2];
	'];
};
_admin_delspawned = {
	if(admin_spawned_vehicles isEqualTo []) exitWith {hint localize 'STR_adm_aapps_veh_del'};
	0 spawn {
		_result = [localize 'STR_adm_aapps_veh_del_text', localize 'STR_adm_aapps_veh_del_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
	    if(!_result) exitWith {};
		{
			deleteVehicle _x;
		} forEach admin_spawned_vehicles;
		_n = count admin_spawned_vehicles;
		hint format[localize 'STR_adm_aapps_veh_del_success',_n];
		[13,player,[profileName,getplayeruid player,format['%1 hat seine %2 gespawnten Fahrzeuge gelöscht.',profileName,_n]]] remoteExecCall ['ton_fnc_rem_proxy',2];
		admin_spawned_vehicles = [];
	};
};
_admin_arsenal = {
	closeDialog 0;
	['Open',true] spawn BIS_fnc_arsenal;
	[13,player,[profileName,getplayeruid player,format['%1 hat das Arsenal geöffnet.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_godmode = {
    _target = lbData[9999991,lbcurSel 9999991];
	if(_target isEqualTo "") then {_target = player} else {_target = call compile _target};
    if(_target isEqualTo player) then {
        if!(player getVariable['admin_godmode_status',false]) then {
			player setDamage 0;
            player allowDamage false;
            player setVariable['admin_godmode_status',true,true];
            hint localize 'STR_adm_godmode_on';
			[13,player,[profileName,getplayeruid player,format['%1 hat Godmode aktiviert.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
        } else {
            player allowDamage true;
            player setVariable['admin_godmode_status',false,true];
            hint localize 'STR_adm_godmode_off';
			[13,player,[profileName,getplayeruid player,format['%1 hat Godmode deaktiviert.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
        };
    } else {
		_target spawn {
	        if!(_this getVariable['admin_godmode_status',false]) then {
	            _result = [format[localize 'STR_adm_aappsgodmode_give',name _this], localize 'STR_Admin_God', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
	            if(!_result) exitWith {};
				[4,_this, profileName, 0] remoteExecCall ['ton_fnc_rem_proxy',2];
	            _this setVariable['admin_godmode_status',true,true];
	            hint format[localize 'STR_adm_aappsgodmode_give_notf',name _this];
				[13,player,[profileName,getplayeruid player,format['%1 hat %2 Godmode aktiviert.',profileName,name _this],name _this,getplayeruid _this]] remoteExecCall ['ton_fnc_rem_proxy',2];
			} else {
	            _result = [format[localize 'STR_adm_aappsgodmode_remove',name _this], 'Godmode', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
	            if(!_result) exitWith {};
				[4,_this, profileName, 1] remoteExecCall ['ton_fnc_rem_proxy',2];
	            _this setVariable['admin_godmode_status',false,true];
	            hint format[localize 'STR_adm_aappsgodmode_remove_notf',name _this];
				[13,player,[profileName,getplayeruid player,format['%1 hat %2 Godmode deaktiviert.',profileName,name _this],name _this,getplayeruid _this]] remoteExecCall ['ton_fnc_rem_proxy',2];
			};
		};
    };
};
_admin_veh_godmode = {
	_veh = vehicle player;
	if(_veh isEqualTo player) exitWith {hint localize 'STR_adm_aappsin_vehicle_self'};
	if(local _veh) then {
		if(_veh getVariable ['admin_godmode_status',false]) then {
			_veh allowDamage true;
			_veh removeAllEventhandlers 'HandleDamage';
			_veh setVariable ['admin_godmode_status',false,true];
			hint localize 'STR_adm_godmode_off';
			[13,player,[profileName,getplayeruid player,format['%1 hat den Fahrzeug-Godmode deaktiviert.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
		} else {
			_veh setDamage 0;
			_veh allowDamage false;
			_veh removeAllEventhandlers 'HandleDamage';
			_veh addEventHandler['HandleDamage',{0}];
			_veh setVariable ['admin_godmode_status',true,true];
			hint localize 'STR_adm_godmode_on';
			[13,player,[profileName,getplayeruid player,format['%1 hat den Fahrzeug-Godmode aktiviert.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
		};
	} else {
		hint localize 'STR_adm_aapps_not_driver';
	};
};
_admin_invisibility = {
    if(!life_admin_visibility) then {
		life_admin_visibility = true;
        hint localize 'STR_adm_aappsinvisibility';
		[11,player,0,player] remoteExecCall ['ton_fnc_rem_proxy',2];
		[13,player,[profileName,getplayeruid player,format['%1 hat sich unsichtbar gemacht.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
		admin_visibility = player getVariable ['realname',''];
		player setVariable ['realname',nil,true];
   } else {
		life_admin_visibility = false;
        hint localize 'STR_adm_aappsvisibility';
		[11,player,1,player] remoteExecCall ['ton_fnc_rem_proxy',2];
		[13,player,[profileName,getplayeruid player,format['%1 hat sich wieder sichtbar gemacht.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
		if(!(isNil 'admin_visibility')) then {
			player setVariable ['realname',admin_visibility,true];
		};
		admin_visibility = nil;
   };
};
_admin_freecam = {
	closeDialog 0;
    [] call BIS_fnc_camera;
    titleText[localize 'STR_adm_aappsfreecam_exit','PLAIN'];
	[13,player,[profileName,getplayeruid player,format['%1 hat die Freecam aufgerufen.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
};
_admin_colorize = {
    _target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
    _target setObjectTextureGlobal [0,format['#(argb,8,8,3)color(%1,%2,%3,1)',str(random(1)),str(random(1)),str(random(1))]];
    if(_target isEqualTo player) then {
        hint localize 'STR_adm_aappsrandom_skin_self';
		[13,player,[profileName,getplayeruid player,format['%1 hat sich einen anderen Skin gegeben.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
    } else {
        hint format['Du hast %1 einen anderen Skin gegeben!',name _target];
        [1,format[localize 'STR_adm_aappsrandom_skin_other',profileName]] remoteExecCall ['life_fnc_broadcast',_target];
		[13,player,[profileName,getplayeruid player,format['%1 hat %2 einen anderen Skin gegeben.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
	};
};
_admin_getExtendedInfofnc = {
	_target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
	if(_target isEqualTo player) then {
		0 spawn {
			[parseText format[localize 'STR_adm_aapps_player_extended',profileName,getplayeruid player,profilenameSteam,playerSide,[life_cash] call life_fnc_numberText,[life_atmbank] call life_fnc_numberText], format['%1 - %2',localize 'STR_adm_fnc_extended',profileName]] call BIS_fnc_guiMessage;
		};
	} else {
		[5,_target] remoteExecCall ['ton_fnc_rem_proxy',2];
	};
};
_admin_freezeplayer = {
	_target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
	if(_target isEqualTo player) then {
		0 spawn {
			closeDialog 0;
			[13,player,[profileName,getplayeruid player,format['%1 hat sich gefreezed.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
			disableUserInput true;
			sleep 5;
			[13,player,[profileName,getplayeruid player,format['%1 hat sich entfreezed.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
			disableUserInput false;
			titleText[localize 'STR_adm_aappsfreeze_notf','PLAIN'];
		};
	} else {
		if(_target getVariable['freezed_status',false]) then {
			hint format[localize 'STR_adm_aappsunfreeze',name _target];
			[13,player,[profileName,getplayeruid player,format['%1 hat %2 entfreezed.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
		} else {
			hint format[localize 'STR_adm_aappsfreeze',name _target];
			[13,player,[profileName,getplayeruid player,format['%1 hat %2 gefreezed.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
		};
		[6,_target,profileName] remoteExecCall ['ton_fnc_rem_proxy',2];
	};
};
_admin_moveinvehicle = {
	_target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
	_vehicle = vehicle _target;
	if(_vehicle isEqualTo _target) exitwith {hint localize 'STR_adm_aappsin_vehicle_self'};
	if(player in (crew _vehicle)) exitWith {hint localize 'STR_adm_aappsalready_in_vehicle'};
	player moveInAny _vehicle;
	if(player in (crew _vehicle)) exitWith {
		hint format[localize 'STR_adm_aappsmoved_vehicle',name _target];
		[13,player,[profileName,getplayeruid player,format['%1 ist ins Fahrzeug von %2 eingestiegen.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
	};
	hint localize 'STR_NOTF_DeviceFull';
};
_admin_moveinmyvehicle = {
	_target = lbData[9999991,lbcurSel 9999991];
    _target = call compile _target;
    if((isNil '_target') OR {isNull _target} OR {_target isEqualTo player}) exitWith {hint localize 'STR_adm_aappsneeded_player'};
	if(isNull (objectParent player)) exitWith {hint localize 'STR_adm_aappsin_vehicle_self'};
	_vehicle = vehicle player;
	if(_target in (crew _vehicle)) exitWith {hint localize 'STR_adm_aappsalready_in_vehicle'};
	moveOut _target;
	_bool = _target moveInAny _vehicle;
	if(_bool) exitWith {
		hint format[localize 'STR_adm_aappstargetmoved_vehicle',name _target];
		[13,player,[profileName,getplayeruid player,format['%1 hat %2 in sein Fahrzeug teleportiert.',profileName,name _target],name _target,getplayeruid _target]] remoteExecCall ['ton_fnc_rem_proxy',2];
	};
	hint localize 'STR_NOTF_DeviceFull';
};
_refreshplayersvar = call ton_fnc_admin_randomGenVar;
_parseScriptsvar = call ton_fnc_admin_randomGenVar;
_loadsafeCodevar = call ton_fnc_admin_randomGenVar;
_executeDevelopScriptsvar = call ton_fnc_admin_randomGenVar;
_getscriptsvar = call ton_fnc_admin_randomGenVar;
_initDevelopTool = compile ("
	[13,player,[profileName,getplayeruid player,format['%1 hat das Debugmenü geöffnet.',profileName]]] remoteExecCall ['ton_fnc_rem_proxy',2];
	closeDialog 0;
	createDialog 'aapps_develop_dialog';
	showChat false;
	developtool_playerinfo = false;
	[] call ((UInamespace getVariable ['" + _objectvar + "',objNull]) getVariable ['" + _refreshplayersvar + "',{}]);
	ctrlSetText [3961506,profileNamespace getVariable ['allianceapps_console_input','hint ""Arma sucks""']];
	lbclear 3961507;
	{
		lbAdd[3961507,(_x select 0)];
		lbSetData[3961507,(lbsize 3961507)-1,(_x select 1)];
	} forEach (profileNamespace getVariable ['aapps_develop_code_x22',[]]);
	if((lbsize 3961507) isEqualTo 0) then {
		lbAdd [3961507,localize 'STR_adm_aappsno_entry_short'];
	};
	[diag_activeSQFScripts,profileName] call ((UInamespace getVariable ['" + _objectvar + "',objNull]) getVariable ['" + _parseScriptsvar + "',{}]);
	lbClear 3961524;
	{
		lbAdd[3961524,(_x select 1)];
		_index = (lbsize 3961524)-1;
		lbSetPicture[3961524,_index,(_x select 0)];
		lbSetData[3961524,_index,(_x select 2)];
	} forEach [
		['\a3\3den\data\displays\display3den\entitymenu\arsenal_ca.paa','VR - Arsenal','closeDialog 0; [''Open'',true] spawn BIS_fnc_arsenal'],
		['\a3\3den\data\displays\display3den\entitymenu\findconfig_ca.paa','Config Viewer','closeDialog 0; [ctrlparent (_this select 0)] spawn (uinamespace getvariable ''bis_fnc_configViewer'')'],
		['\a3\3den\data\displays\display3den\entitymenu\functions_ca.paa','Functions Viewer','[ctrlparent (_this select 0)] spawn (uinamespace getvariable ''bis_fnc_help'')'],
		['\a3\3den\data\cfg3den\group\iconcustomcomposition_ca.paa','Performance Test','[ctrlText 3961506] call BIS_fnc_codePerformance'],
		['\a3\3den\data\attributes\stance\up_ca.paa','Animation Viewer','closeDialog 0; [] call BIS_fnc_animViewer'],
		['\a3\3den\data\displays\display3den\entitymenu\movecamera_ca.paa','Camera Mode','closeDialog 0;[] call BIS_fnc_camera'],
		['\a3\3den\data\cfg3den\history\disconnectitems_ca.paa','Force Disconnect','closeDialog 0; endMission ''END1'''],
		['\a3\3den\data\cfgwrapperui\cursors\3denmoveindisabled_ca.paa','Explode CursorTarget','closeDialog 0; if(!isNull cursorObject) then {cursorObject setDamage 1} else {hint ''No Target found!''}']
	];
	(findDisplay 3961500) displayAddEventHandler ['UnLoad', '
		showChat true;
		profileNamespace setVariable [''allianceapps_value_viewer_1'',ctrlText 3961511];
		profileNamespace setVariable [''allianceapps_value_viewer_2'',ctrlText 3961513];
		profileNamespace setVariable [''allianceapps_value_viewer_3'',ctrlText 3961515];
		profileNamespace setVariable [''allianceapps_value_viewer_4'',ctrlText 3961517];
		profileNamespace setVariable [''allianceapps_console_input'',ctrlText 3961506];
		develop_viewer_ctrl = nil;
	'];
	develop_viewer_ctrl = 0;
	_b = 1;
	{
		((findDisplay 3961500) displayCtrl _x) ctrlSetEventHandler ['SetFocus', '
			_idc = ctrlIDC (_this select 0);
			develop_viewer_ctrl = _idc;
			ctrlSetText[_idc +1,localize ''STR_adm_waitingforinput''];
		'];
		((findDisplay 3961500) displayCtrl _x) ctrlSetEventHandler ['KillFocus', '
			if(develop_viewer_ctrl isEqualTo (ctrlIDC (_this select 0))) then {
				develop_viewer_ctrl = 0;
			};
		'];
		ctrlSetText[_x,profileNamespace getVariable [format['allianceapps_value_viewer_%1',_b],'']];
		_b = _b + 1;
	} forEach [3961511,3961513,3961515,3961517];
	((findDisplay 3961500) displayCtrl 3961504) ctrlSetEventHandler ['ButtonClick', '
		[ctrlText 3961502] call ((UInamespace getVariable [''" + _objectvar + "'',objNull]) getVariable [''" + _refreshplayersvar + "'',{}]);
	'];
	((findDisplay 3961500) displayCtrl 3961503) ctrlSetEventHandler ['ButtonClick', '
		if(developtool_playerinfo) then {
			developtool_playerinfo = false;
		} else {
			developtool_playerinfo = true;
		};
		[] call ((UInamespace getVariable [''" + _objectvar + "'',objNull]) getVariable [''" + _refreshplayersvar + "'',{}]);
	'];
	((findDisplay 3961500) displayCtrl 3961509) ctrlSetEventHandler ['ButtonClick', '
		[1] call ((UInamespace getVariable [''" + _objectvar + "'',objNull]) getVariable [''" + _loadsafeCodevar + "'',{}]);
	'];
	((findDisplay 3961500) displayCtrl 3961510) ctrlSetEventHandler ['ButtonClick', '
		[0] call ((UInamespace getVariable [''" + _objectvar + "'',objNull]) getVariable [''" + _loadsafeCodevar + "'',{}]);
	'];
	((findDisplay 3961500) displayCtrl 3961520) ctrlSetEventHandler ['ButtonClick', '
		[diag_activeSQFScripts,profileName] call ((UInamespace getVariable [''" + _objectvar + "'',objNull]) getVariable [''" + _parseScriptsvar + "'',{}]);
	'];
	_1 = 0;
	{
		((findDisplay 3961500) displayCtrl _x) ctrlSetEventHandler ['ButtonClick', '
			[' + str(_1) + ',ctrlText 3961506] call ((UInamespace getVariable [''" + _objectvar + "'',objNull]) getVariable [''" + _executeDevelopScriptsvar + "'',{}]);
		'];
		_1 = _1 + 1;
	} forEach [3961527,3961529,3961530,3961528,3961532];
	0 spawn {
		_callvalue = {
			ctrlSetText [_this, localize 'STR_adm_aappsdev_returned_val'];
			_var = tolower(ctrlText (_this-1));
			_found = false;
			{
				if((_var find _x) > -1) exitWith {
					_var = 'No Skillz Such WOW!';
					_found = true;
					[format['[AllianceApps] - No Skillz Much WOW: %1',_x]] call bis_fnc_error;
				};
			} forEach ['loadfile','preprocess','include'];
			if(!_found) then {
				_var = call compile _var;
				_var = if(isNil '_var') then {localize 'STR_adm_aappsdev_returned_val'} else {_var};
			};
			ctrlSetText [_this, format['%1',_var]];
		};
		while{dialog} do {
			{
				if(!(develop_viewer_ctrl isEqualTo (_x -1))) then {
					_x spawn _callvalue;
				};
			} forEach [3961512,3961514,3961516,3961518];
			sleep 0.5;
		};
	};
	0 spawn {
		while{dialog} do {
			((findDisplay 3961500) displayCtrl 3961500) ctrlSetText str (round diag_fps);
			sleep 1;
		};
	};
	((findDisplay 3961500) displayCtrl 3961521) ctrlSetEventHandler ['ButtonClick', '
		[] spawn ((UInamespace getVariable [''" + _objectvar + "'',objNull]) getVariable [''" + _getscriptsvar + "'',{}]);
	'];
");
_loadsafeCode = {
	_this spawn {
		_lorem = [_this, 0, -1] call bis_fnc_param;
		if(_lorem isEqualTo -1) exitWith {};
		_consoletext = ctrlText 3961506;
		if(_lorem isEqualTo 0) then {
			if((lbCurSel 3961507) isEqualTo -1) exitWith {};
			_script = lbData [3961507, lbcurSel 3961507];
			_result = false;
			if(!(_consoletext isEqualTo 'hint "Arma sucks";') && {!(_consoletext isEqualTo '')}) then {
				_result = [localize 'STR_adm_aappsdev_over_code', localize 'STR_adm_aappsdev_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
			} else {
				_result = true;
			};
			if(_result) then {
				ctrlSetText[3961506,_script];
			};
		} else {
			_name = ctrlText 3961508;
			if((_name isEqualTo '') OR (_name isEqualTo 'Name...')) exitWith {};
			_array = profileNamespace getVariable ['aapps_develop_code_x22',[]];
			_alreadyHERE = false;
			_index = 0;
			{
				if((_x select 0) isEqualTo _name) exitWith {_alreadyHERE = true};
				_index = _index + 1;
			} forEach _array;
			if(_alreadyHERE) then {
				_result = [localize 'STR_adm_aappsdev_already_present', localize 'STR_adm_aappsdev_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
				if(!_result) exitWith {};
				_array set [_index,_consoletext];
				profileNamespace setVariable ['aapps_develop_code_x22',_array];
			} else {
				if(((lbSize 3961507) isEqualTo 1) && {lbData[3961507,0] isEqualTo ''}) then {
					lbClear 3961507;
				};
				lbAdd[3961507,_name];
				lbSetData[3961507,(lbsize 3961507) -1,_consoletext];
				_array pushBack [_name, _consoletext];
				profileNamespace setVariable ['aapps_develop_code_x22',_array];
			};
		};
	};
};
_refreshPlayers = {
	_text = [_this, 0, ''] call bis_fnc_param;
	_text = tolower _text;
	tvClear 3961501;
	tvAdd [3961501, [], localize 'STR_adm_aappsside_wests'];
	tvSetPicture [3961501, [0], '\a3\3den\data\displays\display3den\panelright\side_west_ca.paa'];
	tvAdd [3961501, [], localize 'STR_adm_aappsside_meds'];
	tvSetPicture [3961501, [1], '\a3\3den\data\displays\display3den\panelright\side_guer_ca.paa'];
	tvAdd [3961501, [], localize 'STR_adm_aappsside_civs'];
	tvSetPicture [3961501, [2], '\a3\3den\data\displays\display3den\panelright\side_civ_ca.paa'];
	tvAdd [3961501, [], localize 'STR_adm_aappsside_east'];
	tvSetPicture [3961501, [3], '\a3\3den\data\displays\display3den\panelright\side_east_ca.paa'];
	tvAdd [3961501, [], localize 'STR_adm_aappsside_group'];
	tvSetPicture [3961501, [4], '\a3\3den\data\displays\display3den\panelright\modegroups_ca.paa'];
	{
		_name = name _x;
		if((tolower(_name) find _text) > -1) then {
			_index = '';
			_1 = 0;
			_2 = 0;
			switch(_x getVariable ["playerSide",sideUnknown]) do {
				case WEST: {
					tvAdd [3961501, [0], _name];
					_1 = 0;
					_2 = (tvCount [3961501, [0]])-1;
					_index = [0,_2];
				};
				case INDEPENDENT: {
					tvAdd [3961501, [1], _name];
					_1 = 1;
					_2 = (tvCount [3961501, [1]])-1;
					_index = [1,_2];
				};
				case CIVILIAN: {
					tvAdd [3961501, [2], _name];
					_1 = 2;
					_2 = (tvCount [3961501, [2]])-1;
					_index = [2,_2];
				};
				case EAST: {
					tvAdd [3961501, [3], _name];
					_1 = 3;
					_2 = (tvCount [3961501, [3]])-1;
					_index = [3,_2];
				};
			};
			if(!(_index isEqualTo '')) then {
				tvSetData [3961501, _index,str(_x)];
				tvSetValue [3961501, _index,2];
				if(developtool_playerinfo) then {
					tvAdd [3961501, _index,format['UID: %1', getplayeruid _x]];
					tvSetPicture [3961501, [_1,_2,0], '\a3\3den\data\controls\ctrlshortcutbutton\steam_ca.paa'];
					tvAdd [3961501, _index,format['Pos: %1', (getpos _x) call BIS_fnc_PosToGrid]];
					tvSetPicture [3961501, [_1,_2,1], '\a3\3den\data\displays\display3den\toolbar\map_off_ca.paa'];
					tvAdd [3961501, _index,format['HP: %1%2', floor ((1-(damage _x))*100),'%']];
					tvSetPicture [3961501, [_1,_2,2], '\a3\3den\data\cfgwaypoints\support_ca.paa'];
				};
				if(!(alive _x)) then {
					((findDisplay 3961500) displayCtrl 3961501) tvSetColor [_index, [1,0,0,1]];
				};
			};
		};
	} forEach (allPlayers - (entities "HeadlessClient_F"));
	{
		_name = _x getVariable ['gang_name','-1'];
		if(!(_name isEqualTo '-1')) then {
			if((tolower(_name) find _text) > -1) then {
				if(developtool_playerinfo) then {
					tvAdd [3961501, [4],_name];
					_1 = 4;
					_2 = (tvCount [3961501, [4]])-1;
					_index = [4,_2];
					tvSetValue [3961501, _index, 1];
					_var = (_x getVariable ['gang_id',-1]);
					tvSetData [3961501, _index, str(_var)];
					tvAdd [3961501, _index,format['DB-ID: %1', _var]];
					tvSetPicture [3961501, [_1,_2,0],'\a3\3den\data\displays\display3den\toolbar\save_ca.paa'];
					tvAdd [3961501, _index,format[localize 'STR_adm_aappsowner', (_x getVariable 'gang_owner')]];
					tvSetPicture [3961501, [_1,_2,1],'\a3\3den\data\displays\display3den\panelright\modeobjects_ca.paa'];
					tvAdd [3961501, _index,format['Gang-Bank: %1€', (_x getVariable 'gang_bank')]];
					tvSetPicture [3961501, [_1,_2,2],'\a3\3den\data\cfg3den\group\iconcustomcomposition_ca.paa'];
					tvAdd [3961501, _index,format[localize 'STR_adm_aappsmembers', count (_x getVariable 'gang_members'), (_x getVariable 'gang_maxMembers')]];
					tvSetPicture [3961501, [_1,_2,3],'\a3\3den\data\displays\display3den\panelright\modegroups_ca.paa'];
				} else {
					tvAdd [3961501, [4],format['%1 (%2)',_name,(_x getVariable ['gang_id',-1])]];
					_index = [4,(tvCount [3961501, [4]])-1];
					tvSetValue [3961501, _index, 1];
					tvSetData [3961501, _index, str(_x getVariable ['gang_id',-1])];
				};
			};
		};
	} forEach allGroups;
	((findDisplay 3961500) displayCtrl 3961531) ctrlSetStructuredText parseText format[localize 'STR_adm_aappsdev_description',west countSide (allplayers - (entities "HeadlessClient_F")),independent countSide (allplayers - (entities "HeadlessClient_F")),civilian countSide (allplayers - (entities "HeadlessClient_F")),east countSide (allplayers - (entities "HeadlessClient_F"))];
};
_executeDevelopScripts = {
	_this spawn {
		_type = [_this, 0, -1] call bis_fnc_param;
		_text = [_this, 1, ''] call bis_fnc_param;
		if((_type isEqualTo -1) OR {_text isEqualTo ''}) exitWith {hint format['NOT DEFINED %1',_this]};
		_text = format['0 spawn {%1}',_text];
		_loweredtext = tolower(_text);
		_found = false;
		{
			if((_loweredtext find _x) >-1) exitWith {
				_found = true;
				hint format['[AllianceApps] - No Skillz Much WOW: %1',_x];
			};
		} forEach ['loadfile','preprocess','include'];
		if(_found) exitWith {};
		switch(_type) do {
			case 0: {
				call compile _text;
				hint localize 'STR_adm_aappsdev_ran_player';
			};
			case 1: {
				_result = [localize 'STR_adm_aappsdev_ran_server_text', localize 'STR_adm_aappsdev_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
				if(!_result) exitWith {};
				[8,objNull,'Server',_text] remoteExecCall ['ton_fnc_rem_proxy',2];
				hint localize 'STR_adm_aappsdev_ran_server';
			};
			case 2: {
				_target = (tvCurSel 3961501);
				if(_target isEqualTo []) exitWith {hint localize 'STR_adm_aappsneeded_player'};
				if(!(tvValue[3961501,_target] isEqualTo 2)) exitWith {hint localize 'STR_adm_aappsneeded_player'};
				_name = tvText [3961501,_target];
				_target = tvData [3961501,_target];
				if((call compile(_target)) isEqualTo player) exitWith {
					call compile _text;
				};
				_result = [format[localize 'STR_adm_aappsdev_ran_target_text',_name], localize 'STR_adm_aappsdev_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
				if(!_result) exitWith {};
				[8,call compile _target,'Unit',_text] remoteExecCall ['ton_fnc_rem_proxy',2];
				hint format[localize 'STR_adm_aappsdev_ran_target',_name];
			};
			case 3: {
				_result = [localize 'STR_adm_aappsdev_ran_everyone_text', localize 'STR_adm_aappsdev_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
				if(!_result) exitWith {};
				[8,objNull,'Everyone',_text] remoteExecCall ['ton_fnc_rem_proxy',0];
				hint localize 'STR_adm_aappsdev_ran_everyone';
			};
			case 4: {
				_target = (tvCurSel 3961501);
				if(_target isEqualTo []) exitWith {hint localize 'STR_adm_aappsneeded_group'};
				if(!(tvValue[3961501,_target] isEqualTo 1)) exitWith {hint localize 'STR_adm_aappsneeded_group'};
				_name = tvText [3961501,_target];
				_target = tvData [3961501,_target];
				_result = [format[localize 'STR_adm_aappsdev_ran_group_text',_name], localize 'STR_adm_aappsdev_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
				if(!_result) exitWith {};
				[8,_target,'Group',_text] remoteExecCall ['ton_fnc_rem_proxy',2];
				hint format[localize 'STR_adm_aappsdev_ran_group',_name];
			};
		};
	};
};
_getScriptsViewerfnc = compile ("
	_target = tvCurSel 3961501;
	if(_target isEqualTo []) exitWith {hint localize 'STR_adm_aappsneeded_player'};
	if(!(tvValue[3961501,_target] isEqualTo 2)) exitWith {hint localize 'STR_adm_aappsneeded_player'};
	_target = tvData[3961501,_target];
	_target = call compile _target;
	if(_target isEqualTo player) exitWith {
		[diag_activeSQFScripts,profileName] call ((UInamespace getVariable ['" + _objectvar + "',objNull]) getVariable ['" + _parseScriptsvar + "',{}]);
	};
	admin_get_scripts = nil;
	[7,_target] remoteExecCall ['ton_fnc_rem_proxy',2];
	waitUntil {!isNil 'admin_get_scripts'};
	if(!((count admin_get_scripts) isEqualTo 2)) exitWith {};
	admin_get_scripts call ((UInamespace getVariable ['" + _objectvar + "',objNull]) getVariable ['" + _parseScriptsvar + "',{}]);
	admin_get_scripts = nil;
");
_parseScriptsViewer = {
	if(isNull (findDisplay 3961500)) exitWith {};
	_scriptsArray = [_this, 0, []] call bis_fnc_param;
	_name = [_this, 1,'Anonym'] call bis_fnc_param;
	tvclear 3961523;
	((findDisplay 3961500) displayCtrl 3961522) ctrlSetText format[localize 'STR_adm_aappsdev_selected',_name];
	{
		tvAdd[3961523, [], (_x select 0)];
		_index = [tvCount [3961523, []]-1];
		if((_x select 1) isEqualTo '') then {_x set [1,'<SPAWN>']};
		tvAdd[3961523, _index, (_x select 1)];
		tvAdd[3961523, _index, format['Status: %1',if(_x select 2) then {localize 'STR_adm_aappsdev_viewer_running'} else {localize 'STR_adm_aappsdev_viewer_done'}]];
		tvAdd[3961523, _index, format[localize 'STR_adm_aappsdev_viewer_line',(_x select 3)]];
	} forEach _scriptsArray;
	((findDisplay 3961500) displayCtrl 3961519) ctrlSetStructuredText parseText format[localize 'STR_adm_aappsdev_viewer_count',count _scriptsArray];
};

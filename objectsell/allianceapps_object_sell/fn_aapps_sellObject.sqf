/*
 *
 *	@File:		fn_aapps_sellObject.sqf
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
scriptName "fn_aapps_sellObject";
life_fnc_initSellObject = compileFinal "
	_object = [_this, 0, objNull] call bis_fnc_param;
	if(isNull _object) exitWith {hint 'Object_sell: No Object given'};
	if(!(alive _object)) exitWith {hint 'Object_sell: Object is not alive'};
	if(!(playerSide isEqualTo CIVILIAN)) exitWith {hint localize 'Das kannst du nur als Zivilist!'};
	if((player getVariable ['Escorting',false]) OR {player getVariable ['restrained',false]}) exitWith {hint localize 'STR_trade_not_working'};
	life_sell_object = nil;
	if(_object isKindOf 'House_F') then {
		life_sell_object = [_object,typeOf _object, 'HOUSE', (_object getVariable ['house_owner',['-1','']]) select 0];
	};
	if((isNil 'life_sell_object') && ((cursorTarget isKindOf 'LandVehicle') OR (cursorTarget isKindOf 'Air') OR (cursorTarget isKindOf 'Ship'))) then {
		_var = (_object getVariable ['dbInfo',['-1',-1]]) select 0;
		life_sell_object = [_object, typeof _object, 'VEHICLE', _var];
	};
	if(isNil 'life_sell_object') exitWith {hint localize 'STR_trade_wrong_object'};
	if(!((life_sell_object select 3) isEqualTo (getPlayeruid player))) exitWith {hint localize 'STR_trade_not_yours'};
	_players = player nearObjects ['Man', 15];
	{
		if((!((side _x) isEqualTo CIVILIAN)) OR (_x isEqualTo player) OR !(alive _x) OR ((getplayeruid _x) isEqualTo '')) then {
			_players = _players - [_x];
		};
	} forEach _players;
	if((count _players) isEqualTo 0) exitWith {hint localize 'STR_trade_no_players'};
	createDialog 'aapps_sell_object';
	disableSerialization;
	_combo = (findDisplay 198802) displayCtrl 1988020;
	{
		_combo lbAdd (name _x);
		_combo lbSetData[(lbSize _combo) -1, (str _x)];
	} forEach _players;
	if((lbsize _combo) isEqualTo 0) exitWith {
		closeDialog 0;
		hint 'Bug-prevention';
	};
";
life_fnc_makeSellRequest = compileFinal "
	if(isNil 'life_sell_object') exitWith {};
	if(!(alive (life_sell_object select 0))) exitWith {hint 'Object_sell: Object is not alive'};
	if(!dialog) exitWith {hint localize 'STR_trade_no_data'};
	_price = abs (parseNumber (ctrlText 1988021));
	if(_price isEqualTo 0) exitWith {hint localize 'STR_trade_too_low'};
	if((lbcursel 1988020) isEqualTo -1) exitWith {hint localize 'STR_trade_not_selected'};
	_bool = false;
	_objectname = getText(configfile >> 'CfgVehicles' >> (typeOf cursorTarget) >> 'displayName');
	_bool = [format [localize 'STR_trade_question_1',_objectname,(lbText[1988020,lbcursel 1988020]),[_price] call life_fnc_numberText], localize 'STR_trade_question_1_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
	if(!_bool) exitWith {};
	life_sell_object pushBack _price;
	life_sell_object pushBack player;
	life_sell_object remoteExec ['life_fnc_acceptSellRequest',call compile (lbData[1988020,lbcursel 1988020])];
	closeDialog 0;
	hint localize 'STR_trade_request';
";
life_fnc_acceptSellRequest = compileFinal "
	_object = [_this, 0, objNull] call bis_fnc_param;
	_uid = [_this, 3, -1] call bis_fnc_param;
	_price = [_this, 4, -1] call bis_fnc_param;
	_player = [_this, 5, objNull] call bis_fnc_param;
	_type = [_this, 2, ''] call bis_fnc_param;
	if((isNull _object) OR {_price isEqualTo -1} OR {isNull _player} OR {_type isEqualTo ''} OR {_uid isEqualTo -1}) exitWith {};
	_objectname = getText(configfile >> 'CfgVehicles' >> (typeOf _object) >> 'displayName');
	_bool = [format [localize 'STR_trade_question_2',name _player,_objectname,[_price] call life_fnc_numberText], localize 'STR_trade_question_1_title', localize 'STR_Global_Yes', localize 'STR_Global_No'] call BIS_fnc_guiMessage;
	if(_type isEqualTo 'HOUSE') then {
		_number = getNumber(missionConfigFile >> 'Life_Settings' >> 'house_limit');
		if ((count life_houses) >= _number) then {hint format [localize 'STR_House_Max_House',_number];_bool = false};
	};
	if(!_bool) exitWith {titleText[localize 'STR_trade_question_2_cancel','PLAIN']};
	if(life_cash < _price) exitwith {hint localize 'STR_NOTF_NotEnoughMoney'};
	life_cash = life_cash - _price;
	[0] call SOCK_fnc_updatePartial;
	[_object,getplayerUid player] remoteExec ['life_fnc_sellobject_keys',-2];
	[_object] call life_fnc_addVehicle2Chain;
	if(_type isEqualTo 'HOUSE') then {
		_object setVariable ['house_owner',[getPlayerUid player,profilename],true];
		_object setVariable ['uid2',floor(random 99999),true];
		_marker = createMarkerLocal [format ['house_%1',(_object getVariable 'uid2')],getPosATL _object];
		_houseName = getText(configFile >> 'CfgVehicles' >> (typeOf _object) >> 'displayName');
		_marker setMarkerTextLocal _houseName;
		_marker setMarkerColorLocal 'ColorBlue';
		_marker setMarkerTypeLocal 'loc_Lighthouse';
		life_houses pushBack [str(getPosATL _object),[]];
		_id = _object getVariable 'house_id';
		[0,getplayeruid player,side player,_uid,side _player,_id,_object] remoteExec ['ton_fnc_aapps_changeObjectOwner',2];
		hint format[localize 'STR_trade_keys_received',name _player,_objectname];
	} else {
		_owners = [[getplayeruid player, profileName]];
		_object setVariable ['vehicle_info_owners',_owners,true];
		_dbinfo = _object getVariable 'dbinfo';
		_dbinfo set [0, getPlayerUid player];
		_object setVariable ['dbinfo',_dbinfo,true];
		[1,getplayeruid player,side player,_uid,side _player,_dbinfo select 1,_object] remoteExec ['ton_fnc_aapps_changeObjectOwner',2];
		hint format[localize 'STR_trade_vehicle_keys_received',name _player,_objectname];
	};
	[name player,_price,_object,_type] remoteExec ['life_fnc_doneObjectSell',_player];
";
life_fnc_sellobject_keys = compileFinal "
	_object = [_this, 0, objNull] call bis_fnc_param;
	_uid = [_this, 1, '-1'] call bis_fnc_param;
	if(isNull _object) exitWith {};
	if(_uid isEqualTo (getplayeruid player)) exitWith {};
	life_vehicles = life_vehicles - [_object];
";
life_fnc_doneObjectSell = compileFinal "
	_name = [_this, 0, localize 'STR_trade_ano'] call bis_fnc_param;
	_price = [_this ,1, -1] call bis_fnc_param;
	_object = [_this, 2, objNull] call bis_fnc_param;
	_type = [_this, 3, ''] call bis_fnc_param;
	if(_type isEqualTo 'HOUSE') then {
		deleteMarkerLocal format ['house_%1',_object getVariable 'uid'];
		_object setVariable ['uid',_object getVariable 'uid2',true];
		_object setVariable ['uid2',nil,true];
		_index = [str(getPosATL _object),life_houses] call TON_fnc_index;
		if !(_index isEqualTo -1) then {
			life_houses deleteAt _index;
		};
	};
	if((_price isEqualTo -1) OR {isNull _object}) exitWith {};
	life_cash = life_cash + _price;
	[0] call SOCK_fnc_updatePartial;
	hint format[localize 'STR_trade_accepted',_name,[_price] call life_fnc_numberText];
";
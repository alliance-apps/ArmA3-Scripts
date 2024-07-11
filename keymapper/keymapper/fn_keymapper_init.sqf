scriptName "fn_keymapper_init";
/*
 *
 *	@File:		fn_keymapper_init.sqf
 *	@Author: 	AllianceApps
 *	@Date:		14.02.2018
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *  
*/
createDialog 'aapps_keymapper_SA';
ctrlSetFocus ((findDisplay 12341234) displayCtrl 12341237);
keymapper_key_change = false;
keymapper_fade = false;
keymapper_temp_keys =+ keymapper_saved_keys;
ctrlShow[12341238,false];
ctrlShow[12341242,false];
ctrlShow[12341243,false];
if((call life_adminlevel) isEqualTo 0) then {
	ctrlShow[12341244,false];
} else {
	((findDisplay 12341234) displayCtrl 12341244) ctrlSetEventHandler ['ButtonClick', '
		ctrlShow[12341242,true];
		ctrlShow[12341243,true];
		_text = str keymapper_temp_keys;
		_arr = _text splitString "";
		for "_i" from 0 to ((count _arr) -1) do {
			if((_arr select _i) isEqualto "[") then {
				_arr set[_i,"{"];
			} else {
				if((_arr select _i) isEqualTo "]") then {
					_arr set[_i,"}"];
				};
			};
		};
		_text = _arr joinString "";
		ctrlSetText[12341243,_text];
		hint localize "STR_aapps_key_export";
	'];
};
((findDisplay 12341234) displayCtrl 12341238) ctrlsetStructuredText parseText (localize 'STR_aapps_key_change');
((findDisplay 12341234) displayCtrl 12341239) ctrlSetEventHandler ['ButtonClick', '
	0 spawn {
		_result = false;
		if(!(keymapper_temp_keys isEqualTo keymapper_saved_keys)) then {
			_result = [localize ''STR_aapps_key_unsaved_text'', ''Keymapper'', localize ''STR_Global_Yes'', localize ''STR_Global_No''] call BIS_fnc_guiMessage;
		};
		if(_result) then {
			keymapper_saved_keys = keymapper_temp_keys;
			profileNamespace setVariable [''aapps_keymapper_keys'',keymapper_saved_keys];
		};
	};
'];
((findDisplay 12341234) displayCtrl 12341240) ctrlSetEventHandler ['ButtonClick', '
	0 spawn {
		_result = [localize ''STR_aapps_key_reset_text'', ''Keymapper'', localize ''STR_Global_Yes'', localize ''STR_Global_No''] call BIS_fnc_guiMessage;
		if(_result) then {
			_arr = getArray(missionConfigFile >> "aapps_keymapper_config" >> "key_preset");
			keymapper_saved_keys = _arr;
			keymapper_temp_keys = _arr;
			profileNamespace setVariable [''aapps_keymapper_keys'',_arr];
			[ctrlText 12341234] call life_fnc_keymapper_build;
			hint localize ''STR_aapps_key_reset_success'';
		};
	};
'];
((findDisplay 12341234) displayCtrl 12341241) ctrlSetEventHandler ['ButtonClick', '
	keymapper_saved_keys = keymapper_temp_keys;
	profileNamespace setVariable [''aapps_keymapper_keys'',keymapper_saved_keys];
	hint localize ''STR_aapps_key_saved'';
'];
((findDisplay 12341234) displayCtrl 12341237) ctrlAddEventHandler ['LBDblClick', '
	_row = _this select 1;
	if((_row isEqualTo -1) OR keymapper_key_change) exitWith {};
	if(lnbValue[12341237,[_row,0]] isEqualTo -1) exitWith {};
	keymapper_fade = true;
	keymapper_key_change = true;
	keymapper_change_lb = [_row,lnbText[12341237,[_row,2]]];
	lnbSetText[12341237,[_row,2],localize ''STR_aapps_key_changing''];
	0 spawn {
		((findDisplay 12341234) displayCtrl 12341236) ctrlSetFade 1;
		((findDisplay 12341234) displayCtrl 12341236) ctrlCommit 0.2;
		((findDisplay 12341234) displayCtrl 12341237) ctrlSetFade 1;
		((findDisplay 12341234) displayCtrl 12341237) ctrlCommit 0.2;
		sleep 0.2;
		ctrlShow[12341238,true];
		keymapper_fade = false;
	};
'];
(findDisplay 12341234) displayAddEventHandler ['KeyDown', '
	if(!keymapper_key_change OR keymapper_fade) exitWith {};
	_key = _this select 1;
	if(_key in [42,54,56,184,29,157,220,219]) exitWith {};
	ctrlShow[12341238,false];
	((findDisplay 12341234) displayCtrl 12341236) ctrlSetFade 0;
	((findDisplay 12341234) displayCtrl 12341236) ctrlCommit 0.2;
	((findDisplay 12341234) displayCtrl 12341237) ctrlSetFade 0;
	((findDisplay 12341234) displayCtrl 12341237) ctrlCommit 0.2;
	_row = keymapper_change_lb select 0;
	if(_key isEqualTo 1) then {
		_arr = call compile (lnbData[12341237,[_row,2]]);
		if(!(_arr isEqualTo [])) then {
			keymapper_temp_keys = keymapper_temp_keys - [_arr];
		};
		lnbSetText[12341237,[_row,2], localize ''STR_aapps_key_notdefined''];
		lnbSetData[12341237,[_row,2],str []];
		keymapper_key_change = false;
		keymapper_change_lb = nil;
	} else {
		_sca = [parseNumber (_this select 2), parseNumber (_this select 3), parseNumber (_this select 4)];
		_arr = call compile (lnbData[12341237,[_row,2]]);
		_data = lnbValue[12341237,[_row,1]];
		_abort = false;
		{
			if(((_x select 1) isEqualTo _key) && {(_x select 2) isEqualTo _sca}) then {
				if(!((_x select 0) isEqualTo _data)) exitWith {
					hint localize "STR_aapps_key_inuse";
					playSound "Alarm";
					keymapper_key_change = false;
					lnbSetText[12341237,[_row,2],keymapper_change_lb select 1];
					_abort = true;
				};
			};
		} forEach keymapper_temp_keys;
		keymapper_change_lb = nil;
		if(_abort) exitWith {true};
		if(_arr isEqualTo []) then {
			_arr set[0,_data];
		} else {
			keymapper_temp_keys = keymapper_temp_keys - [_arr];
		};
		_arr set[1,_key];
		_arr set[2,_sca];
		keymapper_temp_keys pushBack _arr;
		lnbSetData[12341237,[_row,2],str _arr];
		_keytext = '''';
		if((_sca select 0) isEqualTo 1) then {
			_keytext = ''Shift + '';
		};
		if((_sca select 1) isEqualTo 1) then {
			_keytext = _keytext + (localize ''STR_aapps_key_ctrl'');
		};
		if((_sca select 2) isEqualTo 1) then {
			_keytext = _keytext + ''Alt + '';
		};
		_keytext = _keytext + (call compile (keyname _key));
		lnbSetText[12341237,[_row,2],_keytext];
		lnbSetCurSelRow[12341237,_row];
		keymapper_key_change = false;
	};
	true;	
'];
0 spawn {
	_text = '';
	for '_i' from 0 to 1 step 0 do {
		[_text] call life_fnc_keymapper_build;
		waitUntil{sleep 0.1;!((ctrlText 12341234) isEqualTo _text) OR (isNull (findDisplay 12341234))};
		if(isNull (findDisplay 12341234)) exitWith {};
		_text = ctrlText 12341234;
	};
};
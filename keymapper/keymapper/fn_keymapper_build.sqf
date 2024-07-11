scriptName "fn_keymapper_build";
/*
 *
 *	@File:		fn_keymapper_build.sqf
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
_text = toLower([_this, 0, ''] call bis_fnc_param);
lnbclear 12341237;
_val = 0;
_check = {
	!(_this isEqualto '') && (((tolower _this) find _text) > -1)
};
_findkeys = {
	{
		if(_class isEqualTo (_x select 0)) exitWith {_arr = _x};
	} forEach keymapper_temp_keys;
	if(!(_arr isEqualTo [])) then {
		_key = _arr select 1;
		_sca = _arr select 2;
		if((_sca select 0) isEqualTo 1) then {
			_keytext = 'Shift + ';
		};
		if((_sca select 1) isEqualTo 1) then {
			_keytext = _keytext + (localize 'STR_aapps_key_ctrl');
		};
		if((_sca select 2) isEqualTo 1) then {
			_keytext = _keytext + 'Alt + ';
		};
		_keytext = _keytext + (call compile (keyname _key));
	} else {
		_keytext = localize 'STR_aapps_key_notdefined';
	};
};
{
	_condition = getText(_x >> "condition");
	if((_condition isEqualTo "") OR {call compile _condition}) then { //CONDITION CHECK
		_sectionname = getText(_x >> "displayname");
		lnbAddRow[12341237,[_sectionname,'','']];
		lnbSetValue[12341237,[_val,0],-1];
		lnbSetColor [12341237, [_val,0], [0.129,0.451,1,1]];
		_val = _val + 1;
		_secnr = 0;
		{
			_name = _x select 1;
			if(((_x select 2) isEqualTo '') OR {call compile (_x select 2)}) then { //CONDITION CHECK
				if(_name call _check) then {
					_class = _x select 0;
					_arr = [];
					_keytext = '';
					call _findkeys;
					lnbAddRow[12341237,['',_name,_keytext]];
					lnbSetValue[12341237,[_val,1],_class];
					lnbSetData[12341237,[_val,2],str _arr];
					_val = _val + 1;
					_secnr = _secnr + 1;
				};
			};
		} forEach getArray(_x >> "keys");
		if(_secnr isEqualTo 0) then {
			_val = _val - 1;
			((findDisplay 12341234) displayCtrl 12341237) lnbDeleteRow _val;
		};
	};
} forEach ("true" configClasses (missionConfigFile >> "aapps_keymapper_config" >> "sections"));
if(_val isEqualTo 0) then {
	lnbAddRow[12341237, [localize 'STR_aapps_key_no_entry','','']];
	lnbSetColor [12341237, [0,0], [0.875,0.004,0.004,1]];
	lnbSetValue[12341237,[0,0],-1];
};
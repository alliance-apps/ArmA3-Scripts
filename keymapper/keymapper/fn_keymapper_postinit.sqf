scriptName "fn_keymapper_postinit";
/*
 *
 *	@File:		fn_keymapper_postinit.sqf
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
waitUntil {!isNull (findDisplay 46)};
_arr = getArray(missionConfigFile >> "aapps_keymapper_config" >> "key_preset");
if(_arr isEqualTo []) then {
	(findDisplay 46) displayAddEventHandler ['KeyDown', {
		_return = false;
		if((_this select 1) isEqualTo 37) then {
			if(isNull (findDisplay 12341234)) then {
				0 spawn life_fnc_keymapper_init;
				_return = true;
			};
		};
		_return
	}];
	hint localize "STR_aapps_key_hook";
	keymapper_saved_keys = [];
} else {
	keymapper_saved_keys = profileNamespace getVariable ['aapps_keymapper_keys',_arr];
};
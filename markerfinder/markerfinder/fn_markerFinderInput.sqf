 /*
 *
 *	@File:		fn_markerFinderInput.sqf
 *	@Author: 	AllianceApps
 *	@Date:		21.08.2019
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *
 */
disableSerialization;
_listbox = (findDisplay 12) displayCtrl 615124; //can't use IDC on arma displays, fetch control
profilenamespace setVariable ["aapps_oldmarker",_this];
lbclear _listbox;
if(_this isEqualTo "") exitWith {
	_listbox lbadd (localize "STR_noMarkerFoundFinder");
};
_lbcount = 0;
_addentry = {
	_listbox lbAdd (if(getNumber(missionConfigFile >> "aapps_markerFinder_config" >> "addDistance") isEquaLTo 1) then {format["%1 (%2m)",_markertext, (player distance2d (getMarkerPos _x)) call life_fnc_numberText]} else {_markertext});
	_listbox lbSetData [_lbcount,_x];
	_lbcount = _lbcount + 1;
};
_this = toLower _this;
_bool = getNumber(missionConfigFile >> "aapps_markerFinder_config" >> "showUserCreated") isEqualTo 1;
{
	if(_bool || !((_x select [0,15]) isEqualTo "_USER_DEFINED #")) then {
		if((markerAlpha _x) > 0) then {
			_markertext = markerText _x;
			if(!((_markertext isEqualTo ""))) then {
				if(isLocalized _markertext) then {
					_markertext = localize _markertext;
				};
				if(!((toLower(_markertext) find _this) isEqualto -1)) then {
					call _addentry;
				};
			};
		};
	};
} forEach allMapMarkers;
lbsort _listbox;
if(_lbcount isEqualTo 0) then {
	lbclear _listbox;
	_listbox lbadd (localize "STR_noMarkerFoundFinder");
};
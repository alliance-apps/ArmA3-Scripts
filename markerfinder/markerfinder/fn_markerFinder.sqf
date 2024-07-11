 /*
 *
 *	@File:		fn_markerFinder.sqf
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
if(!visibleMap) exitWith {};
if(!(("ItemMap" in (assignedItems player)) || {"ItemGPS" in (assignedItems player)})) exitWith {hint (localize "STR_noMapMarkerFinder")};
disableSerialization;
_display = findDisplay 12;
_button = _display displayCtrl 615120;
_button ctrlSetText (localize "STR_closeMarkerFinder"); 
_button buttonSetAction "call life_fnc_closeMarkerFinder";
_editbox = _display displayCtrl 615123;
{
	_x ctrlSetFade 0;
	_x ctrlCommit 0.3;
} forEach [_editbox,_display displayCtrl 615121,_display displayCtrl 615122,_display displayCtrl 615124];

_lasttext = "";
if(getNumber(missionConfigFile >> "aapps_markerFinder_config" >> "closeMarkerFinder") isEquaLTo 1) then {
	for '_i' from 0 to 1 step 0 do {
		waitUntil{sleep 0.1; (!((ctrlText _editbox) isEqualTo _lasttext)) || !visibleMap};
		if(!visibleMap) exitWith {};
		_lasttext = ctrlText _editbox;
		_lasttext call life_fnc_markerFinderInput;
	};
	0 call life_fnc_closeMarkerFinder;
} else {
	for '_i' from 0 to 1 step 0 do {
		waitUntil{sleep 0.1; (!((ctrlText _editbox) isEqualTo _lasttext) || isNull _editbox)};
		if(isNull _editbox) exitWith {};
		_lasttext = ctrlText _editbox;
		_lasttext call life_fnc_markerFinderInput;
	};
};
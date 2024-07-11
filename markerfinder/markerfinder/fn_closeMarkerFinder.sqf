 /*
 *
 *	@File:		fn_closeMarkerFinder.sqf
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
_display = findDisplay 12;
_button = _display displayCtrl 615120;
_button ctrlSetText (localize "STR_openMarkerFinder"); 
_button buttonSetAction "0 spawn life_fnc_markerFinder";
_time = [0.3,0] select (_this isEqualTo 0);
{
	_x ctrlSetFade 1;
	_x ctrlCommit _time;
} forEach [_display displayCtrl 615123,_display displayCtrl 615121,_display displayCtrl 615122,_display displayCtrl 615124];
life_markerfinder = false;
 /*
 *
 *	@File:		fn_animateMarkerFinder.sqf
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
if(life_markerFinder) exitWith {};
life_markerFinder = true;
disableSerialization;
_listbox = (findDisplay 12) displayCtrl 615124; //can't use IDC on arma displays, fetch control
_cur = lbcursel _listbox;
if(_cur isEqualTo -1) exitWith {};
_markerpos = getMarkerpos(_listbox lbData _cur);
if(_markerpos isEqualTo [0,0,0]) exitWith {};
((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [1, 0.1, _markerpos];
ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
waitUntil{sleep 0.1; mapAnimDone};
((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [1, 0.05, _markerpos];
ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
sleep 1;
life_markerFinder = false;

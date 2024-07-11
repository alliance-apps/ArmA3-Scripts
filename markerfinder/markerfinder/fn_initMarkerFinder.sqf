 /*
 *
 *	@File:		fn_initMarkerFinder.sqf
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
_button = _display ctrlCreate ["RscButton", 615120]; 
_button ctrlSetText (localize "STR_openMarkerFinder"); 
_button ctrlSetPosition [0.418531 * safezoneW + safezoneX, 0.0045 * safezoneH + safezoneY, 0.144375 * safezoneW, 0.025 * safezoneH]; 
_button buttonSetAction "0 spawn life_fnc_markerFinder";
_button ctrlCommit 0;
_background = _display ctrlCreate ["RscText", 615121];
_background ctrlSetPosition [0.418531 * safezoneW + safezoneX, 0.0842 * safezoneH + safezoneY, 0.144375 * safezoneW, 0.1386 * safezoneH];
_background ctrlSetBackgroundColor [0.14902,0.196078,0.219608,0.9];
_background ctrlSetFade 1;
_background ctrlCommit 0;
_title = _display ctrlCreate ["RscStructuredText", 615122];
_title ctrlSetStructuredText parseText (localize "STR_MarkerFinderTitle");
_title ctrlSetPosition [0.418531 * safezoneW + safezoneX, 0.0512 * safezoneH + safezoneY, 0.144375 * safezoneW, 0.033 * safezoneH];
_title ctrlSetBackgroundColor [0.584314,0.647059,0.65098,0.6];
_title ctrlSetFade 1;
_title ctrlCommit 0;
_editbox = _display ctrlCreate ["RscEdit", 615123];
_editbox ctrlSetText (if(getNumber(missionConfigFile >> "aapps_markerFinder_config" >> "setOldInput") isEqualTo 1) then {profilenamespace getVariable ["aapps_oldmarker",""]} else {""});
_editbox ctrlSetPosition [0.422074 * safezoneW + safezoneX, 0.088519 * safezoneH + safezoneY, 0.139209 * safezoneW, 0.033 * safezoneH];
_editbox ctrlSetFade 1;
_editbox ctrlCommit 0;
_listbox = _display ctrlCreate ["RscListbox", 615124];
_listbox ctrlSetPosition [0.421625 * safezoneW + safezoneX, 0.126 * safezoneH + safezoneY, 0.139209 * safezoneW, 0.0924 * safezoneH];
_listbox ctrlSetFontHeight 0.04;
_listbox ctrlSetBackgroundColor [0.584314,0.647059,0.65098,0.6];
_listbox ctrlSetEventHandler ["LBSelChanged","0 spawn life_fnc_animateMarkerFinder"];
_listbox ctrlSetFade 1;
_listbox ctrlCommit 0;
_listbox lbadd (localize "STR_noMarkerFoundFinder");

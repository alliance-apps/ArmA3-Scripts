scriptName "fn_gang_loadGH";
/*
 *
 *	@File:		fn_gang_loadGH.sqf
 *	@Author: 	AllianceApps
 *	@Date:		11.05.2018
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *
 */
if(getNumber(missionConfigFile >> "gang_config" >> "hideouts" >> "loadfromDBafterRESTART") isEqualTo 0) exitWith {};
_hideoutclassnames = getArray(missionConfigFile >> "gang_config" >> "hideouts" >> "possible_hideout_classes"); //you'd rather use terrainsort, but this function is not present in AL 4.0
_query = "SELECT value FROM gang_info WHERE name in ('hideout1','hideout2','hideout3')";
_queryResult = [_query,2,true] call HC_fnc_asynccall;
if(_queryResult isEqualTo []) exitWith {};
for '_i' from 1 to 3 do {
    _pos = getArray(missionConfigFile >> "gang_config" >> "hideouts" >> worldname >> format["gang_hideout%1_pos",_i]);
    _gh = (nearestObjects[_pos,_hideoutclassnames,5]) select 0;
    _val = (_queryResult select (_i - 1)) select 0;
    _marker = format["gh_marker_%1",_i];
    createMarker [_marker, [(_pos select 0) + 30,(_pos select 1) - 30]];
    _marker setMarkerColor "ColorRed";
    _marker setMarkerType "mil_flag";
    _notcaptured = {
        _marker setMarkerText format["%1 %2",getText(missionconfigfile >> "gang_config" >> "hideouts" >> "hideout_markername"), getText(missionConfigFile >> "gang_config" >> "hideouts" >> "hideout_markername_default")];
        _gh setVariable ["gangOwner",-1,true];
    };
    if(_val isEqualTo -1) then {
        call _notcaptured;
    } else {
        _namequery = format["SELECT name FROM gangs WHERE id='%1' AND active='1'",_val];
        _nqresult = [_namequery,2] call HC_fnc_asynccall;
        if(_nqresult isEqualTo []) then {
            call _notcaptured;
        } else {
            _marker setMarkerText format["%1 %2",getText(missionconfigfile >> "gang_config" >> "hideouts" >> "hideout_markername"),_nqresult select 0];
            _gh setVariable ["gangOwner",_val,true];
            _gh setVariable ["gangOwnerName",_nqresult select 0,true];
            _flagTexture = [
        		"\A3\Data_F\Flags\Flag_red_CO.paa",
        		"\A3\Data_F\Flags\Flag_green_CO.paa",
        		"\A3\Data_F\Flags\Flag_blue_CO.paa",
        		"\A3\Data_F\Flags\Flag_white_CO.paa",
        		"\A3\Data_F\Flags\flag_fd_red_CO.paa",
        		"\A3\Data_F\Flags\flag_fd_green_CO.paa",
        		"\A3\Data_F\Flags\flag_fd_blue_CO.paa",
        		"\A3\Data_F\Flags\flag_fd_orange_CO.paa"
        	] call BIS_fnc_selectRandom;
    	    _flag = nearestObject [_gh,"FlagPole_F"];
    	    _flag setFlagTexture _flagTexture;
        };
    };
    _gh setVariable ["inCapture",false,true];
    _gh setVariable ["hideoutnr",_i,true];
};

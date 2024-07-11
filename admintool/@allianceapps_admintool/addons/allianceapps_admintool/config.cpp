/*
 *
 *	@File:		config.cpp
 *	@Author: 	AllianceApps
 *	@Date:		31.01.2018
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *  
 */
class CfgPatches {
    class allianceapps_admintool {
        units[] = {"C_man_1"};
        weapons[] = {};
        requiredAddons[] = {"A3_Data_F"};
        fileName = "allianceapps_admintool.pbo";
        author = "www.AllianceApps.de";
		contact = "www.AllianceApps.de";
    };
};
class CfgServer {
	#include "\allianceapps_admintool\rights_config.hpp"
};

class CfgFunctions {
    class admin_System {
        tag = "TON";
        class scripts {
            file = "\allianceapps_admintool";
			class preInitFile {
				preInit = 1;
			};
			class makeandsendp {};
        };
    };
};

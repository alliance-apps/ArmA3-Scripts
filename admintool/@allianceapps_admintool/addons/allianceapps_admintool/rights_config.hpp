/*
 *
 *	@File:		rights_config.sqf
 *	@Author: 	AllianceApps
 *	@Date:		31.01.2018
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *  
 *
 *	STRUCTURE:
 *  fncname = fncname defined in fn_InitAdminFunctions.sqf
 *	displayName = name which is displayed in your adminmenu
 *	level = admin lvl which is needed to perform this action
 *	type = boolean - if false it's a player category function else it's a multiplayer category function
 *	edit = boolean - true if editbox needs to be displayed on listbox selection
 *	map = boolean - true to show in your keymapper
 */
#define true 1
#define false 0
class general {
	teamspeakaddress = "ts.YOURteamspeakADDRESS.net";
	uid_12345678912345678[] = {"zeus","trunkopen","delcursor"}; 
};
class dev_tool_settings {
	enableDebugConsole = true; //Enable compiling of the Dev-Interface
	devtoolUIDWhitelist[] = {"12345678912345678","12345678912345678"}; //Whitelisted UIDs to use DEV TOOL
};
class admin_tool_fnc {
	class description {//Show Description of a player if selected
		level = 5;
	};
	class trunkunlock {
		fncname = "_admin_trunkunlock";
		displayname = "STR_adm_fnc_trunkunlock";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class trunkopen {
		fncname = "_admin_trunkopen";
		displayname = "STR_adm_fnc_trunkopen";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class spectaten {
		fncname = "_admin_spectate";
		displayname = "STR_adm_fnc_spec";
		level = 5;
		type = true;
		edit = false;
	};
	class teleport {
		fncname = "_admin_teleport";
		displayname = "STR_adm_fnc_tp";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class teleportall {
		fncname = "_admin_teleportallhere";
		displayname = "STR_adm_fnc_tpallhere";
		level = 5;
		type = false;
		edit = false;
	};
	class teleportto {
		fncname = "_admin_teleportto";
		displayname = "STR_adm_fnc_tpto";
		level = 5;
		type = true;
		edit = false;
	};
	class vehgodmode {
		fncname = "_admin_veh_godmode";
		displayname = "STR_adm_fnc_vehgod";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class switchnightday {
		fncname = "_admin_skiptime";
		displayname = "STR_adm_fnc_skiptime";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class mapmarker {
		fncname = "_admin_marker";
		displayname = "STR_adm_fnc_marker";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class fixweather {
		fncname = "_admin_fixweather";
		displayname = "STR_adm_fnc_fixweather";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class zeus {
		fncname = "_admin_zeus";
		displayname = "STR_adm_fnc_zeus";
		level = 5;
		type = true;
		edit = false;
	};
	class delspawned {
		fncname = "_admin_delspawned";
		displayname = "STR_adm_aapps_veh_del_title";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class teleporthere {
		fncname = "_admin_teleporthere";
		displayname = "STR_adm_fnc_tphere";
		level = 5;
		type = true;
		edit = false;
	};
	class keygive {
		fncname = "_admin_keygive";
		displayname = "STR_adm_fnc_givekey";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class delcursor {
		fncname = "_admin_delcursor";
		displayname = "STR_adm_fnc_delcur";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class explocursor {
		fncname = "_admin_explocursor";
		displayname = "STR_adm_fnc_explcur";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class healplayer {
		fncname = "_admin_healplayer";
		displayname = "STR_adm_fnc_healplayer";
		level = 5;
		type = true;
		edit = false;
	};
	class moneygive {
		fncname = "_admin_moneygive";
		displayname = "STR_adm_fnc_givemoney";
		level = 5;
		type = true;
		edit = true;
	};
	class silentimpound {
		fncname = "_admin_silentimpound";
		displayname = "STR_adm_fnc_impound";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class arsenal {
		fncname = "_admin_arsenal";
		displayname = "STR_adm_fnc_arsenal";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class stripplayer {
		fncname = "_admin_stripplayer";
		displayname = "STR_adm_fnc_strip";
		level = 5;
		type = true;
		edit = false;
	};
	class adminmessage {
		fncname = "_admin_adminmessage";
		displayname = "STR_adm_fnc_admin";
		level = 5;
		type = true;
		edit = true;
	};
	class adminmessageALL {
		fncname = "_admin_adminmessageALL";
		displayname = "STR_adm_fnc_adminall";
		level = 5;
		type = false;
		edit = true;
	};
	class tswarning1 {
		fncname = "_admin_tswarning1";
		displayname = "STR_adm_fnc_ts1";
		level = 5;
		type = true;
		edit = false;
	};
	class tswarning2 {
		fncname = "_admin_tswarning2";
		displayname = "STR_adm_fnc_ts2";
		level = 5;
		type = true;
		edit = false;
	};
	class tswarning3 {
		fncname = "_admin_tswarning3";
		displayname = "STR_adm_fnc_ts3";
		level = 5;
		type = true;
		edit = false;
	};
	class kick {
		fncname = "_admin_kick";
		displayname = "STR_adm_fnc_kick";
		level = 5;
		type = true;
		edit = true;
	};
	class pindexlink {
		fncname = "_admin_pindexlink";
		displayname = "STR_adm_fnc_pindex";
		level = 5;
		type = true;
	};
	class restrainplayer {
		fncname = "_admin_restrain";
		displayname = "STR_adm_fnc_restrain";
		level = 5;
		type = true;
		edit = false;
	};
	class unrestrainplayer {
		fncname = "_admin_unrestrain";
		displayname = "STR_adm_fnc_unrestrain";
		level = 5;
		type = true;
		edit = false;
	};
	class forceeject {
		fncname = "_admin_forceeject";
		displayname = "STR_adm_fnc_eject";
		level = 5;
		type = true;
		edit = false;
	};
	class repairvehicle {
		fncname = "_admin_repairtarget";
		displayname = "STR_adm_fnc_repaircur";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class repairvehicleplayer {
		fncname = "_admin_repairvehicle";
		displayname = "STR_adm_fnc_repairveh";
		level = 5;
		type = true;
		edit = false;
	};
	class repairterrain {
		fncname = "_admin_repairterrain";
		displayname = "STR_adm_fnc_repairterrain";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class copyloadout {
		fncname = "_admin_copyloadout";
		displayname = "STR_adm_fnc_copygear";
		level = 5;
		type = true;
		edit = false;
	};
	class addlicenses {
		fncname = "_admin_showlicenses";
		displayName = "STR_adm_fnc_addlicense";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class addvitems {
		fncname = "_admin_showvitems";
		displayName = "STR_adm_fnc_addvitems";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class clearingameadminlogs {
		fncname = "_admin_clearadminlogs";
		displayname = "STR_adm_fnc_dellogs";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class seelogs {
		fncname = "_admin_seelogs";
		displayname = "STR_adm_fnc_showlogs";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class serverstatistic {
		fncname = "_admin_serverstatsfnc";
		displayname = "STR_adm_fnc_statistic";
		level = 5;
		type = false;
		edit = false;
	};
	class killplayer {
		fncname = "_admin_kill";
		displayname = "STR_adm_fnc_killplayer";
		level = 5;
		type = true;
		edit = false;
	};
	class speedplayer {
		fncname = "_admin_speedplayer";
		displayname = "STR_adm_fnc_boost";
		level = 5;
		type = true;
		edit = false;
	};
	class reviveplayer {
		fncname = "_admin_reviveplayer";
		displayname = "STR_adm_fnc_revive";
		level = 5;
		type = true;
		edit = false;
	};
	class invisibility {
		fncname = "_admin_invisibility";
		displayname = "STR_adm_fnc_invisibility";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class freecam {
		fncname = "_admin_freecam";
		displayname = "STR_adm_fnc_freecam";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class godmodeplayer { //function
		fncname = "_admin_godmode";
		displayname = "STR_adm_fnc_godmode";
		level = 5;
		type = true;
		edit = false;
		map = false;
	};
	class colorize {
		fncname = "_admin_colorize";
		displayname = "STR_adm_fnc_colorize";
		level = 5;
		type = true;
		edit = false;
	};
	class getExtendedInfo {
		fncname = "_admin_getExtendedInfofnc";
		displayname = "STR_adm_fnc_extended";
		level = 5;
		type = true;
		edit = false;
	};
	class freezeplayer {
		fncname = "_admin_freezeplayer";
		displayname = "STR_adm_fnc_freeze";
		level = 5;
		type = true;
		edit = false;
	};
	class moveinvehicle {
		fncname = "_admin_moveinvehicle";
		displayname = "STR_adm_fnc_movein";
		level = 5;
		type = true;
		edit = false;
	};
	class moveinmyvehicle {
		fncname = "_admin_moveinmyvehicle";
		displayname = "STR_adm_fnc_moveinmine";
		level = 5;
		type = true;
		edit = false;
	};
	class vehicleshow {
		fncname = "_admin_showvehicles";
		displayname = "STR_adm_fnc_spawnveh";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class 3dmarker {
		fncname = "_admin_3dmarker";
		displayName = "STR_adm_fnc_3dmarker";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
	class copytargetloadout {
		fncname = "_admin_copytargetloadout";
		displayname = "STR_adm_fnc_copytargetgear";
		level = 5;
		type = true;
		edit = false;
	};
	class keymappergodmode { //only for the keymapper
		fncname = "_admin_godmode";
		displayname = "STR_adm_fnc_godmode";
		level = 5;
		type = false;
		edit = false;
		map = true;
	};
};

/*
 *
 *	@File:		reward.hpp
 *	@Author: 	AllianceApps
 *	@Date:		30.07.2019
 *
 *	You are not allowed to use this script or remove the credits of the script without written permission of the author.
 *  You are not allowed to use this script without a valid license. License terms apply.
 *
 *  Du darfst dieses Script nicht nutzen oder diesen Copyright-Hinweis nicht entfernen, wenn du keine schriftliche Bestätigung des Autors hast.
 *  Du darfst dieses Script nicht ohne gültige Lizenz nutzen. Die Lizenzbestimmungen für Scripts sind zu beachten.
 *
 * class xy {
 *     name = ""; //Name to display when reward is gained
 *     description = ""; //Description to display when reward is gained
 *	   sound = ""; //An optional sound to play
 *     statement = ""; //Additional code to execute
 *     condition = ""; //Condition which needs to be true, can be e.g. ((life_rewarddays isEqualTo 2) && license_civ_driver)
 *     rewards[] = {}; //rewards array
 * };
 *
 */
class aapps_reward_config {
	class day2 {
		name = "Tag 2";
		description = "Du warst zwei Tage hintereinander auf dem Server";
		sound = ""; //customsound
		statement = "";
		condition = "life_rewarddays isEqualto 2";
		rewards[] = {
			{"VITEM", "classname", 1},
			{"VITEM", "classname", 1},
			{"VITEM", "classname", 1}
		};
	};
	class day3 {
		name = "Tag 3";
		description = "Du warst drei Tage hintereinander auf dem Server";
		sound = "";
		statement = "";
		condition = "life_rewarddays isEqualto 3";
		rewards[] = {
			{"VITEM", "classname", 1},
			{"VITEM", "classname", 1},
			{"VITEM", "classname", 1}
		};
	};
};

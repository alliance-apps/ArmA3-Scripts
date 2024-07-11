-- Table 
CREATE TABLE IF NOT EXISTS `lottery_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
-- Data
INSERT INTO `lottery_info` (`id`, `name`, `value`) VALUES
	(1, 'lottery_lvl2', 3),
	(2, 'lottery_lvl3', 7),
	(3, 'lottery_lvl4', 25),
	(4, 'lottery_lvl5', 65),
	(5, 'lottery_lvl6', 100),
	(6, 'lottery_jackpot', 0);


-- Procedures
DELIMITER //
CREATE DEFINER=`arma3`@`localhost` PROCEDURE `lotterydeltickets`()
BEGIN
	 UPDATE `lottery_tickets` SET `deleted_at`= CURRENT_TIMESTAMP;
END//

CREATE DEFINER=`arma3`@`localhost` PROCEDURE `lotterydelwin`()
BEGIN
	UPDATE `players` SET `lottery_win`= 0;
END//
DELIMITER ;

-- Table
CREATE TABLE IF NOT EXISTS `lottery_tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` varchar(17) NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE players ADD lottery_win int(100) NOT NULL DEFAULT '0';

CREATE TABLE `services` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(50) NOT NULL COLLATE 'utf8_bin',
	`job` VARCHAR(50) NOT NULL COLLATE 'utf8_bin',
	`time` INT(11) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`),
	INDEX `identifier` (`identifier`),
	INDEX `job` (`job`)
)
COLLATE='utf8_bin'
ENGINE=InnoDB
AUTO_INCREMENT=6
;

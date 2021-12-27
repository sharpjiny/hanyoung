--<ScriptOptions statementTerminator=";"/>

ALTER TABLE `database`.`vehicle_management` DROP PRIMARY KEY;

DROP TABLE `database`.`vehicle_management`;

CREATE TABLE `database`.`vehicle_management` (
	`vehicle_id` VARCHAR(45) NOT NULL,
	`kind` VARCHAR(100),
	`model_car` VARCHAR(100),
	`product_name` VARCHAR(100),
	`lh_rh` ENUM DEFAULT NA,
	`product_id` VARCHAR(100),
	`client` VARCHAR(100),
	`price` DOUBLE DEFAULT 0,
	`created` DATETIME,
	`last_modified` DATETIME,
	PRIMARY KEY (`vehicle_id`)
) ENGINE=InnoDB;


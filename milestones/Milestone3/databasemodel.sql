-- MySQL Script generated by MySQL Workbench
-- Sun Dec 11 21:34:42 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

--  DROP DATABASE IF EXISTS One675;  NEED TO UN COMMENT 
--  CREATE DATABASE IF NOT EXISTS One675; NEED TO UN COMMENT 
 USE SecondOne675; 
 
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Table `SecondOne675`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Users` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Users` (
  `user_id` INT NOT NULL,
  `first_name` VARCHAR(65) NOT NULL,
  `last_name` VARCHAR(65) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Account` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Account` (
  `account_id` INT NOT NULL,
  `username` VARCHAR(65) NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`account_id`, `user_id`),
  INDEX `ACCOUNT_USER_FK_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `ACCOUNT_USER_FK`
    FOREIGN KEY (`user_id`)
    REFERENCES `SecondOne675`.`Users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `SecondOne675`.`blog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`blog` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`blog` (
  `blog_id` INT NOT NULL,
  `date_created` DATE NOT NULL,
  `title` VARCHAR(65) NOT NULL,
  `user_id` INT NOT NULL,
  `blogAmount` INT NOT NULL,
  PRIMARY KEY (`blog_id`, `user_id`),
  INDEX `USER_BLOG_FK_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `USER_BLOG_FK`
    FOREIGN KEY (`user_id`)
    REFERENCES `SecondOne675`.`Users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`category` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`category` (
  `category_id` INT NOT NULL,
  `category_count` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`Report`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Report` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Report` (
  `report_id` INT NOT NULL,
  `title` VARCHAR(65) NOT NULL,
  `body` VARCHAR(150) NOT NULL,
  `date_created` DATE NOT NULL,
  PRIMARY KEY (`report_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`Searches`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Searches` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Searches` (
  `searches_id` INT NOT NULL,
  `searches_count` INT NOT NULL,
  `type` VARCHAR(65) NOT NULL,
  PRIMARY KEY (`searches_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`Tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Tag` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Tag` (
  `tag_id` INT NOT NULL,
  `tag_count` INT NOT NULL,
  `type` VARCHAR(65) NOT NULL,
  `searches_id` INT NOT NULL,
  PRIMARY KEY (`tag_id`, `searches_id`),
  INDEX `TAG_SRCH_FK_idx` (`searches_id` ASC) VISIBLE,
  CONSTRAINT `TAG_SRCH_FK`
    FOREIGN KEY (`searches_id`)
    REFERENCES `SecondOne675`.`Searches` (`searches_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`Contains`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Contains` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Contains` (
  `contains_id` INT NOT NULL,
  `blog_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  `searches_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  `report_id` INT NOT NULL,
  `account_id` INT NOT NULL,
  PRIMARY KEY (`contains_id`, `blog_id`),
  INDEX `CNTNS_BLOG_FK_idx` (`blog_id` ASC) VISIBLE,
  INDEX `CNTNS_SRCS_FK_idx` (`searches_id` ASC) VISIBLE,
  INDEX `CNTNS_TAG_FK_idx` (`tag_id` ASC) VISIBLE,
  INDEX `CNTNS_CAT_FK_idx` (`category_id` ASC) VISIBLE,
  INDEX `CNTNS_REP_FK_idx` (`report_id` ASC) VISIBLE,
  INDEX `CNTNS_ACC_FK_idx` (`account_id` ASC) VISIBLE,
  CONSTRAINT `CNTNS_ACC_FK`
    FOREIGN KEY (`account_id`)
    REFERENCES `SecondOne675`.`Account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `CNTNS_BLOG_FK`
    FOREIGN KEY (`blog_id`)
    REFERENCES `SecondOne675`.`blog` (`blog_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `CNTNS_CAT_FK`
    FOREIGN KEY (`category_id`)
    REFERENCES `SecondOne675`.`category` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `CNTNS_REP_FK`
    FOREIGN KEY (`report_id`)
    REFERENCES `SecondOne675`.`Report` (`report_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `CNTNS_SRCS_FK`
    FOREIGN KEY (`searches_id`)
    REFERENCES `SecondOne675`.`Searches` (`searches_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `CNTNS_TAG_FK`
    FOREIGN KEY (`tag_id`)
    REFERENCES `SecondOne675`.`Tag` (`tag_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `SecondOne675`.`Limited_Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Limited_Account` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Limited_Account` (
  `limited_account_id` INT NOT NULL,
  `limited_account_period` INT NOT NULL,
  `subscription_duration` INT NOT NULL,
  `account_id` INT NOT NULL,
  PRIMARY KEY (`limited_account_id`, `account_id`),
  INDEX `LIM_ACCOUNT_FK_idx` (`account_id` ASC) VISIBLE,
  CONSTRAINT `LIM_ACCOUNT_FK`
    FOREIGN KEY (`account_id`)
    REFERENCES `SecondOne675`.`Account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`advertisements`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`advertisements` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`advertisements` (
  `advertisement_id` INT NOT NULL,
  `title` VARCHAR(150) NOT NULL,
  `body` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`advertisement_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`admin` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`admin` (
  `admin_id` INT NOT NULL,
  `rank` INT NOT NULL,
  `name` VARCHAR(65) NOT NULL,
  `advertisement_id` INT NOT NULL,
  PRIMARY KEY (`admin_id`),
  INDEX `AD_FK_idx` (`advertisement_id` ASC) VISIBLE,
  CONSTRAINT `AD_FK`
    FOREIGN KEY (`advertisement_id`)
    REFERENCES `SecondOne675`.`advertisements` (`advertisement_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`articles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`articles` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`articles` (
  `article_id` INT NOT NULL,
  `title` VARCHAR(150) NOT NULL,
  `body` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`article_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`multimedia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`multimedia` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`multimedia` (
  `multimedia_id` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `lifetime` INT NOT NULL,
  PRIMARY KEY (`multimedia_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`Monitors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Monitors` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Monitors` (
  `monitors_id` INT NOT NULL,
  `admin_id` INT NOT NULL,
  `account_id` INT NOT NULL,
  `multimedia_id` INT NOT NULL,
  `advertisement_id` INT NOT NULL,
  `article_id` INT NOT NULL,
  PRIMARY KEY (`monitors_id`),
  INDEX `ADMIN_MON_FK_idx` (`admin_id` ASC) VISIBLE,
  INDEX `MON_ACC_FK_idx` (`account_id` ASC) VISIBLE,
  INDEX `MON_MULTI_FK_idx` (`multimedia_id` ASC) VISIBLE,
  INDEX `MON_ART_FK_idx` (`article_id` ASC) VISIBLE,
  INDEX `MON_AD_FK_idx` (`advertisement_id` ASC) VISIBLE,
  CONSTRAINT `ADMIN_MON_FK`
    FOREIGN KEY (`admin_id`)
    REFERENCES `SecondOne675`.`admin` (`admin_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MON_ACC_FK`
    FOREIGN KEY (`account_id`)
    REFERENCES `SecondOne675`.`Account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MON_AD_FK`
    FOREIGN KEY (`advertisement_id`)
    REFERENCES `SecondOne675`.`advertisements` (`advertisement_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MON_ART_FK`
    FOREIGN KEY (`article_id`)
    REFERENCES `SecondOne675`.`articles` (`article_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MON_MULTI_FK`
    FOREIGN KEY (`multimedia_id`)
    REFERENCES `SecondOne675`.`multimedia` (`multimedia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`Prime_Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Prime_Account` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Prime_Account` (
  `prime_account_id` INT NOT NULL,
  `prime_account_period` INT NOT NULL,
  `subscription_duration` INT NOT NULL,
  `account_id` INT NOT NULL,
  PRIMARY KEY (`prime_account_id`, `account_id`),
  INDEX `PRIME_ACC_FK_idx` (`account_id` ASC) VISIBLE,
  CONSTRAINT `PRIME_ACC_FK`
    FOREIGN KEY (`account_id`)
    REFERENCES `SecondOne675`.`Account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Product` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Product` (
  `product_id` INT NOT NULL,
  `creation_date` DATE NOT NULL,
  `name` VARCHAR(65) NOT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`Registered_User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Registered_User` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Registered_User` (
  `registered_user_id` INT NOT NULL,
  `name` VARCHAR(65) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`registered_user_id`, `user_id`),
  INDEX `REG_USER_FK_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `REG_USER_FK`
    FOREIGN KEY (`user_id`)
    REFERENCES `SecondOne675`.`Users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Roles` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Roles` (
  `roles_id` INT NOT NULL,
  `conditon` VARCHAR(45) NOT NULL,
  `theme` VARCHAR(45) NOT NULL,
  `account_id` INT NOT NULL,
  PRIMARY KEY (`roles_id`, `account_id`),
  INDEX `ROLES_ACC_FK_idx` (`account_id` ASC) VISIBLE,
  CONSTRAINT `ROLES_ACC_FK`
    FOREIGN KEY (`account_id`)
    REFERENCES `SecondOne675`.`Account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`devices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`devices` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`devices` (
  `devices_id` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `lifetime` INT NOT NULL,
  PRIMARY KEY (`devices_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`Runs_On`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Runs_On` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Runs_On` (
  `runs_on_id` INT NOT NULL,
  `products_id` INT NOT NULL,
  `devices_id` INT NOT NULL,
  PRIMARY KEY (`runs_on_id`),
  INDEX `PROD_RUNON_FK_idx` (`products_id` ASC) VISIBLE,
  INDEX `DEV_RUNON_FK_idx` (`devices_id` ASC) VISIBLE,
  CONSTRAINT `DEV_RUNON_FK`
    FOREIGN KEY (`devices_id`)
    REFERENCES `SecondOne675`.`devices` (`devices_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PROD_RUNON_FK`
    FOREIGN KEY (`products_id`)
    REFERENCES `SecondOne675`.`Product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`Unregistered_User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Unregistered_User` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Unregistered_User` (
  `unregistered_user_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`unregistered_user_id`, `user_id`),
  INDEX `UNREG_USR_FK_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `UNREG_USR_FK`
    FOREIGN KEY (`user_id`)
    REFERENCES `SecondOne675`.`Users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`Upgraded_Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Upgraded_Account` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Upgraded_Account` (
  `upgraded_account_id` INT NOT NULL,
  `account_id` INT NOT NULL,
  PRIMARY KEY (`upgraded_account_id`, `account_id`),
  INDEX `UPGRD_ACC_FK_idx` (`account_id` ASC) VISIBLE,
  CONSTRAINT `UPGRD_ACC_FK`
    FOREIGN KEY (`account_id`)
    REFERENCES `SecondOne675`.`Account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`Upvote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Upvote` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Upvote` (
  `upvote_id` INT NOT NULL,
  `upvote_count` INT NOT NULL,
  `upvote_type` VARCHAR(65) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`upvote_id`, `user_id`),
  INDEX `UPVOTE_USR_FK_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `UPVOTE_USR_FK`
    FOREIGN KEY (`user_id`)
    REFERENCES `SecondOne675`.`Users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`Video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`Video` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`Video` (
  `video_id` INT NOT NULL,
  `title` VARCHAR(65) NOT NULL,
  `description` VARCHAR(150) NOT NULL,
  `type` VARCHAR(15) NOT NULL,
  `multimedia_id` INT NOT NULL,
  PRIMARY KEY (`video_id`, `multimedia_id`),
  INDEX `VIDEO_MULTI_FK_idx` (`multimedia_id` ASC) VISIBLE,
  CONSTRAINT `VIDEO_MULTI_FK`
    FOREIGN KEY (`multimedia_id`)
    REFERENCES `SecondOne675`.`multimedia` (`multimedia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`comment` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`comment` (
  `comment_id` INT NOT NULL,
  `date_created` VARCHAR(45) NOT NULL,
  `body` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`comment_id`, `user_id`),
  INDEX `COMMENT_USR_FK_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `COMMENT_USR_FK`
    FOREIGN KEY (`user_id`)
    REFERENCES `SecondOne675`.`Users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`company` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`company` (
  `company_id` INT NOT NULL,
  `company_name` VARCHAR(150) NOT NULL,
  `account_id` INT NOT NULL,
  PRIMARY KEY (`company_id`, `account_id`),
  INDEX `COMPANY_ACC_FK_idx` (`account_id` ASC) VISIBLE,
  CONSTRAINT `COMPANY_ACC_FK`
    FOREIGN KEY (`account_id`)
    REFERENCES `SecondOne675`.`Account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`digital_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`digital_image` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`digital_image` (
  `digital_image_id` INT NOT NULL,
  `title` VARCHAR(65) NOT NULL,
  `description` VARCHAR(150) NOT NULL,
  `type` VARCHAR(25) NOT NULL,
  `multimedia_id` INT NOT NULL,
  PRIMARY KEY (`digital_image_id`, `multimedia_id`),
  INDEX `DIGIMG_MULTI_FK_idx` (`multimedia_id` ASC) VISIBLE,
  CONSTRAINT `DIGIMG_MULTI_FK`
    FOREIGN KEY (`multimedia_id`)
    REFERENCES `SecondOne675`.`multimedia` (`multimedia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`music`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`music` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`music` (
  `music_id` INT NOT NULL,
  `title` VARCHAR(65) NOT NULL,
  `type` VARCHAR(25) NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  `multimedia_id` INT NOT NULL,
  PRIMARY KEY (`music_id`, `multimedia_id`),
  INDEX `MUSIC_MULTI_FK_idx` (`multimedia_id` ASC) VISIBLE,
  CONSTRAINT `MUSIC_MULTI_FK`
    FOREIGN KEY (`multimedia_id`)
    REFERENCES `SecondOne675`.`multimedia` (`multimedia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`photo` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`photo` (
  `photo_id` INT NOT NULL,
  `description` VARCHAR(150) NOT NULL,
  `title` VARCHAR(65) NOT NULL,
  `type` VARCHAR(25) NOT NULL,
  `multimedia_id` INT NOT NULL,
  PRIMARY KEY (`photo_id`, `multimedia_id`),
  INDEX `PHOTO_MULTI_FK_idx` (`multimedia_id` ASC) VISIBLE,
  CONSTRAINT `PHOTO_MULTI_FK`
    FOREIGN KEY (`multimedia_id`)
    REFERENCES `SecondOne675`.`multimedia` (`multimedia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`post` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`post` (
  `post_id` INT NOT NULL,
  `title` VARCHAR(65) NOT NULL,
  `body` VARCHAR(150) NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`post_id`, `category_id`),
  INDEX `POST_CAT_FK_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `POST_CAT_FK`
    FOREIGN KEY (`category_id`)
    REFERENCES `SecondOne675`.`category` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SecondOne675`.`privileges`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SecondOne675`.`privileges` ;

CREATE TABLE IF NOT EXISTS `SecondOne675`.`privileges` (
  `privileges_id` INT NOT NULL,
  `rank` INT NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`privileges_id`, `user_id`),
  INDEX `PRIV_FK_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `PRIV_FK`
    FOREIGN KEY (`user_id`)
    REFERENCES `SecondOne675`.`Users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `SecondOne675` ;

-- -----------------------------------------------------
-- function categoryCount
-- -----------------------------------------------------

USE `SecondOne675`;
DROP function IF EXISTS `SecondOne675`.`categoryCount`;

DELIMITER $$
USE `SecondOne675`$$
CREATE DEFINER=`root`@`%` FUNCTION `categoryCount`(cat int) RETURNS int
    DETERMINISTIC
BEGIN
 DECLARE count int;
  Select cat into count;
  RETURN count;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure findDevices
-- -----------------------------------------------------

USE `SecondOne675`;
DROP procedure IF EXISTS `SecondOne675`.`findDevices`;

DELIMITER $$
USE `SecondOne675`$$
CREATE DEFINER=`root`@`%` PROCEDURE `findDevices`()
BEGIN
  SELECT rOn.devices_id AS deviceId, dev.type AS 'type', dev.lifetime AS lifetime
  FROM Runs_On rOn 
  INNER JOIN devices dev
  ON dev.devices_id = rOn.runs_on_id
  HAVING dev.lifetime > 85;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure findRoles
-- -----------------------------------------------------

USE `SecondOne675`;
DROP procedure IF EXISTS `SecondOne675`.`findRoles`;

DELIMITER $$
USE `SecondOne675`$$
CREATE DEFINER=`root`@`%` PROCEDURE `findRoles`()
BEGIN
  SELECT a.account_id AS accountIdWithRoles, rol.theme AS theme, rol.conditon AS conditions
  FROM Account a 
  INNER JOIN Roles rol
  ON rol.account_id = a.account_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function subrscription_length
-- -----------------------------------------------------

USE `SecondOne675`;
DROP function IF EXISTS `SecondOne675`.`subrscription_length`;

DELIMITER $$
USE `SecondOne675`$$
CREATE DEFINER=`root`@`%` FUNCTION `subrscription_length`(sub int) RETURNS int
    DETERMINISTIC
BEGIN
 DECLARE sub2 int;
  Select current_date()into sub2;
  RETURN year(sub2)-(sub);
END$$

DELIMITER ;


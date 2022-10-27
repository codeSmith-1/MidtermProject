-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bookdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bookdb` ;

-- -----------------------------------------------------
-- Schema bookdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bookdb` DEFAULT CHARACTER SET utf8 ;
USE `bookdb` ;

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `street2` VARCHAR(45) NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `enabled` TINYINT(1) NULL,
  `role` VARCHAR(45) NULL,
  `address_id` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `about_me` TEXT NULL,
  `profile_img` TEXT(1000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_address1_idx` (`address_id` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  CONSTRAINT `fk_user_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `author` ;

CREATE TABLE IF NOT EXISTS `author` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book` ;

CREATE TABLE IF NOT EXISTS `book` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(75) NOT NULL,
  `description` TEXT NULL,
  `author_id` INT NOT NULL,
  `cover` VARCHAR(1000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_book_author1_idx` (`author_id` ASC),
  CONSTRAINT `fk_book_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `genre` ;

CREATE TABLE IF NOT EXISTS `genre` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `image` VARCHAR(1000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book_condition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book_condition` ;

CREATE TABLE IF NOT EXISTS `book_condition` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `condition_desc` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shelf_book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shelf_book` ;

CREATE TABLE IF NOT EXISTS `shelf_book` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `for_borrow` TINYINT NULL DEFAULT 0,
  `book_id` INT NOT NULL,
  `book_condition_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `for_sale` TINYINT NULL,
  `sale_price` DECIMAL(5,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_shelf_book_book1_idx` (`book_id` ASC),
  INDEX `fk_shelf_book_book_condition1_idx` (`book_condition_id` ASC),
  INDEX `fk_shelf_book_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_shelf_book_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shelf_book_book_condition1`
    FOREIGN KEY (`book_condition_id`)
    REFERENCES `book_condition` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shelf_book_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book_has_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book_has_genre` ;

CREATE TABLE IF NOT EXISTS `book_has_genre` (
  `book_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`book_id`, `genre_id`),
  INDEX `fk_book_has_genre_genre1_idx` (`genre_id` ASC),
  INDEX `fk_book_has_genre_book1_idx` (`book_id` ASC),
  CONSTRAINT `fk_book_has_genre_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_genre_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `genre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment` LONGTEXT NOT NULL,
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `comment_date` DATE NULL,
  `in_reply_to_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comments_user1_idx` (`user_id` ASC),
  INDEX `fk_comments_book1_idx` (`book_id` ASC),
  INDEX `fk_comment_comment1_idx` (`in_reply_to_id` ASC),
  CONSTRAINT `fk_comments_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_comment1`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rating` ;

CREATE TABLE IF NOT EXISTS `rating` (
  `rating` INT NULL,
  `book_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `rating_comment` VARCHAR(255) NULL,
  INDEX `fk_rating_book1_idx` (`book_id` ASC),
  INDEX `fk_rating_user1_idx` (`user_id` ASC),
  PRIMARY KEY (`book_id`, `user_id`),
  CONSTRAINT `fk_rating_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rating_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `checkout`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `checkout` ;

CREATE TABLE IF NOT EXISTS `checkout` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `shelf_book_id` INT NOT NULL,
  `request_date` DATETIME NULL,
  `return_date` DATETIME NULL,
  `request_message` TEXT NULL,
  `checkout_date` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_checkout_user1_idx` (`user_id` ASC),
  INDEX `fk_checkout_shelf_book1_idx` (`shelf_book_id` ASC),
  CONSTRAINT `fk_checkout_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_checkout_shelf_book1`
    FOREIGN KEY (`shelf_book_id`)
    REFERENCES `shelf_book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `favorite_book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorite_book` ;

CREATE TABLE IF NOT EXISTS `favorite_book` (
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `book_id`),
  INDEX `fk_user_has_book_book1_idx` (`book_id` ASC),
  INDEX `fk_user_has_book_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_book_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_book_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genre_has_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `genre_has_user` ;

CREATE TABLE IF NOT EXISTS `genre_has_user` (
  `genre_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`genre_id`, `user_id`),
  INDEX `fk_genre_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_genre_has_user_genre1_idx` (`genre_id` ASC),
  CONSTRAINT `fk_genre_has_user_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `genre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_genre_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_author` ;

CREATE TABLE IF NOT EXISTS `user_has_author` (
  `user_id` INT NOT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `author_id`),
  INDEX `fk_user_has_author_author1_idx` (`author_id` ASC),
  INDEX `fk_user_has_author_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_author_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_author_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `currently_reading`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `currently_reading` ;

CREATE TABLE IF NOT EXISTS `currently_reading` (
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `book_id`),
  INDEX `fk_user_has_book_book2_idx` (`book_id` ASC),
  INDEX `fk_user_has_book_user2_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_book_user2`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_book_book2`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS bookdbuser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'bookdbuser'@'localhost' IDENTIFIED BY 'bookdbuser';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'bookdbuser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (1, '8 Pulaski St.', '', 'Springfield', 'PA', '19064');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (2, '712 South Johnson Court', '', 'Mason City', 'IA', '50401');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (3, '21 Howard Ave.', '', 'Waldorf', 'MD', '20601');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (4, '537 Mill Ave.', '', 'Mechanicsville', 'VA', '23111');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (5, '7436 Bald Hill St.', '', 'Upper Darby', 'PA', '19082');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (6, '985 West Golf Street', '', 'Hopkins', 'MN', '55343');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (7, '4 Euclid Lane', '', 'Chillicothe', 'OH', '45601');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (8, '929 Chestnut Road', '', 'New Brunswick', 'NJ', '8901');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (9, '77 Briarwood Court', '', 'De Pere', 'WI', '54115');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (10, '536 Tanglewood St.', '', 'North Canton', 'OH', '44720');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (11, '16 Helen Drive', '', 'Metairie', 'LA', '70001');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (12, '61 Pheasant Street', '', 'Hendersonville', 'NC', '28792');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (13, '8202 Wayne Dr.', '', 'Plainview', 'NY', '11803');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (14, '63 Ketch Harbour St.', '', 'Bridgeport', 'CT', '6606');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (15, '9911 Manor Street', '', 'Ann Arbor', 'MI', '48103');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (16, '9578 Hawthorne Court', '', 'Holbrook', 'NY', '11741');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (17, '7985 Shub Farm Ave.', '', 'Lawndale', 'CA', '90260');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (18, '515 East King Drive', '', 'Danvers', 'MA', '1923');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (19, '9911 Manor Street', '', 'Lawndale', 'CA', '90260');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (20, '515 East King Drive', '', 'Casselberry', 'FL', '32707');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (21, '13th Street 47 W 13th St', '', 'New York', 'NY', '10011');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (22, '20 Cooper Square', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (23, '1 E 2nd St', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (24, '75 3rd Ave', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (25, '6 Metrotech Center Metrotech Center', '', 'Brooklyn', 'NY', '11201');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (26, '721 Broadway', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (27, '40 E 7th St', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (28, '838 Broadway', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (29, '69 W 9th St', '', 'New York', 'NY', '10011');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (30, '19 Washington Square N', '', 'New York', 'NY', '10011');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (31, '371 7th Ave', '', 'New York', 'NY', '10001');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (32, '33 3rd Ave', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (33, '70 Washington Square South', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (34, '55 East 10th Street', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (35, '400 Broome St', '', 'New York', 'NY', '10013');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (36, '29 Washington Pl', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (37, '36 East 8th Street', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (38, '25 Union Square W', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (39, '55 Clark St', '', 'Brooklyn', 'NY', '11201');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (40, '181 Mercer Street', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (41, '345 E 24th St', '', 'New York', 'NY', '10010');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (42, '242 Greene St', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (43, '14th Street', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (44, '110 W 3rd St', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (45, '239 Greene St', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (46, '433 Greene St', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (47, '5 Washington Square S', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (48, '120 E 12th St', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (49, '249 Sullivan St', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (50, '715 Broadway', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (51, '1 Washington Mews', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (52, '80 Washington Square E', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (53, '310 3rd Ave', '', 'New York', 'NY', '10010');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (54, '636 Greenwich St', '', 'New York', 'NY', '10014');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (55, '726 Broadway', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (56, '44 W 4th St', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (57, '44 W 4th St', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (58, '50 Washington Square S', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (59, '246 Greene St', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (60, '60 Washington Square S', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (61, '16 Washington Mews', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (62, '80 Lafayette St', '', 'New York', 'NY', '10013');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (63, '550 1st Ave', '', 'New York', 'NY', '10016');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (64, '33 Washington Square W', '', 'New York', 'NY', '10011');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (65, '240 Mercer St', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (66, '4 Washington Pl', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (67, '101 Johnson St', '', 'Brooklyn', 'NY', '11201');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (68, '140 E 14th St', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (69, '26 Washington Pl', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (70, '32 Washington Pl', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (71, '53 Washington Square S', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (72, '7 Washington Pl', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (73, '233 W 42nd St', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (74, '25 Waverly Pl', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (75, '433 1st Ave', '', 'New York', 'NY', '10010');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (76, '50 W 4th St', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (77, '100 Bleecker St', '', 'New York', 'NY', '10013');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (78, '35 W 4th St', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (79, '40 W 4th St', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (80, '238 1st Ave', '', 'New York', 'NY', '10009');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (81, '690 E 14th St', '', 'New York', 'NY', '10009');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (82, '339 1st Ave', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (83, '610 E 20th St', '', 'New York', 'NY', '10009');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (84, '22 Washington Square N', '', 'New York', 'NY', '10011');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (85, '40 W 4th St', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (86, '18 Waverly Pl', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (87, '853 Broadway', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (88, '334 E 25th St', '', 'New York', 'NY', '10010');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (89, '120 E 14th St', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (90, '40 Washington Square S', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (91, '4 Washington Square N', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (92, '24 Waverly Pl', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (93, '251 Mercer St', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (94, '5 University Pl', '', 'New York', 'NY', '10003');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (95, '136 W 3rd St', '', 'New York', 'NY', '10012');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (96, '133 Macdougal St', '', 'New York', 'NY', '10012');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (1, 'Wall@example.com', 'Wall!', 1, 'USER', 1, 'Wall@example.com', 'Brenton', 'Wall', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (2, 'Finney@example.com', 'Finney!', 1, 'USER', 2, 'Finney@example.com', 'Myles', 'Finney', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (3, 'Desimone@example.com', 'Desimone!', 1, 'USER', 3, 'Desimone@example.com', 'Red', 'Desimone', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (4, 'Poirier@example.com', 'Poirier!', 1, 'USER', 4, 'Poirier@example.com', 'Juancarlos', 'Poirier', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (5, 'Call@example.com', 'Call!', 1, 'USER', 5, 'Call@example.com', 'Brian', 'Call', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (6, 'Keen@example.com', 'Keen!', 1, 'USER', 6, 'Keen@example.com', 'Krysta', 'Keen', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (7, 'Bergeron@example.com', 'Bergeron!', 0, 'USER', 7, 'Bergeron@example.com', 'Darian', 'Bergeron', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (8, 'Glasgow@example.com', 'Glasgow!', 0, 'USER', 8, 'Glasgow@example.com', 'Pranav', 'Glasgow', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (9, 'Eaton@example.com', 'Eaton!', 1, 'USER', 9, 'Eaton@example.com', 'Sidney', 'Eaton', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (10, 'Blanton@example.com', 'Blanton!', 1, 'USER', 10, 'Blanton@example.com', 'Josefina', 'Blanton', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (11, 'Ashworth@example.com', 'Ashworth!', 1, 'USER', 11, 'Ashworth@example.com', 'Jenifer', 'Ashworth', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (12, 'Engel@example.com', 'Engel!', 1, 'USER', 12, 'Engel@example.com', 'Karlee', 'Engel', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (13, 'Russ@example.com', 'Russ!', 1, 'USER', 13, 'Russ@example.com', 'Alani', 'Russ', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (14, 'Kidd@example.com', 'Kidd!', 1, 'USER', 14, 'Kidd@example.com', 'Amiyah', 'Kidd', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (15, 'Mallory@example.com', 'Mallory!', 1, 'USER', 15, 'Mallory@example.com', 'Trae', 'Mallory', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (16, 'Mauldin@example.com', 'Mauldin!', 1, 'USER', 16, 'Mauldin@example.com', 'Kalie', 'Mauldin', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (17, 'Baez@example.com', 'Baez!', 1, 'USER', 17, 'Baez@example.com', 'Keegan', 'Baez', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (18, 'Markham@example.com', 'Markham!', 1, 'USER', 18, 'Markham@example.com', 'Devonta', 'Markham', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (19, 'Jean@example.com', 'Jean!', 1, 'USER', 19, 'Jean@example.com', 'Juliann', 'Jean', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (20, 'Wyman@example.com', 'Wyman!', 1, 'USER', 20, 'Wyman@example.com', 'Samson', 'Wyman', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (21, 'Alcantar@example.com', 'Alcantar!', 1, 'USER', 21, 'Alcantar@example.com', 'Michael', 'Alcantar', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (22, 'Coble@example.com', 'Coble!', 1, 'USER', 22, 'Coble@example.com', 'Jeffrey', 'Coble', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (23, 'Godfrey@example.com', 'Godfrey!', 1, 'USER', 23, 'Godfrey@example.com', 'Yoselin', 'Godfrey', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (24, 'Shirley@example.com', 'Shirley!', 1, 'USER', 24, 'Shirley@example.com', 'Amari', 'Shirley', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (25, 'Evans@example.com', 'Evans!', 1, 'USER', 25, 'Evans@example.com', 'Tracy', 'Evans', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (26, 'Covarrubias@example.com', 'Covarrubias!', 1, 'USER', 26, 'Covarrubias@example.com', 'Lisette', 'Covarrubias', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (27, 'Gallardo@example.com', 'Gallardo!', 1, 'USER', 27, 'Gallardo@example.com', 'Dora', 'Gallardo', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (28, 'Dugger@example.com', 'Dugger!', 1, 'USER', 28, 'Dugger@example.com', 'Myia', 'Dugger', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (29, 'Bair@example.com', 'Bair!', 1, 'USER', 29, 'Bair@example.com', 'Yasmin', 'Bair', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (30, 'Contreras2@example.com', 'Contreras!', 1, 'USER', 30, 'Contreras2@example.com', 'Lacy', 'Contreras', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (31, 'Odom@example.com', 'Odom!', 1, 'USER', 31, 'Odom@example.com', 'Ian', 'Odom', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (32, 'Gruber@example.com', 'Gruber!', 1, 'USER', 32, 'Gruber@example.com', 'Kevin', 'Gruber', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (33, 'DeJesus@example.com', 'DeJesus!', 0, 'USER', 33, 'DeJesus@example.com', 'Thaddeus', 'DeJesus', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (34, 'Contreras@example.com', 'Contreras!', 1, 'USER', 54, 'Contreras@example.com', 'Johnnie', 'Contreras', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (35, 'Colon@example.com', 'Colon!', 0, 'USER', 35, 'Colon@example.com', 'Brooke', 'Colon', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (36, 'Andersen@example.com', 'Andersen!', 1, 'USER', 36, 'Andersen@example.com', 'Saul', 'Andersen', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (37, 'Wilhelm@example.com', 'Wilhelm!', 1, 'USER', 37, 'Wilhelm@example.com', 'Corrine', 'Wilhelm', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (38, 'Rhoads@example.com', 'Rhoads!', 1, 'USER', 38, 'Rhoads@example.com', 'Caitlynn', 'Rhoads', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (39, 'Combs@example.com', 'Combs!', 1, 'USER', 39, 'Combs@example.com', 'Evan', 'Combs', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (40, 'Longo@example.com', 'Longo!', 1, 'USER', 40, 'Longo@example.com', 'Tiana', 'Longo', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (41, 'Rowell@example.com', 'Rowell!', 1, 'USER', 41, 'Rowell@example.com', 'Yaritza', 'Rowell', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (42, 'Caruso@example.com', 'Caruso!', 1, 'USER', 42, 'Caruso@example.com', 'Wilson', 'Caruso', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (43, 'Coy@example.com', 'Coy!', 1, 'USER', 43, 'Coy@example.com', 'Ester', 'Coy', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (44, 'Newell@example.com', 'Newell!', 1, 'USER', 44, 'Newell@example.com', 'Cailin', 'Newell', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (45, 'Winslow@example.com', 'Winslow!', 1, 'USER', 45, 'Winslow@example.com', 'Jesse', 'Winslow', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (46, 'Armendariz@example.com', 'Armendariz!', 1, 'USER', 46, 'Armendariz@example.com', 'Dwight', 'Armendariz', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (47, 'Echols@example.com', 'Echols!', 1, 'USER', 47, 'Echols@example.com', 'Juancarlos', 'Echols', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (48, 'Mazur@example.com', 'Mazur!', 1, 'USER', 48, 'Mazur@example.com', 'Alexandria', 'Mazur', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (49, 'Trahan@example.com', 'Trahan!', 1, 'USER', 49, 'Trahan@example.com', 'Agustin', 'Trahan', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (50, 'Talbert@example.com', 'Talbert!', 1, 'USER', 50, 'Talbert@example.com', 'Alvin', 'Talbert', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (51, 'Ratcliff@example.com', 'Ratcliff!', 1, 'USER', 51, 'Ratcliff@example.com', 'Stacey', 'Ratcliff', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (52, 'Culpepper@example.com', 'Culpepper!', 1, 'USER', 52, 'Culpepper@example.com', 'Maximilian', 'Culpepper', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (53, 'Slaughter@example.com', 'Slaughter!', 1, 'USER', 53, 'Slaughter@example.com', 'Carlie', 'Slaughter', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (54, 'Haddad@example.com', 'Haddad!', 1, 'USER', 54, 'Haddad@example.com', 'Gary', 'Haddad', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (55, 'Busby@example.com', 'Busby!', 1, 'USER', 55, 'Busby@example.com', 'Theodore', 'Busby', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (56, 'Rosa@example.com', 'Rosa!', 1, 'USER', 56, 'Rosa@example.com', 'Zackery', 'Rosa', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (57, 'McGowan@example.com', 'McGowan!', 1, 'USER', 57, 'McGowan@example.com', 'Adamaris', 'McGowan', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (58, 'Curry@example.com', 'Curry!', 1, 'USER', 58, 'Curry@example.com', 'Caleb', 'Curry', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (59, 'Royer@example.com', 'Royer!', 1, 'USER', 59, 'Royer@example.com', 'Jalynn', 'Royer', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (60, 'Martens@example.com', 'Martens!', 1, 'USER', 60, 'Martens@example.com', 'Odalys', 'Martens', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (61, 'Law@example.com', 'Law!', 1, 'USER', 61, 'Law@example.com', 'Shea', 'Law', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (62, 'Archer@example.com', 'Archer!', 1, 'USER', 62, 'Archer@example.com', 'Eddy', 'Archer', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (63, 'Russo@example.com', 'Russo!', 1, 'USER', 63, 'Russo@example.com', 'Grady', 'Russo', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (64, 'Mobley@example.com', 'Mobley!', 1, 'USER', 64, 'Mobley@example.com', 'Brenna', 'Mobley', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (65, 'Bronson@example.com', 'Bronson!', 1, 'USER', 65, 'Bronson@example.com', 'Cade', 'Bronson', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (66, 'Brinkley@example.com', 'Brinkley!', 1, 'USER', 66, 'Brinkley@example.com', 'Jacey', 'Brinkley', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (67, 'Langley@example.com', 'Langley!', 1, 'USER', 67, 'Langley@example.com', 'Sarina', 'Langley', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (68, 'Rosas@example.com', 'Rosas!', 1, 'USER', 68, 'Rosas@example.com', 'Amari', 'Rosas', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (69, 'Ayala@example.com', 'Ayala!', 1, 'USER', 69, 'Ayala@example.com', 'Nyah', 'Ayala', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (70, 'Wimberly@example.com', 'Wimberly!', 1, 'USER', 70, 'Wimberly@example.com', 'Draven', 'Wimberly', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (71, 'Burks@example.com', 'Burks!', 1, 'USER', 71, 'Burks@example.com', 'Dillion', 'Burks', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (72, 'Liu@example.com', 'Liu!', 1, 'USER', 72, 'Liu@example.com', 'Mike', 'Liu', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (73, 'Albers@example.com', 'Albers!', 1, 'USER', 73, 'Albers@example.com', 'Destinee', 'Albers', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (74, 'Bradshaw@example.com', 'Bradshaw!', 1, 'USER', 74, 'Bradshaw@example.com', 'Julie', 'Bradshaw', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (75, 'Eng@example.com', 'Eng!', 1, 'USER', 75, 'Eng@example.com', 'Antonio', 'Eng', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (76, 'Roy@example.com', 'Roy!', 1, 'USER', 76, 'Roy@example.com', 'Santos', 'Roy', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (77, 'Platt@example.com', 'Platt!', 1, 'USER', 77, 'Platt@example.com', 'Bronson', 'Platt', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (78, 'Parnell@example.com', 'Parnell!', 1, 'USER', 78, 'Parnell@example.com', 'Ricky', 'Parnell', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (79, 'Still@example.com', 'Still!', 1, 'USER', 79, 'Still@example.com', 'Jimmy', 'Still', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (80, 'Haskell@example.com', 'Haskell!', 1, 'USER', 80, 'Haskell@example.com', 'Deondre', 'Haskell', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (81, 'Hook@example.com', 'Hook!', 1, 'USER', 81, 'Hook@example.com', 'Nicholas', 'Hook', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (82, 'Paz@example.com', 'Paz!', 1, 'USER', 82, 'Paz@example.com', 'Javion', 'Paz', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (83, 'Ferraro@example.com', 'Ferraro!', 1, 'USER', 83, 'Ferraro@example.com', 'Gladys', 'Ferraro', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (84, 'Wall2@example.com', 'Wall!', 1, 'USER', 84, 'Wall2@example.com', 'Yamilet', 'Wall', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (85, 'Chappell@example.com', 'Chappell!', 1, 'USER', 85, 'Chappell@example.com', 'Vladimir', 'Chappell', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (86, 'Silverman@example.com', 'Silverman!', 1, 'USER', 86, 'Silverman@example.com', 'Dalia', 'Silverman', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (87, 'Willoughby@example.com', 'Willoughby!', 1, 'USER', 87, 'Willoughby@example.com', 'Ken', 'Willoughby', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (88, 'Brackett@example.com', 'Brackett!', 1, 'USER', 88, 'Brackett@example.com', 'Cheryl', 'Brackett', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (89, 'Vega@example.com', 'Vega!', 1, 'USER', 89, 'Vega@example.com', 'Cristofer', 'Vega', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (90, 'Thorpe@example.com', 'Thorpe!', 1, 'USER', 90, 'Thorpe@example.com', 'Makena', 'Thorpe', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (91, 'Lennon@example.com', 'Lennon!', 1, 'USER', 91, 'Lennon@example.com', 'Lewis', 'Lennon', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (92, 'Stark@example.com', 'Stark!', 1, 'USER', 92, 'Stark@example.com', 'Lane', 'Stark', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (93, 'Bohannon@example.com', 'Bohannon!', 1, 'USER', 93, 'Bohannon@example.com', 'Daja', 'Bohannon', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (94, 'Pearce@example.com', 'Pearce!', 1, 'USER', 94, 'Pearce@example.com', 'Kade', 'Pearce', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (95, 'Tuttle@example.com', 'Tuttle!', 1, 'USER', 95, 'Tuttle@example.com', 'Hunter', 'Tuttle', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (96, 'See@example.com', 'See!', 1, 'USER', 24, 'See@example.com', 'Tessa', 'See', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (97, 'Olivarez@example.com', 'Olivarez!', 1, 'USER', 8, 'Olivarez@example.com', 'Anya', 'Olivarez', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (98, 'Heim@example.com', 'Heim!', 1, 'USER', 44, 'Heim@example.com', 'Charlie', 'Heim', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (99, 'Bourne@example.com', 'Bourne!', 1, 'USER', 32, 'Bourne@example.com', 'Yaquelin', 'Bourne', '', '');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (100, 'Stovall@example.com', 'Stovall!', 1, 'USER', 56, 'Stovall@example.com', 'Jacqueline', 'Stovall', '', '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `author`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (1, 'Peter', 'Ackroyd');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (2, 'Amir', 'Aczel');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (3, 'Jeffery', 'Archer');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (4, 'Richard', 'Bach');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (5, 'Michael', 'Baz-Zohar');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (6, 'BBC', 'BBC');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (7, 'E. T.', 'Bell');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (8, 'Joe', 'Biden');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (9, 'David', 'Bodanis');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (10, 'Gary', 'Bradsky');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (11, 'Braithwaite', 'Braithwaite');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (12, 'Dan', 'Brown');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (13, 'Albert', 'Camus');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (14, 'Fritjof', 'Capra');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (15, 'Drew', 'Conway');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (16, 'Jim', 'Corbett');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (17, 'Thomas', 'Cormen');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (18, 'Michael', 'Crichton');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (19, 'William', 'Dalrymple');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (20, 'Richard', 'Dawkins');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (21, 'Siddhartha', 'Deb');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (22, 'P. L.', 'Deshpande');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (23, 'Keith', 'Devlin');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (24, 'Charles', 'Dickens');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (25, 'Peter', 'Dickinson');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (26, 'Fyodor', 'Dostoevsky');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (27, 'Allen', 'Downey');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (28, 'Arthur Conan', 'Doyle');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (29, 'Peter', 'Drucker');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (30, 'Stephen', 'Dubner');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (31, 'Hart', 'Duda');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (32, 'Will', 'Durant');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (33, 'Gerald', 'Durrell');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (34, 'Bob', 'Dylan');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (35, 'Steve', 'Eddins');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (36, 'Abraham', 'Eraly');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (37, 'Richard', 'Feynman');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (38, 'Robert', 'Fisk');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (39, 'Ken', 'Follett');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (40, 'John', 'Foreman');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (41, 'David', 'Forsyth');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (42, 'Sergio', 'Franco');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (43, 'Thomas', 'Friedman');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (44, 'Earle Stanley', 'Gardner');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (45, 'Sanjay', 'Garg');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (46, 'Amitav', 'Ghosh');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (47, 'James', 'Gleick');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (48, 'Richard', 'Gordon');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (49, 'Jaideva', 'Goswami');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (50, 'W. H.', 'Greene');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (51, 'John', 'Grisham');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (52, 'Madan', 'Gupta');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (53, 'Amartya', 'Sen');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (54, 'Frank', 'Shih');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (55, 'Nate', 'Silver');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (56, 'Simon', 'Singh');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (57, 'Adam', 'Smith');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (58, 'Sorabjee', 'Sorabjee');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (59, 'John', 'Steinbeck');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (60, 'Alfred', 'Stonier');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (61, 'Jonathan', 'Stroud');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (62, 'Gerald', 'Sussman');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (63, 'Andrew', 'Tanenbaum');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (64, 'Terence', 'Tao');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (65, 'Schilling', 'Taub');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (66, 'Shashi', 'Tharoor');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (67, 'Joy', 'Thomas');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (68, 'Vladimir', 'Vapnik');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (69, 'Jules', 'Verne');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (70, 'Cedric', 'Villani');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (71, 'Kurt', 'Vonnegut');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (72, 'H. G.', 'Wells');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (73, 'Morris', 'West');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (74, 'Bob', 'Woodward');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (75, 'Hussain', 'Zaidi');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (76, 'Sunita', 'Deshpande');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (77, 'Frederick', 'Forsyth');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (78, 'Lorraine', 'Hansberry');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (79, 'Sam', 'Harris');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (80, 'Stephen', 'Hawking');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (81, 'Simon', 'Haykin');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (82, 'Werner', 'Heisenberg');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (83, 'Joseph', 'Heller');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (84, 'Ernest', 'Hemingway');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (85, 'Adolph', 'Hitler');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (86, 'Victor', 'Hugo');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (87, 'Samuel', 'Huntington');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (88, 'Klayton', 'Hutchins');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (89, 'Aldous', 'Huxley');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (90, 'Lee', 'Iacoca');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (91, 'James', 'James');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (92, 'Phillip', 'Janert');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (93, 'Frank', 'Kafka');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (94, 'V.P.', 'Kale');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (95, 'Yashwant', 'Kanetkar');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (96, 'Kautiyla', 'Kautiyla');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (97, 'Maria', 'Konnikova');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (98, 'Dominique', 'Lapierre');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (99, 'Steig', 'Larsson');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (100, 'Machiavelli', 'Machiavelli');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (101, 'William', 'Maugham');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (102, 'Ronald', 'McDonald');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (103, 'Wes', 'McKinney');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (104, 'V.P.', 'Menon');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (105, 'Leonard', 'Mlodinow');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (106, 'Ned', 'Mohan');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (107, 'V.S.', 'Naipaul');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (108, 'Nariman', 'Nariman');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (109, 'Kuldip', 'Nayar');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (110, 'Jawaharlal', 'Nehru');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (111, 'Robert', 'Nisbet');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (112, 'Andy', 'Oram');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (113, 'George', 'Orwell');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (114, 'Palkhivala', 'Palkhivala');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (115, 'Randy', 'Pausch');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (116, 'Robert', 'Pirsig');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (117, 'Edgar Allen', 'Poe');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (118, 'John', 'Pratt');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (119, 'Cullen', 'Rafferty');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (120, 'Ayn', 'Rand');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (121, 'Sudhanshu', 'Ranjan');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (122, 'Muhammad', 'Rashid');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (123, 'Eric', 'Raymond');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (124, 'J.K.', 'Rowling');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (125, 'Bertrand', 'Russell');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (126, 'Alex', 'Rutherford');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (127, 'Carl', 'Sagan');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (128, 'Edward', 'Said');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (129, 'Jean', 'Sassoon');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (130, 'Sebastian', 'Gutierrez');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (131, 'Tate', 'Smith');

COMMIT;


-- -----------------------------------------------------
-- Data for table `book`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (1, 'History of England, Foundation', '', 1, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (2, 'Artist and the Mathematician, The', '', 2, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (3, 'False Impressions', '', 3, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (4, 'Prisoner of Birth, A', '', 3, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (5, 'One', '', 4, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (6, 'Mossad', '', 5, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (7, 'Complete Mastermind, The', '', 6, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (8, 'Men of Mathematics', '', 7, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (9, 'Final Crisis', '', 8, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (10, 'Electric Universe', '', 9, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (11, 'Learning OpenCV', '', 10, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (12, 'To Sir With Love', '', 11, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (13, 'Angels & Demons', '', 12, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (15, 'Outsider, The', '', 13, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (16, 'Tao of Physics, The', '', 14, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (17, 'Hidden Connections, The', '', 14, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (18, 'Uncommon Wisdom', '', 14, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (19, 'Machine Learning for Hackers', '', 15, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (20, 'Jim Corbett Omnibus', '', 16, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (21, 'Introduction to Algorithms', '', 17, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (22, 'Jurassic Park', '', 18, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (23, 'Last Mughal, The', '', 19, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (24, 'Beyond the Three Seas', '', 19, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (25, 'City of Djinns', '', 19, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (26, 'Oxford book of Modern Science Writing', '', 20, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (27, 'Beautiful and the Damned, The', '', 21, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (28, 'Asami Asami', '', 22, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (29, 'Ahe Manohar Tari', '', 76, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (30, 'Radiowaril Bhashane & Shrutika', '', 22, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (31, 'Gun Gayin Awadi', '', 22, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (32, 'Aghal Paghal', '', 22, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (33, 'Apulki', '', 22, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (34, 'Char Shabda', '', 22, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (35, 'Vyakti ani Valli', '', 22, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (36, 'Numbers Behind Numb3rs, The', '', 23, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (37, 'Christmas Carol, A', '', 24, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (38, 'Ropemaker, The', '', 25, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (39, 'Crime and Punishment', '', 26, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (40, 'Idiot, The', '', 26, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (41, 'Think Complexity', '', 27, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (42, 'Complete Sherlock Holmes, The - Vol I', '', 28, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (43, 'Complete Sherlock Holmes, The - Vol II', '', 28, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (44, 'New Markets & Other Essays', '', 29, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (45, 'Age of Discontuinity, The', '', 29, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (46, 'Superfreakonomics', '', 30, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (47, 'Freakonomics', '', 30, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (48, 'Pattern Classification', '', 31, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (49, 'Story of Philosophy, The', '', 32, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (50, 'Rosy is My Relative', '', 33, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (51, 'Dylan on Dylan', '', 34, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (52, 'Image Processing with MATLAB', '', 35, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (53, 'Age of Wrath, The', '', 36, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (54, 'Surely You\'re Joking Mr Feynman', '', 37, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (55, 'Great War for Civilization, The', '', 38, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (56, 'Age of the Warrior, The', '', 38, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (57, 'Pillars of the Earth, The', '', 39, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (58, 'Data Smart', '', 40, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (59, 'Veteran, The', '', 77, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (60, 'Computer Vision, A Modern Approach', '', 41, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (61, 'Phantom of Manhattan, The', '', 77, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (62, 'Deceiver, The', '', 77, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (63, 'Design with OpAmps', '', 42, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (64, 'From Beirut to Jerusalem', '', 43, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (65, 'Case of the Lame Canary, The', '', 44, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (66, 'Maqta-e-Ghalib', '', 45, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (67, 'Sea of Poppies', '', 46, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (68, 'Information, The', '', 47, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (69, 'Doctor in the Nude', '', 48, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (70, 'Doctor on the Brain', '', 48, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (71, 'Fundamentals of Wavelets', '', 49, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (72, 'Econometric Analysis', '', 50, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (73, 'Brethren, The', '', 51, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (74, 'Soft Computing & Intelligent Systems', '', 52, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (75, 'Raisin in the Sun, A', '', 78, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (76, 'Free Will', '', 79, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (77, 'God Created the Integers', '', 80, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (78, 'Theory of Everything, The', '', 80, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (79, 'Neural Networks', '', 81, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (80, 'Physics & Philosophy', '', 82, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (81, 'Catch 22', '', 83, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (82, 'Farewell to Arms, A', '', 84, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (83, 'Mein Kampf', '', 85, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (84, 'Hunchback of Notre Dame, The', '', 86, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (85, 'Clash of Civilizations and Remaking of the World Order', '', 87, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (86, 'Flashpoint', '', 88, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (87, 'Eyeless in Gaza', '', 89, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (88, 'Talking Straight', '', 90, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (89, 'Batatyachi Chal', '', 91, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (90, 'Hafasavnuk', '', 91, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (91, 'Urlasurla', '', 91, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (92, 'Data Analysis with Open Source Tools', '', 92, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (93, 'Trial, The', '', 93, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (94, 'Manasa', '', 94, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (95, 'Let Us C', '', 95, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (96, 'Pointers in C', '', 95, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (97, 'Arthashastra, The', '', 96, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (98, 'How to Think Like Sherlock Holmes', '', 97, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (99, 'O Jerusalem!', '', 98, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (100, 'City of Joy, The', '', 98, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (101, 'Freedom at Midnight', '', 98, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (102, 'Girl with the Dragon Tattoo', '', 99, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (103, 'Girl who kicked the Hornet\'s Nest', '', 99, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (104, 'Girl who played with Fire', '', 99, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (105, 'Prince, The', '', 100, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (106, 'Maugham\'s Collected Short Stories, Vol 3', '', 101, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (107, 'Ashenden of The British Agent', '', 101, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (108, 'Moon and Sixpence, The', '', 101, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (109, 'Trembling of a Leaf, The', '', 101, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (110, 'Superman Earth One - 1', '', 102, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (111, 'Superman Earth One - 2', '', 102, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (112, 'Justice League: Throne of Atlantis', '', 102, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (113, 'Justice League: The Villain\'s Journey', '', 102, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (114, 'Death of Superman, The', '', 102, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (115, 'History of the DC Universe', '', 102, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (116, 'Batman: The Long Halloween', '', 102, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (117, 'Python for Data Analysis', '', 103, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (118, 'Integration of the Indian States', '', 104, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (119, 'Drunkard\'s Walk, The', '', 105, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (120, 'Power Electronics - Mohan', '', 106, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (121, 'In a Free State', '', 107, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (122, 'Half A Life', '', 107, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (123, 'India\'s Legal System', '', 108, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (124, 'Scoop!', '', 109, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (125, 'Discovery of India, The', '', 110, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (126, 'Data Mining Handbook', '', 111, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (127, 'Making Software', '', 112, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (128, 'Down and Out in Paris & London', '', 113, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (129, 'Animal Farm', '', 113, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (130, 'We the People', '', 114, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (131, 'We the Nation', '', 114, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (132, 'Last Lecture, The', '', 115, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (133, 'Zen & The Art of Motorcycle Maintenance', '', 116, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (134, 'Tales of Mystery and Imagination', '', 117, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (135, 'Statistical Decision Theory\'', '', 118, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (136, 'Batman Earth One', '', 119, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (137, 'Return of the Primitive', '', 120, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (138, 'We the Living', '', 120, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (139, 'Ayn Rand Answers', '', 120, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (140, 'Philosophy: Who Needs It', '', 120, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (141, 'World\'s Great Thinkers, The', '', 120, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (142, 'Justice, Judiciary and Democracy', '', 121, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (143, 'Power Electronics - Rashid', '', 122, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (144, 'Cathedral and the Bazaar, The', '', 123, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (145, 'Tales of Beedle the Bard', '', 124, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (146, 'On Education', '', 125, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (147, 'History of Western Philosophy', '', 125, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (148, 'Unpopular Essays', '', 125, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (149, 'Empire of the Mughal - The Tainted Throne', '', 126, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (150, 'Empire of the Mughal - Brothers at War', '', 126, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (151, 'Empire of the Mughal - Ruler of the World', '', 126, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (152, 'Empire of the Mughal - The Serpent\'s Tooth', '', 126, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (153, 'Empire of the Mughal - Raiders from the North', '', 126, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (154, 'Broca\'s Brain', '', 127, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (155, 'Orientalism', '', 128, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (156, 'More Tears to Cry', '', 129, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (157, 'Data Scientists at Work', '', 130, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (158, 'Argumentative Indian, The', '', 53, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (159, 'Idea of Justice, The', '', 53, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (160, 'Identity & Violence', '', 53, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (161, 'Rationality & Freedom', '', 53, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (162, 'Image Processing & Mathematical Morphology', '', 54, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (163, 'Signal and the Noise, The', '', 55, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (164, 'Simpsons & Their Mathematical Secrets', '', 56, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (165, 'Code Book, The', '', 56, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (166, 'Wealth of Nations, The', '', 57, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (167, 'Killing Joke, The', '', 131, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (168, 'Crisis on Infinite Earths', '', 131, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (169, 'Courtroom Genius, The', '', 58, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (170, 'Russian Journal, A', '', 59, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (171, 'Journal of a Novel', '', 59, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (172, 'Once There Was a War', '', 59, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (173, 'Moon is Down, The', '', 59, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (174, 'Winter of Our Discontent, The', '', 59, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (175, 'Burning Bright', '', 59, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (176, 'Life in Letters, A', '', 59, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (177, 'Grapes of Wrath, The', '', 59, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (178, 'Textbook of Economic Theory', '', 60, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (179, 'Amulet of Samarkand, The', '', 61, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (180, 'Structure & Interpretation of Computer Programs', '', 62, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (181, 'Data Structures Using C & C++', '', 63, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (182, 'Analysis, Vol I', '', 64, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (183, 'Structure and Randomness', '', 64, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (184, 'Principles of Communication Systems', '', 65, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (185, 'India from Midnight to Milennium', '', 66, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (186, 'Great Indian Novel, The', '', 66, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (187, 'Bookless in Baghdad', '', 66, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (188, 'Elements of Information Theory', '', 67, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (189, 'Nature of Statistical Learning Theory, The', '', 68, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (190, 'Statistical Learning Theory', '', 68, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (191, '20000 Leagues Under the Sea', '', 69, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (192, 'Birth of a Theorem', '', 70, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (193, 'Slaughterhouse Five', '', 71, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (194, 'New Machiavelli, The', '', 72, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (195, 'Short History of the World, A', '', 72, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (196, 'Devil\'s Advocate, The', '', 73, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (197, 'All the President\'s Men', '', 74, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (198, 'Veil: Secret Wars of the CIA', '', 74, '');
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (199, 'Dongri to Dubai', '', 75, '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `genre`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `genre` (`id`, `name`, `description`, `image`) VALUES (1, 'Signal Processing', 'Processing signals', NULL);
INSERT INTO `genre` (`id`, `name`, `description`, `image`) VALUES (2, 'Data Science', 'The science of data', NULL);
INSERT INTO `genre` (`id`, `name`, `description`, `image`) VALUES (3, 'History', 'History Description', NULL);
INSERT INTO `genre` (`id`, `name`, `description`, `image`) VALUES (4, 'Fiction', 'make believe', NULL);
INSERT INTO `genre` (`id`, `name`, `description`, `image`) VALUES (5, 'Biography', 'about people written by other people', NULL);
INSERT INTO `genre` (`id`, `name`, `description`, `image`) VALUES (6, 'Science', 'Sciencey Science stuff', NULL);
INSERT INTO `genre` (`id`, `name`, `description`, `image`) VALUES (7, 'Mathematics', 'Numbers and whatnot', NULL);
INSERT INTO `genre` (`id`, `name`, `description`, `image`) VALUES (8, 'Computer Science', 'Who cares', NULL);
INSERT INTO `genre` (`id`, `name`, `description`, `image`) VALUES (9, 'Philosophy', 'Everyone cares', NULL);
INSERT INTO `genre` (`id`, `name`, `description`, `image`) VALUES (10, 'Comic', 'Comics are for adults too', NULL);
INSERT INTO `genre` (`id`, `name`, `description`, `image`) VALUES (11, 'Non-Fiction', 'Real or Fake', NULL);
INSERT INTO `genre` (`id`, `name`, `description`, `image`) VALUES (12, 'Psychology', 'What do you think?', NULL);
INSERT INTO `genre` (`id`, `name`, `description`, `image`) VALUES (13, 'Economics', 'Don\'t even bother', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `book_condition`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `book_condition` (`id`, `name`, `condition_desc`) VALUES (1, 'New', 'Near perfect condition');
INSERT INTO `book_condition` (`id`, `name`, `condition_desc`) VALUES (2, 'Used - Light', 'Lightly used');
INSERT INTO `book_condition` (`id`, `name`, `condition_desc`) VALUES (3, 'Used - Medium', 'some bent corners ');
INSERT INTO `book_condition` (`id`, `name`, `condition_desc`) VALUES (4, 'Used - Heavy', 'Barely holding on');

COMMIT;


-- -----------------------------------------------------
-- Data for table `shelf_book`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (1, 1, 1, 1, 1, 0, NULL);
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (2, 1, 1, 1, 2, 0, NULL);
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (3, 1, 2, 1, 1, 0, NULL);
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (4, 1, 2, 2, 3, 0, NULL);
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (5, 1, 3, 2, 1, 0, NULL);
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (6, 1, 1, 1, 3, 0, NULL);
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (7, 1, 3, 1, 2, 0, NULL);
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (8, 1, 4, 1, 2, 0, NULL);
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (9, 1, 5, 1, 2, 0, NULL);
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (10, 1, 2, 1, 2, 0, NULL);
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (11, 1, 6, 1, 3, 0, NULL);
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (12, 1, 4, 1, 3, 0, NULL);
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (13, 1, 5, 1, 4, 0, NULL);
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (14, 1, 5, 1, 6, 0, NULL);
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (15, 1, 7, 1, 2, 0, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `book_has_genre`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (1, 1);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (2, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (3, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (4, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (5, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (6, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (7, 12);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (8, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (9, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (10, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (11, 9);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (12, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (13, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (15, 1);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (16, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (17, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (18, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (19, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (20, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (21, 9);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (22, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (23, 11);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (24, 5);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (25, 7);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (26, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (27, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (28, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (29, 9);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (30, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (31, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (32, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (33, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (34, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (35, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (36, 7);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (37, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (38, 1);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (39, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (40, 10);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (41, 11);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (42, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (43, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (44, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (45, 9);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (46, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (47, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (48, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (49, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (50, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (51, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (52, 7);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (53, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (54, 1);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (55, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (56, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (57, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (58, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (59, 9);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (60, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (61, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (62, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (63, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (64, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (65, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (66, 7);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (67, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (68, 1);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (69, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (70, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (71, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (72, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (73, 9);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (74, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (75, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (76, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (77, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (78, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (79, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (80, 7);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (81, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (82, 1);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (83, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (84, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (85, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (86, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (87, 9);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (88, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (89, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (90, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (91, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (92, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (93, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (94, 7);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (95, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (96, 1);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (97, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (98, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (99, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (100, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (101, 9);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (102, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (103, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (104, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (105, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (106, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (107, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (108, 7);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (109, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (110, 1);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (111, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (112, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (113, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (114, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (115, 9);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (116, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (117, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (118, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (119, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (120, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (121, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (122, 7);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (123, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (124, 1);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (125, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (126, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (127, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (128, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (129, 9);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (130, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (131, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (132, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (133, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (134, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (135, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (136, 7);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (137, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (138, 1);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (139, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (140, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (141, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (142, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (143, 9);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (144, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (145, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (146, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (147, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (148, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (149, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (150, 7);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (151, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (152, 1);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (153, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (154, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (155, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (156, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (157, 9);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (158, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (159, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (160, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (161, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (162, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (163, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (164, 7);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (165, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (166, 1);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (167, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (168, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (169, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (170, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (171, 9);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (172, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (173, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (174, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (175, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (176, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (177, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (178, 7);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (179, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (180, 1);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (181, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (182, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (183, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (184, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (185, 9);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (186, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (187, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (188, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (189, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (190, 4);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (191, 6);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (192, 7);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (193, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (194, 1);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (195, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (196, 8);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (197, 2);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (198, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (199, 10);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (199, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (56, 3);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (23, 9);
INSERT INTO `book_has_genre` (`book_id`, `genre_id`) VALUES (100, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `comment` (`id`, `comment`, `user_id`, `book_id`, `comment_date`, `in_reply_to_id`) VALUES (1, 'Looking for some books', 1, 1, '2022-10-21', NULL);
INSERT INTO `comment` (`id`, `comment`, `user_id`, `book_id`, `comment_date`, `in_reply_to_id`) VALUES (2, 'I have some books if youre looking', 2, 1, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (5, 1, 1, 'it was really good');
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (4, 1, 2, 'ehhhhhh it wasnt great');
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (4, 1, 3, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (2, 1, 4, 'waste of time');
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (5, 1, 5, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (4, 1, 6, 'not bad');
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (3, 2, 1, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (4, 2, 2, 'good book');
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (5, 2, 3, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (4, 2, 4, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (3, 2, 5, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (5, 2, 6, 'Cant wait for the sequel');
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (3, 3, 1, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (4, 3, 2, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (5, 3, 3, 'Fantastic');
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (2, 3, 4, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (3, 3, 5, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (4, 3, 6, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (3, 4, 1, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (4, 4, 2, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (5, 4, 3, 'good stuff');
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (2, 4, 4, 'Terrible');
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (4, 4, 5, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (3, 4, 6, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (5, 5, 1, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (5, 5, 2, 'John dies in the end');
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (4, 5, 3, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (4, 5, 4, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (5, 5, 5, NULL);
INSERT INTO `rating` (`rating`, `book_id`, `user_id`, `rating_comment`) VALUES (5, 5, 6, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `checkout`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `checkout` (`id`, `user_id`, `shelf_book_id`, `request_date`, `return_date`, `request_message`, `checkout_date`) VALUES (1, 4, 1, '2022-10-27', NULL, '', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_book`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `favorite_book` (`user_id`, `book_id`) VALUES (1, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `genre_has_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `genre_has_user` (`genre_id`, `user_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_has_author`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `user_has_author` (`user_id`, `author_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `currently_reading`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `currently_reading` (`user_id`, `book_id`) VALUES (1, 2);

COMMIT;


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
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_user_address1_idx` (`address_id` ASC),
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
  `title` VARCHAR(45) NOT NULL,
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
  `id` INT NOT NULL,
  `for_borrow` TINYINT NULL DEFAULT 0,
  `book_id` INT NOT NULL,
  `book_condition_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `for_sale` TINYINT NULL DEFAULT 0,
  `sale_price` DECIMAL(5,2) NULL DEFAULT 0,
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
  `comment_date` DATETIME NULL,
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
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (1, '1503 Oak Knoll Lane', NULL, 'Virginia Beach', 'VA', '23464');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip_code`) VALUES (2, '999 Waterside Drive', NULL, 'Norfolk', 'VA', '23508');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (1, 'admin', 'admin', 1, NULL, 1, 'cullen1882@gmail.com', NULL, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `address_id`, `email`, `first_name`, `last_name`, `about_me`, `profile_img`) VALUES (2, 'Cullen1882', 'password', 1, NULL, 2, 'example@hotmail.com', 'Cullen', 'Rafferty', 'things about me', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `author`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (1, 'Jaideva', 'Goswami');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (2, 'John', 'Foreman');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (3, 'Edward', 'Said');
INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES (4, 'V.P.', 'Menon');

COMMIT;


-- -----------------------------------------------------
-- Data for table `book`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (1, 'Fundamentals of Wavelets', NULL, 1, NULL);
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (2, 'Data Smart', NULL, 2, NULL);
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (3, 'Orientalism', NULL, 3, NULL);
INSERT INTO `book` (`id`, `title`, `description`, `author_id`, `cover`) VALUES (4, 'Integration of the Indian States', NULL, 4, NULL);

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

COMMIT;


-- -----------------------------------------------------
-- Data for table `book_condition`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `book_condition` (`id`, `name`, `condition_desc`) VALUES (1, 'New', 'Near perfect condition');
INSERT INTO `book_condition` (`id`, `name`, `condition_desc`) VALUES (2, 'Used - Light', 'Lightly used');

COMMIT;


-- -----------------------------------------------------
-- Data for table `shelf_book`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `shelf_book` (`id`, `for_borrow`, `book_id`, `book_condition_id`, `user_id`, `for_sale`, `sale_price`) VALUES (1, 0, 1, 1, 1, 0, NULL);

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

COMMIT;


-- -----------------------------------------------------
-- Data for table `checkout`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookdb`;
INSERT INTO `checkout` (`id`, `user_id`, `shelf_book_id`, `request_date`, `return_date`, `request_message`, `checkout_date`) VALUES (1, 1, 1, '2022-10-05', '2022-10-14', 'can I borrow this title', '2022-10-11');

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


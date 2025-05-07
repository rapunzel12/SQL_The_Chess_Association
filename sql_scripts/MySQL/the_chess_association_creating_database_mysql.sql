-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema chess
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `chess` ;

-- -----------------------------------------------------
-- Schema chess
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `chess` DEFAULT CHARACTER SET utf8 ;
USE `chess` ;

-- -----------------------------------------------------
-- Table `chess`.`Member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chess`.`Member` ;

CREATE TABLE IF NOT EXISTS `chess`.`Member` (
  `idMember` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `personal_ID_number` VARCHAR(45) NULL,
  `rating` INT NULL,
  `experience` INT NULL,
  PRIMARY KEY (`idMember`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chess`.`Tournament`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chess`.`Tournament` ;

CREATE TABLE IF NOT EXISTS `chess`.`Tournament` (
  `idTournament` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `date` DATE NULL,
  `event_site` VARCHAR(45) NULL,
  PRIMARY KEY (`idTournament`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chess`.`Ches_Game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chess`.`Ches_Game` ;

CREATE TABLE IF NOT EXISTS `chess`.`Ches_Game` (
  `idChes_Game` INT NOT NULL,
  `outcome` VARCHAR(45) NULL,
  PRIMARY KEY (`idChes_Game`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chess`.`Participate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chess`.`Participate` ;

CREATE TABLE IF NOT EXISTS `chess`.`Participate` (
  `idTournament` INT NOT NULL,
  `idMember` INT NOT NULL,
  PRIMARY KEY (`idTournament`, `idMember`),
  CONSTRAINT `fk_Torunament_has_Member_Torunament1`
    FOREIGN KEY (`idTournament`)
    REFERENCES `chess`.`Tournament` (`idTournament`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Torunament_has_Member_Member1`
    FOREIGN KEY (`idMember`)
    REFERENCES `chess`.`Member` (`idMember`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Torunament_has_Member_Member1_idx` ON `chess`.`Participate` (`idMember` ASC);

CREATE INDEX `fk_Torunament_has_Member_Torunament1_idx` ON `chess`.`Participate` (`idTournament` ASC);


-- -----------------------------------------------------
-- Table `chess`.`Award`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chess`.`Award` ;

CREATE TABLE IF NOT EXISTS `chess`.`Award` (
  `idAward` INT NOT NULL,
  `amount_of_money` INT NULL,
  `idTournament` INT NOT NULL,
  `idMember` INT NOT NULL,
  PRIMARY KEY (`idAward`),
  CONSTRAINT `fk_Award_Participate1`
    FOREIGN KEY (`idTournament` , `idMember`)
    REFERENCES `chess`.`Participate` (`idTournament` , `idMember`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Award_Participate1_idx` ON `chess`.`Award` (`idTournament` ASC, `idMember` ASC);


-- -----------------------------------------------------
-- Table `chess`.`Move`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chess`.`Move` ;

CREATE TABLE IF NOT EXISTS `chess`.`Move` (
  `idMove` INT NOT NULL,
  `mark` VARCHAR(45) NULL,
  `number_of_moves` INT NULL,
  `idChes_Game` INT NOT NULL,
  PRIMARY KEY (`idMove`),
  CONSTRAINT `fk_Move_Ches_Game1`
    FOREIGN KEY (`idChes_Game`)
    REFERENCES `chess`.`Ches_Game` (`idChes_Game`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Move_Ches_Game1_idx` ON `chess`.`Move` (`idChes_Game` ASC);


-- -----------------------------------------------------
-- Table `chess`.`Played`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chess`.`Played` ;

CREATE TABLE IF NOT EXISTS `chess`.`Played` (
  `idPlayed` INT NOT NULL,
  `idMove` INT NOT NULL,
  PRIMARY KEY (`idPlayed`, `idMove`),
  CONSTRAINT `fk_Played_Move1`
    FOREIGN KEY (`idMove`)
    REFERENCES `chess`.`Move` (`idMove`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Played_Move1_idx` ON `chess`.`Played` (`idMove` ASC);


-- -----------------------------------------------------
-- Table `chess`.`Possible`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chess`.`Possible` ;

CREATE TABLE IF NOT EXISTS `chess`.`Possible` (
  `idPossible` INT NOT NULL,
  `idMove` INT NOT NULL,
  PRIMARY KEY (`idPossible`, `idMove`),
  CONSTRAINT `fk_Possible_Move1`
    FOREIGN KEY (`idMove`)
    REFERENCES `chess`.`Move` (`idMove`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Possible_Move1_idx` ON `chess`.`Possible` (`idMove` ASC);


-- -----------------------------------------------------
-- Table `chess`.`Analysis`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chess`.`Analysis` ;

CREATE TABLE IF NOT EXISTS `chess`.`Analysis` (
  `idAnalysis` INT NOT NULL,
  `text` VARCHAR(45) NULL,
  `idPlayed` INT NOT NULL,
  `idMember` INT NOT NULL,
  `idPossible` INT NOT NULL,
  `idMove` INT NOT NULL,
  PRIMARY KEY (`idAnalysis`),
  CONSTRAINT `fk_Analysis_played1`
    FOREIGN KEY (`idPlayed`)
    REFERENCES `chess`.`Played` (`idPlayed`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Analysis_Member1`
    FOREIGN KEY (`idMember`)
    REFERENCES `chess`.`Member` (`idMember`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Analysis_Possible1`
    FOREIGN KEY (`idPossible` , `idMove`)
    REFERENCES `chess`.`Possible` (`idPossible` , `idMove`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Analysis_played1_idx` ON `chess`.`Analysis` (`idPlayed` ASC);

CREATE INDEX `fk_Analysis_Member1_idx` ON `chess`.`Analysis` (`idMember` ASC);

CREATE INDEX `fk_Analysis_Possible1_idx` ON `chess`.`Analysis` (`idPossible` ASC, `idMove` ASC);


-- -----------------------------------------------------
-- Table `chess`.`Chess_Game_on_Tournament`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chess`.`Chess_Game_on_Tournament` ;

CREATE TABLE IF NOT EXISTS `chess`.`Chess_Game_on_Tournament` (
  `idChes_Game` INT NOT NULL,
  `idTournament` INT NULL,
  PRIMARY KEY (`idChes_Game`),
  CONSTRAINT `fk_Chess_Game_on_Tournament_Ches_Game1`
    FOREIGN KEY (`idChes_Game`)
    REFERENCES `chess`.`Ches_Game` (`idChes_Game`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Chess_Game_on_Tournament_Tournament1`
    FOREIGN KEY (`idTournament`)
    REFERENCES `chess`.`Tournament` (`idTournament`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Chess_Game_on_Tournament_Tournament1_idx` ON `chess`.`Chess_Game_on_Tournament` (`idTournament` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

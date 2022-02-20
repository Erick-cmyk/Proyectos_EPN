-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`ubicacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ubicacion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ubicacion` (
  `idUbicacion` INT NOT NULL AUTO_INCREMENT,
  `Area` VARCHAR(45) NULL,
  `Region` VARCHAR(45) NULL,
  `Provincia` VARCHAR(45) NULL,
  `Ciudad` VARCHAR(45) NULL,
  PRIMARY KEY (`idUbicacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`r_clasificacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`r_clasificacion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`r_clasificacion` (
  `idRclasificacion` INT NOT NULL AUTO_INCREMENT,
  `tipoResiduo` VARCHAR(45) NULL,
  `idPregunta` VARCHAR(45) NULL,
  `Respuesta` VARCHAR(45) NULL,
  PRIMARY KEY (`idRclasificacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Problemas_Ambientales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Problemas_Ambientales` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Problemas_Ambientales` (
  `idProblema` INT NOT NULL AUTO_INCREMENT,
  `tipoProblema` VARCHAR(45) NULL,
  `Respuesta` VARCHAR(45) NULL,
  PRIMARY KEY (`idProblema`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tiempo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`tiempo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`tiempo` (
  `idTiempo` INT NOT NULL AUTO_INCREMENT,
  `Decada` INT NULL,
  `Lustro` INT NULL,
  `Anio` VARCHAR(45) NULL,
  PRIMARY KEY (`idTiempo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`servicios_basicos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`servicios_basicos` ;

CREATE TABLE IF NOT EXISTS `mydb`.`servicios_basicos` (
  `idServicio` INT NOT NULL AUTO_INCREMENT,
  `tipoServicio` VARCHAR(45) NULL,
  `idPregunta` VARCHAR(45) NULL,
  `Respuesta` VARCHAR(45) NULL,
  PRIMARY KEY (`idServicio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`r_eliminacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`r_eliminacion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`r_eliminacion` (
  `idR_eliminacion` INT NOT NULL AUTO_INCREMENT,
  `tipoResiduo` VARCHAR(45) NULL,
  `Respuesta` VARCHAR(45) NULL,
  PRIMARY KEY (`idR_eliminacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`FT_Resumen_Ambiental`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`FT_Resumen_Ambiental` ;

CREATE TABLE IF NOT EXISTS `mydb`.`FT_Resumen_Ambiental` (
  `Encuestados` INT NOT NULL,
  `ubicacion_idUbicacion` INT NOT NULL,
  `r_clasificacion_idRclasificacion` INT NOT NULL,
  `Problemas_Ambientales_idProblema` INT NOT NULL,
  `tiempo_idTiempo` INT NOT NULL,
  `servicios_basicos_idServicio` INT NOT NULL,
  `r_eliminacion_idR_eliminacion` INT NOT NULL,
  INDEX `fk_Resumen_Ambiental_ubicacion_idx` (`ubicacion_idUbicacion` ASC) VISIBLE,
  INDEX `fk_Resumen_Ambiental_r_clasificacion1_idx` (`r_clasificacion_idRclasificacion` ASC) VISIBLE,
  INDEX `fk_Resumen_Ambiental_Problemas_Ambientales1_idx` (`Problemas_Ambientales_idProblema` ASC) VISIBLE,
  INDEX `fk_Resumen_Ambiental_tiempo1_idx` (`tiempo_idTiempo` ASC) VISIBLE,
  INDEX `fk_Resumen_Ambiental_servicios_basicos1_idx` (`servicios_basicos_idServicio` ASC) VISIBLE,
  INDEX `fk_Resumen_Ambiental_r_eliminacion1_idx` (`r_eliminacion_idR_eliminacion` ASC) VISIBLE,
  CONSTRAINT `fk_Resumen_Ambiental_ubicacion`
    FOREIGN KEY (`ubicacion_idUbicacion`)
    REFERENCES `mydb`.`ubicacion` (`idUbicacion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Resumen_Ambiental_r_clasificacion1`
    FOREIGN KEY (`r_clasificacion_idRclasificacion`)
    REFERENCES `mydb`.`r_clasificacion` (`idRclasificacion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Resumen_Ambiental_Problemas_Ambientales1`
    FOREIGN KEY (`Problemas_Ambientales_idProblema`)
    REFERENCES `mydb`.`Problemas_Ambientales` (`idProblema`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Resumen_Ambiental_tiempo1`
    FOREIGN KEY (`tiempo_idTiempo`)
    REFERENCES `mydb`.`tiempo` (`idTiempo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Resumen_Ambiental_servicios_basicos1`
    FOREIGN KEY (`servicios_basicos_idServicio`)
    REFERENCES `mydb`.`servicios_basicos` (`idServicio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Resumen_Ambiental_r_eliminacion1`
    FOREIGN KEY (`r_eliminacion_idR_eliminacion`)
    REFERENCES `mydb`.`r_eliminacion` (`idR_eliminacion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

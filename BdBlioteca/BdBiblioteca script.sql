-- MySQL Script generated by MySQL Workbench
-- Sat Jan 13 22:31:48 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BdBiblioteca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BdBiblioteca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BdBiblioteca` DEFAULT CHARACTER SET utf8 ;
USE `BdBiblioteca` ;

-- -----------------------------------------------------
-- Table `BdBiblioteca`.`Autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BdBiblioteca`.`Autor` (
  `idAutor` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Apellido` VARCHAR(45) NULL,
  PRIMARY KEY (`idAutor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BdBiblioteca`.`Editorial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BdBiblioteca`.`Editorial` (
  `idEditorial` INT NOT NULL,
  `Editorial` VARCHAR(45) NULL,
  PRIMARY KEY (`idEditorial`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BdBiblioteca`.`Libros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BdBiblioteca`.`Libros` (
  `idLibros` INT NOT NULL,
  `Titulo` VARCHAR(45) NULL,
  `Año` VARCHAR(45) NULL,
  `Paginas` INT NULL,
  `Categoria` VARCHAR(45) NULL,
  `Autor_idAutor` INT NOT NULL,
  `Editorial_idEditorial` INT NOT NULL,
  PRIMARY KEY (`idLibros`, `Autor_idAutor`, `Editorial_idEditorial`),
  INDEX `fk_Libros_Editorial1_idx` (`Editorial_idEditorial` ASC) VISIBLE,
  CONSTRAINT `fk_Libros_Editorial1`
    FOREIGN KEY (`Editorial_idEditorial`)
    REFERENCES `BdBiblioteca`.`Editorial` (`idEditorial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BdBiblioteca`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BdBiblioteca`.`Persona` (
  `idPersona` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  `ApePaterno` VARCHAR(45) NULL,
  `ApeMaterno` VARCHAR(45) NULL,
  `Tipo` VARCHAR(45) NULL,
  `Direccion` VARCHAR(45) NULL,
  PRIMARY KEY (`idPersona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BdBiblioteca`.`Prestamo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BdBiblioteca`.`Prestamo` (
  `idPrestamo` INT NOT NULL,
  `FechaInicio` DATE NULL,
  `FechaEntrega` DATE NULL,
  `Libros_idLibros` INT NOT NULL,
  `Libros_Autor_idAutor` INT NOT NULL,
  `Libros_Editorial_idEditorial` INT NOT NULL,
  `Persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idPrestamo`, `Libros_idLibros`, `Libros_Autor_idAutor`, `Libros_Editorial_idEditorial`, `Persona_idPersona`),
  INDEX `fk_Prestamo_Libros1_idx` (`Libros_idLibros` ASC, `Libros_Autor_idAutor` ASC, `Libros_Editorial_idEditorial` ASC) VISIBLE,
  INDEX `fk_Prestamo_Persona1_idx` (`Persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_Prestamo_Libros1`
    FOREIGN KEY (`Libros_idLibros` , `Libros_Autor_idAutor` , `Libros_Editorial_idEditorial`)
    REFERENCES `BdBiblioteca`.`Libros` (`idLibros` , `Autor_idAutor` , `Editorial_idEditorial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prestamo_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `BdBiblioteca`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BdBiblioteca`.`Sanciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BdBiblioteca`.`Sanciones` (
  `idSanciones` INT NOT NULL,
  `Comentario` VARCHAR(45) NULL,
  PRIMARY KEY (`idSanciones`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BdBiblioteca`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BdBiblioteca`.`Empleado` (
  `idEmpleado` INT NOT NULL,
  `Rol` VARCHAR(45) NOT NULL,
  `Persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`, `Persona_idPersona`),
  INDEX `fk_Empleado_Persona1_idx` (`Persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_Empleado_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `BdBiblioteca`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BdBiblioteca`.`Estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BdBiblioteca`.`Estudiante` (
  `idEstudiante` INT NOT NULL,
  `Matricula` VARCHAR(45) NULL,
  `Carreta` VARCHAR(45) NULL,
  `Sanciones_idSanciones` INT NOT NULL,
  `Persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idEstudiante`, `Sanciones_idSanciones`, `Persona_idPersona`),
  INDEX `fk_Estudiante_Sanciones1_idx` (`Sanciones_idSanciones` ASC) VISIBLE,
  INDEX `fk_Estudiante_Persona1_idx` (`Persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_Estudiante_Sanciones1`
    FOREIGN KEY (`Sanciones_idSanciones`)
    REFERENCES `BdBiblioteca`.`Sanciones` (`idSanciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estudiante_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `BdBiblioteca`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BdBiblioteca`.`Autor_has_Libros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BdBiblioteca`.`Autor_has_Libros` (
  `Autor_idAutor` INT NOT NULL,
  `Libros_idLibros` INT NOT NULL,
  `Libros_Autor_idAutor` INT NOT NULL,
  `Libros_Editorial_idEditorial` INT NOT NULL,
  PRIMARY KEY (`Autor_idAutor`, `Libros_idLibros`, `Libros_Autor_idAutor`, `Libros_Editorial_idEditorial`),
  INDEX `fk_Autor_has_Libros_Libros1_idx` (`Libros_idLibros` ASC, `Libros_Autor_idAutor` ASC, `Libros_Editorial_idEditorial` ASC) VISIBLE,
  INDEX `fk_Autor_has_Libros_Autor1_idx` (`Autor_idAutor` ASC) VISIBLE,
  CONSTRAINT `fk_Autor_has_Libros_Autor1`
    FOREIGN KEY (`Autor_idAutor`)
    REFERENCES `BdBiblioteca`.`Autor` (`idAutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Autor_has_Libros_Libros1`
    FOREIGN KEY (`Libros_idLibros` , `Libros_Autor_idAutor` , `Libros_Editorial_idEditorial`)
    REFERENCES `BdBiblioteca`.`Libros` (`idLibros` , `Autor_idAutor` , `Editorial_idEditorial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
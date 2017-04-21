-- MySQL Script generated by MySQL Workbench
-- Sex 21 Abr 2017 19:06:11 BRT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema MobPDV
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `MobPDV` ;

-- -----------------------------------------------------
-- Schema MobPDV
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MobPDV` DEFAULT CHARACTER SET utf8 ;
USE `MobPDV` ;

-- -----------------------------------------------------
-- Table `MobPDV`.`Contato`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MobPDV`.`Contato` ;

CREATE TABLE IF NOT EXISTS `MobPDV`.`Contato` (
  `id_Contato` INT NOT NULL DEFAULT AUTO_INCREMENT,
  `tel_Contato` VARCHAR(45) NULL,
  `email_Contato` VARCHAR(45) NULL,
  `tel_alt_Contato` VARCHAR(45) NULL,
  PRIMARY KEY (`id_Contato`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MobPDV`.`Fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MobPDV`.`Fornecedor` ;

CREATE TABLE IF NOT EXISTS `MobPDV`.`Fornecedor` (
  `id_Forn` INT NOT NULL DEFAULT AUTO_INCREMENT,
  `nome_Forn` VARCHAR(50) NOT NULL,
  `Contato_id_Contato` INT NULL,
  PRIMARY KEY (`id_Forn`),
  INDEX `fk_Fornecedor_Contato_idx` (`Contato_id_Contato` ASC),
  CONSTRAINT `fk_Fornecedor_Contato`
    FOREIGN KEY (`Contato_id_Contato`)
    REFERENCES `MobPDV`.`Contato` (`id_Contato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MobPDV`.`Produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MobPDV`.`Produto` ;

CREATE TABLE IF NOT EXISTS `MobPDV`.`Produto` (
  `id_Prod` INT NOT NULL DEFAULT AUTO_INCREMENT,
  `id_Forn` INT NOT NULL,
  `nome_Prod` VARCHAR(75) NOT NULL,
  `validade_Prod` DATE NOT NULL,
  `cdgBarras_Prod` BIGINT(19) NOT NULL,
  `val_Prod` DECIMAL(6,2) NOT NULL,
  `quant_Prod` INT NOT NULL,
  PRIMARY KEY (`id_Prod`),
  UNIQUE INDEX `cdgBarras_Prod_UNIQUE` (`cdgBarras_Prod` ASC),
  INDEX `fk_Produto_Fornecedor1_idx` (`id_Forn` ASC),
  CONSTRAINT `fk_Produto_Fornecedor1`
    FOREIGN KEY (`id_Forn`)
    REFERENCES `MobPDV`.`Fornecedor` (`id_Forn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MobPDV`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MobPDV`.`Usuario` ;

CREATE TABLE IF NOT EXISTS `MobPDV`.`Usuario` (
  `id_Funcionario` INT NOT NULL DEFAULT AUTO_INCREMENT,
  `nome_Funcionario` VARCHAR(45) NOT NULL,
  `username_Funcionario` VARCHAR(45) NOT NULL,
  `senha_Funcionario` CHAR(64) NOT NULL,
  `salt_Funcionario` CHAR(15) NOT NULL,
  `id_Contato` INT NOT NULL,
  PRIMARY KEY (`id_Funcionario`),
  UNIQUE INDEX `username_Funcionario_UNIQUE` (`username_Funcionario` ASC),
  INDEX `fk_Funcionario_Contato1_idx` (`id_Contato` ASC),
  CONSTRAINT `fk_Funcionario_Contato1`
    FOREIGN KEY (`id_Contato`)
    REFERENCES `MobPDV`.`Contato` (`id_Contato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MobPDV`.`Venda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MobPDV`.`Venda` ;

CREATE TABLE IF NOT EXISTS `MobPDV`.`Venda` (
  `id_Venda` INT NOT NULL DEFAULT AUTO_INCREMENT,
  `id_Funcionario` INT NOT NULL,
  `data_Venda` DATETIME NOT NULL DEFAULT NOW(),
  `valor_Venda` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id_Venda`),
  INDEX `fk_Venda_Funcionario1_idx` (`id_Funcionario` ASC),
  CONSTRAINT `fk_Venda_Funcionario1`
    FOREIGN KEY (`id_Funcionario`)
    REFERENCES `MobPDV`.`Usuario` (`id_Funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MobPDV`.`ListaProdutos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MobPDV`.`ListaProdutos` ;

CREATE TABLE IF NOT EXISTS `MobPDV`.`ListaProdutos` (
  `id_ListaProdutos` INT NOT NULL,
  `ListaProdutoscol` VARCHAR(45) NULL,
  PRIMARY KEY (`id_ListaProdutos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MobPDV`.`Venda_Produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MobPDV`.`Venda_Produto` ;

CREATE TABLE IF NOT EXISTS `MobPDV`.`Venda_Produto` (
  `id_Venda` INT NOT NULL,
  `id_Prod` INT NOT NULL,
  `unidades_Prod` INT NOT NULL,
  PRIMARY KEY (`id_Venda`, `id_Prod`),
  INDEX `fk_Venda_has_Produto_Produto1_idx` (`id_Prod` ASC),
  INDEX `fk_Venda_has_Produto_Venda1_idx` (`id_Venda` ASC),
  CONSTRAINT `fk_Venda_has_Produto_Venda1`
    FOREIGN KEY (`id_Venda`)
    REFERENCES `MobPDV`.`Venda` (`id_Venda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_has_Produto_Produto1`
    FOREIGN KEY (`id_Prod`)
    REFERENCES `MobPDV`.`Produto` (`id_Prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MobPDV`.`HistoricoLogin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MobPDV`.`HistoricoLogin` ;

CREATE TABLE IF NOT EXISTS `MobPDV`.`HistoricoLogin` (
  `id_Login` INT NOT NULL DEFAULT AUTO_INCREMENT,
  `data_Login` DATETIME NOT NULL DEFAULT NOW(),
  `macAddr_Login` CHAR(12) NOT NULL,
  `ip_Login` CHAR(17) NOT NULL,
  `id_Funcionario` INT NOT NULL,
  `token` VARCHAR(25) NULL,
  PRIMARY KEY (`id_Login`),
  INDEX `fk_Logins_Funcionario1_idx` (`id_Funcionario` ASC),
  CONSTRAINT `fk_Logins_Funcionario1`
    FOREIGN KEY (`id_Funcionario`)
    REFERENCES `MobPDV`.`Usuario` (`id_Funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MobPDV`.`Entrega`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MobPDV`.`Entrega` ;

CREATE TABLE IF NOT EXISTS `MobPDV`.`Entrega` (
  `id_Entrega` INT NOT NULL DEFAULT AUTO_INCREMENT,
  `id_Prod` INT NOT NULL,
  `data_Entrega` DATE NOT NULL DEFAULT CURDATE(),
  `quant_Entrega` INT NOT NULL,
  `custo_Entrega` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id_Entrega`),
  INDEX `fk_Entrega_Produto1_idx` (`id_Prod` ASC),
  CONSTRAINT `fk_Entrega_Produto1`
    FOREIGN KEY (`id_Prod`)
    REFERENCES `MobPDV`.`Produto` (`id_Prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `MobPDV` ;

-- -----------------------------------------------------
-- procedure NovoUsuario
-- -----------------------------------------------------

USE `MobPDV`;
DROP procedure IF EXISTS `MobPDV`.`NovoUsuario`;

DELIMITER $$
USE `MobPDV`$$
CREATE PROCEDURE `NovoUsuario` (pass varchar(50), username varchar(50), nome varchar(75))
BEGIN
	SET @salt = LEFT(UUID(), 8);
    SET @hashedPass = SHA2(CONCAT(@salt, pass),0);
    INSERT INTO Funcionario(nome_Funcionario, username_Funcionario, senha_Funcionario, salt_Funcionario)
			VALUES (nome, username, @hashedPass, @salt);
END;$$

DELIMITER ;
USE `MobPDV`;

DELIMITER $$

USE `MobPDV`$$
DROP TRIGGER IF EXISTS `MobPDV`.`Fornecedor_BEFORE_INSERT` $$
USE `MobPDV`$$
CREATE DEFINER = CURRENT_USER TRIGGER `MobPDV`.`Fornecedor_BEFORE_INSERT` BEFORE INSERT ON `Fornecedor` FOR EACH ROW
BEGIN
	IF NEW.email_Forn NOT LIKE "_%@_%._%" THEN
		SET NEW.id_Forn = null;
    END IF;
END$$


USE `MobPDV`$$
DROP TRIGGER IF EXISTS `MobPDV`.`Fornecedor_BEFORE_UPDATE` $$
USE `MobPDV`$$
CREATE DEFINER = CURRENT_USER TRIGGER `MobPDV`.`Fornecedor_BEFORE_UPDATE` BEFORE UPDATE ON `Fornecedor` FOR EACH ROW
BEGIN
	IF NEW.email_Forn NOT LIKE "_%@_%._%" THEN
		SET NEW.id_Forn = null;
    END IF;
END$$


USE `MobPDV`$$
DROP TRIGGER IF EXISTS `MobPDV`.`Produto_BEFORE_INSERT` $$
USE `MobPDV`$$
CREATE DEFINER = CURRENT_USER TRIGGER `MobPDV`.`Produto_BEFORE_INSERT` BEFORE INSERT ON `Produto` FOR EACH ROW
BEGIN
	SET @val = NEW.validade_Prod;
	IF @val >= CURDATE() THEN
		SET NEW.id_Prod = null;
	END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `MobPDV`.`Fornecedor`
-- -----------------------------------------------------
START TRANSACTION;
USE `MobPDV`;
INSERT INTO `MobPDV`.`Fornecedor` (`id_Forn`, `nome_Forn`, `Contato_id_Contato`) VALUES (1, 'Elmachips', NULL);
INSERT INTO `MobPDV`.`Fornecedor` (`id_Forn`, `nome_Forn`, `Contato_id_Contato`) VALUES (2, 'Coca-Cola', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `MobPDV`.`Produto`
-- -----------------------------------------------------
START TRANSACTION;
USE `MobPDV`;
INSERT INTO `MobPDV`.`Produto` (`id_Prod`, `id_Forn`, `nome_Prod`, `validade_Prod`, `cdgBarras_Prod`, `val_Prod`, `quant_Prod`) VALUES (1, 1, 'Cheetos', '25/08/2017', 01234567800, 2.50, 300);
INSERT INTO `MobPDV`.`Produto` (`id_Prod`, `id_Forn`, `nome_Prod`, `validade_Prod`, `cdgBarras_Prod`, `val_Prod`, `quant_Prod`) VALUES (2, 2, 'Coca-Cola', '02/02/2018', 01134567800, 5.00, 100);

COMMIT;


-- -----------------------------------------------------
-- Data for table `MobPDV`.`Usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `MobPDV`;
INSERT INTO `MobPDV`.`Usuario` (`id_Funcionario`, `nome_Funcionario`, `username_Funcionario`, `senha_Funcionario`, `salt_Funcionario`, `id_Contato`) VALUES (1, 'Samuel H.', 'samosaara', '1234', 'dsajdhash', DEFAULT);

COMMIT;
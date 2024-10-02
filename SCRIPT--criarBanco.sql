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
-- Table `mydb`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Paciente` (
  `idPaciente` INT NOT NULL AUTO_INCREMENT,
  `historico_bucal` VARCHAR(100) NULL,
  `data_nasc` DATE NOT NULL,
  `cpf` CHAR(14) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idPaciente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`endereco_paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`endereco_paciente` (
  `uf` CHAR(2) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `bairro` VARCHAR(100) NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `numero` VARCHAR(5) NULL,
  `cep` VARCHAR(9) NULL,
  `complemento` VARCHAR(100) NULL,
  `Paciente_idPaciente` INT NOT NULL,
  PRIMARY KEY (`Paciente_idPaciente`),
  INDEX `fk_endereco_paciente_Paciente1_idx` (`Paciente_idPaciente` ASC) VISIBLE,
  CONSTRAINT `fk_endereco_paciente_Paciente1`
    FOREIGN KEY (`Paciente_idPaciente`)
    REFERENCES `mydb`.`Paciente` (`idPaciente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EquipeClinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EquipeClinica` (
  `idFuncionário` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `salario` DECIMAL(5,2) NOT NULL,
  `registro_profissional` VARCHAR(8) NOT NULL,
  `especializacao` VARCHAR(255) NULL,
  `dataAdmi` DATE NOT NULL,
  `dataDemi` VARCHAR(45) NULL,
  PRIMARY KEY (`idFuncionário`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Agendamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Agendamentos` (
  `idAgendamentos` INT NOT NULL AUTO_INCREMENT,
  `horario` TIME NULL,
  `estado_paciente` VARCHAR(100) NULL,
  `Paciente_idPaciente` INT NOT NULL,
  `Funcionário_idFuncionário` INT NOT NULL,
  PRIMARY KEY (`idAgendamentos`),
  INDEX `fk_Agendamentos_Paciente1_idx` (`Paciente_idPaciente` ASC) VISIBLE,
  INDEX `fk_Agendamentos_Funcionário1_idx` (`Funcionário_idFuncionário` ASC) VISIBLE,
  CONSTRAINT `fk_Agendamentos_Paciente1`
    FOREIGN KEY (`Paciente_idPaciente`)
    REFERENCES `mydb`.`Paciente` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Agendamentos_Funcionário1`
    FOREIGN KEY (`Funcionário_idFuncionário`)
    REFERENCES `mydb`.`EquipeClinica` (`idFuncionário`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Procedimentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Procedimentos` (
  `idProcedimento` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` VARCHAR(255) NOT NULL,
  `valor` DECIMAL(5,2) NULL,
  PRIMARY KEY (`idProcedimento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Seguros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Seguros` (
  `idSeguro` INT NOT NULL AUTO_INCREMENT,
  `cobertura` VARCHAR(100) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `numero_apolice` VARCHAR(45) NOT NULL,
  `inicio_vigencia` DATE NOT NULL,
  `final_vigencia` DATE NULL,
  `Paciente_idPaciente` INT NOT NULL,
  PRIMARY KEY (`idSeguro`),
  INDEX `fk_Seguros_Paciente1_idx` (`Paciente_idPaciente` ASC) VISIBLE,
  CONSTRAINT `fk_Seguros_Paciente1`
    FOREIGN KEY (`Paciente_idPaciente`)
    REFERENCES `mydb`.`Paciente` (`idPaciente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pagamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pagamentos` (
  `idPagamentos` INT NOT NULL AUTO_INCREMENT,
  `metodo_pagamento` VARCHAR(45) NOT NULL,
  `valor` DECIMAL(7,2) NOT NULL,
  `Procedimentos_idProcedimento` INT NOT NULL,
  `Seguros_idSeguro` INT NOT NULL,
  PRIMARY KEY (`idPagamentos`),
  INDEX `fk_Pagamentos_Procedimentos1_idx` (`Procedimentos_idProcedimento` ASC) VISIBLE,
  INDEX `fk_Pagamentos_Seguros1_idx` (`Seguros_idSeguro` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamentos_Procedimentos1`
    FOREIGN KEY (`Procedimentos_idProcedimento`)
    REFERENCES `mydb`.`Procedimentos` (`idProcedimento`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pagamentos_Seguros1`
    FOREIGN KEY (`Seguros_idSeguro`)
    REFERENCES `mydb`.`Seguros` (`idSeguro`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Registro_Clinico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Registro_Clinico` (
  `RegistroClinico` INT(10) UNSIGNED NOT NULL,
  `diagnostico` VARCHAR(255) NOT NULL,
  `tratamento` VARCHAR(255) NOT NULL,
  `prescricao` VARCHAR(255) NOT NULL,
  `recomendação` VARCHAR(255) NOT NULL,
  `Paciente_idPaciente` INT NOT NULL,
  `Funcionário_idFuncionário` INT NOT NULL,
  PRIMARY KEY (`Paciente_idPaciente`, `Funcionário_idFuncionário`),
  INDEX `fk_Registro_Clinico_Paciente1_idx` (`Paciente_idPaciente` ASC) VISIBLE,
  INDEX `fk_Registro_Clinico_Funcionário1_idx` (`Funcionário_idFuncionário` ASC) VISIBLE,
  CONSTRAINT `fk_Registro_Clinico_Paciente1`
    FOREIGN KEY (`Paciente_idPaciente`)
    REFERENCES `mydb`.`Paciente` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Registro_Clinico_Funcionário1`
    FOREIGN KEY (`Funcionário_idFuncionário`)
    REFERENCES `mydb`.`EquipeClinica` (`idFuncionário`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor` (
  `cnpj` VARCHAR(15) NOT NULL,
  `telefone` VARCHAR(15) NULL,
  `nome` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NULL,
  `telefone_fornecedor_telefone` INT NOT NULL,
  PRIMARY KEY (`cnpj`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`compras` (
  `idcompras` INT NOT NULL,
  `cupom_fiscal` VARCHAR(45) NOT NULL,
  `desconto` DECIMAL(5,2) NULL,
  `data_entrega` DATE NOT NULL,
  `data_compra` VARCHAR(45) NOT NULL,
  `valor` DECIMAL(5,2) NULL,
  `Fornecedor_cnpj` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idcompras`),
  INDEX `fk_compras_Fornecedor1_idx` (`Fornecedor_cnpj` ASC) VISIBLE,
  CONSTRAINT `fk_compras_Fornecedor1`
    FOREIGN KEY (`Fornecedor_cnpj`)
    REFERENCES `mydb`.`Fornecedor` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Lab_Externo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Lab_Externo` (
  `Cnpj` VARCHAR(15) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `telefone` VARCHAR(15) NULL,
  `telefone_lab_externo_telefone` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Cnpj`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servico_externo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Servico_externo` (
  `valor` DECIMAL(5,2) NOT NULL,
  `data` DATE NOT NULL,
  `protocolo` VARCHAR(45) NOT NULL,
  `Lab_Externo_Cnpj` VARCHAR(15) NOT NULL,
  `Procedimentos_idProcedimento` INT NOT NULL,
  INDEX `fk_Servico_externo_Lab_Externo1_idx` (`Lab_Externo_Cnpj` ASC) VISIBLE,
  INDEX `fk_Servico_externo_Procedimentos1_idx` (`Procedimentos_idProcedimento` ASC) VISIBLE,
  PRIMARY KEY (`Lab_Externo_Cnpj`, `Procedimentos_idProcedimento`),
  UNIQUE INDEX `protocolo_UNIQUE` (`protocolo` ASC) VISIBLE,
  CONSTRAINT `fk_Servico_externo_Lab_Externo1`
    FOREIGN KEY (`Lab_Externo_Cnpj`)
    REFERENCES `mydb`.`Lab_Externo` (`Cnpj`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Servico_externo_Procedimentos1`
    FOREIGN KEY (`Procedimentos_idProcedimento`)
    REFERENCES `mydb`.`Procedimentos` (`idProcedimento`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Despesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Despesa` (
  `idDespesa` INT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `valor` DECIMAL(6,2) NOT NULL,
  `dataVenci` DATE NOT NULL,
  `dataPag` VARCHAR(45) NULL,
  `Funcionário_idFuncionário` INT NULL,
  `compras_idcompras` INT NULL,
  `Servico_externo_Lab_Externo_Cnpj` VARCHAR(15) NULL,
  PRIMARY KEY (`idDespesa`),
  INDEX `fk_Despesa_Funcionário1_idx` (`Funcionário_idFuncionário` ASC) VISIBLE,
  INDEX `fk_Despesa_compras1_idx` (`compras_idcompras` ASC) VISIBLE,
  INDEX `fk_Despesa_Servico_externo1_idx` (`Servico_externo_Lab_Externo_Cnpj` ASC) VISIBLE,
  CONSTRAINT `fk_Despesa_Funcionário1`
    FOREIGN KEY (`Funcionário_idFuncionário`)
    REFERENCES `mydb`.`EquipeClinica` (`idFuncionário`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Despesa_compras1`
    FOREIGN KEY (`compras_idcompras`)
    REFERENCES `mydb`.`compras` (`idcompras`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Despesa_Servico_externo1`
    FOREIGN KEY (`Servico_externo_Lab_Externo_Cnpj`)
    REFERENCES `mydb`.`Servico_externo` (`Lab_Externo_Cnpj`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `lote` VARCHAR(45) NULL,
  `data_validade` DATE NULL,
  `valor` DECIMAL(5,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Utiliza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Utiliza` (
  `qtd` INT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Procedimentos_idProcedimento` INT NOT NULL,
  INDEX `fk_Utiliza_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Utiliza_Procedimentos1_idx` (`Procedimentos_idProcedimento` ASC) VISIBLE,
  PRIMARY KEY (`Procedimentos_idProcedimento`, `Produto_idProduto`),
  CONSTRAINT `fk_Utiliza_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Utiliza_Procedimentos1`
    FOREIGN KEY (`Procedimentos_idProcedimento`)
    REFERENCES `mydb`.`Procedimentos` (`idProcedimento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Item_Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Item_Compra` (
  `qtd` INT NULL,
  `valor_compra` DECIMAL(5,2) NOT NULL,
  `compras_idcompras` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  INDEX `fk_Item_Compra_compras1_idx` (`compras_idcompras` ASC) VISIBLE,
  INDEX `fk_Item_Compra_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  PRIMARY KEY (`compras_idcompras`, `Produto_idProduto`),
  CONSTRAINT `fk_Item_Compra_compras1`
    FOREIGN KEY (`compras_idcompras`)
    REFERENCES `mydb`.`compras` (`idcompras`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Item_Compra_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`telefone_paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`telefone_paciente` (
  `telefone` VARCHAR(15) NOT NULL,
  `Paciente_idPaciente` INT NOT NULL,
  INDEX `fk_telefone_paciente_Paciente1_idx` (`Paciente_idPaciente` ASC) VISIBLE,
  PRIMARY KEY (`Paciente_idPaciente`),
  CONSTRAINT `fk_telefone_paciente_Paciente1`
    FOREIGN KEY (`Paciente_idPaciente`)
    REFERENCES `mydb`.`Paciente` (`idPaciente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`telefone` (
  `idTelefone` INT(11) NOT NULL,
  `numero` VARCHAR(15) NOT NULL,
  `Funcionário_idFuncionário` INT NULL,
  `Fornecedor_cnpj` VARCHAR(15) NULL,
  `Lab_Externo_Cnpj` VARCHAR(15) NULL,
  INDEX `fk_table1_Funcionário1_idx` (`Funcionário_idFuncionário` ASC) VISIBLE,
  INDEX `fk_table1_Fornecedor1_idx` (`Fornecedor_cnpj` ASC) VISIBLE,
  PRIMARY KEY (`idTelefone`),
  INDEX `fk_telefone_Lab_Externo1_idx` (`Lab_Externo_Cnpj` ASC) VISIBLE,
  CONSTRAINT `fk_table1_Funcionário1`
    FOREIGN KEY (`Funcionário_idFuncionário`)
    REFERENCES `mydb`.`EquipeClinica` (`idFuncionário`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_table1_Fornecedor1`
    FOREIGN KEY (`Fornecedor_cnpj`)
    REFERENCES `mydb`.`Fornecedor` (`cnpj`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_telefone_Lab_Externo1`
    FOREIGN KEY (`Lab_Externo_Cnpj`)
    REFERENCES `mydb`.`Lab_Externo` (`Cnpj`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`endereco` (
  `idEndereco` INT NOT NULL AUTO_INCREMENT,
  `uf` CHAR(2) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `bairro` VARCHAR(100) NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `numero` VARCHAR(5) NULL,
  `cep` VARCHAR(9) NULL,
  `complemento` VARCHAR(100) NULL,
  `Funcionário_idFuncionário` INT NULL,
  `Fornecedor_cnpj` VARCHAR(15) NULL,
  `Lab_Externo_Cnpj` VARCHAR(15) NULL,
  PRIMARY KEY (`idEndereco`),
  INDEX `fk_endereco_Funcionário1_idx` (`Funcionário_idFuncionário` ASC) VISIBLE,
  INDEX `fk_endereco_Fornecedor1_idx` (`Fornecedor_cnpj` ASC) VISIBLE,
  INDEX `fk_endereco_Lab_Externo1_idx` (`Lab_Externo_Cnpj` ASC) VISIBLE,
  CONSTRAINT `fk_endereco_Funcionário1`
    FOREIGN KEY (`Funcionário_idFuncionário`)
    REFERENCES `mydb`.`EquipeClinica` (`idFuncionário`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_endereco_Fornecedor1`
    FOREIGN KEY (`Fornecedor_cnpj`)
    REFERENCES `mydb`.`Fornecedor` (`cnpj`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_endereco_Lab_Externo1`
    FOREIGN KEY (`Lab_Externo_Cnpj`)
    REFERENCES `mydb`.`Lab_Externo` (`Cnpj`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

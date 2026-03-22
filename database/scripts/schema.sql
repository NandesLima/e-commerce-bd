-- 🛒 Script DDL para E-commerce (Marketplace)
-- Banco de dados gerado a partir da modelagem lógica

CREATE SCHEMA IF NOT EXISTS `ecommerce_marketplace` DEFAULT CHARACTER SET utf8mb4 ;
USE `ecommerce_marketplace` ;

-- -----------------------------------------------------
-- Tabela Cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(100) NOT NULL,
  `Tipo_Pessoa` ENUM('PF', 'PJ') NOT NULL,
  `CPF_CNPJ` VARCHAR(14) NOT NULL UNIQUE,
  `Endereco` VARCHAR(255) NOT NULL,
  `Telefone` VARCHAR(15) NULL,
  `Email` VARCHAR(100) NOT NULL UNIQUE,
  PRIMARY KEY (`idCliente`)
);

-- -----------------------------------------------------
-- Tabela Pagamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT,
  `Cliente_idCliente` INT NOT NULL,
  `Metodo` ENUM('Cartão', 'Boleto', 'Pix') NOT NULL,
  `Instituicao` VARCHAR(50) NULL,
  `Dados_Pagamento` VARCHAR(255) NULL,
  PRIMARY KEY (`idPagamento`),
  CONSTRAINT `fk_Pagamento_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Cliente` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Tabela Pedido
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Cliente_idCliente` INT NOT NULL,
  `Status` ENUM('Processando', 'Pago', 'Enviado', 'Entregue', 'Cancelado') NOT NULL DEFAULT 'Processando',
  `Descricao` TEXT NULL,
  `Valor_Frete` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Valor_Total` DECIMAL(10,2) NOT NULL,
  `Data_Criacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPedido`),
  CONSTRAINT `fk_Pedido_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Cliente` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Tabela Entrega
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Entrega` (
  `idEntrega` INT NOT NULL AUTO_INCREMENT,
  `Pedido_idPedido` INT NOT NULL,
  `Codigo_Rastreio` VARCHAR(50) NULL UNIQUE,
  `Status_Logistica` ENUM('Separacao', 'Em Transito', 'Saiu para Entrega', 'Concluido') NOT NULL DEFAULT 'Separacao',
  `Previsao_Entrega` DATE NOT NULL,
  PRIMARY KEY (`idEntrega`),
  CONSTRAINT `fk_Entrega_Pedido`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `Pedido` (`idPedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Tabela Categoria
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY (`idCategoria`)
);

-- -----------------------------------------------------
-- Tabela Produto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Categoria_idCategoria` INT NOT NULL,
  `Nome` VARCHAR(100) NOT NULL,
  `Descricao` TEXT NULL,
  `Valor` DECIMAL(10,2) NOT NULL,
  `Dimensao` VARCHAR(50) NULL,
  PRIMARY KEY (`idProduto`),
  CONSTRAINT `fk_Produto_Categoria`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `Categoria` (`idCategoria`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Tabela Fornecedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fornecedor` (
  `idFornecedor` INT NOT NULL AUTO_INCREMENT,
  `Razao_Social` VARCHAR(100) NOT NULL,
  `CNPJ` VARCHAR(14) NOT NULL UNIQUE,
  `Telefone` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idFornecedor`)
);

-- -----------------------------------------------------
-- Tabela Produto_Fornecedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Produto_Fornecedor` (
  `Produto_idProduto` INT NOT NULL,
  `Fornecedor_idFornecedor` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Fornecedor_idFornecedor`),
  CONSTRAINT `fk_Produto_Fornecedor_Produto`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `Produto` (`idProduto`),
  CONSTRAINT `fk_Produto_Fornecedor_Fornecedor`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `Fornecedor` (`idFornecedor`)
);

-- -----------------------------------------------------
-- Tabela Vendedor_Terceiro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vendedor_Terceiro` (
  `idVendedor` INT NOT NULL AUTO_INCREMENT,
  `Razao_Social` VARCHAR(100) NOT NULL,
  `Nome_Fantasia` VARCHAR(100) NULL,
  `CNPJ_CPF` VARCHAR(14) NOT NULL UNIQUE,
  `Endereco` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idVendedor`)
);

-- -----------------------------------------------------
-- Tabela Produto_Vendedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Produto_Vendedor` (
  `Vendedor_idVendedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`Vendedor_idVendedor`, `Produto_idProduto`),
  CONSTRAINT `fk_Produto_Vendedor_Vendedor`
    FOREIGN KEY (`Vendedor_idVendedor`)
    REFERENCES `Vendedor_Terceiro` (`idVendedor`),
  CONSTRAINT `fk_Produto_Vendedor_Produto`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `Produto` (`idProduto`)
);

-- -----------------------------------------------------
-- Tabela Estoque
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Estoque` (
  `idEstoque` INT NOT NULL AUTO_INCREMENT,
  `Localizacao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idEstoque`)
);

-- -----------------------------------------------------
-- Tabela Produto_Estoque
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Produto_Estoque` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Quantidade` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  CONSTRAINT `fk_Produto_Estoque_Produto`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `Produto` (`idProduto`),
  CONSTRAINT `fk_Produto_Estoque_Estoque`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `Estoque` (`idEstoque`)
);

-- -----------------------------------------------------
-- Tabela Item_Pedido
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Item_Pedido` (
  `Pedido_idPedido` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NOT NULL DEFAULT 1,
  `Status` ENUM('Pendente', 'Confirmado', 'Indisponivel') NOT NULL DEFAULT 'Pendente',
  PRIMARY KEY (`Pedido_idPedido`, `Produto_idProduto`),
  CONSTRAINT `fk_Item_Pedido_Pedido`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `Pedido` (`idPedido`),
  CONSTRAINT `fk_Item_Pedido_Produto`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `Produto` (`idProduto`)
);

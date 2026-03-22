# 💾 Scripts SQL

Além do modelo em Workbench (`.mwb`), este projeto disponibiliza os scripts físicos para geração e consulta do banco de dados na pasta `database/scripts` do repositório.

## 🏗️ Data Definition Language (DDL)

Script responsável por criar as tabelas e relacionamentos do modelo lógico de e-commerce.

```sql
-- 🛒 Script DDL para E-commerce (Marketplace)
CREATE SCHEMA IF NOT EXISTS `ecommerce_marketplace` DEFAULT CHARACTER SET utf8mb4 ;
USE `ecommerce_marketplace` ;

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

-- (O restante do script completo encontra-se no repositório GitHub)
```

👉 **[Ver o Script DDL Completo no GitHub](https://github.com/NandesLima/e-commerce-bd/blob/master/database/scripts/schema.sql)**

---

## 🔍 Data Query Language (DQL)

Consultas que respondem as principais regras de negócio do modelo.

```sql
-- 1. Quantos pedidos foram feitos por cada cliente?
SELECT c.Nome, COUNT(p.idPedido) as Total_Pedidos
FROM Cliente c
LEFT JOIN Pedido p ON c.idCliente = p.Cliente_idCliente
GROUP BY c.idCliente
ORDER BY Total_Pedidos DESC;

-- 2. Algum vendedor também é fornecedor?
SELECT v.Razao_Social as Vendedor, f.Razao_Social as Fornecedor
FROM Vendedor_Terceiro v
INNER JOIN Fornecedor f ON v.CNPJ_CPF = f.CNPJ;

-- (O restante das consultas encontra-se no repositório GitHub)
```

👉 **[Ver as Consultas DQL no GitHub](https://github.com/NandesLima/e-commerce-bd/blob/master/database/scripts/queries.sql)**

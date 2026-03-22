-- 🛒 Consultas de Negócio (DQL) - E-commerce

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

-- 3. Relação de produtos fornecedores e estoques (Produtos controlados pela plataforma)
SELECT p.Nome as Produto, f.Razao_Social as Fornecedor, e.Localizacao as Estoque, pe.Quantidade
FROM Produto p
JOIN Produto_Fornecedor pf ON p.idProduto = pf.Produto_idProduto
JOIN Fornecedor f ON pf.Fornecedor_idFornecedor = f.idFornecedor
JOIN Produto_Estoque pe ON p.idProduto = pe.Produto_idProduto
JOIN Estoque e ON pe.Estoque_idEstoque = e.idEstoque;

-- 4. Relação de nomes dos fornecedores e nomes dos produtos
SELECT f.Razao_Social as Fornecedor, p.Nome as Produto
FROM Fornecedor f
JOIN Produto_Fornecedor pf ON f.idFornecedor = pf.Fornecedor_idFornecedor
JOIN Produto p ON pf.Produto_idProduto = p.idProduto
ORDER BY f.Razao_Social;

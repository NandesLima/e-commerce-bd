# Projeto Ecommerce

## Narrativa

### Produto

- Os produtos são vendidos por uma única plataforma online. Contudo, estes podem ter vendedores distintos (terceiros).

- Cada produto possui um fornecedor.

- Um ou mais produtos podem compor um pedido.


### Cliente

- Cliente pode se cadastrar no site com CPF ou CNPJ.

- O Endereço do cliente irá determinar o valor do frete.

- Um cliente pode comprar mais de um pedido. Este têm um período de carência para devolução do produto.


### Pedido

- Os pedidos são criados por clientes e possuem informações de compra, endereço e status da entrega.

- Um produto ou mais compõem o pedido

- O pedido pode ser cancelado



## Requisitos


### Entidades

**Produto:** Nome, descrição, valor, categoria

**Estoque:** Local

**Cliente:** Nome, Endereço

- **Pessoa fśisica:** CPF
- **Pessoa jurídica:** CNPJ

**Pagamento:** Intituição, Número do cartão, Data vencimento,  Bandeira

**Pedido:** Identificação pedido, status, valor frete, valor pedido, descrição

**Entrega:** Status, Código de rastreio, endereço

**Fornecedor:** Razão social, CNPJ

**Terceiros:** Razão social, CNPJ


### Relacionamentos

**Cliente x Pagamento (1, N)** - Formas de pagamento do cliente

**Cliente x Pedido (1, N)** - Pedidos do cliente

**Pedido x Pagamento (N, 1)** - Pagamento do pedido

**Pedido x Entrega (1, 1)** - Entrega do pedido

**Pedido x Produto (N, M)** - Produtos do pedido

**Produto x Estoque (N, M)** - Produtos em estoque

**Produto x Fornecedor (N, M)** - Disponibilizar produto (Fornecedor)

**Produto x Terceiros (N, M)** - Disponibilizar produto (Terceiro)

## Modelo UML

![](https://github.com/NandesLima/e-commerce-bd/blob/master/modelo-uml.png)


## Modelo EER

![](https://github.com/NandesLima/e-commerce-bd/blob/master/modelo-EER.png)




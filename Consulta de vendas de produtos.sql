create database if not exists loja;
use loja;

/*
Um cliente <faz> varias vendas
Uma venda <possui> um produto
Um produto <tem> mais de um vendedor
*/

create table if not exists vendas (
	id_venda INT PRIMARY KEY,
    data_venda DATE,
    id_cliente INT,
    id_produto INT,
    quantidade INT,
    valor_total DECIMAL(10,2)
);

create table if not exists cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(50),
    estado CHAR(2)
);

create table if not exists produtos (
    id_produto INT PRIMARY KEY,
    nome_produto VARCHAR(100),
    categoria VARCHAR(50),
    preco DECIMAL(10,2)
);

create table if not exists vendedores (
    id_vendedor INT PRIMARY KEY,
    nome_vendedor VARCHAR(100)
);

create table if not exists produto_vendedor (
    id_produto INT,
    id_vendedor INT
);

#-----------------------------------------Dados_Clientes--------------------------------------------------
INSERT INTO cliente (id_cliente, nome, cidade, estado) VALUES
(1, 'Ana Silva', 'São Paulo', 'SP'),
(2, 'Bruno Costa', 'Rio de Janeiro', 'RJ'),
(3, 'Carla Mendes', 'Belo Horizonte', 'MG'),
(4, 'Daniel Rocha', 'Campinas', 'SP'),
(5, 'Eduarda Lima', 'Curitiba', 'PR'),
(6, 'Felipe Santos', 'Recife', 'PE'),
(7, 'Gabriela Nunes', 'Porto Alegre', 'RS'),
(8, 'Henrique Alves', 'Salvador', 'BA');

#-----------------------------------------Dados_Produtos---------------------------------------------------
INSERT INTO produtos (id_produto, nome_produto, categoria, preco) VALUES
(1, 'Notebook', 'Eletrônicos', 3500.00),
(2, 'Smartphone', 'Eletrônicos', 2500.00),
(3, 'Cadeira Gamer', 'Móveis', 1200.00),
(4, 'Mesa Escritório', 'Móveis', 900.00),
(5, 'Fone Bluetooth', 'Acessórios', 300.00),
(6, 'Mouse', 'Acessórios', 150.00);

#-------------------------------------------Dados_Vendedores-------------------------------------------------
INSERT INTO vendedores (id_vendedor, nome_vendedor) VALUES
(1, 'Carlos Vendas'),
(2, 'Mariana Sales'),
(3, 'João Comercial'),
(4, 'Patrícia Negócios');

#---------------------------------------------Dados_Vendas---------------------------------------------------
INSERT INTO vendas (id_venda, data_venda, id_cliente, id_produto, quantidade, valor_total) VALUES
(1, '2023-01-05', 1, 1, 1, 3500.00),
(2, '2023-01-10', 2, 2, 1, 2500.00),
(3, '2023-01-15', 3, 5, 2, 600.00),
(4, '2023-01-20', 4, 6, 3, 450.00),

(5, '2023-02-01', 1, 3, 1, 1200.00),
(6, '2023-02-05', 5, 4, 1, 900.00),
(7, '2023-02-10', 6, 2, 1, 2500.00),
(8, '2023-02-15', 7, 5, 1, 300.00),
(9, '2023-02-20', 8, 6, 2, 300.00),

(10, '2023-03-01', 2, 1, 1, 3500.00),
(11, '2023-03-05', 3, 3, 1, 1200.00),
(12, '2023-03-10', 4, 4, 2, 1800.00),
(13, '2023-03-15', 5, 5, 3, 900.00),
(14, '2023-03-20', 6, 6, 1, 150.00),
(15, '2023-03-25', 7, 2, 1, 2500.00),

(16, '2023-04-01', 1, 5, 2, 600.00),
(17, '2023-04-05', 2, 6, 2, 300.00),
(18, '2023-04-10', 3, 1, 1, 3500.00),
(19, '2023-04-15', 5, 2, 1, 2500.00),
(20, '2023-04-20', 8, 3, 1, 1200.00);

#-----------------------------------------------Dado_produtoVendedor---------------------------------------
INSERT INTO produto_vendedor (id_produto, id_vendedor) VALUES
(1, 1),  
(1, 2),  
(2, 3),  
(3, 4),  
(4, 2),  
(5, 1),  
(6, 3);  


select * from vendas;
select * from cliente;
select * from produtos;
select * from vendedores;
select * from produto_vendedor;


#1. Calcular o faturamento total por categoria de produto
select p.categoria, sum(v.valor_total) as faturamento from vendas v
join produtos p on v.id_produto = p.id_produto
group by categoria
having faturamento > 1000
order by faturamento desc;


#2. Calcular o faturamento mensal por categoria
select year(v.data_venda) as ano, month(v.data_venda) as mes, p.categoria, sum(v.valor_total) as faturamento from vendas v
join produtos p on v.id_produto = p.id_produto
group by ano, mes, categoria
having faturamento > 1000
order by ano;


#3. Calcular o faturamento total por estado do cliente
select c.estado, sum(v.valor_total) as Faturamento_Total from vendas v
join cliente c on v.id_cliente = c.id_cliente
group by c.estado
order by Faturamento_Total desc;


#4. Listar os 5 produtos mais vendidos em valor
select p.nome_produto, sum(v.valor_total) as Faturamento from vendas v
join produtos p on v.id_produto = p.id_produto
group by p.id_produto, p.nome_produto
order by Faturamento desc
limit 5;


#5. Listar os clientes que mais gastaram
select  c.id_cliente, c.nome, sum(v.valor_total) as Gasto from vendas v
join cliente c on v.id_cliente = c.id_cliente
group by c.id_cliente, c.nome
order by Gasto desc;


#6. Calcular o ticket médio por categoria
select p.categoria, avg(v.valor_total) as Ticket_Medio from vendas v
join produtos p on v.id_produto = p.id_produto
group by p.categoria
order by Ticket_Medio DESC; 


#7. Identificar clientes que compraram apenas 1 vezes
select c.id_cliente, c.nome, c.estado, count(v.id_cliente) as Total_Compras from vendas v
join cliente c on v.id_cliente = c.id_cliente
group by c.id_cliente, c.nome
having count(v.id_venda) = 1; #TODOS OS CLIENTES COMPRARAM MAIS DE UMA VEZ

  
#8. Identificar categorias que não venderam em algum mês
SELECT m.ano_mes, c.categoria 
FROM ( 
	select distinct date_format(data_venda, '%Y-%m') as ano_mes from vendas 
    ) as m
CROSS JOIN ( 
	select distinct categoria from produtos 
    ) as c
LEFT JOIN vendas v ON date_format(v.data_venda, '%Y-%m') = m.ano_mes
LEFT JOIN produtos p ON v.id_produto = p.id_produto AND p.categoria = c.categoria
GROUP BY m.ano_mes, c.categoria
HAVING sum(v.valor_total) IS NULL
ORDER BY m.ano_mes; #TODAS AS CATEGORIAS VENDERAM EM DETERMINADOS MESES

  
#9. Descobrir qual cliente gerou mais faturamento em cada mês
SELECT f.ano_mes, c.id_cliente, c.nome, f.faturamento
FROM (
    SELECT DATE_FORMAT(v.data_venda, '%Y-%m') AS ano_mes, v.id_cliente, SUM(v.valor_total) AS faturamento
    FROM vendas v
    GROUP BY ano_mes, v.id_cliente
) f
JOIN (
    SELECT
        ano_mes, MAX(faturamento) AS maior_faturamento
    FROM (
        SELECT DATE_FORMAT(data_venda, '%Y-%m') AS ano_mes, id_cliente, SUM(valor_total) AS faturamento
        FROM vendas
        GROUP BY
            ano_mes,
            id_cliente
    ) t
    GROUP BY ano_mes
) m
ON f.ano_mes = m.ano_mes AND f.faturamento = m.maior_faturamento
JOIN cliente c ON f.id_cliente = c.id_cliente
ORDER BY f.ano_mes;

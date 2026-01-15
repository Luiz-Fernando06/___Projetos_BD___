/*
Análise de Vendas Mensais
Contexto: Uma empresa de e-commerce deseja analisar o desempenho de vendas ao longo do tempo.
*/

create database if not exists vendas;
use vendas;

create table if not exists compras(
	id_venda INT primary key,
    data_venda DATE,
    id_cliente INT,
    valor DECIMAL(10,2),
    categoria VARCHAR(50)
)default charset=utf8;

insert into compras (id_venda, data_venda, id_cliente, valor, categoria) values
(1,  '2023-01-05',  101,  89.90,  'Eletrônicos'),
(2,  '2023-01-10',  102, 150.00,  'Eletrônicos'),
(3,  '2023-01-20',  103, 220.50,  'Livros'),
(4,  '2023-02-02',  104,  99.99,  'Livros'),
(5,  '2023-02-15',  105, 310.00,  'Eletrônicos'),
(6,  '2023-02-28',  101, 180.75,  'Moda'),
(7,  '2023-03-03',  106, 450.00,  'Eletrônicos'),
(8,  '2023-03-18',  107, 120.00,  'Moda'),
(9,  '2023-03-25',  108,  75.00,  'Livros'),
(10, '2023-04-01',  109, 600.00,  'Eletrônicos'),
(11, '2023-04-12',  110, 130.00,  'Moda'),
(12, '2023-04-29',  102,  95.00,  'Livros'),
(13, '2024-01-08',  111, 200.00,  'Eletrônicos'),
(14, '2024-01-17',  112, 340.00,  'Moda'),
(15, '2024-02-05',  113, 110.00,  'Livros'),
(16, '2024-02-19',  114,  90.00,  'Moda'),
(17, '2024-03-11',  115, 520.00,  'Eletrônicos'),
(18, '2024-03-22',  116, 145.00,  'Livros');

#Faturamento Total mensal
select year(data_venda) as ano, month(data_venda) as mes, sum(valor) as faturamento_total from compras 
where valor > 100
group by ano, mes
order by ano;

#Ticket médio mensal
#Como eu não tenho a quantidade irei simular com o total a quantidade de pessoas de cada mês
select year(data_venda) as ano, month(data_venda) as mes, avg(valor) as ticket_medio from compras 
where valor > 100
group by ano, mes
order by ano;

#Identificar o mês com maior faturamento
select year(data_venda) as ano, month(data_venda) as mes, sum(valor) as faturamento_total from compras
group by ano, mes
order by faturamento_total desc
limit 1;






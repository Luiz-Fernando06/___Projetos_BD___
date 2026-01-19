/* 

>Análise de Clientes<
Contexto: O time de marketing quer identificar clientes mais valiosos.

Tarefas:
1. Calcular o total gasto por cliente.
2. Listar apenas clientes com mais de 3 pedidos.
3. Identificar os 10 clientes que mais gastaram.
4. Mostrar clientes que nunca realizaram pedidos.

*/

use exercicio;

CREATE TABLE if not exists clientes (
	id_cliente INT auto_increment primary key,
    nome VARCHAR(100),
    cidade VARCHAR(50),
    data_cadastro DATE
);

CREATE TABLE  if not exists pedidos (
    id_pedido INT auto_increment primary key,
    id_cliente INT,
    data_pedido DATE,
    valor_total DECIMAL(10,2),
    foreign key(id_cliente) references clientes(id_cliente)
);

INSERT INTO clientes (id_cliente, nome, cidade, data_cadastro) VALUES
(1, 'Ana Silva', 'São Paulo', '2023-01-10'),
(2, 'Bruno Costa', 'Rio de Janeiro', '2023-01-15'),
(3, 'Carla Mendes', 'Belo Horizonte', '2023-02-01'),
(4, 'Daniel Rocha', 'São Paulo', '2023-02-10'),
(5, 'Eduarda Lima', 'Curitiba', '2023-02-15'),
(6, 'Felipe Santos', 'Recife', '2023-03-01'),
(7, 'Gabriela Nunes', 'Porto Alegre', '2023-03-05'),
(8, 'Henrique Alves', 'Campinas', '2023-03-10'),
(9, 'Isabela Torres', 'Salvador', '2023-03-15'),
(10, 'João Pereira', 'Fortaleza', '2023-04-01'),
(11, 'Karen Souza', 'Manaus', '2023-04-05'),
(12, 'Lucas Martins', 'São Paulo', '2023-04-10'),
(13, 'Mariana Freitas', 'Rio Branco', '2023-04-15'),
(14, 'Nicolas Barros', 'Florianópolis', '2023-05-01'),
(15, 'Olivia Pacheco', 'Vitória', '2023-05-05');

INSERT INTO pedidos (id_pedido, id_cliente, data_pedido, valor_total) VALUES
(101, 1, '2023-02-01', 250.00),
(102, 1, '2023-02-15', 180.00),
(103, 1, '2023-03-01', 320.00),
(104, 1, '2023-03-20', 150.00),

(105, 2, '2023-02-05', 90.00),
(106, 2, '2023-03-10', 120.00),

(107, 3, '2023-02-20', 500.00),
(108, 3, '2023-03-22', 450.00),
(109, 3, '2023-04-02', 300.00),

(110, 4, '2023-03-01', 80.00),

(111, 5, '2023-03-05', 200.00),
(112, 5, '2023-03-25', 220.00),
(113, 5, '2023-04-10', 210.00),
(114, 5, '2023-04-25', 190.00),

(115, 6, '2023-03-15', 130.00),

(116, 7, '2023-04-01', 400.00),
(117, 7, '2023-04-15', 380.00),

(118, 8, '2023-04-20', 160.00),

(119, 9, '2023-04-25', 600.00),

(120, 10, '2023-05-01', 110.00),
(121, 10, '2023-05-10', 140.00),

(122, 12, '2023-05-15', 700.00),
(123, 12, '2023-05-20', 650.00),
(124, 12, '2023-05-25', 720.00);

select * from clientes;
select * from pedidos;

#1. Calcular o total gasto por cliente
select c.id_cliente, c.nome, sum(p.valor_total) as Total_Gasto from clientes as c
join pedidos as p on c.id_cliente = p.id_cliente
group by c.id_cliente, c.nome
order by Total_Gasto DESC;

#2. Listar apenas clientes com mais de 3 pedidos.
select  c.nome, sum(p.valor_total) as total_gasto from clientes c
join pedidos p on c.id_cliente = p.id_cliente
group by c.id_cliente
having count(p.id_cliente) >= 3 #FIltra o resultado agregado
order by total_gasto desc;

#3. Identificar os 10 clientes que mais gastaram.
select c.nome, sum(p.valor_total) as total_gasto from clientes c
join pedidos p on c.id_cliente = p.id_cliente
group by c.id_cliente
order by total_gasto desc
limit 10;

#4. Mostrar clientes que nunca realizaram pedidos.
select c.* from clientes c
left join pedidos p on c.id_cliente = p.id_cliente #pega todos os registros não correspondente
where p.id_cliente is null;















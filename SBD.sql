CREATE DATABASE Delicias_do_Ceara;
USE Delicias_do_Ceara;

CREATE TABLE Departamento (
CodigoDepto int auto_increment primary key,
NomeDepto VARCHAR(40) NOT NULL
);

CREATE TABLE Funcionario (
Matricula INT auto_increment PRIMARY KEY,
CPF char(11) not null,
NomeCompleto VARCHAR(100) not null,
Endereco VARCHAR(100) NOT NULL,
Telefone char(11) NOT NULL,
Salario DECIMAL(10, 2),
CodDepto INT,
FOREIGN KEY (CodDepto) REFERENCES Departamento (CodigoDepto)
);

ALTER TABLE Delicias_do_Ceara.Funcionario
MODIFY Salario Double NOT NULL;

ALTER TABLE delicias_do_ceara.funcionario
MODIFY Salario decimal(10, 2);

CREATE TABLE Cliente (
CPF CHAR(11),
Nome VARCHAR(100),
Endereco VARCHAR(100),
Telefone char(11)
);

ALTER TABLE delicias_do_ceara.cliente
ADD PRIMARY KEY (CPF);


CREATE TABLE Fornecedor (
CNPJ char(14) not null, 
Nome varchar(100) not null,
Telefone char(11),
Categoria enum('Insumo, Organicos', 'Equipamentos Metrologia')
);

Alter Table delicias_do_ceara.fornecedor
add Endereco varchar(100);

Alter table delicias_do_ceara.fornecedor
MODIFY Categoria Enum('Insumo Organicos', 'Equipamentos Agriculas');


ALTER TABLE delicias_do_ceara.Fornecedor
ADD Primary key (CNPJ);

CREATE TABLE Produto (
CodProduto int auto_increment primary key,
Nome varchar(100) not null,
PrecoUnitario decimal(10,2) not null,
Categoria int
);

ALTER TABLE delicias_do_ceara.Produto
Modify PrecoUnitario Double Not Null;

Alter table delicias_do_ceara.produto
MODIFY Categoria Enum('Frutas', 'Hortalicias', 'Graos');

ALTER TABLE delicias_do_ceara.Produto
Modify PrecoUnitario Decimal (10, 2);

CREATE TABLE Venda (
CodVenda int auto_increment Primary KEY,
DataVenda date,
CPFCliente char(11),
CodProduto int,
Quantidade int,
TotalVenda decimal(10,2),
foreign key (CPFCliente) references Cliente (CPF),
foreign key (CodProduto) references Produto (CodProduto)
);

CREATE TABLE Compra (
CodCompra int auto_increment primary key,
DataCompra date,
CNPJFornecedor char(14),
CodProduto int,
Quantidade int,
TotalCompra decimal(10,2),
foreign key (CNPJFornecedor) references Fornecedor (CNPJ),
foreign key (CodProduto) references Produto (CodProduto)
);


-- Inserir dados Departamento
INSERT INTO departamento (NomeDepto) values
('Produto'),
('Venda'),
('Administracao');

-- Inserir dados Funcionarios
INSERT INTO Funcionario (CPF, NomeCompleto, Endereco, Telefone, Salario, CodDepto) values
('12365478987','Carlos Eduardo da Silva','Rua Principal, 2555','21987562547', 3000.00, '1'),
('75485622545','Cleber Araujo Foncesa','Rua Brasil, 1455','21986532144', 4000.00, '1'),
('78459862548','Henrique Nogueira','Rua Aladin, 445','21898586589', 5000.00, '2'),
('47859632145','Gabriel Nogueira','Rua Esperança, 558','21985685478', 6000.00, '2'),
('89564785698','Raphael Rodrigues','Rua Saudades,12','21985698547', 5000.00, '3');

-- inserir dados Cliente
INSERT INTO Cliente (CPF, Nome, Endereco, Telefone) values
('89564785698','Analua Rosa','Rua Alegria, 25568 - Nova Era - Nova Iguaçu, RJ 25685-985','21985698745'),
('32165498745','Luiza Souza','Rua Esperanã, 45 - Laureano, Duque de Caxias, RJ 25699854','21956874588'),
('25639874587','Erick Rodrigues','Av. Brasil, 75845 - Centro, Rio de Janeiro - RJ 26589744','21985632569'),
('78965412356','Gael Dias','Rua Recreio, 787 - Olinda, Nova Campinas, Duque de Caxias - RJ 25554745','21569856987'),
('26598321456','Alvaro Nogueira','Av. Estrada de Madureira, 245 - Jardim Felicidade, Nova Esperança - RJ 25669874','21985698745');

-- inserir dados Produto
INSERT INTO Produto (Nome, PrecoUnitario, Categoria) values
('Maca', 2.50, 'Frutas'),
('Feijao', 4.20, 'Graos'),
('CouveFlor', 2.40, 'Hortalicias');

-- inserir dados Fornecedr
INSERT INTO Fornecedor (CNPJ, Nome, Endereco, Telefone, Categoria) values
('12365478958692', 'Fornecedor A', 'Rua A, 1548', '2126585955', 'Insumo Organicos'),
('22365214569551', 'Fornecedor B', 'Rua B, 113', '2516484646', 'Insumo Organicos'),
('21544546516546', 'Fornecedor C', 'Rua C,1 115', '2154841541', 'Equipamentos Agriculas');

-- inserir dados Venda
INSERT INTO Venda (DataVenda, CPFCliente, CodProduto, Quantidade, TotalVenda) values
('2023-09-18', '89564785698', 1, 100, 100.00),
('2023-09-18', '32165498745', 2, 200, 200.00),
('2023-09-19',  '25639874587', 3, 150, 600.00);

-- inserir dados Compras
INSERT INTO Compra (DataCompra, CNPJFornecedor, CodProduto, Quantidade, TotalCompra) values
('2023-09-20', '12365478958692', 1, 1000, 5000.00),
('2023-08-15', '22365214569551', 2, 2000, 6000.00),
('2023-09-18', '21544546516546', 3, 3000, 7000.00);


-- Q1- Quantos Funcionarios a empresa possui?
SELECT COUNT(*) AS total_funcionarios FROM Funcionario;

-- Q2- Quantos produtos foram cadastrados?
SELECT COUNT(*) AS Total_Produtos FROM Produto;

-- Q3- Atualmente o banco de dados possui quantos clientes cadastrados e qual o contatos telefonico deles?
SELECT COUNT(*)as Total_Clientes, group_concat(Telefone separator', ') as Contatos_Telefonicos FROM Cliente;

-- Q4- Quem são os fornecedores que já possuem cadastro?
SELECT Nome FROM Fornecedor;

-- Q5- Quanto a empresa gasta para pagar os funcionarios de cada departamento?
SELECT CodDepto, SUM(Salario) as Total_Salario_Depto FROM funcionario Group by CodDepto;


-- Q6- Quanto foi vendido no ano de 2023?
SELECT SUM(totalVenda) as Total_Vendas_2023 FROM Venda
WHERE YEAR(totalvenda) = 2023;

-- Q7- Quanto foi gasto em insumos e equipamento no ano de 2023?
SELECT SUM(totalcompra) as Total_Compras_2023 FROM Compra WHERE YEAR(totalCompra) = 2023;

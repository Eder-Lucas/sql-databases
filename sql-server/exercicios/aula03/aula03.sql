-- CRIANDO UM BANCO DE DADOS POR CÓDIGOS SQL

-- Primeiro criamos o banco
CREATE DATABASE Farmacia;

-- Selecionar o banco de dados
USE Farmacia;

-- Criando a primeira tabela
CREATE TABLE Clientes(
    ID_Clientes INT PRIMARY KEY IDENTITY,
    Nome_Cliente VARCHAR(50) NOT NULL,
    Endereco VARCHAR(50) NOT NULL,
    Telefone CHAR(14) NOT NULL,
    Cpf CHAR(14) NOT NULL
);

-- Criando a segunda tabela

CREATE TABLE Produtos(
    ID_Produtos INT PRIMARY KEY IDENTITY,
    Nome_Produto VARCHAR(50) NOT NULL,
    Quantidade_Estoque INT NOT NULL,
    Valor_Compra Decimal(6,2) NOT NULL, -- 6 digitos com 2 digitos depois da vírgula
    Valor_Venda DECIMAL(6,2) NOT NULL
);
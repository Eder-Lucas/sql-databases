USE master
GO

-- Evita criar o banco duas vezes
IF DB_ID('Aula14_ex002') IS NOT NULL
BEGIN
	ALTER DATABASE Aula14_ex002
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE

	DROP DATABASE Aula14_ex002
END

CREATE DATABASE Aula14_ex002
GO

USE Aula14_ex002
GO

-- Criando as tabelas do banco
CREATE TABLE Departamentos (
    ID_DEPARTAMENTO INT PRIMARY KEY IDENTITY(1,1),
    NOME VARCHAR(50) NOT NULL
);

CREATE TABLE Funcionarios (
    ID_FUNCIONARIO INT PRIMARY KEY IDENTITY(1,1),
    NOME VARCHAR(50) NOT NULL,
    SALARIO DECIMAL(10,2),
    ID_DEPARTAMENTO INT,

    FOREIGN KEY (ID_DEPARTAMENTO) REFERENCES Departamentos(ID_DEPARTAMENTO)
);

-- Insertando dados iniciais
INSERT INTO Departamentos(NOME) VALUES
('TI'),
('Financeiro'),
('RH'),
('Marketing'),
('Jurídico');

INSERT INTO Funcionarios(NOME, SALARIO, ID_DEPARTAMENTO) VALUES
('João', 3500, 1),
('Maria', 4200, 1),
('Carlos', 3000, 2),
('Ana', 2800, 3),
('Pedro', 4000, 2),
('Fernanda', 5000, 1),
('Lucas', 2500, 4);
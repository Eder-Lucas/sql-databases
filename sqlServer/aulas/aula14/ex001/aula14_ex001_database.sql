-- Usa o master por seguran�a
USE master
GO

-- Se já existir o banco dessa aula, remove ele de forma segura
IF DB_ID('Aula14_ex001') IS NOT NULL
BEGIN
	ALTER DATABASE Aula14_ex001
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE

	DROP DATABASE Aula14_ex001
END
GO

-- Cria o banco da aula
CREATE DATABASE Aula14_ex001
GO

USE Aula14_ex001
GO

-- Criando as tabelas
CREATE TABLE Usuarios(
	ID_USUARIO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NOME NVARCHAR(50) NOT NULL,
	EMAIL NVARCHAR(50) NOT NULL,
	TELEFONE VARCHAR(16) NOT NULL
)

CREATE TABLE Categorias(
	ID_CATEGORIA INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NOME NVARCHAR(30) NOT NULL
)

CREATE TABLE Autores(
	ID_AUTOR INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NOME_AUTOR NVARCHAR(50) NOT NULL
)

CREATE TABLE Livros(
	ID_LIVRO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ISBN NVARCHAR(20) NOT NULL,
	ID_CATEGORIA INT NOT NULL,
	ID_AUTOR INT NOT NULL,
	TITULO NVARCHAR(50) NOT NULL,
	DATA_PUBLICACAO DATE NOT NULL,

	CONSTRAINT FK_LIVRO_CATEGORIA FOREIGN KEY(ID_CATEGORIA) REFERENCES Categorias(ID_CATEGORIA),
	CONSTRAINT FK_LIVRO_AUTOR FOREIGN KEY(ID_AUTOR) REFERENCES Autores(ID_AUTOR)
)

CREATE TABLE Aluguel(
	ID_ALUGUEL INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ID_USUARIO INT NOT NULL,
	ID_LIVRO INT NOT NULL,
	DATA_ALUGUEL DATETIME NOT NULL,
	DATA_DEVOLUCAO DATETIME NULL,
	DEVOLVIDO BIT NOT NULL DEFAULT 0,

	CONSTRAINT FK_ALUGUEL_USUARIO FOREIGN KEY(ID_USUARIO) REFERENCES Usuarios(ID_USUARIO),
	CONSTRAINT FK_ALUGUEL_LIVRO FOREIGN KEY(ID_LIVRO) REFERENCES Livros(ID_LIVRO)
);

DECLARE @DataInicio DATE = GETDATE();
DECLARE @DataFinal DATE = DATEADD(MONTH, 1, @dataInicio);

-- Inserindo dados iniciais
INSERT INTO Usuarios(NOME, EMAIL, TELEFONE) VALUES
('João Pedro Calado', 'joaozin123@gmail.com', '(82) 9 9876-4532'),
('Clara Vitória Ferreira', 'clarinha3321@gmail.com', '(81) 9 7856-9002'),
('Fernanda Carla da Silva', 'fernan234@gmail.com', '(87) 9 7865-1243'),
('Carlos Miguel Morales', 'carlao34@gmail.com', '(83) 9 4567-0923'),
('Pedro Augusto Santos', 'august120@gmail.com', '(87) 9 4567-8909');

INSERT INTO Categorias(NOME) VALUES
('Romance'),
('Ficçãoo Científica'),
('Terror'),
('Aventura');

INSERT INTO Autores(NOME_AUTOR) VALUES
('Jorge Amado'),
('Maurice Leblanc'),
('Júlio Verne'),
('H.P Lovecraft'),
('Machado de Assis');

INSERT INTO Livros(ISBN, ID_CATEGORIA, ID_AUTOR, TITULO, DATA_PUBLICACAO) VALUES
('978-6555522303', '1', '2', 'Arsène Lupin, o Ladrão de Casaca', '08/01/21'),
('978-8535914061', '1', '1', 'Capitães da areia', '11/02/09'),
('978-6555521733', '2', '3', 'Da Terra à Lua', '05/01/21'),
('978-6555948820', '3', '4', 'H.P. Lovecraft - O Habitante da Escuridão', '27/06/25'),
('978-8535911824', '1', '1', 'Mar Morto', '10/03/08');

INSERT INTO Aluguel(ID_USUARIO, ID_LIVRO, DATA_ALUGUEL, DATA_DEVOLUCAO, DEVOLVIDO) VALUES
('3', '2', @DataInicio, @DataFinal, 0),
('3', '3', @DataInicio, @DataFinal, 0),
('1', '2', @DataInicio, @DataFinal, 0),
('2', '1', @DataInicio, @DataFinal, 0),
('4', '4', @DataInicio, @DataFinal, 0),
('1', '1', @DataInicio, @DataFinal, 0);
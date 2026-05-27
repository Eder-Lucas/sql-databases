-- Usa o master por segurança
USE MASTER
GO

-- Se já existir o banco dessa aula
-- Remove todos os usuários e cancela as transações para excluir de forma segura
IF DB_ID('Aula11_ex001') IS NOT NULL
BEGIN
    ALTER DATABASE Aula11_ex001 
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE

    DROP DATABASE Aula11_ex001
END
GO

-- Cria o banco de forma segura
CREATE DATABASE Aula11_ex001
GO

-- Começa a utilizar o banco criado
USE Aula11_ex001
GO

-- Cria as tabelas
CREATE TABLE Estado (
	ID_ESTADO INT IDENTITY(1,1) PRIMARY KEY,
	SIGLA CHAR(2)
)

CREATE TABLE Cidade (
	ID_CIDADE INT IDENTITY(1,1) PRIMARY KEY,
	ID_ESTADO INT,
	NOME NVARCHAR(50),

	FOREIGN KEY(ID_ESTADO) REFERENCES Estado (ID_ESTADO) ON UPDATE CASCADE
)

CREATE TABLE Aluno (
	ID_ALUNO INT IDENTITY(1,1) PRIMARY KEY,
	ID_CIDADE INT,
	NOME NVARCHAR(50),
	NASCIMENTO DATE,
	RUA NVARCHAR(50),
	NUMERO INT,
	TELEFONE VARCHAR(16),

	FOREIGN KEY(ID_CIDADE) REFERENCES Cidade (ID_CIDADE) ON UPDATE CASCADE
)

CREATE TABLE Turma (
	ID_TURMA INT IDENTITY(1,1) PRIMARY KEY,
	NOME NVARCHAR(50),
	VAGAS INT
)

CREATE TABLE Matricula (
	ID_MATRICULA INT IDENTITY(1,1) PRIMARY KEY,
	ID_TURMA INT,
	ID_ALUNO INT,
	SITUACAO NVARCHAR(30),

	FOREIGN KEY(ID_TURMA) REFERENCES Turma (ID_TURMA) ON DELETE CASCADE,
	FOREIGN KEY(ID_ALUNO) REFERENCES Aluno (ID_ALUNO) ON DELETE CASCADE
)

-- Insere todos os estados brasileiros
INSERT INTO Estado(SIGLA) VALUES
('AC'),
('AL'),
('AP'),
('AM'),
('BA'),
('CE'),
('DF'),
('ES'),
('GO'),
('MA'),
('MT'),
('MS'),
('MG'),
('PA'),
('PB'),
('PR'),
('PE'),
('PI'),
('RJ'),
('RN'),
('RS'),
('RO'),
('RR'),
('SC'),
('SP'),
('SE'),
('TO');

-- Declara as variáveis do id de alguns estados
DECLARE @ID_PE INT
DECLARE @ID_SP INT
DECLARE @ID_AL INT
DECLARE @ID_RJ INT

-- Busca os IDs de cada um
SELECT @ID_PE = ID_ESTADO FROM Estado WHERE SIGLA = 'PE';
SELECT @ID_SP = ID_ESTADO FROM Estado WHERE SIGLA = 'SP';
SELECT @ID_AL = ID_ESTADO FROM Estado WHERE SIGLA = 'AL';
SELECT @ID_RJ = ID_ESTADO FROM Estado WHERE SIGLA = 'RJ';

-- Se qualquer um tiver NULL, o banco retorna um erro
IF @ID_PE IS NULL OR @ID_SP IS NULL OR @ID_AL IS NULL OR @ID_RJ IS NULL
    THROW 50000, 'Um ou mais estados não foram encontrados!', 1;

-- Insere algumas cidades nesses estados
INSERT INTO Cidade(ID_ESTADO, NOME) VALUES
(@ID_PE, 'Recife'),
(@ID_PE, 'Caruaru'),
(@ID_PE, 'Peroba'),

(@ID_SP, 'São Paulo'),
(@ID_SP, 'Guarulhos'),

(@ID_AL, 'Maceió'),
(@ID_AL, 'Arapiraca'),

(@ID_RJ, 'Niterói'),
(@ID_RJ, 'Petrópolis');

-- Inserindo alguns alunos
INSERT INTO Aluno(ID_CIDADE, NOME, NASCIMENTO, RUA, NUMERO, TELEFONE) VALUES
(3, 'Pedro Rocha', '02/03/03', 'Rua da Prata', 34, '(11) 9 5634-9812'),
(5, 'Carla Maria', '22/11/07', 'Rua da Visconde', 79, '(82) 9 5634-9812'),
(6, 'Jorge Amado', '10/08/12', 'Rua Capitães da Areia', 33, '(21) 9 5634-9812');

-- Inserindo duas turmas
INSERT INTO Turma(NOME, VAGAS) VALUES
('Biologia', 30),
('Matemática', 12);

-- Inserindo algumas matrículas
INSERT Matricula(ID_TURMA, ID_ALUNO, SITUACAO) VALUES
(1, 1, 'Finalizado'),
(1, 2, 'Cursando'),
(1, 3, 'Finalizado');
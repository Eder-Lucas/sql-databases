-- Usa o master por segurança
USE master
GO

-- Se já existir o banco dessa aula
-- Remove todos os usuários e cancela as transações para excluir de forma segura
IF DB_ID('Aula11_ex002') IS NOT NULL
BEGIN
	ALTER DATABASE Aula11_ex002
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE

	DROP DATABASE Aula11_ex002
END
GO

-- Cria o banco do exemplo 002
CREATE DATABASE Aula11_ex002
GO

-- Começa a usar o banco criado
USE Aula11_ex002
GO

-- Cria as tabelas
CREATE TABLE Estado(
	ID_ESTADO INT IDENTITY PRIMARY KEY,
	SIGLA CHAR(2)
)

CREATE TABLE Cidade(
	ID_CIDADE INT IDENTITY PRIMARY KEY,
	NOME NVARCHAR(30),
	ID_ESTADO INT,

	FOREIGN KEY(ID_ESTADO) REFERENCES Estado(ID_ESTADO) ON UPDATE CASCADE
)

CREATE TABLE Departamento(
	ID_DEPARTAMENTO INT IDENTITY(1,1) PRIMARY KEY,
	NOME_DEPARTAMENTO NVARCHAR(50),
)

CREATE TABLE Empregado(
	ID_EMPREGADO INT IDENTITY(1,1) PRIMARY KEY,
	NOME_EMPREGADO NVARCHAR(50),
	RUA NVARCHAR(30),
	NUMERO INT,
	ID_CIDADE INT,
	TELEFONE VARCHAR(16),
	FUNCAO NVARCHAR(30),
	SALARIO DECIMAL(6,2),
	DIA_PAGAMENTO TINYINT
)

CREATE TABLE Historico(
	ID_HISTORICO INT IDENTITY(1,1) PRIMARY KEY,
	ID_EMPREGADO INT,
	ID_DEPARTAMENTO INT,
	DATA_INICIO DATE,
	DATA_TERMINO DATE,

	FOREIGN KEY(ID_EMPREGADO) REFERENCES Empregado(ID_EMPREGADO) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ID_DEPARTAMENTO) REFERENCES Departamento(ID_DEPARTAMENTO) ON DELETE CASCADE ON UPDATE CASCADE
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

-- Declara a variavel que vai armazenar o ID_ESTADO
DECLARE @ID_PE INT

-- Busca os ID
SELECT @ID_PE = ID_ESTADO FROM Estado WHERE SIGLA = 'PE';

-- Se o estado tiver inválido
IF @ID_PE IS NULL
    THROW 50000, 'Estado não encontrado!', 1;

-- Insere algumas cidades nesse estado
INSERT INTO Cidade(ID_ESTADO, NOME) VALUES
(@ID_PE, 'Recife'),
(@ID_PE, 'Caruaru'),
(@ID_PE, 'Peroba');

-- Inserindo alguns dados iniciais
INSERT INTO Empregado(NOME_EMPREGADO, RUA, NUMERO, ID_CIDADE, TELEFONE, FUNCAO, SALARIO, DIA_PAGAMENTO) VALUES
('João Vaqueiro', 'Rua Wakanda', 123, 1, '(81) 9 8767-5445', 'Analista', 2000.00, 10),
('Pedro Antônio', 'Rua do Fogo', 56, 2, '(81) 9 2323-6789', 'Gerente', 1950.00, 10),
('Roberto Carlos', 'Av. Caxangá', 03, 3, '(81) 9 5555-3332', 'Recepcionista', 1300.00, 10);

INSERT INTO Departamento(NOME_DEPARTAMENTO) VALUES
('Marketing'),
('Design'),
('Vendas');

INSERT INTO Historico(ID_EMPREGADO, ID_DEPARTAMENTO, DATA_INICIO, DATA_TERMINO)
VALUES(1, 2, '12/02/23', NULL);

USE master
GO

-- Se já existir o banco dessa aula, remove ele de forma segura
IF DB_ID('Aula15_projetoFinal') IS NOT NULL
BEGIN
	ALTER DATABASE Aula15_projetoFinal
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE

	DROP DATABASE Aula15_projetoFinal
END
GO

-- Cria o banco da aula
CREATE DATABASE Aula15_projetoFinal
GO

USE Aula15_projetoFinal
GO

CREATE TABLE Produto (
    ID_PRODUTO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    NOME_PRODUTO NVARCHAR(50) NOT NULL,
    DESCRICAO_PRODUTO NVARCHAR(100) NOT NULL
);

CREATE TABLE Estado (
    ID_ESTADO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    NOME NVARCHAR(50) NOT NULL,
    SIGLA CHAR(2) NOT NULL
);

CREATE TABLE Cidade (
    ID_CIDADE INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    NOME NVARCHAR(50) NOT NULL,
    ID_ESTADO INT NOT NULL,

	CONSTRAINT FK_CIDADE_ESTADO FOREIGN KEY(ID_ESTADO) REFERENCES Estado(ID_ESTADO)
);

CREATE TABLE Endereco (
    ID_ENDERECO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    RUA NVARCHAR(50) NOT NULL,
    NUMERO NVARCHAR(7) NOT NULL,
    BAIRRO NVARCHAR(50) NOT NULL,
    COMPLEMENTO NVARCHAR(50),
    ID_CIDADE INT NOT NULL,
    CEP NVARCHAR(10) NOT NULL,

	CONSTRAINT FK_ENDERECO_CIDADE FOREIGN KEY(ID_CIDADE) REFERENCES Cidade(ID_CIDADE)
);

CREATE TABLE Fornecedor (
    ID_FORNECEDOR INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    NOME_FORNECEDOR NVARCHAR(50) NOT NULL,
    ID_ENDERECO INT NOT NULL,
    DESCRICAO_FORNECEDOR NVARCHAR(200) NOT NULL,

	CONSTRAINT FK_FORNECEDOR_ENDERECO FOREIGN KEY(ID_ENDERECO) REFERENCES Endereco(ID_ENDERECO)
);

CREATE TABLE Trabalho (
    ID_TRABALHO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    ID_ENDERECO INT NOT NULL,
    PROPRIETARIO NVARCHAR(50) NOT NULL,
    DESCRICAO_TRABALHO NVARCHAR(100) NOT NULL,

	CONSTRAINT FK_TRABALHO_ENDERECO FOREIGN KEY(ID_ENDERECO) REFERENCES Endereco(ID_ENDERECO)
);

CREATE TABLE Funcionario (
    ID_FUNCIONARIO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    NOME_FUNCIONARIO VARCHAR(50) NOT NULL,
    ID_ENDERECO INT NOT NULL,
    FUNCAO VARCHAR(50) NOT NULL,

	CONSTRAINT FK_FUNCIONARIO_ENDERECO FOREIGN KEY(ID_ENDERECO) REFERENCES Endereco(ID_ENDERECO)
);

CREATE TABLE Pedido (
    ID_PEDIDO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    ID_FORNECEDOR INT NOT NULL,
    ID_TRABALHO INT NOT NULL,
    ID_FUNCIONARIO INT NOT NULL,
    ID_PRODUTO INT NOT NULL,
    DATA_SOLICITACAO DATETIME NOT NULL,
    DATA_ATENDIDO DATETIME,

	CONSTRAINT FK_PEDIDO_FORNECEDOR FOREIGN KEY(ID_FORNECEDOR) REFERENCES Fornecedor(ID_FORNECEDOR),
	CONSTRAINT FK_PEDIDO_TRABALHO FOREIGN KEY(ID_TRABALHO) REFERENCES Trabalho(ID_TRABALHO),
	CONSTRAINT FK_PEDIDO_FUNCIONARIO FOREIGN KEY(ID_FUNCIONARIO) REFERENCES Funcionario(ID_FUNCIONARIO),
	CONSTRAINT FK_PEDIDO_PRODUTO FOREIGN KEY(ID_PRODUTO) REFERENCES Produto(ID_PRODUTO)
);

-- Insere dados iniciais
INSERT INTO Estado (NOME, SIGLA) VALUES
('Acre', 'AC'),
('Alagoas', 'AL'),
('Amapá', 'AP'),
('Amazonas', 'AM'),
('Bahia', 'BA'),
('Ceará', 'CE'),
('Distrito Federal', 'DF'),
('Espírito Santo', 'ES'),
('Goiás', 'GO'),
('Maranhão', 'MA'),
('Mato Grosso', 'MT'),
('Mato Grosso do Sul', 'MS'),
('Minas Gerais', 'MG'),
('Pará', 'PA'),
('Paraíba', 'PB'),
('Paraná', 'PR'),
('Pernambuco', 'PE'),
('Piauí', 'PI'),
('Rio de Janeiro', 'RJ'),
('Rio Grande do Norte', 'RN'),
('Rio Grande do Sul', 'RS'),
('Rondônia', 'RO'),
('Roraima', 'RR'),
('Santa Catarina', 'SC'),
('São Paulo', 'SP'),
('Sergipe', 'SE'),
('Tocantins', 'TO');

DECLARE @ID_PE INT
DECLARE @ID_BA INT

SELECT @ID_PE = ID_ESTADO FROM Estado WHERE SIGLA = 'PE'
SELECT @ID_BA = ID_ESTADO FROM Estado WHERE SIGLA = 'BA'

INSERT INTO Cidade(NOME, ID_ESTADO) VALUES
('Recife', @ID_PE),
('Salvador', @ID_BA);

INSERT INTO Endereco(RUA, NUMERO, BAIRRO, COMPLEMENTO, ID_CIDADE, CEP) VALUES
('Rua do Caixote', '1123', 'Centro', 'Proximo a Bom Destino', 1, '2220-000'),
('Av. Dourados', '234', 'Pescados', NULL, 2, '5560-090'),
('Rod. Luiz Carlos', '1900', 'Centro', 'Ao lado do Galpão 12', 1, '2220-001'),
('Rod. Luiz Carlos', '1901', 'Centro', 'Em frente a Chico Construção', 1, '2220-001'),
('Rua Vicente Claro', '12', 'Rio Vermellho', NULL, 2, '5561-204');

INSERT INTO Funcionario(NOME_FUNCIONARIO, ID_ENDERECO, FUNCAO) VALUES
('Francisco Alves', 1, 'Engenheiro Civil'),
('Edvaldo Carvalho', 2, 'Engenheiro Civil'),
('Rivaldo Peixoto', 2, 'Pedreiro Sênior');

INSERT INTO Fornecedor VALUES
('Chico Construção & Servicos', 3, 'Revenda de materiais de construção'),
('Ricardinho Encanamentos', 4, 'Revenda de materias de encanamento');

INSERT Produto(NOME_PRODUTO, DESCRICAO_PRODUTO) VALUES
('Tijolo', 'Bloco de tijolo cozido'),
('Areia Fina', 'Areia do tipo fina'),
('Areia Grossa', 'Areia do tipo grossa'),
('Cimento Woltorium', 'Cimento para construção'),
('Tubo esgoto 90mm', 'Tubo para esgoto com 90mm'),
('Cal Woltorium', 'Cal para pinturas diversas');

INSERT Trabalho(ID_ENDERECO, PROPRIETARIO, DESCRICAO_TRABALHO) VALUES
(4, 'Pedro Xavier', 'Fazer o canal de esgoto da propriedade');

INSERT Pedido(ID_FORNECEDOR, ID_TRABALHO, ID_FUNCIONARIO, ID_PRODUTO, DATA_SOLICITACAO, DATA_ATENDIDO) VALUES
(1, 1, 2, 2, '12/08/25', '13/09/26'),
(2, 1, 1, 5, '13/08/25', NULL),
(1, 1, 3, 1, '11/08/25', NULL),
(1, 1, 3, 4, '11/08/25', NULL),
(1, 1, 3, 6, '14/08/25', '20/08/25');
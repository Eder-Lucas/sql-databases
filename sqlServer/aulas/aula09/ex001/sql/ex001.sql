-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.

/*
----- regras de comportamento da FK -----
CASCADE: apaga os filhos automaticamente
NO ACTION: impede apagar
SET NULL: deixa NULL 
SET DEFAULT: mantém com valor padrão
*/

CREATE DATABASE Aula09_ex001
GO

USE Aula09_ex001
GO

CREATE TABLE Estado (
	ID_ESTADO Int PRIMARY KEY,
	SIGLA Char(2)
)

CREATE TABLE Cidade (
	ID_CIDADE Int PRIMARY KEY,
	ID_ESTADO Int,
	NOME Nvarchar(50),

	-- FOREIGN KEY(ID_ESTADO) >> Essa coluna aqui (ID_ESTADO) é uma chave estrangeira
	-- REFERENCES Estado (ID_ESTADO) >> Esse ID_ESTADO vem da tabela Estado
	-- ON UPDATE CASCADE >> Se o ID_ESTADO mudar na tabela Estado, atualiza automaticamente aqui também
	-- Essa tabela DEPENDE da tabela Estado, sem estado não existe cidade
	FOREIGN KEY(ID_ESTADO) REFERENCES Estado (ID_ESTADO) ON UPDATE CASCADE
)

CREATE TABLE Aluno (
	ID_ALUNO Int PRIMARY KEY,
	ID_CIDADE Int,
	NOME Nvarchar(50),
	NASCIMENTO Date,
	RUA Nvarchar(50),
	NUMERO Int,
	TELEFONE Varchar(16),

	-- Se o ID_CIDADE for alterado na tabela Cidade, ele é atualizado aqui automaticamente
	-- Como não foi definido ON DELETE, o padrão é NO ACTION
	-- Se a cidade for apagada, o banco bloqueia o DELETE para manter a integridade referencial
	FOREIGN KEY(ID_CIDADE) REFERENCES Cidade (ID_CIDADE) ON UPDATE CASCADE
)

CREATE TABLE Turma (
	ID_TURMA Int PRIMARY KEY,
	NOME Nvarchar(50),
	VAGAS Int
)

CREATE TABLE Matricula (
	ID_MATRICULA Int PRIMARY KEY,
	ID_TURMA Int,
	ID_ALUNO Int,
	SITUACAO Bit,

	-- Quando ID_TURMA é deletado na tabela Turma, é apagado aqui também
	-- Apagando a matricula pois ela depende desses dados
	-- Não é o ideal pois o histórico das matrículas devem ser mantidos
	FOREIGN KEY(ID_TURMA) REFERENCES Turma (ID_TURMA) ON DELETE CASCADE,
	FOREIGN KEY(ID_ALUNO) REFERENCES Aluno (ID_ALUNO) ON DELETE CASCADE
)
/*
SOFT DELETE >>
Ao invés de apagar: ATIVO = 0
Desativa aquela linha e o dado continua no banco
*/
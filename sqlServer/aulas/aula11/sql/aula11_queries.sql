-- Usando o banco dessa aula
USE Aula11_ex001
GO

-- Inserindo um estado
INSERT INTO Estado(ID_ESTADO, SIGLA)
VALUES(17, 'PE');

-- Atualizando um estado
UPDATE Estado
SET SIGLA = 'SP'
WHERE SIGLA = 'PE'

-- Deletando um estado
DELETE FROM Estado
WHERE SIGLA = 'SP'

-- Inserindo um aluno
INSERT INTO Aluno
VALUES(1, 'Jacinto Bala', '31/12/93', 'Rua Agente Secreto', 123, '(81) 9 9756-4543');

-- Usando operadores lógicos
-- <> = Diferente
UPDATE Matricula
SET SITUACAO = 'Trancado'
WHERE ID_TURMA = 1 AND SITUACAO <> 'Cursando';
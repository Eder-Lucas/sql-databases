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

-- Mostra o que foi deletado
DELETE FROM Matricula
OUTPUT DELETED.* 
WHERE ID_ALUNO = 1

-- Usando Merge, executando duas operações numa única consulta
-- Se tiver algum aluno cadastrado sem matrícula, a sua matrícula é inserida
-- Se o aluno já tiver matriculado, apenas atualiza os dados
MERGE Matricula
USING Aluno
ON Matricula.ID_ALUNO = Aluno.ID_ALUNO
WHEN NOT MATCHED THEN
INSERT (ID_ALUNO, ID_TURMA, SITUACAO)
VALUES(Aluno.ID_ALUNO, 1, 'Cursando')
WHEN MATCHED THEN
UPDATE SET Matricula.SITUACAO = 'Cursando', Matricula.ID_TURMA = 2
OUTPUT $ACTION, INSERTED.*;

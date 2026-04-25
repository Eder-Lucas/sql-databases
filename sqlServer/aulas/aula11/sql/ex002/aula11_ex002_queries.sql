-- Usando o banco dessa aula
USE Aula11_ex002
GO

-- GETDATE() > Pega a data atual no sistema
INSERT INTO Historico(ID_EMPREGADO, ID_DEPARTAMENTO, DATA_INICIO, DATA_TERMINO)
OUTPUT INSERTED.*
VALUES(2, 3, GETDATE(), NULL);

-- Usando Alias no update
UPDATE h
SET h.DATA_TERMINO = GETDATE()
FROM Historico AS h 
WHERE h.ID_EMPREGADO = 1;

-- Apaga todos os dados
TRUNCATE TABLE Historico;
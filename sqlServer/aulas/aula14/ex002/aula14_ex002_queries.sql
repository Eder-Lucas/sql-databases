USE Aula14_ex002
GO

-- 1. Mostrar o nome de cada funcionário junto com o nome do seu departamento
-- ( NomeFuncionario | Departamento )
SELECT fun.NOME AS FUNCIONARIO, dpt.NOME AS DEPARTAMENTO
FROM Funcionarios fun
INNER JOIN Departamentos dpt
ON dpt.ID_DEPARTAMENTO = fun.ID_DEPARTAMENTO

-- 2. Mostrar todos os departamentos, mesmo aqueles que não possuem funcionários
-- ( Departamento | Funcionario )
SELECT dpt.NOME AS DEPARTAMENTO, fun.NOME AS FUNCIONARIO
FROM Departamentos dpt
LEFT JOIN Funcionarios fun
ON fun.ID_DEPARTAMENTO = dpt.ID_DEPARTAMENTO

-- 3. Mostrar quantos funcionários existem em cada departamento
-- ( Departamento | Quantidade )
SELECT dpt.NOME AS DEPARTAMENTO, COUNT(fun.ID_FUNCIONARIO) AS QTD_FUNCIONARIOS
FROM Departamentos dpt
LEFT JOIN Funcionarios fun
ON fun.ID_DEPARTAMENTO = dpt.ID_DEPARTAMENTO
GROUP BY dpt.NOME

-- 4. Mostrar apenas os departamentos que possuem 2 ou mais funcionários
-- ( Departamento | Quantidade )
SELECT dpt.NOME AS DEPARTAMENTO, COUNT(fun.ID_FUNCIONARIO) AS QTD_FUNCIONARIOS
FROM Departamentos dpt
LEFT JOIN Funcionarios fun
ON fun.ID_DEPARTAMENTO = dpt.ID_DEPARTAMENTO
GROUP BY dpt.NOME
HAVING COUNT(fun.ID_FUNCIONARIO) >= 2

-- 5. Mostrar o salário médio de cada departamento
-- ( Departamento | Média Salarial )
SELECT dpt.NOME AS DEPARTAMENTO, AVG(fun.SALARIO) AS MEDIA
FROM Departamentos dpt
LEFT JOIN Funcionarios fun
ON fun.ID_DEPARTAMENTO = dpt.ID_DEPARTAMENTO
GROUP BY dpt.NOME

-- 6. Mostrar o maior salário de cada departamento
-- ( Departamento | Maior Salário )
SELECT dpt.NOME, MAX(fun.SALARIO) AS MAIOR_SALARIO
FROM Departamentos dpt
LEFT JOIN Funcionarios fun
ON fun.ID_DEPARTAMENTO = dpt.ID_DEPARTAMENTO
GROUP BY dpt.NOME

-- 7. Mostrar o menor salário de cada departamento.
-- ( Departamento | Menor Salário )
SELECT dpt.NOME, MIN(fun.SALARIO) AS MENOR_SALARIO
FROM Departamentos dpt
LEFT JOIN Funcionarios fun
ON fun.ID_DEPARTAMENTO = dpt.ID_DEPARTAMENTO
GROUP BY dpt.NOME

-- 8. Mostar em uma única consulta:
-- ( Departamento | Quantidade de Funcionários | Salário Médio | Maior Salário | Menor Salário )
SELECT dpt.NOME AS DEPARTAMENTO, COUNT(fun.ID_FUNCIONARIO) QTD_FUNCIONARIOS, AVG(fun.SALARIO) MEDIA_SALARIO, MAX(fun.SALARIO) MAIOR_SALARIO, MIN(fun.SALARIO) MENOR_SALARIO
FROM Departamentos dpt
LEFT JOIN Funcionarios fun
ON fun.ID_DEPARTAMENTO = dpt.ID_DEPARTAMENTO
GROUP BY dpt.NOME
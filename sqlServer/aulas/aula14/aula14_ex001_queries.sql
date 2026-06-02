USE Aula14_ex001
GO

-- Correspondência dos dois lados
SELECT u.NOME, l.TITULO, a.DATA_ALUGUEL, a.DATA_DEVOLUCAO, a.DEVOLVIDO FROM Aluguel a
INNER JOIN Usuarios u
	ON u.ID_USUARIO = a.ID_USUARIO
INNER JOIN Livros l
	ON l.ID_LIVRO = a.ID_LIVRO

-- Traz tudo da esquerda + o que combina da direita, o que não combina vem como NULL
SELECT NOME, EMAIL, a.ID_LIVRO, u.ID_USUARIO, a.ID_USUARIO
FROM Usuarios u -- ESQUERDA
LEFT JOIN Aluguel a -- DIREITA
	ON u.ID_USUARIO = a.ID_USUARIO

/*
	FROM A
	LEFT JOIN B
	"Quero todas as linhas de A e, se existir correspondência, os dados de B."
*/

-- Outro exemplo mas aqui o titulo aparece
SELECT u.NOME, u.EMAIL, a.ID_LIVRO, ls.TITULO
FROM Usuarios u
LEFT JOIN Aluguel a
	ON u.ID_USUARIO = a.ID_USUARIO
LEFT JOIN Livros ls -- Usa os dados do primeiro left join
	ON ls.ID_LIVRO = a.ID_LIVRO

-- Traz apenas quem não tem aluguel
SELECT NOME, EMAIL, a.ID_LIVRO
FROM Usuarios u
LEFT JOIN Aluguel a
	ON u.ID_USUARIO = a.ID_USUARIO
WHERE a.ID_LIVRO IS NULL

SELECT ls.TITULO, COUNT(*) AS ALUGUEIS
FROM Aluguel a
INNER JOIN Livros ls
	ON a.ID_LIVRO = ls.ID_LIVRO
GROUP BY a.ID_LIVRO, ls.TITULO

-- Conta quantos livros existem em determinadas categorias usando COUNT e LEFT JOIN
SELECT c.NOME, COUNT(ls.ID_LIVRO) AS QUANTIDADE_LIVROS
FROM Categorias c
LEFT JOIN Livros ls
	ON c.ID_CATEGORIA = ls.ID_CATEGORIA 
GROUP BY c.NOME
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

	Quando tiver com dúvida sobre um JOIN, remover o GROUP BY e os COUNTs e fazer um SELECT das colunas envolvidas.
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

-- Traz quantos alugueis cada livro tem
SELECT ls.TITULO, COUNT(*) AS ALUGUEIS
FROM Aluguel a
INNER JOIN Livros ls
	ON a.ID_LIVRO = ls.ID_LIVRO
GROUP BY ls.TITULO

-- Conta quantos livros existem em determinadas categorias usando COUNT e LEFT JOIN
-- COUNT(ls.ID_LIVRO) > Conta apenas as linhas da tabela da direita onde o resultado não é NULL
-- Permitindo que uma categoria sem livro fique com '0', usando (*) ficaria '1' mesmo sendo NULL
SELECT c.NOME, COUNT(ls.ID_LIVRO) AS QUANTIDADE_LIVROS
FROM Categorias c
LEFT JOIN Livros ls
	ON c.ID_CATEGORIA = ls.ID_CATEGORIA 
GROUP BY c.NOME

SELECT ls.TITULO, a.DATA_ALUGUEL, u.NOME
FROM Aluguel a -- Retorna NULL se não tiver associação
RIGHT JOIN Livros ls -- Sempre retorna
	ON a.ID_LIVRO = ls.ID_LIVRO
LEFT JOIN Usuarios u
	ON u.ID_USUARIO = a.ID_USUARIO

-- Todos os autores são retornados, mas os livros podem vir com NULL
SELECT a.NOME_AUTOR, ISNULL(ls.TITULO, 'SEM LIVROS REGISTRADOS') AS TITULO 
FROM Livros ls -- ESQUERDA
RIGHT JOIN Autores a -- DIREITA
	ON a.ID_AUTOR = ls.ID_AUTOR

-- Junta a ideia do LEFT JOIN e RIGHT JOIN
-- Traz todas a linhas da tabela da esquerda e todas da direita, o que não tiver associação fica com NULL
SELECT ls.TITULO, au.NOME_AUTOR, a.DATA_ALUGUEL
FROM Livros ls
FULL JOIN Autores au
	ON ls.ID_AUTOR = au.ID_AUTOR
FULL JOIN Aluguel a
	ON ls.ID_LIVRO = a.ID_LIVRO
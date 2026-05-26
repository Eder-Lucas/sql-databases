USE Aula12_ex001
GO

SELECT * FROM Livros -- Traz todas as informações

SELECT TITULO FROM Livros -- Específica o que quer selecionar

SELECT TITULO, ISBN FROM Livros -- Traz essas duas colunas
ORDER BY TITULO DESC -- Organiza os titulos por ordem decrecente

SELECT COUNT(*) FROM Livros -- Conta os registros existentes

SELECT COUNT(*) FROM Livros WHERE ID_CATEGORIA = 1;

SELECT COUNT(*) FROM Livros WHERE DATA_PUBLICACAO > '2020-12-31';

SELECT Livros.TITULO, Categorias.NOME FROM Livros, Categorias
WHERE Livros.ID_CATEGORIA = Categorias.ID_CATEGORIA

-- GROUP BY: agrupa linhas iguais para permitir cálculos
-- COUNT: conta quantas linhas existem em cada grupo (ou no total)
-- sem GROUP BY > conta tudo
-- com GROUP BY > conta por grupo

SELECT COUNT(*) AS TOTAL_CATEGORIA FROM Livros -- Conta tudo junto
SELECT ID_CATEGORIA, COUNT(*) AS TOTAL_CATEGORIA FROM Livros GROUP BY ID_CATEGORIA -- Quantos livros existem em cada categoria?

-- Quantos livros com determinada categoria existem
-- Seleciona o Nome da categoria
-- Conta quantos registros existem onde: o idCategoria aparece na tabela livros
-- Agrupa pelo nome da Categoria, contando o total de categorias e não apenas retornando o total bruto
SELECT Categorias.NOME, COUNT(*) AS TOTAL_CATEGORIAS FROM Livros, Categorias
WHERE Livros.ID_CATEGORIA = Categorias.ID_CATEGORIA
GROUP BY Categorias.NOME

-- Quantos livros cada autor escreveu
SELECT Autores.NOME_AUTOR, COUNT(*) AS LIVROS_ESCRITOS FROM Autores, Livros
WHERE Livros.ID_AUTOR = Autores.ID_AUTOR
GROUP BY Autores.NOME_AUTOR

-- Quantas vezes cada pessoa alugou cada livro
SELECT 
	Usuarios.NOME, 
	Livros.TITULO, 
	COUNT(*) AS TOTAL_ALUGUEIS 
FROM Usuarios, Aluguel, Livros
WHERE Aluguel.ID_USUARIO = Usuarios.ID_USUARIO AND Livros.ID_LIVRO = Aluguel.ID_LIVRO
GROUP BY Usuarios.NOME, Livros.TITULO
USE Aula13_ex001
GO

-- Cria uma procedure para inserir uma categoria
CREATE PROCEDURE insereCategoria
	@DescricaoCategoria NVARCHAR(50)
AS
BEGIN
	INSERT INTO Categorias(DESCRICAO_CATEGORIA)
	VALUES (@DescricaoCategoria)
END
GO

-- Essa procedure exibe os registros da tabela Produtos
CREATE PROCEDURE mostraProdutos
	@idProduto INT = NULL -- Variável opcional, sem ela teria que fazer: EXEC mostraProdutos NULL
AS
BEGIN
	IF @idProduto IS NOT NULL
	BEGIN
		SELECT * FROM Produtos
		WHERE ID_PRODUTO = @idProduto
	END

	ELSE
	BEGIN
		SELECT * FROM Produtos
	END
END
GO
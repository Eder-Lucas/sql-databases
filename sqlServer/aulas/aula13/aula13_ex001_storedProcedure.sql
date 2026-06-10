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

-- Procedure que cria uma produçãoe já atualiza o estoque 
CREATE PROCEDURE controleProducao
	@quant INT,
	@idProduto INT
AS
BEGIN
	INSERT Producao VALUES(@quant, GETDATE(), @idProduto) -- Insere o produto na produção

	EXEC atualizaEstoque @quant, @idProduto -- Chama a procedure pra atualizar o estoque
	
	SELECT * FROM Estoque
	WHERE ID_PRODUTO = @idProduto
END
GO

-- Procedure para atualizar o estoque de um produto
CREATE PROCEDURE atualizaEstoque
	@quant INT,
	@idProduto INT
AS
BEGIN
	-- Verifica se o produto existe na tabela estoque
	IF EXISTS (
		SELECT 1 FROM Estoque
		WHERE ID_PRODUTO = @idProduto
	)
	BEGIN -- Se existir, atualiza o estoque
		UPDATE Estoque
		SET QTD_ESTOQUE	= QTD_ESTOQUE + @quant
		WHERE ID_PRODUTO = @idProduto
	END

	ELSE -- Se não existir, insere o produto adicionando a quantidade em estoque
	BEGIN
		INSERT INTO Estoque(ID_PRODUTO, QTD_ESTOQUE) VALUES
		(@idProduto, @quant)
	END
END
GO

-- Retorna a quantidade através do select
CREATE PROCEDURE quantidadeProduto
	@idProduto INT,
	@qtdProduzida INT OUTPUT
AS
BEGIN
	SELECT @qtdProduzida = QTD_ESTOQUE
	FROM Estoque
		WHERE ID_PRODUTO = @idProduto
END
GO

CREATE PROCEDURE insereProduto
	@nome NVARCHAR(50),
	@descricao NVARCHAR(200),
	@idCategoria INT,
	@idProduto INT OUTPUT
AS
BEGIN
	INSERT INTO Produtos(NOME_PRODUTO, DESCRICAO, ID_CATEGORIA)
	OUTPUT inserted.ID_PRODUTO -- Retorna o id alterado, ou seja, gerado (Result Set)
	VALUES (@nome, @descricao, @idCategoria)

	SET @idProduto = SCOPE_IDENTITY() -- Atribui o id à variável
END
GO

CREATE PROCEDURE realizaVenda
	@idProduto INT,
	@qtdVendida INT,
	@dataVenda DATE
AS
BEGIN
	IF @idProduto IS NULL
		OR @qtdVendida IS NULL
		OR @dataVenda IS NULL
	BEGIN
		RETURN 101
	END

	INSERT INTO Vendas(ID_PRODUTO, QTD_VENDIDA, DATA_VENDA)
	OUTPUT INSERTED.*
	VALUES (@idProduto, @qtdVendida, @dataVenda)

	RETURN 0
END
GO
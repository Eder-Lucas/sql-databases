USE Aula13_ex001
GO

-- Executando stored procedures
EXEC sp_help

EXEC insereCategoria
@descricaoCategoria = 'Salgados'
GO

EXEC insereCategoria 'Bolachas'
GO

EXEC mostraProdutos
GO

EXEC mostraProdutos 5
GO

EXEC controleProducao 1,6
GO

EXEC controleProducao 2,5
GO

-- Procedure que retorna um valor
DECLARE @qtd INT
EXEC quantidadeProduto
	5,
	@qtd OUTPUT -- A saída é salva nessa variável

PRINT 'A quantidade desse produto é ' + CAST(@qtd AS VARCHAR(10))

DECLARE @idProduto INT
EXEC insereProduto 
	'Chocolate amargo',
	'1 barra de chocolate amargo',
	2,
	@idProduto OUTPUT

PRINT 'Produto gerado com id ' + CAST(@idProduto AS VARCHAR(20))
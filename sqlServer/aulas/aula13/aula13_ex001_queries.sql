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
	@qtd OUTPUT

PRINT 'A quantidade desse produto é ' + CAST(@qtd AS VARCHAR(10))
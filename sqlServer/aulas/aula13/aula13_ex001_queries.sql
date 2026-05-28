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
USE Aula13_ex001
GO

EXEC sp_help

EXEC insereCategoria
@descricaoCategoria = 'Massas Pães'
GO

EXEC insereCategoria 'Doces'
GO
-- Cria uma procedure para inserir uma categoria
CREATE PROCEDURE insereCategoria
@DescricaoCategoria NVARCHAR(50)
AS
	INSERT INTO Categorias(DESCRICAO_CATEGORIA)
	VALUES (@DescricaoCategoria)
GO
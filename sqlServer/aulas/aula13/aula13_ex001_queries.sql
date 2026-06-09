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


-- Usando Return da Stored Procedure
DECLARE @data DATE = GETDATE()
DECLARE @retorno INT

EXEC @retorno = realizaVenda
	@qtdVendida = 2,
	@dataVenda = @data

SELECT @retorno AS CÓDIGO_SAIDA

IF @retorno = 000
	PRINT 'VENDA REGISTRADA SEM ERROS ÀS ' + CAST(@data AS VARCHAR(20))
ELSE IF @retorno = 101
	PRINT 'VENDA NÃO REGISTRADA POR FALTA DE INFORMAÇÕES'
ELSE
	PRINT 'ERRO DESCONHECIDO'
	
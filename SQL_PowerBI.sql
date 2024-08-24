 
 --PROJETO DE INTEGRAÇÃO SQL SERVER e POWER BI

-- 1. Definindo os indicadores do projeto

-- ABA GERAL

-- i) Receita Total
-- ii) Quantidade Vendida
-- iii) Total de Categorias de Produtos
-- iv) Quantidade de Clientes
-- v) Receita Total e Lucro Total por Mês
-- vi) Margem de Lucro
-- vii) Quantidade Vendida por Mês
-- viii) Lucro por País

-- ABA CLIENTES

-- i) Vendas por País
-- ii) Clientes por País
-- iii) Vendas por Gênero
-- iv) Vendas por Categoria


USE AdventureWorksDW2014

CREATE OR ALTER VIEW RESULTADOS_ADW AS
SELECT
	fis.SalesOrderNumber AS 'Nº PEDIDO',
	fis.OrderDate AS 'DATA PEDIDO',
	dpc.EnglishProductCategoryName AS 'CATEGORIA PRODUTO',
	fis.CustomerKey AS 'ID CLIENTE',
	dc.FirstName + ' ' + dc.LastName AS 'NOME CLIENTE',
	REPLACE(REPLACE(dc.Gender, 'M', 'Masculino'), 'F', 'Feminino') AS 'SEXO',
	dg.EnglishCountryRegionName AS 'PAÍS',
	fis.OrderQuantity AS 'QTD. VENDIDA',
	fis.SalesAmount AS 'RECEITA VENDA',
	fis.TotalProductCost AS 'CUSTO VENDA',
	fis.SalesAmount - fis.TotalProductCost AS 'LUCRO VENDA'
FROM FactInternetSales fis
INNER JOIN DimProduct dp
	ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps
		ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN DimProductCategory dpc
			ON dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimCustomer dc
	ON fis.CustomerKey = dc.CustomerKey
	INNER JOIN DimGeography dg 
		ON dc.GeographyKey = dg.GeographyKey

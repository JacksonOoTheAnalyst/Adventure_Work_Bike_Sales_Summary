--Cleaned DIM_Date Table--
SELECT
      [DateKey],
      [FullDateAlternateKey] AS Date,
      [EnglishDayNameOfWeek] AS Day,
      [EnglishMonthName] AS Month,
      LEFT([EnglishMonthName], 3) AS MonthShort,
      [MonthNumberOfYear] AS MonthNo,
      [CalendarQuarter] AS Quarter,
      [CalendarYear] AS Year
FROM [AdventureWorksDW2019].[dbo].[DimDate]
WHERE CalendarYear >= 2021 AND CalendarYear <= 2023





--Cleaned DIM_Customer Table--
SELECT *

FROM 
  [AdventureWorksDW2019].[dbo].[DimCustomer] AS c 
  LEFT JOIN dbo.DimGeography AS g ON g.GeographyKey = c.GeographyKey 
ORDER BY 
  CustomerKey ASC







  --Cleaned DIM_product Table--
SELECT 
  p.[ProductKey], 
  p.[ProductAlternateKey] AS ProductItemCode, 
  p.[EnglishProductName] AS [Product Name], 
  ps.EnglishProductSubcategoryName AS [Sub Category], 
  pc.EnglishProductCategoryName AS [Product Category], 
  p.[Color] AS [Product Color], 
  p.[Size] AS [Product Size], 
  p.[ProductLine] AS [Product Line], 
  p.[ModelName] AS [Product Model Name], 
  p.[EnglishDescription] AS [Product Description], 
  ISNULL (p.Status, 'Outdated') AS [Product Status] 
FROM 
  [AdventureWorksDW2019].[dbo].[DimProduct] as p 
  LEFT JOIN dbo.DimProductSubCategory AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey 
  LEFT JOIN dbo.DimProductCategory AS pc ON ps.ProductSubcategoryKey = pc.ProductCategoryKey 
ORDER BY 
  p.ProductKey ASC






  --Cleaned FACT_InternetSales Table--
SELECT 
  I.[ProductKey], 
  I.[OrderDateKey], 
  I.[DueDateKey], 
  I.[ShipDateKey], 
  I.[CustomerKey],
  R.[ResellerKey],

  I.[SalesOrderNumber] AS InOrderNumber,
  R.[SalesOrderNumber] AS ReOrderNumber,

  I.[OrderQuantity] AS InOrdreQuantity,
  R.[OrderQuantity] AS ReOrdreQuantity,

  I.[UnitPrice] AS InUnitPrice,
  R.[UnitPrice] AS ReUnitPrice,

  I.[ProductStandardCost] AS InProductCost,
  R.[ProductStandardCost] AS ReProductCost,

  I.[SalesAmount] AS InSalesAmount,
  R.[SalesAmount] AS ReSalesAmount

FROM 
  [AdventureWorksDW2019].[dbo].[FactInternetSales] I
  FULL OUTER JOIN dbo.FactResellerSales AS R ON I.OrderDateKey = R.OrderDateKey 

WHERE 
  LEFT(I.OrderDateKey, 4) >= YEAR(GETDATE()) -5 -- Ensures we always only bring two years of date from extraction.
ORDER BY 
  OrderDateKey ASC







  --Cleaned FACT_ResellertSales Table--
  SELECT 
  [ProductKey], 
  [OrderDateKey], 
  [DueDateKey], 
  [ShipDateKey], 
  [ResellerKey], 
  [PromotionKey],
  [SalesOrderNumber],
  [OrderQuantity],
  [UnitPrice],
  [ProductStandardCost],
  [SalesAmount]
FROM 
  [AdventureWorksDW2019].[dbo].[FactResellerSales] 
WHERE 
  LEFT(OrderDateKey, 4) >= YEAR(GETDATE()) -5 -- Ensures we always only bring two years of date from extraction.
ORDER BY 
  OrderDateKey ASC




  --Cleaned DIM_Reseller Table--
SELECT 
	[ResellerKey],
	[GeographyKey],
	[BusinessType],
	[ResellerName],
	[NumberEmployees]

FROM [AdventureWorksDW2019].[dbo].[DimReseller]
ORDER BY ResellerKey ASC;

  --Cleaned DIM_SalesTerritory Table--
SELECT 
	[SalesTerritoryKey],
	[SalesTerritoryRegion],
	[SalesTerritoryCountry],
	[SalesTerritoryGroup]

FROM [AdventureWorksDW2019].[dbo].[DimSalesTerritory]


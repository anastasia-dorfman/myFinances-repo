USE myFinances
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetAllProducts] 

AS
BEGIN
  	SELECT 
		Product.Id AS ProductId, 
		Product.[Name], 
		ProductSubcategoryId,
		ProductSubcategory.[Name] AS ProductSubcategoryName, 
		ProductCategory.[Name] AS ProductCategoryName
	FROM Product 
		JOIN ProductSubcategory ON Product.ProductSubcategoryId = ProductSubcategory.Id
		JOIN ProductCategory ON ProductCategory.Id = ProductSubcategory.ProductCategoryId 
	ORDER BY Product.[Name];
END
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetProduct] 
	@ProductId AS INT

AS
BEGIN
  	SELECT Product.Id AS ProductId, Product.[Name], ProductSubcategoryId, ProductCategoryId 
	FROM Product JOIN ProductSubcategory ON Product.ProductSubcategoryId = ProductSubcategory.Id
	WHERE Product.Id = @ProductId ;
END
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetProductsWithPrices] 
	@ProductId AS INT

AS
BEGIN
  	SELECT 
		Product.Id AS ProductId, 
		Product.[Name] AS ProductName, 
		ProductSubcategory.[Name] AS ProductSubcategoryName,
		ProductCategory.[Name] AS ProductCategoryName, 
		[Date],
		Retailer.Id AS RetailerId,
		Retailer.[Name] AS RetailerName, 
		Price 
	FROM Product 
		LEFT OUTER JOIN ProductSubcategory ON Product.ProductSubcategoryId = ProductSubcategory.Id
		LEFT OUTER JOIN ProductCategory ON ProductCategory.Id = ProductSubcategory.ProductCategoryId
		LEFT OUTER JOIN ReceiptProduct ON Product.Id = ReceiptProduct.ProductId
		LEFT OUTER JOIN Receipt ON Receipt.Id = ReceiptProduct.ReceiptId
		LEFT OUTER JOIN Retailer ON Receipt.RetailerId = Retailer.Id

	WHERE Product.Id = @ProductId ;
END
GO

/*
CREATE OR ALTER PROCEDURE [dbo].[spGetProductsWithPrices] 
	@ProductId AS INT

AS
BEGIN
  	SELECT 
		ProductId,
		ProductName,
		ProductSubcategoryName,
		ProductCategoryName,
		Date,
		RetailerId,
		RetailerName,
		Price
	FROM (
		SELECT 
			Product.Id AS ProductId, 
			Product.[Name] AS ProductName, 
			ProductSubcategory.[Name] AS ProductSubcategoryName,
			ProductCategory.[Name] AS ProductCategoryName, 
			[Date],
			Retailer.Id AS RetailerId,
			Retailer.[Name] AS RetailerName, 
			Price,
			ROW_NUMBER() OVER (PARTITION BY Price ORDER BY Price ASC) AS PriceRank
		FROM Product 
			JOIN ReceiptProduct ON Product.Id = ReceiptProduct.ProductId
			JOIN Receipt ON Receipt.Id = ReceiptProduct.ReceiptId
			JOIN Retailer ON Receipt.RetailerId = Retailer.Id
			JOIN ProductSubcategory ON Product.ProductSubcategoryId = ProductSubcategory.Id
			JOIN ProductCategory ON ProductCategory.Id = ProductSubcategory.ProductCategoryId
		WHERE ProductId = @ProductId
	) AS RankedResults
	WHERE PriceRank = 1;
END
GO
*/

CREATE OR ALTER PROCEDURE [dbo].[spGetProductsByConsumer] 
	@Consumer AS NVARCHAR(30)

AS
BEGIN
  	SELECT 
		Product.Id AS ProductId, 
		Product.[Name] AS ProductName, 
		ProductSubcategory.[Name] AS ProductSubcategoryName,
		ProductCategory.[Name] AS ProductCategoryName, 
		Consumer, 
		SUM(Amount) AS TotalAmount
	FROM Product 
		JOIN ReceiptProduct ON Product.Id = ReceiptProduct.ProductId
		JOIN Consumer ON ReceiptProduct.Consumer = Consumer.[Name]
		JOIN ProductSubcategory ON Product.ProductSubcategoryId = ProductSubcategory.Id
		JOIN ProductCategory ON ProductCategory.Id = ProductSubcategory.ProductCategoryId
	WHERE Consumer = @Consumer 
	GROUP BY 
		Consumer,
		Product.Id,
		Product.[Name],
		ProductSubcategory.[Name],
		ProductCategory.[Name]
	ORDER BY Product.[Name];
END
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetProductSubcategory] 
	@Id INT

AS
BEGIN
  	SELECT ProductSubcategory.Id, ProductSubcategory.[Name], ProductCategoryId, ProductCategory.[Name] AS CategoryName
	FROM ProductSubcategory INNER JOIN ProductCategory ON ProductSubcategory.ProductCategoryId = ProductCategory.Id
	WHERE ProductSubcategory.Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetProductSubcategories] 

AS
BEGIN
  	SELECT ProductSubcategory.Id, ProductSubcategory.[Name], ProductCategoryId, ProductCategory.[Name] AS CategoryName
	FROM ProductSubcategory INNER JOIN ProductCategory ON ProductSubcategory.ProductCategoryId = ProductCategory.Id
	ORDER BY ProductCategory.[Name], ProductSubcategory.[Name];
END
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetProductCategories] 

AS
BEGIN
  	SELECT * FROM ProductCategory ORDER BY [Name];
END
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetProductSubcategoriesByCategory] 
	@ProductCategoryId INT
AS
BEGIN
  	SELECT * FROM ProductSubcategory WHERE ProductCategoryId = @ProductCategoryId;
END
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetProductsBySubcategory] 
	@ProductSubcategoryId INT
AS
BEGIN
  	SELECT * FROM Product WHERE ProductSubcategoryId = @ProductSubcategoryId ;
END
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetProductsByCategory] 
	@ProductCategoryId INT
AS
BEGIN
  	SELECT * FROM Product JOIN ProductSubcategory ON Product.ProductSubcategoryId = ProductSubcategory.Id 
	WHERE ProductSubcategory.ProductCategoryId = @ProductCategoryId;
END
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetProductCategoryIdBySubcategory] 
	@ProductSubcategoryId INT
AS
BEGIN
  	SELECT ProductCategoryId FROM ProductSubcategory WHERE Id = @ProductSubcategoryId;
END
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetSubcategoryIdByProduct] 
	@ProductId INT
AS
BEGIN
  	SELECT ProductSubcategoryId FROM Product WHERE Id = @ProductId;
END
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetCategoryIdByProduct] 
	@ProductId INT
AS
BEGIN
  	SELECT ProductSubcategory.ProductCategoryId FROM Product JOIN ProductSubcategory ON Product.ProductSubcategoryId = ProductSubcategory.Id WHERE Product.Id = @ProductId;
END
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetConsumers] 

AS
BEGIN
  	SELECT * FROM Consumer ORDER BY [Name];
END
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetAccounts] 

AS
BEGIN
  	SELECT * FROM Account ORDER BY [Name];
END
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetRetailers] 

AS
BEGIN
  	SELECT * FROM Retailer ORDER BY [Name];
END
GO

CREATE OR ALTER PROCEDURE [dbo].[spGetAllReceiptsWithDetails] 

AS
BEGIN
  	SELECT 
		Receipt.Id, 
		[Date], 
		Comment, 
		IsRecurring, 
		Account.[Name] AS AccountName, 
		Retailer.[Name] AS RetailerName
	FROM Receipt 
		JOIN Account ON Receipt.AccountId = Account.Id
		JOIN Retailer ON Receipt.Id = Retailer.Id 
	ORDER BY Account.[Name], [Date], Retailer.[Name];
END
GO

CREATE OR ALTER PROC [dbo].[spInsertProduct]
	@Id INT OUTPUT,
	@RecordVersion ROWVERSION OUTPUT,
	@Name NVARCHAR(30),
	@SubcategoryId INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO Product([Name], ProductSubcategoryId)			
			VALUES (@Name, @SubcategoryId)

			SET @Id = SCOPE_IDENTITY()

			SET @RecordVersion = (SELECT RecordVersion FROM Product WHERE Id = @Id)

		COMMIT TRAN

	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRAN
		;THROW
	END CATCH
END
GO

CREATE OR ALTER PROC [dbo].[spUpdateProduct]
	@Id INT,
	@RecordVersion ROWVERSION OUTPUT,
	@Name NVARCHAR(30),
	@SubcategoryId INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF @RecordVersion <> (SELECT RecordVersion FROM Product WHERE Id = @Id)
				THROW 51002, 'The record has been updated since you last retrieve it', 1;

			UPDATE Product SET
				[Name] = @Name, 
				ProductSubcategoryId = @SubcategoryId			
			WHERE Id = @Id

			SET @RecordVersion = (SELECT RecordVersion FROM Product WHERE Id = @Id)

		COMMIT TRAN

	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRAN
		;THROW
	END CATCH
END
GO

CREATE OR ALTER PROC [dbo].[spDeleteProduct]
	@Id INT,
	@RecordVersion ROWVERSION

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF @RecordVersion <> (SELECT RecordVersion FROM Product WHERE Id = @Id)
				THROW 51002, 'The record has been updated since you last retrieve it', 1;

			DELETE Product WHERE Id = @Id

		COMMIT TRAN

	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRAN
		;THROW
	END CATCH
END
GO

CREATE OR ALTER PROC [dbo].[spInsertSubcategory]
	@Id INT OUTPUT,
	@Name NVARCHAR(30),
	@CategoryId INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO ProductSubcategory([Name], ProductCategoryId)			
			VALUES (@Name, @CategoryId)

			SET @Id = SCOPE_IDENTITY()

		COMMIT TRAN

	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRAN
		;THROW
	END CATCH
END
GO


CREATE OR ALTER PROC [dbo].[spDeleteSubcategory]
	@Id INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN

			DELETE FROM ProductSubcategory WHERE Id = @Id

		COMMIT TRAN

	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRAN
			;THROW
	END CATCH
END
GO

-- How to insert Lists as a property
-- HOW TO INSERT LIST AS PROPERTY
IF NOT EXISTS (SELECT 1 FROM sys.types WHERE name = 'ReceiptProductsTableType' AND is_table_type = 1)
BEGIN
CREATE TYPE ReceiptProductsTableType AS TABLE
	(ReceiptId INT, ProductId INT, Consumer NVARCHAR(30), Price MONEY, Quantity FLOAT, Amount MONEY)
END
GO

CREATE OR ALTER PROC [dbo].[spInsertReceipt]
	@ReceiptId INT OUTPUT,
	@RecordVersion ROWVERSION OUTPUT,
	@AccountId INT,
	@Date DATETIME2(7),
	@RetailerId INT,
	@Comment NTEXT,
	@IsRecurring BIT,
	@ReceiptProducts ReceiptProductsTableType READONLY

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO Receipt(AccountId, [Date], RetailerId, Comment, IsRecurring)			
			VALUES (@AccountId, @Date, @RetailerId, @Comment, @IsRecurring)

			SET @ReceiptId = SCOPE_IDENTITY()

			INSERT INTO ReceiptProduct
				SELECT @ReceiptId, ProductId, Consumer, Price, Quantity, Amount FROM @ReceiptProducts

			SET @RecordVersion = (SELECT RecordVersion FROM Receipt WHERE Id = @ReceiptId)

		COMMIT TRAN

	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRAN
		;THROW
	END CATCH
END
GO
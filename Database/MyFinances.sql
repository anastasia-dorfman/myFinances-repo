USE [myFinances]
GO
/****** Object:  UserDefinedTableType [dbo].[ReceiptProductsTableType]    Script Date: 12-Feb-24 1:38:40 PM ******/
CREATE TYPE [dbo].[ReceiptProductsTableType] AS TABLE(
	[ReceiptId] [int] NULL,
	[ProductId] [int] NULL,
	[Price] [money] NULL,
	[Quantity] [float] NULL,
	[Amount] [money] NULL
)
GO
/****** Object:  Table [dbo].[Account]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountType] [nvarchar](35) NOT NULL,
	[Name] [nvarchar](35) NOT NULL,
	[Institution] [nvarchar](25) NOT NULL,
	[CreditLimit] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Consumer]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Consumer](
	[Name] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Institution]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Institution](
	[Name] [nvarchar](25) NOT NULL,
	[InstitutionType] [nvarchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[ProductSubcategoryId] [int] NULL,
	[RecordVersion] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductSubcategory]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSubcategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[ProductCategoryId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Receipt]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Receipt](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [int] NOT NULL,
	[Date] [datetime2](7) NOT NULL,
	[RetailerId] [int] NULL,
	[Consumer] [nvarchar](30) NULL,
	[Comment] [ntext] NULL,
	[IsRecurring] [bit] NULL,
	[RecordVersion] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReceiptProduct]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReceiptProduct](
	[ReceiptId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[Quantity] [float] NOT NULL,
	[Amount] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ReceiptId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Retailer]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Retailer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([Id], [AccountType], [Name], [Institution], [CreditLimit]) VALUES (1, N'Personal Chequing Account', N'RBC Personal Chequing', N'RBC', 0.0000)
INSERT [dbo].[Account] ([Id], [AccountType], [Name], [Institution], [CreditLimit]) VALUES (2, N'Personal Credit Card', N'RBC Personal CC', N'RBC', 500.0000)
INSERT [dbo].[Account] ([Id], [AccountType], [Name], [Institution], [CreditLimit]) VALUES (3, N'Personal Line of Credit', N'RBC Personal LoC', N'RBC', 8000.0000)
INSERT [dbo].[Account] ([Id], [AccountType], [Name], [Institution], [CreditLimit]) VALUES (4, N'Business Chequing Acc', N'RBC Business Chequing', N'RBC', 0.0000)
INSERT [dbo].[Account] ([Id], [AccountType], [Name], [Institution], [CreditLimit]) VALUES (5, N'Business Credit Card', N'RBC Business CC', N'RBC', 8000.0000)
INSERT [dbo].[Account] ([Id], [AccountType], [Name], [Institution], [CreditLimit]) VALUES (6, N'Personal Chequing Acc', N'DISCOUNT Chequing', N'ISRAEL DISCOUNTBANK', 0.0000)
INSERT [dbo].[Account] ([Id], [AccountType], [Name], [Institution], [CreditLimit]) VALUES (7, N'Personal Line of Credit 6817013', N'SCOTIA LoC 6817013', N'SCOTIABANK', 8000.0000)
INSERT [dbo].[Account] ([Id], [AccountType], [Name], [Institution], [CreditLimit]) VALUES (8, N'Personal Line of Credit 3687013', N'SCOTIA LoC 3687013', N'SCOTIABANK', 23000.0000)
INSERT [dbo].[Account] ([Id], [AccountType], [Name], [Institution], [CreditLimit]) VALUES (9, N'Personal Credit Card', N'MBNA CC', N'MBNA', 5700.0000)
INSERT [dbo].[Account] ([Id], [AccountType], [Name], [Institution], [CreditLimit]) VALUES (10, N'Personal Credit Card', N'WALMART CC', N'WALMART', 8000.0000)
INSERT [dbo].[Account] ([Id], [AccountType], [Name], [Institution], [CreditLimit]) VALUES (11, N'Personal Credit Card', N'CANADIANTIRE', N'CANADIANTIRE', 3000.0000)
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
INSERT [dbo].[Consumer] ([Name]) VALUES (N'ANASTASIA')
INSERT [dbo].[Consumer] ([Name]) VALUES (N'KONSTANTIN')
INSERT [dbo].[Consumer] ([Name]) VALUES (N'NAOMI')
GO
INSERT [dbo].[Institution] ([Name], [InstitutionType]) VALUES (N'CANADIANTIRE', N'CREDIT CARD')
INSERT [dbo].[Institution] ([Name], [InstitutionType]) VALUES (N'ISRAEL DISCOUNTBANK', N'BANK')
INSERT [dbo].[Institution] ([Name], [InstitutionType]) VALUES (N'MBNA', N'MASTERCARD')
INSERT [dbo].[Institution] ([Name], [InstitutionType]) VALUES (N'RBC', N'BANK')
INSERT [dbo].[Institution] ([Name], [InstitutionType]) VALUES (N'SCOTIABANK', N'BANK')
INSERT [dbo].[Institution] ([Name], [InstitutionType]) VALUES (N'WALMART', N'MASTERCARD')
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [Name], [ProductSubcategoryId]) VALUES (1, N'Tomato', 9)
INSERT [dbo].[Product] ([Id], [Name], [ProductSubcategoryId]) VALUES (2, N'Spring Water', 9)
INSERT [dbo].[Product] ([Id], [Name], [ProductSubcategoryId]) VALUES (3, N'Cucumber', 9)
INSERT [dbo].[Product] ([Id], [Name], [ProductSubcategoryId]) VALUES (4, N'Radish', 9)
INSERT [dbo].[Product] ([Id], [Name], [ProductSubcategoryId]) VALUES (5, N'Strawberry', 9)
INSERT [dbo].[Product] ([Id], [Name], [ProductSubcategoryId]) VALUES (6, N'Sweets', 9)
INSERT [dbo].[Product] ([Id], [Name], [ProductSubcategoryId]) VALUES (7, N'Outwear', 35)
INSERT [dbo].[Product] ([Id], [Name], [ProductSubcategoryId]) VALUES (8, N'Shoes', 35)
INSERT [dbo].[Product] ([Id], [Name], [ProductSubcategoryId]) VALUES (9, N'Underwear', 35)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategory] ON 

INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (1, N'Beauty')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (2, N'Car')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (3, N'Cigarettes')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (4, N'Commute')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (5, N'Documents')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (6, N'Fast food')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (7, N'Fee')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (8, N'Gift')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (9, N'Housing')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (10, N'Health')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (11, N'Misc')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (12, N'Mobile')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (13, N'Naomi')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (14, N'PUBG')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (15, N'Subscriptions')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (16, N'Grocery')
INSERT [dbo].[ProductCategory] ([Id], [Name]) VALUES (17, N'Clothes')
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductSubcategory] ON 

INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (1, N'Cosmetics', 1)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (2, N'Gas', 2)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (3, N'Insurance', 2)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (4, N'Loan', 2)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (5, N'Service', 2)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (6, N'Taxi', 4)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (7, N'Passport', 5)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (8, N'Fast food', 6)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (9, N'Food', 16)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (10, N'Houshold Items', 16)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (11, N'Bank Account Fee', 7)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (12, N'Internet', 9)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (13, N'Laundry', 9)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (14, N'Dentist', 10)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (15, N'Drugs', 10)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (16, N'Supplements', 10)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (17, N'Afterschool', 13)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (18, N'Ballet', 13)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (19, N'Birthday', 13)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (20, N'Gymnastics', 13)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (21, N'Skating', 13)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (22, N'Outings', 13)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (23, N'Rent', 9)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (24, N'Electricity', 9)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (25, N'Insurance', 9)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (27, N'Amazon Prime', 15)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (28, N'Spotify', 15)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (29, N'Yotube', 15)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (30, N'Cigarettes', 3)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (31, N'Gift', 8)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (32, N'Misc', 11)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (33, N'Mobile', 12)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (34, N'PUBG', 14)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (35, N'Clothes', 17)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (36, N'Shoes', 17)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (37, N'Outerwear', 17)
INSERT [dbo].[ProductSubcategory] ([Id], [Name], [ProductCategoryId]) VALUES (39, N'Accessories', 17)
SET IDENTITY_INSERT [dbo].[ProductSubcategory] OFF
GO
SET IDENTITY_INSERT [dbo].[Retailer] ON 

INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (1, N'WALMART')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (2, N'COSTCO')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (3, N'CANADIAN TIRE')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (4, N'SUPERSTORE')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (5, N'GIANT TIGER')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (6, N'DOLLARAMA')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (7, N'DOLLAR STORE')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (8, N'TASTE OF HOMELAND')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (9, N'AMAZON')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (10, N'IKEA')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (11, N'HOSTINGER')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (12, N'PUBLIC MOBILE')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (13, N'LUCKY MOBILE')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (14, N'BELL')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (15, N'GOOGLE')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (16, N'SPOTIFY')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (17, N'WHITE CAB')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (18, N'ATLANTIC BALLET')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (19, N'MARIPOSA')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (20, N'KILLAM')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (21, N'DENTIST - SIPKEMA')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (22, N'SOBEYS')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (23, N'TIM HORTONS')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (24, N'LOVES')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (25, N'CIRCLE K')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (26, N'JEAN COUTU')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (27, N'EAGLES REPAIR')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (28, N'COUCHE-TARD')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (29, N'RBC')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (30, N'SCOTIABANK')
INSERT [dbo].[Retailer] ([Id], [Name]) VALUES (1000, N'UKNOWN')
SET IDENTITY_INSERT [dbo].[Retailer] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [CreditLimit]
GO
ALTER TABLE [dbo].[ProductCategory] ADD  DEFAULT ('UNKNOWN') FOR [Name]
GO
ALTER TABLE [dbo].[ReceiptProduct] ADD  DEFAULT ((1.0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Institution_Account] FOREIGN KEY([Institution])
REFERENCES [dbo].[Institution] ([Name])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Institution_Account]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_ProductSubcategory_Product] FOREIGN KEY([ProductSubcategoryId])
REFERENCES [dbo].[ProductSubcategory] ([Id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_ProductSubcategory_Product]
GO
ALTER TABLE [dbo].[ProductSubcategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_ProductSubcategory] FOREIGN KEY([ProductCategoryId])
REFERENCES [dbo].[ProductCategory] ([Id])
GO
ALTER TABLE [dbo].[ProductSubcategory] CHECK CONSTRAINT [FK_ProductCategory_ProductSubcategory]
GO
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Account_Receipt] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_Account_Receipt]
GO
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Consumer_Receipt] FOREIGN KEY([Consumer])
REFERENCES [dbo].[Consumer] ([Name])
GO
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_Consumer_Receipt]
GO
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Retailer_Receipt] FOREIGN KEY([RetailerId])
REFERENCES [dbo].[Retailer] ([Id])
GO
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_Retailer_Receipt]
GO
ALTER TABLE [dbo].[ReceiptProduct]  WITH CHECK ADD  CONSTRAINT [FK_Product_ReceiptProduct] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[ReceiptProduct] CHECK CONSTRAINT [FK_Product_ReceiptProduct]
GO
ALTER TABLE [dbo].[ReceiptProduct]  WITH CHECK ADD  CONSTRAINT [FK_Receipt_ReceiptProduct] FOREIGN KEY([ReceiptId])
REFERENCES [dbo].[Receipt] ([Id])
GO
ALTER TABLE [dbo].[ReceiptProduct] CHECK CONSTRAINT [FK_Receipt_ReceiptProduct]
GO
/****** Object:  StoredProcedure [dbo].[spDeleteProduct]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[spDeleteProduct]
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
/****** Object:  StoredProcedure [dbo].[spDeleteSubcategory]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROC [dbo].[spDeleteSubcategory]
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
/****** Object:  StoredProcedure [dbo].[spGetAllProducts]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spGetAllProducts] 

AS
BEGIN
  	SELECT 
		Product.Id AS ProductId, 
		Product.[Name], 
		ProductSubcategory.[Name] AS ProductSubcategoryName, 
		ProductCategory.[Name] AS ProductCategoryName
	FROM Product 
		JOIN ProductSubcategory ON Product.ProductSubcategoryId = ProductSubcategory.Id
		JOIN ProductCategory ON ProductCategory.Id = ProductSubcategory.ProductCategoryId 
	ORDER BY Product.[Name];
END
GO
/****** Object:  StoredProcedure [dbo].[spGetProduct]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spGetProduct] 
	@ProductId AS INT

AS
BEGIN
  	SELECT Product.Id AS ProductId, Product.[Name], ProductSubcategoryId, ProductCategoryId 
	FROM Product JOIN ProductSubcategory ON Product.ProductSubcategoryId = ProductSubcategory.Id
	WHERE Product.Id = @ProductId ;
END
GO
/****** Object:  StoredProcedure [dbo].[spGetProductCategories]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spGetProductCategories] 

AS
BEGIN
  	SELECT * FROM ProductCategory ORDER BY [Name];
END
GO
/****** Object:  StoredProcedure [dbo].[spGetProductCategoryIdBySubcategory]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spGetProductCategoryIdBySubcategory] 
	@ProductSubcategoryId INT
AS
BEGIN
  	SELECT ProductCategoryId FROM ProductSubcategory WHERE Id = @ProductSubcategoryId;
END
GO
/****** Object:  StoredProcedure [dbo].[spGetProductsByConsumer]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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

CREATE   PROCEDURE [dbo].[spGetProductsByConsumer] 
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
		JOIN Receipt ON Receipt.Id = ReceiptProduct.ReceiptId
		JOIN Consumer ON Receipt.Consumer = Consumer.[Name]
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
/****** Object:  StoredProcedure [dbo].[spGetProductSubcategories]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spGetProductSubcategories] 

AS
BEGIN
  	SELECT ProductSubcategory.Id, ProductSubcategory.[Name], ProductCategoryId, ProductCategory.[Name] AS CategoryName
	FROM ProductSubcategory INNER JOIN ProductCategory ON ProductSubcategory.ProductCategoryId = ProductCategory.Id
	ORDER BY ProductCategory.[Name], ProductSubcategory.[Name];
END
GO
/****** Object:  StoredProcedure [dbo].[spGetProductSubcategoriesByCategory]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spGetProductSubcategoriesByCategory] 
	@ProductCategoryId INT
AS
BEGIN
  	SELECT * FROM ProductSubcategory WHERE ProductCategoryId = @ProductCategoryId;
END
GO
/****** Object:  StoredProcedure [dbo].[spGetProductSubcategory]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spGetProductSubcategory] 
	@Id INT

AS
BEGIN
  	SELECT ProductSubcategory.Id, ProductSubcategory.[Name], ProductCategoryId, ProductCategory.[Name] AS CategoryName
	FROM ProductSubcategory INNER JOIN ProductCategory ON ProductSubcategory.ProductCategoryId = ProductCategory.Id
	WHERE ProductSubcategory.Id = @Id;
END
GO
/****** Object:  StoredProcedure [dbo].[spGetProductsWithPrices]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spGetProductsWithPrices] 
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
/****** Object:  StoredProcedure [dbo].[spInsertProduct]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[spInsertProduct]
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
/****** Object:  StoredProcedure [dbo].[spInsertReceipt]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[spInsertReceipt]
	@ReceiptId INT OUTPUT,
	@RecordVersion ROWVERSION OUTPUT,
	@AccountId INT,
	@Date DATETIME2(7),
	@RetailerId INT,
	@ConsumerName NVARCHAR(30),
	@Comment NTEXT,
	@IsRecurring BIT,
	@ReceiptProducts ReceiptProductsTableType READONLY

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO Receipt(AccountId, [Date], RetailerId, Consumer, Comment, IsRecurring)			
			VALUES (@AccountId, @Date, @RetailerId, @ConsumerName, @Comment, @IsRecurring)

			SET @ReceiptId = SCOPE_IDENTITY()

			INSERT INTO ReceiptProduct
				SELECT @ReceiptId, ProductId, Price, Quantity, Amount FROM @ReceiptProducts

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
/****** Object:  StoredProcedure [dbo].[spInsertSubcategory]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[spInsertSubcategory]
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
/****** Object:  StoredProcedure [dbo].[spUpdateProduct]    Script Date: 12-Feb-24 1:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[spUpdateProduct]
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

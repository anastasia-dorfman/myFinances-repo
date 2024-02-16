USE myFinances;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'myFinances')
BEGIN
	USE master;
    DROP DATABASE myFinances;  
END;
CREATE DATABASE myFinances;
GO

USE myFinances
GO

---- BEGIN TABLE CREATION ----
CREATE TABLE Institution (
	[Name] NVARCHAR(25) NOT NULL PRIMARY KEY, 
	InstitutionType NVARCHAR(25) NOT NULL
);

CREATE TABLE Account (
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	AccountType NVARCHAR(35) NOT NULL, 
	[Name] NVARCHAR(35) NOT NULL, 
	Institution NVARCHAR(25) NOT NULL,
	CreditLimit MONEY NOT NULL DEFAULT 0,
	CONSTRAINT FK_Institution_Account FOREIGN KEY (Institution) REFERENCES Institution ([Name])
);

CREATE TABLE Retailer (
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[Name] NVARCHAR(40) NOT NULL
);

CREATE TABLE Consumer (
	[Name] NVARCHAR(30) NOT NULL PRIMARY KEY
);

CREATE TABLE Receipt (
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	AccountId INT NOT NULL, 
	[Date] DATETIME2 NOT NULL, 
	RetailerId INT NULL,
	Comment NTEXT NULL, 
	IsRecurring BIT NULL,
	RecordVersion ROWVERSION,
	CONSTRAINT FK_Account_Receipt FOREIGN KEY (AccountId) REFERENCES Account (Id),
	CONSTRAINT FK_Retailer_Receipt FOREIGN KEY (RetailerId) REFERENCES Retailer (Id)
);

CREATE TABLE ProductCategory (
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[Name] NVARCHAR(40) NOT NULL DEFAULT 'UNKNOWN'
);

CREATE TABLE ProductSubcategory (
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[Name] NVARCHAR(40) NOT NULL, 
	ProductCategoryId INT NULL,
	CONSTRAINT FK_ProductCategory_ProductSubcategory FOREIGN KEY (ProductCategoryId) REFERENCES ProductCategory (Id)
);

CREATE TABLE Product (
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[Name] NVARCHAR(30) NOT NULL, 
	ProductSubcategoryId INT NULL, 
	RecordVersion ROWVERSION,
	CONSTRAINT FK_ProductSubcategory_Product FOREIGN KEY (ProductSubcategoryId) REFERENCES ProductSubcategory (Id),
);

--CREATE TABLE Price (
--	[Date] DATETIME2 NOT NULL, 
--	ProductId INT NOT NULL, 
--	RetailerId INT NOT NULL, 
	
--	PRIMARY KEY (ProductId, RetailerId, [Date]),
--	CONSTRAINT FK_Product_Price FOREIGN KEY (ProductId) REFERENCES Product (Id),
--	CONSTRAINT FK_Receipt_Price FOREIGN KEY (RetailerId) REFERENCES Receipt (RetailerId)
--);

CREATE TABLE ReceiptProduct (
	ReceiptId INT NOT NULL, 
	ProductId INT NOT NULL, 
	Consumer NVARCHAR(30) NULL,
	Price MONEY NOT NULL,
	Quantity FLOAT NOT NULL DEFAULT 1.0, 
	Amount MONEY NOT NULL, 
	PRIMARY KEY (ReceiptId, ProductId),
	CONSTRAINT FK_Consumer_ReceiptProduct FOREIGN KEY (Consumer) REFERENCES Consumer ([Name]),
	CONSTRAINT FK_Receipt_ReceiptProduct FOREIGN KEY (ReceiptId) REFERENCES Receipt (Id),
	CONSTRAINT FK_Product_ReceiptProduct FOREIGN KEY (ProductId) REFERENCES Product (Id)
);

---- END TABLE CREATION ----

---- BEGIN SEED DATA ----

/**** INSTITUTION ****/

GO

INSERT INTO Institution ([Name], InstitutionType)
VALUES 
	('RBC', 'BANK'),
	('SCOTIABANK', 'BANK'),
	('ISRAEL DISCOUNTBANK', 'BANK'),
	('MBNA', 'MASTERCARD'),
	('WALMART', 'MASTERCARD'),
	('CANADIANTIRE', 'CREDIT CARD')

GO

/**** CONSUMER ****/

GO

INSERT INTO Consumer ([Name])
VALUES 
	('ANASTASIA'),
	('KONSTANTIN'),
	('NAOMI')

GO

/**** ACCOUNT ****/
SET IDENTITY_INSERT [dbo].Account ON 
GO

INSERT INTO Account (Id, [Name], AccountType, Institution, CreditLimit)
VALUES 
	(1, 'RBC Personal Chequing', 'Personal Chequing Account', 'RBC', 0),
	(2, 'RBC Personal CC', 'Personal Credit Card', 'RBC', 500),
	(3, 'RBC Personal LoC', 'Personal Line of Credit', 'RBC', 8000),
	(4, 'RBC Business Chequing', 'Business Chequing Acc', 'RBC', 0),
	(5, 'RBC Business CC', 'Business Credit Card', 'RBC', 8000),
	(6, 'DISCOUNT Chequing', 'Personal Chequing Acc', 'ISRAEL DISCOUNTBANK', 0),
	(7, 'SCOTIA LoC 6817013', 'Personal Line of Credit 6817013', 'SCOTIABANK', 8000),
	(8, 'SCOTIA LoC 3687013', 'Personal Line of Credit 3687013', 'SCOTIABANK', 23000),
	(9, 'MBNA CC', 'Personal Credit Card', 'MBNA', 5700),
	(10, 'WALMART CC', 'Personal Credit Card', 'WALMART', 8000),
	(11, 'CANADIANTIRE', 'Personal Credit Card', 'CANADIANTIRE', 3000)

SET IDENTITY_INSERT [dbo].Account OFF 
GO

/**** CATEGORY ****/
SET IDENTITY_INSERT [dbo].ProductCategory ON 
GO

INSERT INTO ProductCategory(Id, [Name])
VALUES 
	(1, 'Beauty'),
	(2, 'Car'),
	(3, 'Cigarettes'),
	(4, 'Commute'),
	(5, 'Documents'),
	(6, 'Fast food'),
	(7, 'Fee'),
	(8, 'Gift'),
	(9, 'Housing'),
	(10, 'Health'),
	(11, 'Misc'),
	(12, 'Mobile'),
	(13, 'Naomi'),
	(14, 'PUBG'),
	(15, 'Subscriptions'),
	(16, 'Grocery'),
	(17, 'Clothes')

SET IDENTITY_INSERT [dbo].ProductCategory OFF 
GO

/**** SUBCATEGORY ****/
SET IDENTITY_INSERT [dbo].ProductSubcategory ON 
GO

INSERT INTO ProductSubcategory(Id, [Name], ProductCategoryId)
VALUES 
	(1, 'Cosmetics', 1),
	(2, 'Gas', 2),
	(3, 'Insurance', 2),
	(4, 'Loan', 2),
	(5, 'Service', 2),
	(6, 'Taxi', 4),
	(7, 'Passport', 5),
	(8, 'Fast food', 6),
	(9, 'Food', 16),
	(11, 'Bank Account Fee', 7),
	(12, 'Internet', 9),
	(13, 'Laundry', 9),
	(14, 'Dentist', 10),
	(15, 'Drugs', 10),
	(16, 'Supplements', 10),
	(17, 'Afterschool', 13),
	(18, 'Ballet', 13),
	(19, 'Birthday', 13),
	(20, 'Gymnastics', 13),
	(21, 'Skating', 13),
	(22, 'Outings', 13),
	(23, 'Rent', 9),
	(24, 'Electricity', 9),
	(25, 'Insurance', 9),
	(27, 'Amazon Prime', 15),
	(28, 'Spotify', 15),
	(29, 'Yotube', 15),
	(30, 'Cigarettes',3),
	(31, 'Gift',8),
	(32, 'Misc', 11),
	(33, 'Mobile', 12),
	(34, 'PUBG', 14),
	(10, 'Houshold Items', 16),
	(35, 'Clothes', 17)

SET IDENTITY_INSERT [dbo].ProductSubcategory OFF 
GO

/**** RETAILER ****/
SET IDENTITY_INSERT [dbo].Retailer ON 
GO

INSERT INTO Retailer (Id, [Name])
VALUES 
	(1, 'WALMART'),
	(2, 'COSTCO'),
	(3, 'CANADIAN TIRE'),
	(4, 'SUPERSTORE'),
	(5, 'GIANT TIGER'),
	(6, 'DOLLARAMA'),
	(7, 'DOLLAR STORE'),
	(8, 'TASTE OF HOMELAND'),
	(9, 'AMAZON'),
	(10, 'IKEA'),
	(11, 'HOSTINGER'),
	(12, 'PUBLIC MOBILE'),
	(13, 'LUCKY MOBILE'),
	(14, 'BELL'),
	(15, 'GOOGLE'),
	(16, 'SPOTIFY'),
	(17, 'WHITE CAB'),
	(18, 'ATLANTIC BALLET'),
	(19, 'MARIPOSA'),
	(20, 'KILLAM'),
	(21, 'DENTIST - SIPKEMA'),
	(22, 'SOBEYS'),
	(23, 'TIM HORTONS'),
	(24, 'LOVES'),
	(25, 'CIRCLE K'),
	(26, 'JEAN COUTU'),
	(27, 'EAGLES REPAIR'),
	(28, 'COUCHE-TARD'),
	(29, 'RBC'),
	(30, 'SCOTIABANK'),
	(1000, 'UKNOWN')

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
-------------------------------------------------------------- AUTO-GENERATED --------------------------------------------------------------------
/*
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
*/
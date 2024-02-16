USE myFinances;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'myFinances')
BEGIN
    DROP DATABASE myFinances;  
END;
CREATE DATABASE myFinances;
GO

USE myFinances
GO

---- BEGIN TABLE CREATION ----

CREATE TABLE Account (
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[[Name]] NVARCHAR(35) NOT NULL, 
	Entity NVARCHAR(25) NOT NULL
);

CREATE TABLE Receipt (
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[Name] NVARCHAR(255) NOT NULL, 
	AccountId INT NOT NULL, 
	[Date] DATETIME2 NOT NULL, 
	Comment NVARCHAR(255) NULL, 
	IsRecurring BIT NULL,
	CONSTRAINT FK_Account_Receipt FOREIGN KEY (AccountId) REFERENCES Account (Id);
);

--ALTER TABLE Receipt ADD CONSTRAINT FKReceipt749387 FOREIGN KEY (AccountId) REFERENCES Account (Id);


CREATE TABLE ProductSubcategory (
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[Name] NVARCHAR(40) NOT NULL, 
	ProductCategoryId INT NULL,
	CONSTRAINT FK_ProductCategory_ProductSubcategory FOREIGN KEY (ProductCategoryId) REFERENCES ProductCategory (Id);
);

CREATE TABLE ProductBusiness (
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[Name] NVARCHAR(40) NOT NULL
);

CREATE TABLE ProductCategory (
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[Name] NVARCHAR(40) NOT NULL
);

CREATE TABLE Product (
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[Name] INT NOT NULL, 
	ProductSubcategoryId INT NULL, 
	ProductBusinessId INT NULL,
	CONSTRAINT FK_ProductSubcategory_Product FOREIGN KEY (ProductSubcategoryId) REFERENCES ProductSubcategory (Id),
	CONSTRAINT FK_ProductBusiness_Product FOREIGN KEY (ProductBusinessId) REFERENCES ProductBusiness (Id);
);

ALTER TABLE Receipt_Product ADD CONSTRAINT [contains] FOREIGN KEY (ReceiptId) REFERENCES Receipt (Id);
ALTER TABLE Receipt_Product ADD CONSTRAINT FKReceipt_Pr831898 FOREIGN KEY (ProductId) REFERENCES Product (Id);

CREATE TABLE Price (
	[Date] DATETIME2 NOT NULL PRIMARY KEY, 
	ProductId INT NOT NULL PRIMARY KEY, 
	Price MONEY NULL,
	CONSTRAINT FK_Product_Price FOREIGN KEY (ProductId) REFERENCES Product (Id);
--	PRIMARY KEY ([Date], ProductId)
);

CREATE TABLE ReceiptProduct (
	ReceiptId INT NOT NULL, 
	ProductId INT NOT NULL, 
	Quantity INT NULL, 
	Amount INT NOT NULL, 
	PRIMARY KEY (ReceiptId, ProductId),
	CONSTRAINT FK_Receipt_ReceiptProduct FOREIGN KEY (ReceiptId) REFERENCES Receipt (Id),
	CONSTRAINT FK_Product_ReceiptProduct FOREIGN KEY (ProductId) REFERENCES Product (Id);
);

---- END TABLE CREATION ----

---- BEGIN SEED DATA ----
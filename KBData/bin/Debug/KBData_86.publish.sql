﻿/*
Deployment script for KBData

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "KBData"
:setvar DefaultFilePrefix "KBData"
:setvar DefaultDataPath "C:\Users\Max\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\Max\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
The column [dbo].[Product].[ProductDescription] is being dropped, data loss could occur.

The column [dbo].[Product].[ProductName] is being dropped, data loss could occur.

The column [dbo].[Product].[ProductPrice] is being dropped, data loss could occur.

The column [dbo].[Product].[ProductQuantity] is being dropped, data loss could occur.

The column [dbo].[Product].[Name] on table [dbo].[Product] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [dbo].[Product].[Slug] on table [dbo].[Product] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [dbo].[Product])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[ProductCategory].[ProductCategoryName] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[ProductCategory])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[ProductImage].[ProductImageLocation] is being dropped, data loss could occur.

The column [dbo].[ProductImage].[ProductImageName] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[ProductImage])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Dropping unnamed constraint on [dbo].[Product]...';


GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [DF__tmp_ms_xx__Produ__36B12243];


GO
PRINT N'Dropping unnamed constraint on [dbo].[Product]...';


GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [DF__tmp_ms_xx__Produ__37A5467C];


GO
PRINT N'Dropping unnamed constraint on [dbo].[Product]...';


GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [DF__tmp_ms_xx__Creat__38996AB5];


GO
PRINT N'Dropping unnamed constraint on [dbo].[Product]...';


GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [DF__tmp_ms_xx__LastM__398D8EEE];


GO
PRINT N'Starting rebuilding table [dbo].[Product]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Product] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (100) NOT NULL,
    [Price]        MONEY          DEFAULT 0 NOT NULL,
    [Quantity]     INT            DEFAULT 1 NOT NULL,
    [Slug]         NVARCHAR (100) NOT NULL,
    [Description]  NVARCHAR (MAX) NULL,
    [CreateDate]   DATETIME2 (7)  DEFAULT (getutcdate()) NOT NULL,
    [LastModified] DATETIME2 (7)  DEFAULT (getutcdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Product])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Product] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Product] ([Id], [CreateDate], [LastModified])
        SELECT   [Id],
                 [CreateDate],
                 [LastModified]
        FROM     [dbo].[Product]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Product] OFF;
    END

DROP TABLE [dbo].[Product];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Product]', N'Product';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Altering [dbo].[ProductCategory]...';


GO
ALTER TABLE [dbo].[ProductCategory] DROP COLUMN [ProductCategoryName];


GO
ALTER TABLE [dbo].[ProductCategory]
    ADD [Name] NVARCHAR (50) NULL;


GO
PRINT N'Altering [dbo].[ProductImage]...';


GO
ALTER TABLE [dbo].[ProductImage] DROP COLUMN [ProductImageLocation], COLUMN [ProductImageName];


GO
ALTER TABLE [dbo].[ProductImage]
    ADD [Name]     NVARCHAR (200) NULL,
        [Location] NVARCHAR (50)  NULL;


GO
PRINT N'Altering [dbo].[spGetAllProducts]...';


GO
ALTER PROCEDURE [dbo].[spGetAllProducts]
AS
BEGIN

	SELECT p.Id, p.Name, p.Price, p.Quantity, p.Slug, p.Description, pim.Location, 
			ProductImageString = STUFF((
				SELECT ';'  +  pim.Name FROM ProductImage AS pim
				WHERE pim.ProductId = p.Id
				FOR XML PATH('')),1,1,''),
			ProductCategoryString = STUFF((
				SELECT ';'  +  pc.Name FROM ProductCategory AS pc
				WHERE pc.ProductId = p.Id
				FOR XML PATH('')),1,1,'')
	FROM Product AS p
	LEFT JOIN ProductImage AS pim
	ON pim.ProductId = p.Id

	LEFT JOIN ProductCategory AS pc
	ON pc.ProductId = p.Id

	GROUP BY p.Id, p.Name, p.Price, p.Quantity, p.Slug, p.Description, pim.Location;

END
GO
PRINT N'Altering [dbo].[spGetAllCategories]...';


GO
ALTER PROCEDURE [dbo].[spGetAllCategories]
AS
BEGIN

	SELECT pc.Id, pc.ProductId, pc.Name
	FROM ProductCategory pc
	ORDER BY pc.Name;

END
GO
PRINT N'Update complete.';


GO

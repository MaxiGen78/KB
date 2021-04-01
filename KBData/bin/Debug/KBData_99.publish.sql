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
The column [dbo].[ProductCategory].[ProductId] on table [dbo].[ProductCategory] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/
GO
PRINT N'Starting rebuilding table [dbo].[ProductCategory]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_ProductCategory] (
    [Id]        INT           IDENTITY (1, 1) NOT NULL,
    [ProductId] INT           NOT NULL,
    [Name]      NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[ProductCategory])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_ProductCategory] ON;
        INSERT INTO [dbo].[tmp_ms_xx_ProductCategory] ([Id], [Name])
        SELECT   [Id],
                 [Name]
        FROM     [dbo].[ProductCategory]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_ProductCategory] OFF;
    END

DROP TABLE [dbo].[ProductCategory];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ProductCategory]', N'ProductCategory';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Altering [dbo].[spGetAllCategories]...';


GO
ALTER PROCEDURE [dbo].[spGetAllCategories]
AS
BEGIN

	SELECT pc.Id, pc.pc.Name
	FROM ProductCategory pc
	ORDER BY pc.Name;

END
GO
PRINT N'Refreshing [dbo].[spGetAllProducts]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spGetAllProducts]';


GO
PRINT N'Update complete.';


GO

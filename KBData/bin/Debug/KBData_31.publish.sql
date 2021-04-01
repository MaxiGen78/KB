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
PRINT N'Altering [dbo].[GetAllProducts]...';


GO
ALTER PROCEDURE [dbo].[GetAllProducts]
AS
BEGIN
	SELECT [dbo].[Product].Id , ProductName, ProductQuantity, ProductPrice, ProductDescription, ProductID, ProductImageLocation, 
		   STRING_AGG (ProductImageName, ',') WITHIN GROUP (ORDER BY ProductImageName ASC)
	FROM [dbo].[Product]
	LEFT JOIN [dbo].[ProductImages]
	ON [dbo].[Product].Id = [dbo].[ProductImages].ProductID
	GROUP BY [dbo].[Product].Id;

END
GO
PRINT N'Update complete.';


GO
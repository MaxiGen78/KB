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
PRINT N'Altering [dbo].[Product]...';


GO
ALTER TABLE [dbo].[Product]
    ADD [IsActive] BIT DEFAULT 1 NOT NULL;


GO
PRINT N'Altering [dbo].[spGetAllProducts]...';


GO
ALTER PROCEDURE [dbo].[spGetAllProducts]
AS
BEGIN

	SELECT p.Id, p.Name, p.Price, p.Quantity, p.Slug, p.Description, p.ImageLocation, 
			ImageString = STUFF((
				SELECT ';'  +  pim.Name FROM ProductImage AS pim
				WHERE pim.ProductId = p.Id
				FOR XML PATH('')),1,1,''),
			CategoryString = STUFF((
				SELECT ';'  +  pc.Name FROM ProductCategory AS pc
				WHERE pc.ProductId = p.Id
				FOR XML PATH('')),1,1,'')
	FROM Product AS p 
	
	LEFT JOIN ProductImage AS pim
	ON pim.ProductId = p.Id

	LEFT JOIN ProductCategory AS pc
	ON pc.ProductId = p.Id

	WHERE p.IsActive = 1

	GROUP BY p.Id, p.Name, p.Price, p.Quantity, p.Slug, p.Description, p.ImageLocation;

END
GO
PRINT N'Update complete.';


GO

CREATE TABLE [dbo].[ProductImage]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [ProductId] INT NULL, 
    [Name] NVARCHAR(200) NULL
)

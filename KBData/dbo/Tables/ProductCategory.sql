CREATE TABLE [dbo].[ProductCategory]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
	[ProductId] INT NOT NULL,
    [Name] NVARCHAR(50) NULL
)

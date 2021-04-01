CREATE TABLE [dbo].[Product] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [Name]  NVARCHAR (100) NOT NULL,
	[Price]  money  NOT NULL DEFAULT 0,
	[Quantity] INT NOT NULL DEFAULT 1,
    [Slug]  NVARCHAR (100) NULL,
    [ImageLocation]  NVARCHAR (100) NULL,
    [Description]  NVARCHAR (MAX) NULL,
    [CreateDate]   DATETIME2 (7)  DEFAULT (getutcdate()) NOT NULL,
    [LastModified] DATETIME2 (7)  DEFAULT (getutcdate()) NOT NULL,
    [IsActive] BIT NOT NULL DEFAULT 1, 
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

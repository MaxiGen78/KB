CREATE TABLE [dbo].[OrderDetail]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [OrderId] INT NOT NULL, 
    [ProductId] INT NOT NULL, 
    [Quantity] INT NOT NULL,
    [PurchasePrice] MONEY NOT NULL, 
    [Tax] MONEY NOT NULL    
)

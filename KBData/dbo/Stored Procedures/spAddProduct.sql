CREATE PROCEDURE [dbo].[spAddProduct]
	@Id INT = NULL OUTPUT,
	@Name NVARCHAR(100),
	@Price MONEY,
	@Quantity INT,
	@Slug NVARCHAR(100),
	@ImageLocation NVARCHAR(100),
	@Description NVARCHAR(MAX),
	@CreateDate DATETIME2 = NULL,
	@LastModified DATETIME2 = NULL,
	@IsActive BIT
	
AS
BEGIN

	INSERT INTO Product (Name, Price, Quantity, Slug, ImageLocation, Description, CreateDate, LastModified, IsActive)
	VALUES (@Name, @Price, @Quantity, @Slug, @ImageLocation, @Description, COALESCE(@CreateDate, GETUTCDATE()), COALESCE(@LastModified, GETUTCDATE()), @IsActive)
	SELECT @Name, @Price, @Quantity, @Slug, @ImageLocation, @Description, @IsActive;
    SET @Id = SCOPE_IDENTITY();
END
CREATE PROCEDURE [dbo].[spAddImage]
	@Name nvarchar(200),
	@ProductId int = NULL,
	@Id int = NULL OUTPUT
AS
BEGIN
	INSERT INTO ProductImage(Name, ProductId)
	VALUES (@Name, @ProductId)
	SELECT @Name;
    SET @Id = SCOPE_IDENTITY();
END
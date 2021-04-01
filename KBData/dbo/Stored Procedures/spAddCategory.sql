CREATE PROCEDURE [dbo].[spAddCategory]
	@Name nvarchar(50),
	@Id INT = NULL OUTPUT
AS
BEGIN

	INSERT INTO Category (Name)
	VALUES (@Name)
	SELECT @Name;
    SET @Id = SCOPE_IDENTITY();
END
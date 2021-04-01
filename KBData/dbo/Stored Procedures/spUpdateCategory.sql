CREATE PROCEDURE [dbo].[spUpdateCategory]
	@Name nvarchar(50),
	@Id INT = NULL OUTPUT
AS
BEGIN
	UPDATE Category
	SET Name = @Name
	WHERE Id = @Id;

END
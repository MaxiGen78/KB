CREATE PROCEDURE [dbo].[spDeleteCategory]
	@Name nvarchar(50),
	@Id int
AS
BEGIN
	DELETE FROM dbo.Category WHERE Id = @Id;
END

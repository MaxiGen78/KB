CREATE PROCEDURE [dbo].[spGetCategories]
AS
BEGIN

	SELECT c.Id, c.Name
	FROM Category c
	ORDER BY c.Name;

END


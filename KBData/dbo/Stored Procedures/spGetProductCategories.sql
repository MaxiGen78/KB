CREATE PROCEDURE [dbo].[spGetProductCategories]
AS
BEGIN

	SELECT pc.Id, pc.ProductId, pc.Name
	FROM ProductCategory pc
	ORDER BY pc.Name;

END

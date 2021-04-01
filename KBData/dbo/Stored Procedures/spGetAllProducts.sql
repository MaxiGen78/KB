CREATE PROCEDURE [dbo].[spGetAllProducts]
AS
BEGIN

	SELECT p.Id, p.Name, p.Price, p.Quantity, p.Slug, p.Description, p.ImageLocation, 
			ImageString = STUFF((
				SELECT ';'  +  pim.Name FROM ProductImage AS pim
				WHERE pim.ProductId = p.Id
				FOR XML PATH('')),1,1,''),
			CategoryString = STUFF((
				SELECT ';'  +  pc.Name FROM ProductCategory AS pc
				WHERE pc.ProductId = p.Id
				FOR XML PATH('')),1,1,'')
	FROM Product AS p 
	
	LEFT JOIN ProductImage AS pim
	ON pim.ProductId = p.Id

	LEFT JOIN ProductCategory AS pc
	ON pc.ProductId = p.Id

	WHERE p.IsActive = 1

	GROUP BY p.Id, p.Name, p.Price, p.Quantity, p.Slug, p.Description, p.ImageLocation;

END

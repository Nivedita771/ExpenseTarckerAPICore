create procedure GetAllCategories
(@pageNumber int =1,
@pageSize int =10
)
as
begin
SET NOCOUNT ON;
Select * from Categories
ORDER BY CategoryId
OFFSET (@pageNumber-1)*@pageSize ROWS
FETCH NEXT @pageSize ROWS ONLY

SELECT COUNT(*) AS TotalCount FROM Categories

END
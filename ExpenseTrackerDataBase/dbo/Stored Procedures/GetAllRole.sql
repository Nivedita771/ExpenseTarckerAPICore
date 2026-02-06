create procedure GetAllRole
(
 @pageNumber int =1,
 @pageSize int=10
)
as
begin
SET NOCOUNT ON;
select * from Roles
ORDER BY RoleId
OFFSET (@pageNumber-1)*@pageSize ROWS
FETCH NEXT @pageSize ROWS ONLY;

select count(*) AS TotalCount from Roles
END
CREATE procedure GetAllUsers
(@pageNumber int =1,
@pageSize int =10
)
as
 begin
 SET NOCOUNT ON;
 SELECT u.UserId, u.Username,u.Password, r.RoleName, u.Email
FROM Users u
left join  Roles r ON u.RoleId = r.RoleId
ORDER BY U.UserId
OFFSET (@pageNumber-1) * @pageSize ROWS
FETCH NEXT  @pageSize ROWS ONLY

 SELECT COUNT(*) as TotalCount
FROM Users u
left join  Roles r ON u.RoleId = r.RoleId
end
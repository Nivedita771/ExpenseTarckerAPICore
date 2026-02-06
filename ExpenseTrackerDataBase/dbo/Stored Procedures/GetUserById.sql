CREATE procedure GetUserById
(@userid int)
as
begin
 SELECT u.UserId, u.Username,u.Password, r.RoleName, r.RoleId, u.Email
FROM Users u
left JOIN Roles r ON u.RoleId = r.RoleId
where u.UserId=@userid
end
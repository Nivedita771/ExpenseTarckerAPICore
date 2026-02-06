CREATE procedure ValidateUser
(@username nvarchar(20),
@password nvarchar(256))
as
begin
SELECT u.UserId, u.Username,u.Password, r.RoleName, u.Email, u.RoleId
FROM Users u
JOIN Roles r ON u.RoleId = r.RoleId
WHERE u.Username = @username AND u.Password = @password;
end
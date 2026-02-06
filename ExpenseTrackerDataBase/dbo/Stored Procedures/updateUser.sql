CREATE procedure updateUser(
@userid int,
@username varchar(20),
@roleid int,
@email varchar(30)
)
as
begin
update Users
set UserName=@username, RoleId=@roleid, Email=@email
where UserId=@userid
end

create procedure DeleteUser
(@userid int)
as
begin
delete from Users
where UserId=@userid
end
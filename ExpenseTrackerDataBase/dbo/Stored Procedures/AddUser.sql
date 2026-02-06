CREATE procedure AddUser(
@username varchar(20),
@password varchar(20),
@roleid int,
@email varchar(30)
)
as
begin
 insert into Users
 values( @username, @password, @roleid,@email)
 end
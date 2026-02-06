CREATE PROCEDURE RegisterUser
    @UserName NVARCHAR(100),
    @Password NVARCHAR(100),
    @Email NVARCHAR(100)
AS
BEGIN
    INSERT INTO Users (UserName, Password, Email, RoleId)
    VALUES (@UserName, @Password, @Email, 2)
END

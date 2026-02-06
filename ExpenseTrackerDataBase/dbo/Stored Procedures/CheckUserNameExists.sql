CREATE PROCEDURE [dbo].[CheckUserNameExists]
    @UserName NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT COUNT(1) AS UserExists
    FROM [Users]
    WHERE UserName = @UserName and IsActive=1
END
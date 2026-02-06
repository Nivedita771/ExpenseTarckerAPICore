CREATE PROCEDURE [dbo].[RegisterUser]
    @UserName NVARCHAR(100),
    @Password NVARCHAR(100),
    @Email NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO Users (UserName, Password, Email, RoleId,IsActive)
        VALUES (@UserName, @Password, @Email, 2,1);

        SELECT CAST(SCOPE_IDENTITY() AS INT) AS UserId;
    END TRY
    BEGIN CATCH
        INSERT INTO ErrorLog (ErrorMessage, ErrorProcedure, ErrorLine)
        VALUES (
            ERROR_MESSAGE(),
            ERROR_PROCEDURE(),
            ERROR_LINE()
        );
        SELECT CAST(0 AS INT) AS UserId;
    END CATCH
END
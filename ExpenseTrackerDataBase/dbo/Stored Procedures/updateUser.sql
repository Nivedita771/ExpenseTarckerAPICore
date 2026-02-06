CREATE PROCEDURE updateUser
(
    @userid INT,
    @username VARCHAR(20),
    @roleid INT,
    @email VARCHAR(30)
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE Users
        SET UserName = @username, RoleId = @roleid, Email = @email
        WHERE UserId = @userid;
    END TRY
    BEGIN CATCH
        INSERT INTO ErrorLog (ErrorMessage, ErrorProcedure, ErrorLine)
        VALUES (
            ERROR_MESSAGE(),
            ERROR_PROCEDURE(),
            ERROR_LINE()
        );
        -- THROW;
    END CATCH
END
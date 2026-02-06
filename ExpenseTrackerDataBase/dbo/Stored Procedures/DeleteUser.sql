CREATE procedure DeleteUser
(
    @userid INT
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DELETE FROM Users
        WHERE UserId = @userid;
    END TRY
    BEGIN CATCH
        INSERT INTO ErrorLog (ErrorMessage, ErrorProcedure, ErrorLine)
        VALUES (
            ERROR_MESSAGE(),
            ERROR_PROCEDURE(),
            ERROR_LINE()
        );
    END CATCH
END
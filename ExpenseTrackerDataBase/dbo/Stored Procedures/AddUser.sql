CREATE PROCEDURE AddUser
(
    @username VARCHAR(20),
    @password VARCHAR(20),
    @roleid INT,
    @email VARCHAR(30)
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO Users
        VALUES (@username, @password, @roleid, @email);
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
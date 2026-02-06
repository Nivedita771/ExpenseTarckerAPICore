CREATE procedure CheckExpenseLimitExistForMonth
(
    @userid INT,
    @month INT,
    @year INT
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT COUNT(*) FROM ExpenseLimit 
        WHERE UserId = @userid AND LimitYear = @year AND LimitMonth = @month;
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
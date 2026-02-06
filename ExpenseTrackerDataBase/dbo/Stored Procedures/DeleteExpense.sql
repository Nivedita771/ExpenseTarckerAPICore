CREATE procedure DeleteExpense
(
    @ExpenseId INT
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DELETE FROM Expenses
        WHERE ExpenseId = @ExpenseId;
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
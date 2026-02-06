CREATE PROCEDURE AddExpenses
(
    @Title NVARCHAR(100),
    @Amount DECIMAL(18,2),
    @ExpenseDate DATE,
    @CategoryId INT,
    @UserId INT
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO Expenses
        VALUES(@Title, @Amount, @ExpenseDate, @CategoryId, @UserId);
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
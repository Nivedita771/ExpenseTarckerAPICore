CREATE PROCEDURE AddExpenseLimitForCurrentMonth
(
    @UserId INT,
    @LimitAmount DECIMAL(18,2),
    @LimitMonth INT,
    @LimitYear INT
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO ExpenseLimit(UserId, LimitAmount, LimitMonth, LimitYear)
        VALUES (@UserId, @LimitAmount, @LimitMonth, @LimitYear);
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
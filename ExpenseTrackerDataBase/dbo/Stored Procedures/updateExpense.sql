CREATE Procedure updateExpense
(@ExpenseId int,
@Title nvarchar(100),
@Amount decimal(18,2),
@ExpenseDate date,
@CategoryId int,
@UserId int)
as
begin
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE Expenses
        SET 
            Title = @Title,
            Amount = @Amount,
            ExpenseDate = @ExpenseDate,
            CategoryId = @CategoryId,
            UserId = @UserId
        WHERE ExpenseId = @ExpenseId;
    END TRY
    BEGIN CATCH
        INSERT INTO ErrorLog (ErrorMessage, ErrorProcedure, ErrorLine)
        VALUES (
            ERROR_MESSAGE(),
            ERROR_PROCEDURE(),
            ERROR_LINE()
        );
    END CATCH
end
CREATE PROCEDURE GetTotalExpensesForUser
    @UserId INT,
    @ExpenseMonth INT,
    @ExpenseYear INT
AS
BEGIN
    SELECT ISNULL(SUM(Amount), 0)
    FROM Expenses
    WHERE UserId = @UserId
      AND MONTH(ExpenseDate) = @ExpenseMonth
      AND YEAR(ExpenseDate) = @ExpenseYear
END
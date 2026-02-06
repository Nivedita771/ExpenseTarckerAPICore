CREATE PROCEDURE GetExpenseLimitForUser
    @UserId INT,
    @LimitMonth INT,
    @LimitYear INT
AS
BEGIN
    SELECT TOP 1 LimitAmount
    FROM ExpenseLimit
    WHERE UserId = @UserId AND LimitMonth = @LimitMonth AND LimitYear = @LimitYear
END
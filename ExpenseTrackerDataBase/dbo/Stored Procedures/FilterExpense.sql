CREATE PROCEDURE FilterExpense(    
    @userid INT,    
    @isAdmin BIT = 0,    
    @title VARCHAR(100) = NULL,    
    @amount DECIMAL(18,2) = NULL,    
    @expensefromdate DATE = NULL,    
    @expensetodate DATE = NULL,    
    @categoryid INT = NULL,    
    @sortColumn NVARCHAR(20) = 'Title',    
    @sortDirection NVARCHAR(5) = 'ASC',    
    @pageNumber INT = 1,    
    @pageSize INT = 10    
)    
AS     
BEGIN    
    SET NOCOUNT ON;    

    BEGIN TRY
        DECLARE @offset INT = (@pageNumber - 1) * @pageSize;    

        SELECT e.ExpenseId, e.Title, e.Amount, e.ExpenseDate, e.CategoryId, c.Name AS CategoryName, u.UserName    
        FROM Expenses AS e    
        INNER JOIN Categories AS c ON e.CategoryId = c.CategoryId    
        INNER JOIN Users AS u ON e.UserId = u.UserId    
        WHERE (@isAdmin = 1 OR e.UserId = @userid)    
          AND (@title IS NULL OR e.Title LIKE '%' + @title + '%')    
          AND (@amount IS NULL OR e.Amount = @amount)    
          AND (@expensefromdate IS NULL OR e.ExpenseDate >= @expensefromdate)    
          AND (@expensetodate IS NULL OR e.ExpenseDate <= @expensetodate)    
          AND (@categoryid IS NULL OR e.CategoryId = @categoryid)    
        ORDER BY     
            CASE WHEN @sortColumn = 'Title' AND @sortDirection = 'ASC' THEN e.Title END ASC,    
            CASE WHEN @sortColumn = 'Title' AND @sortDirection = 'DESC' THEN e.Title END DESC,    
            CASE WHEN @sortColumn = 'Amount' AND @sortDirection = 'ASC' THEN e.Amount END ASC,    
            CASE WHEN @sortColumn = 'Amount' AND @sortDirection = 'DESC' THEN e.Amount END DESC,    
            CASE WHEN @sortColumn = 'ExpenseDate' AND @sortDirection = 'ASC' THEN e.ExpenseDate END ASC,    
            CASE WHEN @sortColumn = 'ExpenseDate' AND @sortDirection = 'DESC' THEN e.ExpenseDate END DESC    
        OFFSET @offset ROWS    
        FETCH NEXT @pageSize ROWS ONLY;    

        SELECT COUNT(*) AS TotalCount    
        FROM Expenses    
        WHERE (@isAdmin = 1 OR UserId = @userid)    
          AND (@title IS NULL OR Title LIKE '%' + @title + '%')    
          AND (@amount IS NULL OR Amount = @amount)    
          AND (@expensefromdate IS NULL OR ExpenseDate >= @expensefromdate)    
          AND (@expensetodate IS NULL OR ExpenseDate <= @expensetodate)    
          AND (@categoryid IS NULL OR CategoryId = @categoryid);    
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
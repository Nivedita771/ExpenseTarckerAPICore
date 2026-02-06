
CREATE PROCEDURE sp_CheckExpenseLimitsAndNotify
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserId INT,
            @UserName NVARCHAR(100),
            @UserEmail NVARCHAR(100),
            @LimitAmount DECIMAL(18,2),
            @TotalExpense DECIMAL(18,2),
            @EmailBody NVARCHAR(MAX);

    -- Cursor declaration
    DECLARE user_cursor CURSOR FOR
        SELECT 
            el.UserId, 
            u.UserName,
			u.Email,
            el.LimitAmount,
            (SELECT ISNULL(SUM(Amount), 0)
             FROM Expenses
             WHERE UserId = el.UserId
               AND MONTH(ExpenseDate) = el.LimitMonth
               AND YEAR(ExpenseDate) = el.LimitYear)
        FROM [ExpenseLimit] el
        INNER JOIN [Users] u ON el.UserId = u.UserId
        WHERE el.LimitMonth = MONTH(GETDATE()) AND el.LimitYear = YEAR(GETDATE());

    OPEN user_cursor;
    FETCH NEXT FROM user_cursor INTO @UserId, @UserName,@UserEmail, @LimitAmount, @TotalExpense;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRY
            IF @TotalExpense > @LimitAmount
            BEGIN
                SET @EmailBody = 'Dear ' + @UserName + ',<br/><br/>You have exceeded your monthly expense limit of ' 
                                + CAST(@LimitAmount AS NVARCHAR) + '. Your total expenses so far is ' 
                                + CAST(@TotalExpense AS NVARCHAR) + '.<br/><br/>Please review your expenses.';

                EXEC msdb.dbo.sp_send_dbmail
                    @profile_name = 'ExpenseTrackerProfile',
                    @recipients = @UserEmail,
                    @subject = 'Expense Limit Exceeded',
                    @body = @EmailBody,
                    @body_format = 'HTML';
            END
        END TRY
        BEGIN CATCH
            -- Log errors for individual user processing
            INSERT INTO ErrorLog (ErrorMessage, ErrorProcedure, ErrorLine)
            VALUES (
                ERROR_MESSAGE(),
                ERROR_PROCEDURE(),
                ERROR_LINE()
            );
        END CATCH;

        FETCH NEXT FROM user_cursor INTO @UserId, @UserName,@UserEmail, @LimitAmount, @TotalExpense;
    END

    CLOSE user_cursor;
    DEALLOCATE user_cursor;
END;
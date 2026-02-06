CREATE procedure FilterExpense(    
@userid int,    
@isAdmin bit =0,    
@title varchar(100) null,    
@amount decimal(18,2) null,    
@expensefromdate date null,    
@expensetodate date null,    
@categoryid int null ,    
@sortColumn nvarchar(20) = 'Title',    
@sortDirection nvarchar(5)='ASC',    
@pageNumber  int =1,    
@pageSize int =10    
    
)    
as     
begin    
SET NOCOUNT ON;    
    
declare @offset int =(@pageNumber-1) * @pageSize;    
    
select e.ExpenseId,e.Title,e.Amount,e.ExpenseDate,e.CategoryId, c.Name as CategoryName , u.UserName    
from Expenses as e    
inner join Categories as c on e.CategoryId=c.CategoryId    
inner join Users as u on e.UserId=u.UserId    
where (@isAdmin=1 or e.UserId=@userid)    
and     
(@title is null or e.Title like '%' + @title +'%')    
and (@amount is null or e.Amount=@amount)    
and ( @expensefromdate is null or e.ExpenseDate >= @expensefromdate)    
and( @expensetodate is null or e.ExpenseDate <=@expensetodate)    
and( @categoryid is null or e.CategoryId=@categoryid)    
order by     
CASE     
    WHEN @sortColumn='Title' and @sortDirection='ASC' then e.Title     
END ASC,    
CASE     
    WHEN @sortColumn='Title' and @sortDirection='DESC' then e.Title    
END DESC,    
CASE     
    WHEN @sortColumn = 'Amount' AND @sortDirection = 'ASC' THEN e.Amount    
END ASC,    
CASE     
 WHEN @sortColumn = 'Amount' AND @sortDirection = 'DESC' THEN e.Amount    
END DESC,    
CASE     
 WHEN @sortColumn = 'ExpenseDate' AND @sortDirection = 'ASC' THEN e.ExpenseDate    
END ASC,    
CASE     
 WHEN @sortColumn = 'ExpenseDate' AND @sortDirection = 'DESC' THEN e.ExpenseDate    
END DESC    
OFFSET  @offset ROWS    
fetch NEXT @pageSize ROWS ONLY    
    
SELECT COUNT(*) AS TotalCount    
FROM Expenses    
where (@isAdmin=1 or UserId=@userid)    
  AND (@title IS NULL OR Title LIKE '%' + @title + '%')    
  AND (@amount IS NULL OR Amount = @amount)    
  AND (@expensefromdate IS NULL OR ExpenseDate >= @expensefromdate)    
  AND (@expensetodate IS NULL OR ExpenseDate <= @expensetodate)    
  AND (@categoryid IS NULL OR CategoryId = @categoryid);    
end    
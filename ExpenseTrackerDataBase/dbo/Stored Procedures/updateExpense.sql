Create Procedure updateExpense
(@ExpenseId int,
@Title nvarchar(100),
@Amount decimal(18,2),
@ExpenseDate date,
@CategoryId int,
@UserId int)
as
begin
update Expenses
set 
Title =@Title 
,Amount =@Amount 
,ExpenseDate=@ExpenseDate
,CategoryId =@CategoryId 
,UserId =@UserId 
WHERE ExpenseId=@ExpenseId
end
create procedure AddExpenses
(
@Title nvarchar(100),
@Amount decimal(18,2),
@ExpenseDate date,
@CategoryId int,
@UserId int)
as
begin
insert Into Expenses
values(@Title, @Amount, @ExpenseDate, @CategoryId, @UserId)
end

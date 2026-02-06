create procedure DeleteExpense
(@ExpenseId int)
as
begin
delete from Expenses
where ExpenseId=@ExpenseId
end
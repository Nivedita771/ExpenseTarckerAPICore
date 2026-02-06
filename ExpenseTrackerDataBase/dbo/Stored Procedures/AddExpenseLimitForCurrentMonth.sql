create procedure AddExpenseLimitForCurrentMonth(
@UserId int,
@LimitAmount decimal(18,2),
@LimitMonth int,
@LimitYear  int
)
as
begin
insert into ExpenseLimit(UserId,LimitAmount,LimitMonth,LimitYear)
values( @UserId,@LimitAmount,@LimitMonth,@LimitYear)
end

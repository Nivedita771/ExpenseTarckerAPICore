create procedure CheckExpenseLimitExistForMonth
(@userid int,
@month int,
@year int)
as
begin

select count(*) from ExpenseLimit 
where UserId=@userid and LimitYear=@year and LimitMonth=@month
end

CREATE procedure GetAllRole
(
 @pageNumber int =1,
 @pageSize int=10
)
as
begin
SET NOCOUNT ON;

BEGIN TRY
 select * from Roles
 ORDER BY RoleId
 OFFSET (@pageNumber-1)*@pageSize ROWS
 FETCH NEXT @pageSize ROWS ONLY;

 select count(*) AS TotalCount from Roles;
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
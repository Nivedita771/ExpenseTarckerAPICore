CREATE PROCEDURE ValidateUser  
(  
    @username NVARCHAR(20),  
    @password NVARCHAR(256)  
)  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    BEGIN TRY  
        SELECT u.UserId, u.Username, u.Password, r.RoleName,u.RoleId , u.Email, u.IsActive 
        FROM Users u  
        JOIN Roles r ON u.RoleId = r.RoleId  
        WHERE u.Username = @username AND u.Password = @password;  
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
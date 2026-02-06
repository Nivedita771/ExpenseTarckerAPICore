ALTER ROLE [db_owner] ADD MEMBER [IIS APPPOOL\ExpenseTrackerMvc];


GO
ALTER ROLE [db_ddladmin] ADD MEMBER [IIS APPPOOL\ExpenseTrackerMvc];


GO
ALTER ROLE [db_datareader] ADD MEMBER [IIS APPPOOL\ExpenseTrackerAPI];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [IIS APPPOOL\ExpenseTrackerAPI];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [IIS APPPOOL\ExpenseTrackerMvc];


CREATE TABLE [dbo].[ErrorLog] (
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [ErrorMessage]   NVARCHAR (MAX) NULL,
    [ErrorProcedure] NVARCHAR (200) NULL,
    [ErrorLine]      INT            NULL,
    [ErrorTime]      DATETIME       DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


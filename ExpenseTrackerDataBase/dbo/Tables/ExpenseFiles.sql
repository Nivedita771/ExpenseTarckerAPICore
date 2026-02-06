CREATE TABLE [dbo].[ExpenseFiles] (
    [FileId]       INT            IDENTITY (1, 1) NOT NULL,
    [ExpenseId]    INT            NOT NULL,
    [UserId]       INT            NOT NULL,
    [FileName]     NVARCHAR (255) NOT NULL,
    [FilePath]     NVARCHAR (500) NOT NULL,
    [UploadedDate] DATETIME       DEFAULT (getdate()) NULL,
    [IsDeleted]    BIT            DEFAULT ((0)) NULL,
    [CreatedBy]    NVARCHAR (100) NULL,
    [ModifiedBy]   NVARCHAR (100) NULL,
    [ModifiedDate] DATETIME       NULL,
    [IsSigned]     BIT            DEFAULT ((0)) NOT NULL,
    [SignedDate]   DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([FileId] ASC),
    CONSTRAINT [FK_ExpenseFiles_Expenses] FOREIGN KEY ([ExpenseId]) REFERENCES [dbo].[Expenses] ([ExpenseId]),
    CONSTRAINT [FK_ExpenseFiles_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
);


GO
CREATE NONCLUSTERED INDEX [IX_ExpenseFiles_ExpenseId]
    ON [dbo].[ExpenseFiles]([ExpenseId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ExpenseFiles_UserId]
    ON [dbo].[ExpenseFiles]([UserId] ASC);

